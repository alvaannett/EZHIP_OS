#!/bin/sh
#SBATCH --job-name=02_GSEA_ORA
#SBATCH --account=def-jabado
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --mem-per-cpu 30G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

bm=100
lfc=1
pval=0.05

Rscript -e "rmarkdown::render(
'/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/GSEA/MSigDB_Bone_GSEA_ORA.Rmd',
params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/KHOS/',
path_out = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/02_GSEA_ORA/KHOS/',
prefix = 'KHOS',
comp = 'WTvsEZHIP',
bm = ${bm},
pval_gene = ${pval}, 
lfc = ${lfc},
reference = 'hg19.Ensembl',
pval_gsea_ora = 1,
qval_gsea_ora = 1),
output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/02_GSEA_ORA/KHOS/GSEA_ORA.html')"

Rscript -e "rmarkdown::render(
'/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/GSEA/MSigDB_Bone_GSEA_ORA.Rmd',
params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/MG63/',
path_out = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/02_GSEA_ORA/MG63/',
prefix = 'MG63',
comp = 'WTvsEZHIP',
bm = ${bm},
reference = 'hg19.Ensembl',
pval_gene = ${pval}, 
lfc = ${lfc},
pval_gsea_ora = 1,
qval_gsea_ora = 1),
output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/02_GSEA_ORA/MG63/GSEA_ORA.html')"
