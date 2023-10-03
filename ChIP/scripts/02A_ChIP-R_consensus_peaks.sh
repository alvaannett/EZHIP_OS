#!/usr/bin/bash
#SBATCH --job-name=01D_ChIP-R 
#SBATCH --account=rrg-jabado-ab
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00
#SBATCH --mem-per-cpu 2G
#SBATCH --output=logs/%x.out
#SBATCH --error=logs/%x.err

module load mugqic/python/3.10.4

bed1="out/01A_genpipes_chipseq/peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak"
bed2="out/01A_genpipes_chipseq/peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak"
bed3="out/01A_genpipes_chipseq/peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak"

chipr \
 -i ${bed1} ${bed2} ${bed3} \
 -m 2 \
 -o out/02_consensus_peaks/consensus_wt.chipr
