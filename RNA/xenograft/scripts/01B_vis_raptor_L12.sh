
module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/visalize_raptor_L3_output.Rmd',
            params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/KHOS/',
            prefix = 'KHOS',
            comp = 'WTvsEZHIP',
            reference = 'hg19.Ensembl',
            volcano_y_lim = c(-15, 15),
            colors = list(group = c('WT' = 'blue', 'EZHIP' = 'red'))),
            output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/KHOS/vis_raptor_L12.KHOS.html')"

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/visalize_raptor_L3_output.Rmd',
            params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/MG63/',
            prefix = 'MG63',
            reference = 'hg19.Ensembl',
            comp = 'WTvsEZHIP',
            volcano_y_lim = c(-15, 15),
            colors = list(group = c('WT' = 'blue', 'EZHIP' = 'red'))),
            output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/MG63/vis_raptor_L12.MG63.html')"
