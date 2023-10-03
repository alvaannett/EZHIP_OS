#!/usr/bin/env bash
#SBATCH --job-name=04_call_domains
#SBATCH --account=rrg-jabado-ab
#SBATCH --cpus-per-task=20
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu 5G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module add StdEnv/2020 gcc/9.3.0 r-bundle-bioconductor/3.12

#run r script 
Rscript ./scripts/src/call_domains.R


