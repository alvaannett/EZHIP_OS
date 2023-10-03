#!/bin/bash

# Generate and submit jobs for chipseq.py pipeline

module load mugqic/python/2.7.14
module load mugqic/genpipes/3.6.2

# More memory for picard collect metrics with custom config

readsets="files/genpipes_files/readsets.noInput.tsv"
designfile="files/genpipes_files/design.tsv"
out="out/01_genpipes_chipseq"
run_script="scripts/01A_run_genpipes.sh"

chipseq.py \
 -c $MUGQIC_PIPELINES_HOME/pipelines/chipseq/chipseq.base.ini \
    $MUGQIC_PIPELINES_HOME/pipelines/chipseq/chipseq.beluga.ini \
 -r $readsets \
 -d $designfile \
 -o $out \
 -g $run_script  

