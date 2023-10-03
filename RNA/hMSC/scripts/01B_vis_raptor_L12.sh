
module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/visalize_raptor_L3_output.Rmd',
            params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/hMSC/out/01_raptor_exprtools/EZHIP/',
            prefix = 'hMSC',
            comp = 'WTvsEZHIP',
            volcano_y_lim = c(-15, 15),
            colors = list(group = c('WT' = 'blue', 'EZHIP' = 'red'))),
            output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/hMSC/out/01_raptor_exprtools/EZHIP/vis_raptor_L12.hMSC.html')"

