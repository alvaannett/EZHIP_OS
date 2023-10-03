
library(tidyverse)

SAMPELS = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/files/samples.tsv"

PATH_IN = "/lustre06/project/6037386/data-kleinman/pipeline/v0/levels1-2/njabado/RNAseq/"
PATH_OUT = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/out/01_concat/"

DIR = paste0(PATH_IN, c("2022-10-28_Clincal_RNA_OS_hg/", "2022-09-14_clinical_OS_hg/"))

col_names = c('fusion_name', 'JunctionReads',	'SpanningFrags',	'Splice_type',	'LeftGene',	'LeftBreakpoint',	'RightGene',	'RightBreakpoint',	'JunctionReads.1',	'SpanningFrags.1')

print(DIR)

meta = data.table::fread(SAMPELS)

samples = (meta %>% filter(!is.na(RNA)))$RNA

print(samples)

file = paste0(DIR[2], samples[2], "/star-fusion/", samples[2], ".fusion_candidates.final")

df = data.table::fread(file, col.names = col_names, select = 1:10)
df$sample = samples[1]

# read files and rbind with data frame
for(d in DIR){
  for(s in samples[-2]){
    #get file name
    file = paste0(d, s, "/star-fusion/", s, ".fusion_candidates.final")

    #check if file exists, if yes read and add to df
    if(file.exists(file)){
      tmp = data.table::fread(file, col.names = col_names,  select = 1:10)
      tmp$sample = s
      df = rbind(df, tmp)
    }
  }
}

unique(df$Sample) %in% samples

# save
data.table::fwrite(df, file = paste0(PATH_OUT, "fusions_final.tsv"), sep = "\t")
