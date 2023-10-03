#!/usr/bin/env Rscript

# This script is meant to be run on beluga.  The following modules need to be
# loaded before:
#
# $ module add StdEnv/2020 gcc/9.3.0 r-bundle-bioconductor/3.12
# $ R
#
# And the following R package needs to be installed:
# $ R
# > install.packages("changepoint")

###############################################################################
# 1. Load libraries
###############################################################################

# beluga's R search path is a bit messed up.  Here, I'm forcing R to look first
# in personal library, then in beluga's Bioconductor library install, then in
# beluga's library install  Don't forget to replace `ndejay` with your username!
#.libPaths(c(
#  "/home/ndejay/R/x86_64-pc-linux-gnu-library/4.0",
#  "/cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Compiler/gcc9/r-bundle-bioconductor/3.12",
#  "/cvmfs/soft.computecanada.ca/easybuild/software/2020/avx512/Core/r/4.0.2/lib64/R/library"
#))

.libPaths(c("/home/alvann/R/x86_64-pc-linux-gnu-library/4.0", 
            "/cvmfs/soft.computecanada.ca/easybuild/software/2020/avx2/Compiler/gcc9/r-bundle-bioconductor/3.12",  
            "/cvmfs/soft.computecanada.ca/easybuild/software/2020/avx2/Core/r/4.0.2/lib64/R/library"))

library(tidyverse)    # our church
library(magrittr)     # for the pipe operator
library(GenomeInfoDb) # for generating genomic bins
library(Rsubread)     # for read counting
library(changepoint)  # for segmenting bins
library(tictoc)       # for timing

###############################################################################
# 2. Prepare annotation for counts
###############################################################################

create_segmented_annotation <- function (genome = "hg19", bin_size = 1000) {
  tictoc::tic("Creating segment annotation")
  # Get chromosome sizes
  annot_full <- GenomeInfoDb::getChromInfoFromUCSC(genome)
  # Filter chromosomes of interest.  No random or sex chromosomes.
  chromosomes <- annot_full %>%
    .[grepl("chr[0-9]*$", .$chrom) & .$assembled, "chrom"]
  # Bin the genome
  annot <-
    chromosomes %>%
    purrr::map(
      ~ data.frame(Chr = .,
                   Start = 0:(annot_full[annot_full$chrom == ., "size"] / bin_size) * bin_size) %>%
        dplyr::mutate(End = Start + bin_size,
                      Strand = "*",
                      # Disable scientific notation and space padding
                      GeneID = paste0(Chr, ":", format(Start, trim = T, scientific = F), "-", format(End, trim = T, scientific = F)))
    ) %>%
    dplyr::bind_rows()

  tictoc::toc()
  return(annot)
}

###############################################################################
# 3. Count reads
###############################################################################

# TODO: Parallelize
count_reads <- function (samples, annot, n_threads = 1) {
  tictoc::tic("Counting reads")
  read_counts <- 
    samples %>%
    tidyr::pivot_longer(-c(sample, endedness), names_to = "type", values_to = "BAM") %>%
    dplyr::select(BAM, endedness) %>%
    # Only count reads for a given BAM once (in case the same input is re-used)
    dplyr::distinct() %>%
    # Count reads in each BAM
    purrr::pmap(function (BAM, endedness) {
      tictoc::tic(paste0("Counting reads for ", BAM))
      # Suppress Rsubread output
      # sink("/dev/null")
        read_counts_ <-
          BAM %>%
          Rsubread::featureCounts(
            nthreads    = n_threads,
            annot.ext   = annot,
            ignoreDup   = TRUE,
            verbose     = F,
            isPairedEnd = endedness == "PE"
          ) %$%
          counts %>%
          as.data.frame(check.names = F) %>%
          tibble::rownames_to_column(var = "location")
      # sink(NULL)
      tictoc::toc()
      return(read_counts_)
    }) %>%
    # Join BAM read counts into single matrix
    Reduce(function (x, y) dplyr::full_join(x, y, by = "location"), .) %>%
    # Separate location column into its constituents
    tidyr::extract(location,
                   regex = "(chr[0-9]*):([0-9]*)-([0-9]*)",
                   into = c("chr", "start", "end"),
                   convert = T)
  tictoc::toc()
  return(read_counts)
}

###############################################################################
# 4. Normalize counts and calculate IP/input enrichment
###############################################################################

normalize_counts <- function (samples, read_counts) {
  tictoc::tic("Normalizing read counts")
  normalized_counts <-
    samples %>%
  # For each sample, normalize IP-input pairs
    purrr::pmap(function (sample, IP, input, endedness)
      read_counts %>%
        dplyr::select(chr, start, end, "IP" = !!basename(IP), "input" = !!basename(input)) %>%
        # Scale read counts within each sample to library depth and a pseudocount and
        # calculate enrichment of IP over input.
        dplyr::mutate(signal = ((IP + 1) / sum(IP + 1)) / ((input + 1) / sum(input + 1))) %>%
        # Hack: set low count bins to 0 so that they get filtered out in later steps.  This
        # is important because the pseudocounts makes (0, 0) bins have (1, 1) and therefore
        # a signal of 1.0, which the segmentation algorithm will lump together with (10, 10),
        # (100, 100), etc.
        dplyr::mutate(signal = ifelse(IP == 0 & input == 0, 0, signal)) %>%
        dplyr::transmute(chr, start, end, signal, sample = sample)
      ) %>%
    # Convert list of matrices into long data frame
    dplyr::bind_rows() %>%
    # Convert long data frame to wide
    tidyr::pivot_wider(names_from = "sample", values_from = "signal")
  tictoc::toc()
  return(normalized_counts)
}

###############################################################################
# 5. Segment bins
###############################################################################

call_changepoints <- function (signal) {
  changepoints <-
    signal %>%
    # Call changepoints
    changepoint::cpt.mean(minseglen = 50, penalty = "SIC", method = "PELT", test.stat = "Normal") %>%
    # Retrieve indices of changepoints
    changepoint::cpts()
  return(changepoints)
}

# TODO: Parallelize
segment_bins <- function (normalized_counts,
                          samples) {
  tictoc::tic("Segmenting bins")
  segments <-
    samples$sample %>%
    purrr::set_names() %>%
    # Call segments in each sample and chromosome separately and then
    # join them per sample.
    purrr::map(function (sample_) {
      tictoc::tic(paste0("Segmenting bins for ", sample_))
      segments_ <-
        normalized_counts$chr %>%
        unique() %>%
        purrr::map(function (chromosome_) {
          # Subset signal to (sample, chr) pair
          normalized_counts_ <- normalized_counts %>%
            dplyr::filter(chr == !!chromosome_) %>%
            dplyr::select(chr, start, end, !!sample_)

          # Call changepoints
          changepoints <- call_changepoints(normalized_counts_[[sample_]])

          # Create segments by fusing bins between changepoints
          purrr::map2(c(1, changepoints),
                      c(changepoints, nrow(normalized_counts_)),
                      ~ normalized_counts_[.x:(.y - 1), , drop = F]) %>%
            # Compute new genomic location and mean signal accordingly
            purrr::map(
              ~ data.frame(chr = chromosome_,
                           start = min(.x$start),
                           end = max(.x$end),
                           signal = mean(.x[[sample_]], na.rm = T))) %>%
            dplyr::bind_rows()
        }) %>%
        dplyr::bind_rows() %>%
        # Assign unique ID to each segment within sample
        dplyr::mutate(name = paste0("segment_", 1:nrow(.)), .after = end)
      tictoc::toc()
      return(segments_)
    })
  tictoc::toc()
  return(segments)
}


###############################################################################
# 6. Define samples
###############################################################################

# The input to this script is a four-column tab-separated value file.  Here's
# an example:

# $ cat ../data/01-info.samples.tsv | column -t
# sample                             IP                                                     input                                               endedness
# BT245_KO_c2p8_H3K27me2_SE          ../data/00-bams/BT245_KO_c2p8_H3K27me2_SE.bam          ../data/00-bams/BT245_KO_c2p8_Input_SE.bam          SE
# BT245_KO_c4p9_H3K27me2_SE          ../data/00-bams/BT245_KO_c4p9_H3K27me2_SE.bam          ../data/00-bams/BT245_KO_c4p9_Input_SE.bam          SE
# BT245_NKO_c1p5_H3K27me2_SE         ../data/00-bams/BT245_NKO_c1p5_H3K27me2_SE.bam         ../data/00-bams/BT245_NKO_c1p5_Input_SE.bam         SE
# BT245_parental_C24_H3K27me2_SE     ../data/00-bams/BT245_parental_C24_H3K27me2_SE.bam     ../data/00-bams/BT245_parental_C24_Input_SE.bam     SE
# DIPG21_KO_c7p6_H3K27me2_PE         ../data/00-bams/DIPG21_KO_c7p6_H3K27me2_PE.bam         ../data/00-bams/DIPG21_KO_c7p6_Input_PE.bam         PE
# DIPG21_NKO_c4p6_H3K27me2_PE        ../data/00-bams/DIPG21_NKO_c4p6_H3K27me2_PE.bam        ../data/00-bams/DIPG21_NKO_c4p6_Input_PE.bam        PE
# DIPG21_parental_p28_H3K27me2_SE    ../data/00-bams/DIPG21_parental_p28_H3K27me2_SE.bam    ../data/00-bams/DIPG21_parental_p28_Input_SE.bam    SE
# DIPG36_KO_c2p4_H3K27me2_PE         ../data/00-bams/DIPG36_KO_c2p4_H3K27me2_PE.bam         ../data/00-bams/DIPG36_KO_c2p4_Input_PE.bam         PE
# DIPG36_KO_c3S2p6_H3K27me2_SE       ../data/00-bams/DIPG36_KO_c3S2p6_H3K27me2_SE.bam       ../data/00-bams/DIPG36_KO_c3S2p6_Input_SE.bam       SE
# DIPG36_NKO_c1S2_H3K27me2_PE        ../data/00-bams/DIPG36_NKO_c1S2_H3K27me2_PE.bam        ../data/00-bams/DIPG36_NKO_c1S2_Input_PE.bam        PE
# DIPG36_parental_p20_H3K27me2_SE    ../data/00-bams/DIPG36_parental_p20_H3K27me2_SE.bam    ../data/00-bams/DIPG36_parental_p20_Input_SE.bam    SE
# DIPGIV_KO_c1p5_H3K27me2_SE         ../data/00-bams/DIPGIV_KO_c1p5_H3K27me2_SE.bam         ../data/00-bams/DIPGIV_KO_c1p5_Input_SE.bam         SE
# DIPGIV_KO_c9p9_H3K27me2_PE         ../data/00-bams/DIPGIV_KO_c9p9_H3K27me2_PE.bam         ../data/00-bams/DIPGIV_KO_c9p9_Input_PE.bam         PE
# DIPGIV_NKO_c3p5_H3K27me2_SE        ../data/00-bams/DIPGIV_NKO_c3p5_H3K27me2_SE.bam        ../data/00-bams/DIPGIV_NKO_c3p5_Input_SE.bam        SE
# DIPGXIII_KO_c10p5_H3K27me2_SE      ../data/00-bams/DIPGXIII_KO_c10p5_H3K27me2_SE.bam      ../data/00-bams/DIPGXIII_KO_c10p5_Input_SE.bam      SE
# DIPGXIII_KO_c5p5_H3K27me2_SE       ../data/00-bams/DIPGXIII_KO_c5p5_H3K27me2_SE.bam       ../data/00-bams/DIPGXIII_KO_c5p5_Input_SE.bam       SE
# DIPGXIII_NKO_c12p3_H3K27me2_SE     ../data/00-bams/DIPGXIII_NKO_c12p3_H3K27me2_SE.bam     ../data/00-bams/DIPGXIII_NKO_c12p3_Input_SE.bam     SE
# DIPGXIII_parental_C14_H3K27me2_SE  ../data/00-bams/DIPGXIII_parental_C14_H3K27me2_SE.bam  ../data/00-bams/DIPGXIII_parental_C14_Input_SE.bam  SE
# HSJ019_KO_c10p29_H3K27me2_PE       ../data/00-bams/HSJ019_KO_c10p29_H3K27me2_PE.bam       ../data/00-bams/HSJ019_KO_c10p29_Input_PE.bam       PE
# HSJ019_KO_c8p30_H3K27me2_PE        ../data/00-bams/HSJ019_KO_c8p30_H3K27me2_PE.bam        ../data/00-bams/HSJ019_KO_c8p30_Input_PE.bam        PE
# HSJ019_parental_C7-2_H3K27me2_SE   ../data/00-bams/HSJ019_parental_C7-2_H3K27me2_SE.bam   ../data/00-bams/HSJ019_parental_C7-2_Input_SE.bam   SE
# HSJ019_parental_p25_H3K27me2_PE    ../data/00-bams/HSJ019_parental_p25_H3K27me2_PE.bam    ../data/00-bams/HSJ019_parental_p25_Input_PE.bam    PE

samples <-
  "files/call_domains_files/sample_info.tsv" %>%
  readr::read_tsv()

print(samples)

tictoc::tic("Total time")

# Slurm execution nodes block internet access, so I put `annot` into an RDS
# file.  You can generate it with the following lines:
#
# > annot <- create_segmented_annotation(genome = "hg19", bin_size = 1000)
# > saveRDS(annot, "01-script-annot.rds")


if (!base::exists("annot"))
  annot <- readRDS("files/call_domains_files/segment_annotation.rds")

if (!base::exists("read_counts"))
  read_counts <- count_reads(samples, annot, n_threads = 4)

if (!base::exists("normalized_counts"))
  normalized_counts <- normalize_counts(samples, read_counts)

if (!base::exists("segmented_bins"))
  segmented_bins <- segment_bins(normalized_counts, samples)

if (!base::exists("filtered_segments"))
  filtered_segments <-
    segmented_bins %>%
    purrr::map(~ dplyr::filter(., signal > 1 & end - start >= 5000)) %T>%
    # Don't forget to change the output directory!
    purrr::map2(., names(.), ~ readr::write_tsv(.x, paste0("out/04A_call_domains/", .y, ".bed"), col_names = F))

tictoc::toc()
