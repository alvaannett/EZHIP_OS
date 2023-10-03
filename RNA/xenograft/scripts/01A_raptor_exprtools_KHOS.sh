#!/usr/bin/bash
#SBATCH --job-name=01_raptor_exprtools_KHOS
#SBATCH --account=rrg-kleinman
#SBATCH --cpus-per-task=10
#SBATCH --time=1:00:00
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load raptor-exprtools/v0

mkdir out/01_raptor_exprtools/KHOS
cd out/01_raptor_exprtools/KHOS

# copy info files
cp ../../../files/raptor_files/KHOS/* .

# run exprtools
exprtools fetch
exprtools normalize
exprtools cluster -f var -n 10000
exprtools diff
exprtools report
