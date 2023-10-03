#!/bin/sh

module load StdEnv/2020 gcc/9.3.0 mugqic/R_Bioconductor/4.1.0_3.13 r/4.1.2

notebook="/lustre06/project/6004736/alvann/from_narval/PIPELINES/notebooks/ssGSEA/ssGSEA_GSVA.Rmd"
raptor="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/MG63/out/01_raptor_exprtools/EZHIP/"
out="/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/RNA/MG63/out/04_ssGSEA/"

atlas_prefix=("baryawno_n100" "baccin_n100" "demicheli_n100" "dolgalev_n100" "zhang_n100")

atlas=("Skeletal_Development_Baryawno_mm/out/01_gene_sets/develop_bone_atlas_gene_sets.n100.Rda" "Bone_Marrow_Baccin/out/01_cluster_markers/bone_atlas_baccin_gene_sets.n100.Rda" "/Skeletal_Muscle_Tissue_hg/out/02_gene_sets/skeletal_muscle_atlas_gene_sets.n100.Rda" "Bone_Marrow_Niche_Dolgalev_mm/out/01_cluster_markers/bone_atlas_dolgalev_gene_sets.n100.Rda" "Bone_Marrow_Zhang/out/01_cluster_markers/bone_atlas_zhang_gene_sets.n100.Rda")

mkdir ${out}

for i in {0..4}
do
Rscript -e "rmarkdown::render(
            '${notebook}',
            params = list(raptor_path = '${raptor}',
                          out_path = '${out}',
                          atlas = '/lustre06/project/6004736/alvann/from_narval/REFERENCES/${atlas[$i]}', 
                          atlas_prefix = '${atlas_prefix[$i]}'),
            output_file = '${out}/${atlas_prefix[$i]}.ssGSEA.html')"
done
            
