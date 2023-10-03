#!/bin/sh
#SBATCH --job-name=05_run_bayes_prism
#SBATCH --account=def-jabado
#SBATCH --cpus-per-task=30
#SBATCH --time=05:00:00
#SBATCH --mem-per-cpu 2G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

bulk_exp='/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/hMSC/out/01_raptor_exprtools/EZHIP/counts/Ensembl.ensGene.exon.raw.tsv.gz'
bulk_meta='/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/hMSC/out/01_raptor_exprtools/EZHIP/'
ref_exp='/lustre06/project/6004736/alvann/from_narval/REFERENCES/Bone_Marrow_Baccin/out/02_bayes_prism_only_mes/sc.ref.txt.gz'
cell_types='/lustre06/project/6004736/alvann/from_narval/REFERENCES/Bone_Marrow_Baccin/out/02_bayes_prism_only_mes/cell.type.labels.Rda'
out='/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/hMSC/out/03_deconvolution/Skeletal_Development_Baccin_only_mes_mm/'
n_cores=30

mkdir -p ${out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/BayesPrism/deconvolution_bayesprsm.Rmd',
            params = list(bulk_exp = '${bulk_exp}',
                          bulk_meta = '${bulk_meta}',
                          ref_exp = '${ref_exp}',
                          cell_types = '${cell_types}',
                          out = '${out}',
                          n_cores = '${n_cores}'),
            output_file = '${out}/bayesprism.res.html')"
