
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

# ---- PCGR SOMATIC ------------------------------------

# read first file
df = data.table::fread(paste0(DIR[1], samples[1], "/cpsr/", samples[1], ".cpsr.grch37.snvs_indels.tiers.tsv"))

# read files and rbind with data frame
for(d in DIR){
  for(s in samples[-1]){
    #get file name
    file = paste0(d, s, "/cpsr/", s, ".cpsr.grch37.snvs_indels.tiers.tsv")

    #check if file exists, if yes read and add to df
    if(file.exists(file)){
      tmp = data.table::fread(file)
      df = rbind(df, tmp)
    }
  }
}

# check that all samples are included
unique(df$VCF_SAMPLE_ID) %in% samples

# save
data.table::fwrite(df, file = paste0(OUT, "germline.cpsr.tiers.all.samples.tsv"), sep = "\t")
