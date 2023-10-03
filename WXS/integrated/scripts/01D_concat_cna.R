
library(tidyverse)

SAMPELS = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/files/samples.tsv"

DIR=c("/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch2/pairedVariants/ensemble/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WGS/clinical_seq_patients/out/01_genpipes_tumorpair/pairedVariants/ensemble/", 
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WGS/clinical_seq_patients/out/01_genpipes_tumorpair/pairedVariants/ensemble/")

OUT="out/01_concat/"

meta = data.table::fread(SAMPELS)

samples = (meta %>% filter(Paired == 'Yes'))$WXS

print(samples)

# read first file
df = data.table::fread(paste0(DIR[1], samples[1], "/pcgr/", samples[1], ".pcgr_acmg.grch37.cna_segments.tsv.gz")) %>%
     filter(biotype == 'protein_coding') %>%
     filter(tumor_suppressor == "TRUE" | oncogene == "TRUE")

# read files and rbind with data frame
for(d in DIR){
  for(s in samples[-1]){
    #get file name
    file = paste0(d, s, "/pcgr/", s, ".pcgr_acmg.grch37.cna_segments.tsv.gz")

    #check if file exists, if yes read and add to df
    if(file.exists(file)){
      tmp = data.table::fread(file) %>%
            filter(biotype == 'protein_coding') %>%
            filter(tumor_suppressor == "TRUE" | oncogene == "TRUE")

      df = rbind(df, tmp)
    }
  }
}

# check that all samples are included
print(unique(df$sample_id))

# save
data.table::fwrite(df, file = paste0(OUT, "cna.samples.tsv"), sep = "\t")
