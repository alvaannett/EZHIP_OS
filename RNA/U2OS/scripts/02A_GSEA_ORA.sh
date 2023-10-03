#!/bin/sh
#SBATCH --job-name=GSEA_ORA
#SBATCH --account=def-jabado
#SBATCH --cpus-per-task=2
#SBATCH --time=01:00:00
#SBATCH --mem-per-cpu 10G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/GSEA/MSigDB_Bone_GSEA_ORA.Rmd',
            params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/U2OS/out/01_raptor_exprtools/EZHIP_minus_C77_C2/',
                          path_out = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/U2OS/out/02_GSEA_ORA/',
                          prefix = 'U2OS',
                          comp = 'EZHIP_KOvsEZHIP',
                          bm = 100,
                          pval_gene = 0.05, 
                          lfc = 1, 
                          pval_gsea_ora = 1,
                          qval_gsea_ora = 1),
            output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/U2OS/out/02_GSEA_ORA_minus/GSEA_ORA.html')"

