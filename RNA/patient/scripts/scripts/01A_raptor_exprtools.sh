#!/usr/bin/bash
#SBATCH --job-name=01_raptor_exprtools
#SBATCH --account=def-jabado
#SBATCH --cpus-per-task=10
#SBATCH --time=1:00:00
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load raptor-exprtools/v0

mkdir -p out/01_raptor_exprtools/EZHIP_negVsEZHIP_pos_no_reps_filt
cd out/01_raptor_exprtools/EZHIP_negVsEZHIP_pos_no_reps_filt

# copy info files
cp ../../../files/raptor_files/EZHIP_negVsEZHIP_pos_no_reps_filt/* .

# run exprtools
exprtools fetch
exprtools normalize
exprtools cluster -f var -n 10000
exprtools diff
exprtools report
