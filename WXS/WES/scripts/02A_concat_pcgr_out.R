

library(tidyverse)

DIR="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/"
OUT="out/02_oncoprint/"


# get sample names from pcgr output folder
samples = list.dirs(DIR,
          full.names = FALSE,
          recursive = FALSE)

print(samples)

# ---- PCGR SOMATIC ------------------------------------

# read first file
df = data.table::fread(paste0("out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/", samples[1], "/pcgr/", samples[1], ".pcgr_acmg.grch37.snvs_indels.tiers.tsv"))

# read files and rbind with data framw
for(s in samples[-1]){
    tmp = data.table::fread(paste0("out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/", s, "/pcgr/", s, ".pcgr_acmg.grch37.snvs_indels.tiers.tsv"))
    df = rbind(df, tmp)
}

# check that all samples are included
unique(df$VCF_SAMPLE_ID) %in% samples

# save
data.table::fwrite(df, file = paste0(OUT, "somatic.pcgr.tiers.all.samples.tsv"), sep = "\t")

# ---- CPSR GERMLINE -----------------------------------

# read first file
df = data.table::fread(paste0("out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/", samples[1], "/cpsr/", samples[1], ".cpsr.grch37.snvs_indels.tiers.tsv"))

# read files and rbind with data framw
for(s in samples[-1]){
    tmp = data.table::fread(paste0("out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/", s, "/cpsr/", s, ".cpsr.grch37.snvs_indels.tiers.tsv"))
    df = rbind(df, tmp)
}

# check that all samples are included
unique(df$VCF_SAMPLE_ID) %in% samples

# save
data.table::fwrite(df, file = paste0(OUT, "germline.cpsr.tiers.all.samples.tsv"), sep = "\t")
