#!/bin/sh

module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

path_raptor_xgraft="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/01_raptor_exprtools/"
path_raptor_KHOS_cult="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/RNA_KHOS/out/01_raptor_exprtools/EZHIP/diff/Ensembl.ensGene.exon/WTvsEZHIP.tsv"
path_raptor_MG63_cult="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/RNA_MG63/out/01_raptor_exprtools/EZHIP/diff/Ensembl.ensGene.exon/WTvsEZHIP.tsv"
path_raptor_U2OS_cult="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/RNA_U2OS/out/01_raptor_exprtools/EZHIP_minus_C77_C2/diff/Ensembl.ensGene.exon/EZHIP_KOvsEZHIP.tsv"

bm=100

# MG63 Xgraft, cell line and U2OS 
path_out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/03_compare_DE_genes/MG63_Xgraft_Culture_vs_U2OS_Culture/"

mkdir ${path_out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/compare_DE_genes.Rmd',
            params = list(groups = c('MG63_Cult', 'MG63_Xgra', 'U2OS_Cult'),
                          paths = c('${path_raptor_MG63_cult}',
                                    '${path_raptor_xgraft}MG63/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_U2OS_cult}'),
                          out = '${path_out}',
                          bm = '${bm}', 
                          sp = 'hg'),
            output_file = '${path_out}/Compare_DE_genes.html')"


# Compare all 4 models
path_out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/03_compare_DE_genes/KHOS_MG63_Xgraft_vs_U2OS_Culture/"

mkdir ${path_out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/compare_DE_genes.Rmd',
            params = list(groups = c('KHOS_Xgraft', 'MG63_Xgraft', 'U2OS_Culture'),
                          paths = c('${path_raptor_xgraft}KHOS/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_xgraft}MG63/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_U2OS_cult}'),
                          out = '${path_out}',
                          bm = '${bm}'),
            output_file = '${path_out}/Compare_DE_genes.html')"


# Compare KHOS and MG63 Xnegoraft samples 
path_out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/03_compare_DE_genes/KHOS_MG63_Xgrafts/"

mkdir ${path_out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/compare_DE_genes.Rmd',
            params = list(groups = c('KHOS', 'MG63'),
                          paths = c('${path_raptor_xgraft}KHOS/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_xgraft}MG63/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv'),
                          out = '${path_out}',
                          bm = '${bm}'),
            output_file = '${path_out}/Compare_DE_genes.html')"

# Compare KHOS Xnegoraft with culture
path_out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/03_compare_DE_genes/KHOS_Xgraft_vs_Culture/"

mkdir ${path_out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/compare_DE_genes.Rmd',
            params = list(groups = c('KHOS_Xgraft', 'KHOS_Culture'),
                          paths = c('${path_raptor_xgraft}KHOS/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_KHOS_cult}'),
                          out = '${path_out}',
                          bm = '${bm}'),
            output_file = '${path_out}/Compare_DE_genes.html')"

# Compare MG63 Xnegoraft with culture
path_out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/03_compare_DE_genes/MG63_Xgraft_vs_Culture/"

mkdir ${path_out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/compare_DE_genes.Rmd',
            params = list(groups = c('MG63_Xgraft', 'MG63_Culture'),
                          paths = c('${path_raptor_xgraft}MG63/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_MG63_cult}'),
                          out = '${path_out}',
                          bm = '${bm}'),
            output_file = '${path_out}/Compare_DE_genes.html')"

# Compare all 4 models 
path_out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/xgrafts/out/03_compare_DE_genes/KHOS_MG63_Xgraft_vs_Culture/"

mkdir ${path_out}

Rscript -e "rmarkdown::render(
            '/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/Raptor/compare_DE_genes.Rmd',
            params = list(groups = c('KHOS_Xgraft', 'KHOS_Culture', 'MG63_Xgraft', 'MG63_Culture'),
                          paths = c('${path_raptor_xgraft}KHOS/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_KHOS_cult}',
                                    '${path_raptor_xgraft}MG63/diff/hg19.Ensembl.ensGene.exon/WTvsEZHIP.tsv',
                                    '${path_raptor_MG63_cult}'),
                          out = '${path_out}',
                          bm = '${bm}'),
            output_file = '${path_out}/Compare_DE_genes.html')"


