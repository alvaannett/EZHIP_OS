
module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2
module load mugqic/bcftools/1.15 mugqic/samtools/1.14


PATH_PIPELINE="/lustre06/project/6037386/data-kleinman/pipeline/v0/levels1-2/njabado/RNAseq/2022-08-23_hMSC_OS-cell-lines_EZHIP_Wajih_hg/"
PATH_OUT="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/U2OS/out/03_variant_calls/"

for f in ${PATH_PIPELINE}*U2OS*;
do 
 SAMPLE="$(basename ${f})"
 echo ${SAMPLE}
 Rscript --vanilla scripts/src/process_vcf.R ${SAMPLE} ${PATH_PIPELINE} ${PATH_OUT}
 
 gzip -d ${PATH_OUT}${SAMPLE}.filterAnnotated.vcf.gz
 bgzip ${PATH_OUT}${SAMPLE}.filterAnnotated.vcf
 tabix -p vcf ${PATH_OUT}${SAMPLE}.filterAnnotated.vcf.gz

done;


#Rscript --vanilla src/process_vcf.R 

