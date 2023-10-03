#!/bin/sh
#SBATCH --job-name=GSEA_ORA
#SBATCH --account=def-jabado
#SBATCH --cpus-per-task=4
#SBATCH --time=00:30:00
#SBATCH --mem-per-cpu 2G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/GSEA/MSigDB_Bone_GSEA_ORA.Rmd',
            params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/patient_clinical_seq/out/01_raptor_exprtools/EZHIP_neg_VsEZHIP_pos_no_reps/',
                          path_out = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/patient_clinical_seq/out/02_GSEA_ORA/',
                          prefix = 'clinical',
                          comp = 'EZHIP_negvsEZHIP_pos',
                          bm = 100,
                          pval_gene = 0.05, 
                          lfc = 1, 
                          pval_gsea_ora = 1,
                          qval_gsea_ora = 1),
            output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/patient_clinical_seq/out/02_GSEA_ORA/GSEA_ORA.html')"

