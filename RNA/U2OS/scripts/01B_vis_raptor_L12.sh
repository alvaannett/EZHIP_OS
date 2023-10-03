
module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/visalize_raptor_L3_output.Rmd',
            params = list(path_raptor = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/U2OS/out/01_raptor_exprtools/EZHIP_minus_C77_C2/',
                          prefix = 'U2OS',
                          comp = 'EZHIP_KOvsEZHIP',
                          colors = list(group = c('EZHIP_KO' = 'blue', 'EZHIP' = 'red'))),
            output_file = '/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/U2OS/out/01_raptor_exprtools/EZHIP_minus_C77/vis_raptor_L12.U2OS.html')"
