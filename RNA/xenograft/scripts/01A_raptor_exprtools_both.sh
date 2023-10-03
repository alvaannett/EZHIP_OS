#!/usr/bin/bash
#SBATCH --job-name=01_raptor_exprtools_both
#SBATCH --account=rrg-kleinman
#SBATCH --cpus-per-task=10
#SBATCH --time=1:00:00
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load raptor-exprtools/v0

mkdir out/01_raptor_exprtools/both
cd out/01_raptor_exprtools/both

# copy info files
cp ../../../files/raptor_files/both/* .

# run exprtools
exprtools fetch
exprtools normalize
exprtools cluster -f var -n 10000
exprtools diff
exprtools report
