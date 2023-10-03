#!/usr/bin/bash
#SBATCH --job-name=03_deeptools_snakemake
#SBATCH --account=def-jabado
#SBATCH --cpus-per-task=10
#SBATCH --time=03:00:00
#SBATCH --mem-per-cpu=5G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

CONFIG="files/deeptools_files/config.yml"
SNAKEFILE="/lustre06/project/6004736/alvann/from_narval/PIPELINES/DeepTools/snakefile"

# script to launch snakemake pipeline and crate rule graph at end
snakemake \
 -s ${SNAKEFILE} \
 --configfile ${CONFIG} \
 -c 10 \
 --rerun-incomplete

