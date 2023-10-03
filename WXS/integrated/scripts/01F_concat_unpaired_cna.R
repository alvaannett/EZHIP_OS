
library(tidyverse)

PATH = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/inhouse_patients/out/01_genpipes_dnaseq/SVariants"
OUT="out/01_concat/"
SAMPELS = "/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/integrated/221106_oncoprint/files/samples.tsv"

meta = data.table::fread(SAMPELS)
samples = (meta %>% filter(Paired == 'No'))$WXS

files = data.frame(path = list.files(PATH, 
                                     pattern = "cnvkit.snpeff.vcf.stats.genes", 
                                     recursive = T, 
                                     full.names = T)) %>%
  separate(path, sep = 'SVariants/', into = c(NA, 'tmp'), remove = F) %>%
  separate(tmp, sep = '/', into = c('sample', NA)) %>%
  filter(sample %in% samples)

CNV = data.frame(matrix(ncol = 4))
names(CNV) = c('sample', 'GeneId', 'dup', 'loss')

for(i in 1:nrow(files)){
  print(files$sample[i])
  tmp = data.table::fread(files$path[i]) 
  if('variants_effect_exon_loss_variant' %in% names(tmp)){
  tmp = tmp %>% 
        filter(BioType == 'protein_coding') %>% 
        mutate(dup = ifelse(variants_effect_duplication > 0, 'cna gain', NA),
               loss = ifelse(variants_effect_exon_loss_variant > 0, 'cna loss', NA), 
               sample = files$sample[i]) %>%
       select(sample, GeneId, dup, loss)
  CNV = rbind(CNV, tmp)
  }
  else{
    tmp = tmp %>% 
      filter(BioType == 'protein_coding') %>% 
      mutate(dup = ifelse(variants_effect_duplication > 0, 'cna gain', NA),
             loss = NA, 
             sample = files$sample[i]) %>%
      select(sample, GeneId, dup, loss)
    CNV = rbind(CNV, tmp)
  }
 
}

CNV = CNV %>% 
      filter(!(is.na(loss) & is.na(dup))) %>% 
      distinct()

# save
data.table::fwrite(CNV, file = paste0(OUT, "cna_unpaired.tsv"), sep = "\t")



