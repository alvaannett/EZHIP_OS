
library(tidyverse)
library(rjson)

SAMPELS = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/files/samples.tsv"

DIR=c("/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch1/pairedVariants/ensemble/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch2/pairedVariants/ensemble/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/inhouse_patients/out/03_pcgr_haplotypecaller_genpipes/",
      "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WGS/clinical_seq_patients/out/01_genpipes_tumorpair/pairedVariants/ensemble/")

OUT="~/projects/rrg-kleinman/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/out/01_concat/"

meta = data.table::fread(SAMPELS)

samples = (meta %>% filter(!is.na(WXS)))$WXS

df = data.frame('sample' = NA, 'TMB' = NA, 'MSS' = NA)

for(d in DIR){
  for(s in samples){
    #get file name 
    file = paste0(d, s, "/pcgr/", s, ".pcgr_acmg.grch37.json.gz")
    
    #check if file exists, if yes read and add to df 
    if(file.exists(file)){
      print(file)
      tmp = fromJSON(file = file)
      df = rbind(df, c(s, tmp$content$tmb$v_stat$tmb_estimate, tmp$content$msi$prediction$msi_stats[[1]]$predicted_class))
    }
    
    file = paste0(d, s, "/", s, ".pcgr_acmg.grch37.json.gz")
    
    if(file.exists(file)){
      print(file)
      tmp = fromJSON(file = file)
      df = rbind(df, c(s, tmp$content$tmb$v_stat$tmb_estimate, NA))
    }
  }
}

df = df[-1,]

df = df %>% left_join(meta %>% select(Patient, WXS), by = c('sample' = 'WXS'))

data.table::fwrite(df, file = paste0(OUT, "TMB_MSI.tsv"), sep = "\t")
