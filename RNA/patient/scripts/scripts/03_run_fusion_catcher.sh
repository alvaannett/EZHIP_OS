#!/usr/bin/bash
#SBATCH --job-name=fusioncatcher_snakemake
#SBATCH --account=rrg-jabado-ab
#SBATCH --ntasks=8 
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=20GB
#SBATCH --time=24:00:00
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

SNAKEFILE="/lustre06/project/6004736/alvann/from_narval/PIPELINES/FusionCatcher/snakefile"
CONFIG="files/fusion_catcher_files/config.yml" 

snakemake -s ${SNAKEFILE} --configfile ${CONFIG} -c 40 --rerun-incomplete

