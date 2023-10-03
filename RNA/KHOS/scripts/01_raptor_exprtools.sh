#!/usr/bin/bash
#SBATCH --job-name=raptor_exprtools
#SBATCH --account=rrg-kleinman
#SBATCH --cpus-per-task=10
#SBATCH --time=1:00:00
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load raptor-exprtools/v0

mkdir out/01_raptor_exprtools/
cd out/01_raptor_exprtools/

# copy info files
cp ../../files/raptor_files/* .

# run exprtools
exprtools fetch
exprtools normalize
exprtools cluster -f var -n 10000
exprtools diff
exprtools report
