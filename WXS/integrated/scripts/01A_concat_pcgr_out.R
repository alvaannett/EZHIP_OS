

library(tidyverse)

SAMPELS = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/files/samples.tsv"

DIR=c("/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch2/pairedVariants/ensemble/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/inhouse_patients/out/03_pcgr_genpipes/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WGS/clinical_seq_patients/out/01_genpipes_tumorpair/pairedVariants/ensemble/")

OUT="out/01_concat/"

meta = data.table::fread(SAMPELS)

samples = (meta %>% filter(!is.na(WXS)))$WXS

print(samples)

# ---- PCGR SOMATIC ------------------------------------

# read first file
df = data.table::fread(paste0(DIR[3], samples[1], "/", samples[1], ".pcgr_acmg.grch37.snvs_indels.tiers.tsv"))

# read files and rbind with data frame
for(d in DIR){
  for(s in samples[-1]){
    #get file name
    file = paste0(d, s, "/pcgr/", s, ".pcgr_acmg.grch37.snvs_indels.tiers.tsv")

    #check if file exists, if yes read and add to df
    if(file.exists(file)){
      tmp = data.table::fread(file)
      df = bind_rows(df, tmp)
    }

    file = paste0(d, s, "/", s, ".pcgr_acmg.grch37.snvs_indels.tiers.tsv")

    if(file.exists(file)){
      tmp = data.table::fread(file)
      df = bind_rows(df, tmp)
    }
  }
}

# check that all samples are included
samples %in% unique(df$VCF_SAMPLE_ID)

# save
data.table::fwrite(df, file = paste0(OUT, "somatic.pcgr.tiers.all.samples.tsv"), sep = "\t")
