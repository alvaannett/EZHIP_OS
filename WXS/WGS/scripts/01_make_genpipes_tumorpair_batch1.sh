#!/bin/bash

module load mugqic/python/3.9.1
module load mugqic/genpipes/4.3.0

tumor_pair.py \
     -c $MUGQIC_PIPELINES_HOME/pipelines/tumor_pair/tumor_pair.base.ini \
        $MUGQIC_PIPELINES_HOME/pipelines/common_ini/narval.ini \
        $MUGQIC_PIPELINES_HOME/pipelines/tumor_pair/tumor_pair.extras.ini \
        files/genpipes_files_batch1/user.config.ini \
     -r files/genpipes_files_batch1/readset.tsv \
     -p files/genpipes_files_batch1/pairs.csv \
     -o out/01_genpipes_tumorpair \
     -g scripts/01_run_genpipes_tumorpair.sh \
     -s 1-41 
