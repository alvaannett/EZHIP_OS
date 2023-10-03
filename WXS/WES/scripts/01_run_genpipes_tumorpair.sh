#!/bin/bash
# Exit immediately on error

set -eu -o pipefail

#-------------------------------------------------------------------------------
# TumorPair SLURM Job Submission Bash script
# Version: 4.3.0
# Created on: 2022-12-20T11:43:31
# Steps:
#   picard_sam_to_fastq: 0 job... skipping
#   skewer_trimming: 10 jobs
#   bwa_mem_sambamba_sort_sam: 10 jobs
#   sambamba_merge_sam_files: 6 jobs
#   gatk_indel_realigner: 18 jobs
#   sambamba_merge_realigned: 6 jobs
#   sambamba_mark_duplicates: 6 jobs
#   recalibration: 12 jobs
#   conpair_concordance_contamination: 9 jobs
#   metrics_dna_picard_metrics: 24 jobs
#   metrics_dna_sample_qualimap: 6 jobs
#   metrics_dna_fastqc: 6 jobs
#   sequenza: 81 jobs
#   manta_sv_calls: 3 jobs
#   strelka2_paired_somatic: 6 jobs
#   strelka2_paired_germline: 6 jobs
#   strelka2_paired_germline_snpeff: 9 jobs
#   purple: 12 jobs
#   rawmpileup: 3 jobs
#   paired_varscan2: 3 jobs
#   merge_varscan2: 3 jobs
#   paired_mutect2: 3 jobs
#   merge_mutect2: 3 jobs
#   vardict_paired: 6 jobs
#   merge_filter_paired_vardict: 3 jobs
#   ensemble_somatic: 3 jobs
#   gatk_variant_annotator_somatic: 3 jobs
#   merge_gatk_variant_annotator_somatic: 0 job... skipping
#   ensemble_germline_loh: 3 jobs
#   gatk_variant_annotator_germline: 3 jobs
#   merge_gatk_variant_annotator_germline: 0 job... skipping
#   cnvkit_batch: 12 jobs
#   filter_ensemble_germline: 3 jobs
#   filter_ensemble_somatic: 3 jobs
#   report_cpsr: 3 jobs
#   report_pcgr: 3 jobs
#   run_pair_multiqc: 3 jobs
#   sym_link_fastq_pair: 12 jobs
#   sym_link_final_bam: 12 jobs
#   sym_link_report: 3 jobs
#   sym_link_ensemble: 3 jobs
#   TOTAL: 323 jobs
#-------------------------------------------------------------------------------

OUTPUT_DIR=/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3
JOB_OUTPUT_DIR=$OUTPUT_DIR/job_output
TIMESTAMP=`date +%FT%H.%M.%S`
JOB_LIST=$JOB_OUTPUT_DIR/TumorPair_job_list_$TIMESTAMP
export CONFIG_FILES="/cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-4.3.0/pipelines/tumor_pair/tumor_pair.base.ini,/cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-4.3.0/pipelines/common_ini/narval.ini,/cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-4.3.0/pipelines/tumor_pair/tumor_pair.extras.ini,/cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-4.3.0/pipelines/tumor_pair/tumor_pair.exome.ini,files/genpipes_files_batch3/user.config.ini"
mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

#-------------------------------------------------------------------------------
# STEP: skewer_trimming
#-------------------------------------------------------------------------------
STEP=skewer_trimming
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_1_JOB_ID: skewer_trimming.SISJ0635_N_RS1
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0635_N_RS1
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0635_N_RS1.008b032ffa02b02b9b0b2e6daa78cbdf.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0635_N_RS1.008b032ffa02b02b9b0b2e6daa78cbdf.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0635_N && \
touch trim/SISJ0635_N && \
`cat > trim/SISJ0635_N/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0635_N/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_N/reads/raw/173137_SISJ0635_N_WES_blood_43580_S10_L001_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_N/reads/raw/173137_SISJ0635_N_WES_blood_43580_S10_L001_R2.fastq.gz \
  -o trim/SISJ0635_N/SISJ0635_N_RS1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS1-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS1.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS1-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS1.trim.pair2.fastq.gz
skewer_trimming.SISJ0635_N_RS1.008b032ffa02b02b9b0b2e6daa78cbdf.mugqic.done
chmod 755 $COMMAND
skewer_trimming_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_2_JOB_ID: skewer_trimming.SISJ0635_N_RS2
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0635_N_RS2
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0635_N_RS2.492a5dddc97f75c4df63597507eebf70.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0635_N_RS2.492a5dddc97f75c4df63597507eebf70.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0635_N && \
touch trim/SISJ0635_N && \
`cat > trim/SISJ0635_N/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0635_N/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_N/reads/raw/173137_SISJ0635_N_WES_blood_43580_S10_L002_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_N/reads/raw/173137_SISJ0635_N_WES_blood_43580_S10_L002_R2.fastq.gz \
  -o trim/SISJ0635_N/SISJ0635_N_RS2 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS2-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS2.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS2-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_N/SISJ0635_N_RS2.trim.pair2.fastq.gz
skewer_trimming.SISJ0635_N_RS2.492a5dddc97f75c4df63597507eebf70.mugqic.done
chmod 755 $COMMAND
skewer_trimming_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_3_JOB_ID: skewer_trimming.SISJ0635_T_RS1
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0635_T_RS1
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0635_T_RS1.998832e731245ed8ccca58e6d828a152.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0635_T_RS1.998832e731245ed8ccca58e6d828a152.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0635_T && \
touch trim/SISJ0635_T && \
`cat > trim/SISJ0635_T/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0635_T/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_T/reads/raw/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_T/reads/raw/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R2.fastq.gz \
  -o trim/SISJ0635_T/SISJ0635_T_RS1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS1-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS1.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS1-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS1.trim.pair2.fastq.gz
skewer_trimming.SISJ0635_T_RS1.998832e731245ed8ccca58e6d828a152.mugqic.done
chmod 755 $COMMAND
skewer_trimming_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_4_JOB_ID: skewer_trimming.SISJ0635_T_RS2
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0635_T_RS2
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0635_T_RS2.12db0af6d40ecc3e668cc040f0bf17a2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0635_T_RS2.12db0af6d40ecc3e668cc040f0bf17a2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0635_T && \
touch trim/SISJ0635_T && \
`cat > trim/SISJ0635_T/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0635_T/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_T/reads/raw/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L002_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_T/reads/raw/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L002_R2.fastq.gz \
  -o trim/SISJ0635_T/SISJ0635_T_RS2 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS2-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS2.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS2-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0635_T/SISJ0635_T_RS2.trim.pair2.fastq.gz
skewer_trimming.SISJ0635_T_RS2.12db0af6d40ecc3e668cc040f0bf17a2.mugqic.done
chmod 755 $COMMAND
skewer_trimming_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_5_JOB_ID: skewer_trimming.SISJ0732_N_RS1
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0732_N_RS1
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0732_N_RS1.ab4c7478a26436acc07578eddac0d7a1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0732_N_RS1.ab4c7478a26436acc07578eddac0d7a1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0732_N && \
touch trim/SISJ0732_N && \
`cat > trim/SISJ0732_N/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0732_N/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_N/reads/raw/176397_SISJ0732_N_WES_blood_44103_S3_L001_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_N/reads/raw/176397_SISJ0732_N_WES_blood_44103_S3_L001_R2.fastq.gz \
  -o trim/SISJ0732_N/SISJ0732_N_RS1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS1-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS1.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS1-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS1.trim.pair2.fastq.gz
skewer_trimming.SISJ0732_N_RS1.ab4c7478a26436acc07578eddac0d7a1.mugqic.done
chmod 755 $COMMAND
skewer_trimming_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_6_JOB_ID: skewer_trimming.SISJ0732_N_RS2
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0732_N_RS2
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0732_N_RS2.68a9b75bca06c5db62e37e8d3625c6d9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0732_N_RS2.68a9b75bca06c5db62e37e8d3625c6d9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0732_N && \
touch trim/SISJ0732_N && \
`cat > trim/SISJ0732_N/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0732_N/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_N/reads/raw/176397_SISJ0732_N_WES_blood_44103_S3_L002_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_N/reads/raw/176397_SISJ0732_N_WES_blood_44103_S3_L002_R2.fastq.gz \
  -o trim/SISJ0732_N/SISJ0732_N_RS2 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS2-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS2.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS2-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_N/SISJ0732_N_RS2.trim.pair2.fastq.gz
skewer_trimming.SISJ0732_N_RS2.68a9b75bca06c5db62e37e8d3625c6d9.mugqic.done
chmod 755 $COMMAND
skewer_trimming_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_7_JOB_ID: skewer_trimming.SISJ0732_T_RS1
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0732_T_RS1
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0732_T_RS1.a6de1e070d66467520b09970969c0257.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0732_T_RS1.a6de1e070d66467520b09970969c0257.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0732_T && \
touch trim/SISJ0732_T && \
`cat > trim/SISJ0732_T/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0732_T/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_T/reads/raw/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_T/reads/raw/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R2.fastq.gz \
  -o trim/SISJ0732_T/SISJ0732_T_RS1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS1-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS1.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS1-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS1.trim.pair2.fastq.gz
skewer_trimming.SISJ0732_T_RS1.a6de1e070d66467520b09970969c0257.mugqic.done
chmod 755 $COMMAND
skewer_trimming_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_8_JOB_ID: skewer_trimming.SISJ0732_T_RS2
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.SISJ0732_T_RS2
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.SISJ0732_T_RS2.b7bfe7a0ecf13637e9c8815ff9b24718.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.SISJ0732_T_RS2.b7bfe7a0ecf13637e9c8815ff9b24718.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/SISJ0732_T && \
touch trim/SISJ0732_T && \
`cat > trim/SISJ0732_T/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/SISJ0732_T/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_T/reads/raw/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L002_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_T/reads/raw/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L002_R2.fastq.gz \
  -o trim/SISJ0732_T/SISJ0732_T_RS2 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS2-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS2.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS2-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/SISJ0732_T/SISJ0732_T_RS2.trim.pair2.fastq.gz
skewer_trimming.SISJ0732_T_RS2.b7bfe7a0ecf13637e9c8815ff9b24718.mugqic.done
chmod 755 $COMMAND
skewer_trimming_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_9_JOB_ID: skewer_trimming.TCMG240_T1_RS1
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.TCMG240_T1_RS1
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.TCMG240_T1_RS1.acd0311104db330f2b02171a2ac46e7d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.TCMG240_T1_RS1.acd0311104db330f2b02171a2ac46e7d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/TCMG240_T1 && \
touch trim/TCMG240_T1 && \
`cat > trim/TCMG240_T1/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/TCMG240_T1/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_T1/reads/raw/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_T1/reads/raw/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R2.fastq.gz \
  -o trim/TCMG240_T1/TCMG240_T1_RS1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_T1/TCMG240_T1_RS1-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_T1/TCMG240_T1_RS1.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_T1/TCMG240_T1_RS1-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_T1/TCMG240_T1_RS1.trim.pair2.fastq.gz
skewer_trimming.TCMG240_T1_RS1.acd0311104db330f2b02171a2ac46e7d.mugqic.done
chmod 755 $COMMAND
skewer_trimming_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: skewer_trimming_10_JOB_ID: skewer_trimming.TCMG240_N_RS1
#-------------------------------------------------------------------------------
JOB_NAME=skewer_trimming.TCMG240_N_RS1
JOB_DEPENDENCIES=
JOB_DONE=job_output/skewer_trimming/skewer_trimming.TCMG240_N_RS1.6e0cd3adc62a7372f22f7d3805fcb1f9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'skewer_trimming.TCMG240_N_RS1.6e0cd3adc62a7372f22f7d3805fcb1f9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/skewer/0.2.2 && \
mkdir -p trim/TCMG240_N && \
touch trim/TCMG240_N && \
`cat > trim/TCMG240_N/adapter.tsv << END
>Adapter1
AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2
 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
$SKEWER_HOME/./skewer --threads 16 --min 25 -q 25 --compress -f sanger \
  -x trim/TCMG240_N/adapter.tsv \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_N/reads/raw/166081_TCMG240_N_WES_blood_42467_S3_L001_R1.fastq.gz \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_N/reads/raw/166081_TCMG240_N_WES_blood_42467_S3_L001_R2.fastq.gz \
  -o trim/TCMG240_N/TCMG240_N_RS1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_N/TCMG240_N_RS1-trimmed-pair1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_N/TCMG240_N_RS1.trim.pair1.fastq.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_N/TCMG240_N_RS1-trimmed-pair2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/trim/TCMG240_N/TCMG240_N_RS1.trim.pair2.fastq.gz
skewer_trimming.TCMG240_N_RS1.6e0cd3adc62a7372f22f7d3805fcb1f9.mugqic.done
chmod 755 $COMMAND
skewer_trimming_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 16 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$skewer_trimming_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$skewer_trimming_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: bwa_mem_sambamba_sort_sam
#-------------------------------------------------------------------------------
STEP=bwa_mem_sambamba_sort_sam
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_1_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0635_N_RS1
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0635_N_RS1
JOB_DEPENDENCIES=$skewer_trimming_1_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0635_N_RS1.ed60cba857f7cade46c2bef730b1df27.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0635_N_RS1.ed60cba857f7cade46c2bef730b1df27.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0635_N/SISJ0635_N_RS1 && \
touch alignment/SISJ0635_N/SISJ0635_N_RS1 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0635_N_RS1\tSM:SISJ0635_N\tLB:SISJ0635_N\tPU:SISJ0635_N.1.1\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0635_N/SISJ0635_N_RS1.trim.pair1.fastq.gz \
  trim/SISJ0635_N/SISJ0635_N_RS1.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0635_N/SISJ0635_N_RS1/SISJ0635_N_RS1.sorted.bam && \
sambamba index  \
  alignment/SISJ0635_N/SISJ0635_N_RS1/SISJ0635_N_RS1.sorted.bam \
  alignment/SISJ0635_N/SISJ0635_N_RS1/SISJ0635_N_RS1.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0635_N_RS1.ed60cba857f7cade46c2bef730b1df27.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_2_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0635_N_RS2
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0635_N_RS2
JOB_DEPENDENCIES=$skewer_trimming_2_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0635_N_RS2.44d408d4ba245be123c76c0393373852.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0635_N_RS2.44d408d4ba245be123c76c0393373852.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0635_N/SISJ0635_N_RS2 && \
touch alignment/SISJ0635_N/SISJ0635_N_RS2 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0635_N_RS2\tSM:SISJ0635_N\tLB:SISJ0635_N\tPU:SISJ0635_N.1.2\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0635_N/SISJ0635_N_RS2.trim.pair1.fastq.gz \
  trim/SISJ0635_N/SISJ0635_N_RS2.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0635_N/SISJ0635_N_RS2/SISJ0635_N_RS2.sorted.bam && \
sambamba index  \
  alignment/SISJ0635_N/SISJ0635_N_RS2/SISJ0635_N_RS2.sorted.bam \
  alignment/SISJ0635_N/SISJ0635_N_RS2/SISJ0635_N_RS2.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0635_N_RS2.44d408d4ba245be123c76c0393373852.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_3_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0635_T_RS1
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0635_T_RS1
JOB_DEPENDENCIES=$skewer_trimming_3_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0635_T_RS1.30ddfef8bcc4add0b2d2a30c52b81a39.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0635_T_RS1.30ddfef8bcc4add0b2d2a30c52b81a39.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0635_T/SISJ0635_T_RS1 && \
touch alignment/SISJ0635_T/SISJ0635_T_RS1 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0635_T_RS1\tSM:SISJ0635_T\tLB:SISJ0635_T\tPU:SISJ0635_T.1.1\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0635_T/SISJ0635_T_RS1.trim.pair1.fastq.gz \
  trim/SISJ0635_T/SISJ0635_T_RS1.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0635_T/SISJ0635_T_RS1/SISJ0635_T_RS1.sorted.bam && \
sambamba index  \
  alignment/SISJ0635_T/SISJ0635_T_RS1/SISJ0635_T_RS1.sorted.bam \
  alignment/SISJ0635_T/SISJ0635_T_RS1/SISJ0635_T_RS1.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0635_T_RS1.30ddfef8bcc4add0b2d2a30c52b81a39.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_4_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0635_T_RS2
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0635_T_RS2
JOB_DEPENDENCIES=$skewer_trimming_4_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0635_T_RS2.918397b79c0d0c876a0f3ac3806b28c1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0635_T_RS2.918397b79c0d0c876a0f3ac3806b28c1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0635_T/SISJ0635_T_RS2 && \
touch alignment/SISJ0635_T/SISJ0635_T_RS2 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0635_T_RS2\tSM:SISJ0635_T\tLB:SISJ0635_T\tPU:SISJ0635_T.1.2\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0635_T/SISJ0635_T_RS2.trim.pair1.fastq.gz \
  trim/SISJ0635_T/SISJ0635_T_RS2.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0635_T/SISJ0635_T_RS2/SISJ0635_T_RS2.sorted.bam && \
sambamba index  \
  alignment/SISJ0635_T/SISJ0635_T_RS2/SISJ0635_T_RS2.sorted.bam \
  alignment/SISJ0635_T/SISJ0635_T_RS2/SISJ0635_T_RS2.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0635_T_RS2.918397b79c0d0c876a0f3ac3806b28c1.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_5_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0732_N_RS1
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0732_N_RS1
JOB_DEPENDENCIES=$skewer_trimming_5_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0732_N_RS1.a3b256fd81be84c8f96574c6b4bdd62d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0732_N_RS1.a3b256fd81be84c8f96574c6b4bdd62d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0732_N/SISJ0732_N_RS1 && \
touch alignment/SISJ0732_N/SISJ0732_N_RS1 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0732_N_RS1\tSM:SISJ0732_N\tLB:SISJ0732_N\tPU:SISJ0732_N.1.1\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0732_N/SISJ0732_N_RS1.trim.pair1.fastq.gz \
  trim/SISJ0732_N/SISJ0732_N_RS1.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0732_N/SISJ0732_N_RS1/SISJ0732_N_RS1.sorted.bam && \
sambamba index  \
  alignment/SISJ0732_N/SISJ0732_N_RS1/SISJ0732_N_RS1.sorted.bam \
  alignment/SISJ0732_N/SISJ0732_N_RS1/SISJ0732_N_RS1.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0732_N_RS1.a3b256fd81be84c8f96574c6b4bdd62d.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_6_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0732_N_RS2
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0732_N_RS2
JOB_DEPENDENCIES=$skewer_trimming_6_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0732_N_RS2.f4f3475d8fd0bdad3a3d9aeeb24ef846.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0732_N_RS2.f4f3475d8fd0bdad3a3d9aeeb24ef846.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0732_N/SISJ0732_N_RS2 && \
touch alignment/SISJ0732_N/SISJ0732_N_RS2 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0732_N_RS2\tSM:SISJ0732_N\tLB:SISJ0732_N\tPU:SISJ0732_N.1.2\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0732_N/SISJ0732_N_RS2.trim.pair1.fastq.gz \
  trim/SISJ0732_N/SISJ0732_N_RS2.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0732_N/SISJ0732_N_RS2/SISJ0732_N_RS2.sorted.bam && \
sambamba index  \
  alignment/SISJ0732_N/SISJ0732_N_RS2/SISJ0732_N_RS2.sorted.bam \
  alignment/SISJ0732_N/SISJ0732_N_RS2/SISJ0732_N_RS2.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0732_N_RS2.f4f3475d8fd0bdad3a3d9aeeb24ef846.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_7_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0732_T_RS1
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0732_T_RS1
JOB_DEPENDENCIES=$skewer_trimming_7_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0732_T_RS1.617d2b05466550d3bfe92a700383bac0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0732_T_RS1.617d2b05466550d3bfe92a700383bac0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0732_T/SISJ0732_T_RS1 && \
touch alignment/SISJ0732_T/SISJ0732_T_RS1 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0732_T_RS1\tSM:SISJ0732_T\tLB:SISJ0732_T\tPU:SISJ0732_T.1.1\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0732_T/SISJ0732_T_RS1.trim.pair1.fastq.gz \
  trim/SISJ0732_T/SISJ0732_T_RS1.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0732_T/SISJ0732_T_RS1/SISJ0732_T_RS1.sorted.bam && \
sambamba index  \
  alignment/SISJ0732_T/SISJ0732_T_RS1/SISJ0732_T_RS1.sorted.bam \
  alignment/SISJ0732_T/SISJ0732_T_RS1/SISJ0732_T_RS1.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0732_T_RS1.617d2b05466550d3bfe92a700383bac0.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_8_JOB_ID: bwa_mem_sambamba_sort_sam.SISJ0732_T_RS2
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.SISJ0732_T_RS2
JOB_DEPENDENCIES=$skewer_trimming_8_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.SISJ0732_T_RS2.623669b882bd6a33a4b1c153805fb90e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.SISJ0732_T_RS2.623669b882bd6a33a4b1c153805fb90e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0732_T/SISJ0732_T_RS2 && \
touch alignment/SISJ0732_T/SISJ0732_T_RS2 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:SISJ0732_T_RS2\tSM:SISJ0732_T\tLB:SISJ0732_T\tPU:SISJ0732_T.1.2\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/SISJ0732_T/SISJ0732_T_RS2.trim.pair1.fastq.gz \
  trim/SISJ0732_T/SISJ0732_T_RS2.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/SISJ0732_T/SISJ0732_T_RS2/SISJ0732_T_RS2.sorted.bam && \
sambamba index  \
  alignment/SISJ0732_T/SISJ0732_T_RS2/SISJ0732_T_RS2.sorted.bam \
  alignment/SISJ0732_T/SISJ0732_T_RS2/SISJ0732_T_RS2.sorted.bam.bai
bwa_mem_sambamba_sort_sam.SISJ0732_T_RS2.623669b882bd6a33a4b1c153805fb90e.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_9_JOB_ID: bwa_mem_sambamba_sort_sam.TCMG240_T1_RS1
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.TCMG240_T1_RS1
JOB_DEPENDENCIES=$skewer_trimming_9_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.TCMG240_T1_RS1.18754e5c4894fcd841126ac1f547e3c2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.TCMG240_T1_RS1.18754e5c4894fcd841126ac1f547e3c2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/TCMG240_T1/TCMG240_T1_RS1 && \
touch alignment/TCMG240_T1/TCMG240_T1_RS1 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:TCMG240_T1_RS1\tSM:TCMG240_T1\tLB:TCMG240_T1\tPU:TCMG240_T1.1.1\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/TCMG240_T1/TCMG240_T1_RS1.trim.pair1.fastq.gz \
  trim/TCMG240_T1/TCMG240_T1_RS1.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/TCMG240_T1/TCMG240_T1_RS1/TCMG240_T1_RS1.sorted.bam && \
sambamba index  \
  alignment/TCMG240_T1/TCMG240_T1_RS1/TCMG240_T1_RS1.sorted.bam \
  alignment/TCMG240_T1/TCMG240_T1_RS1/TCMG240_T1_RS1.sorted.bam.bai
bwa_mem_sambamba_sort_sam.TCMG240_T1_RS1.18754e5c4894fcd841126ac1f547e3c2.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: bwa_mem_sambamba_sort_sam_10_JOB_ID: bwa_mem_sambamba_sort_sam.TCMG240_N_RS1
#-------------------------------------------------------------------------------
JOB_NAME=bwa_mem_sambamba_sort_sam.TCMG240_N_RS1
JOB_DEPENDENCIES=$skewer_trimming_10_JOB_ID
JOB_DONE=job_output/bwa_mem_sambamba_sort_sam/bwa_mem_sambamba_sort_sam.TCMG240_N_RS1.0897efb236e2b36eec3ea2b39cc51be6.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bwa_mem_sambamba_sort_sam.TCMG240_N_RS1.0897efb236e2b36eec3ea2b39cc51be6.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bwa/0.7.17 mugqic/sambamba/0.8.0 && \
mkdir -p alignment/TCMG240_N/TCMG240_N_RS1 && \
touch alignment/TCMG240_N/TCMG240_N_RS1 && \
bwa mem -t 16 -K 100000000 -Y \
   \
  -R '@RG\tID:TCMG240_N_RS1\tSM:TCMG240_N\tLB:TCMG240_N\tPU:TCMG240_N.1.1\tCN:McGill University and Genome Quebec Innovation Centre\tPL:Illumina' \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/bwa_index/Homo_sapiens.GRCh37.fa \
  trim/TCMG240_N/TCMG240_N_RS1.trim.pair1.fastq.gz \
  trim/TCMG240_N/TCMG240_N_RS1.trim.pair2.fastq.gz | \
sambamba view -S -f bam \
  /dev/stdin \
    | \
sambamba sort -m 10G \
  /dev/stdin \
  --tmpdir ${SLURM_TMPDIR} \
  --out alignment/TCMG240_N/TCMG240_N_RS1/TCMG240_N_RS1.sorted.bam && \
sambamba index  \
  alignment/TCMG240_N/TCMG240_N_RS1/TCMG240_N_RS1.sorted.bam \
  alignment/TCMG240_N/TCMG240_N_RS1/TCMG240_N_RS1.sorted.bam.bai
bwa_mem_sambamba_sort_sam.TCMG240_N_RS1.0897efb236e2b36eec3ea2b39cc51be6.mugqic.done
chmod 755 $COMMAND
bwa_mem_sambamba_sort_sam_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 60G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$bwa_mem_sambamba_sort_sam_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$bwa_mem_sambamba_sort_sam_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sambamba_merge_sam_files
#-------------------------------------------------------------------------------
STEP=sambamba_merge_sam_files
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_sam_files_1_JOB_ID: sambamba_merge_sam_files.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_sam_files.SISJ0635_N
JOB_DEPENDENCIES=$bwa_mem_sambamba_sort_sam_1_JOB_ID:$bwa_mem_sambamba_sort_sam_2_JOB_ID
JOB_DONE=job_output/sambamba_merge_sam_files/sambamba_merge_sam_files.SISJ0635_N.c2797f4a1edeeb65bef735790d9986aa.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_sam_files.SISJ0635_N.c2797f4a1edeeb65bef735790d9986aa.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0635_N && \
touch alignment/SISJ0635_N && \
sambamba merge -t 16 \
  alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
   \
  alignment/SISJ0635_N/SISJ0635_N_RS1/SISJ0635_N_RS1.sorted.bam \
  alignment/SISJ0635_N/SISJ0635_N_RS2/SISJ0635_N_RS2.sorted.bam
sambamba_merge_sam_files.SISJ0635_N.c2797f4a1edeeb65bef735790d9986aa.mugqic.done
chmod 755 $COMMAND
sambamba_merge_sam_files_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_sam_files_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_sam_files_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_sam_files_2_JOB_ID: sambamba_merge_sam_files.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_sam_files.SISJ0635_T
JOB_DEPENDENCIES=$bwa_mem_sambamba_sort_sam_3_JOB_ID:$bwa_mem_sambamba_sort_sam_4_JOB_ID
JOB_DONE=job_output/sambamba_merge_sam_files/sambamba_merge_sam_files.SISJ0635_T.197df4d313aae3a36e4ab9e1fe9fc573.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_sam_files.SISJ0635_T.197df4d313aae3a36e4ab9e1fe9fc573.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0635_T && \
touch alignment/SISJ0635_T && \
sambamba merge -t 16 \
  alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
   \
  alignment/SISJ0635_T/SISJ0635_T_RS1/SISJ0635_T_RS1.sorted.bam \
  alignment/SISJ0635_T/SISJ0635_T_RS2/SISJ0635_T_RS2.sorted.bam
sambamba_merge_sam_files.SISJ0635_T.197df4d313aae3a36e4ab9e1fe9fc573.mugqic.done
chmod 755 $COMMAND
sambamba_merge_sam_files_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_sam_files_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_sam_files_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_sam_files_3_JOB_ID: sambamba_merge_sam_files.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_sam_files.SISJ0732_N
JOB_DEPENDENCIES=$bwa_mem_sambamba_sort_sam_5_JOB_ID:$bwa_mem_sambamba_sort_sam_6_JOB_ID
JOB_DONE=job_output/sambamba_merge_sam_files/sambamba_merge_sam_files.SISJ0732_N.6f117b64c80ba885518094b44d961173.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_sam_files.SISJ0732_N.6f117b64c80ba885518094b44d961173.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0732_N && \
touch alignment/SISJ0732_N && \
sambamba merge -t 16 \
  alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
   \
  alignment/SISJ0732_N/SISJ0732_N_RS1/SISJ0732_N_RS1.sorted.bam \
  alignment/SISJ0732_N/SISJ0732_N_RS2/SISJ0732_N_RS2.sorted.bam
sambamba_merge_sam_files.SISJ0732_N.6f117b64c80ba885518094b44d961173.mugqic.done
chmod 755 $COMMAND
sambamba_merge_sam_files_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_sam_files_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_sam_files_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_sam_files_4_JOB_ID: sambamba_merge_sam_files.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_sam_files.SISJ0732_T
JOB_DEPENDENCIES=$bwa_mem_sambamba_sort_sam_7_JOB_ID:$bwa_mem_sambamba_sort_sam_8_JOB_ID
JOB_DONE=job_output/sambamba_merge_sam_files/sambamba_merge_sam_files.SISJ0732_T.06c649589f3b079d906fb231c2556c33.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_sam_files.SISJ0732_T.06c649589f3b079d906fb231c2556c33.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
mkdir -p alignment/SISJ0732_T && \
touch alignment/SISJ0732_T && \
sambamba merge -t 16 \
  alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
   \
  alignment/SISJ0732_T/SISJ0732_T_RS1/SISJ0732_T_RS1.sorted.bam \
  alignment/SISJ0732_T/SISJ0732_T_RS2/SISJ0732_T_RS2.sorted.bam
sambamba_merge_sam_files.SISJ0732_T.06c649589f3b079d906fb231c2556c33.mugqic.done
chmod 755 $COMMAND
sambamba_merge_sam_files_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_sam_files_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_sam_files_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_sam_files_5_JOB_ID: symlink_readset_sample_bam.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=symlink_readset_sample_bam.TCMG240_T1
JOB_DEPENDENCIES=$bwa_mem_sambamba_sort_sam_9_JOB_ID
JOB_DONE=job_output/sambamba_merge_sam_files/symlink_readset_sample_bam.TCMG240_T1.1acb6426483bb3984ce824d1b90683a4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'symlink_readset_sample_bam.TCMG240_T1.1acb6426483bb3984ce824d1b90683a4.mugqic.done' > $COMMAND
mkdir -p alignment/TCMG240_T1 && \
touch alignment/TCMG240_T1 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1_RS1/TCMG240_T1_RS1.sorted.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1_RS1/TCMG240_T1_RS1.sorted.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam.bai
symlink_readset_sample_bam.TCMG240_T1.1acb6426483bb3984ce824d1b90683a4.mugqic.done
chmod 755 $COMMAND
sambamba_merge_sam_files_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_sam_files_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_sam_files_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_sam_files_6_JOB_ID: symlink_readset_sample_bam.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=symlink_readset_sample_bam.TCMG240_N
JOB_DEPENDENCIES=$bwa_mem_sambamba_sort_sam_10_JOB_ID
JOB_DONE=job_output/sambamba_merge_sam_files/symlink_readset_sample_bam.TCMG240_N.038f22d58aee98cd819ffad124a11369.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'symlink_readset_sample_bam.TCMG240_N.038f22d58aee98cd819ffad124a11369.mugqic.done' > $COMMAND
mkdir -p alignment/TCMG240_N && \
touch alignment/TCMG240_N && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N_RS1/TCMG240_N_RS1.sorted.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N_RS1/TCMG240_N_RS1.sorted.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam.bai
symlink_readset_sample_bam.TCMG240_N.038f22d58aee98cd819ffad124a11369.mugqic.done
chmod 755 $COMMAND
sambamba_merge_sam_files_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_sam_files_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_sam_files_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: gatk_indel_realigner
#-------------------------------------------------------------------------------
STEP=gatk_indel_realigner
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_1_JOB_ID: gatk_indel_realigner.SISJ0635_T.0
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0635_T.0
JOB_DEPENDENCIES=$sambamba_merge_sam_files_1_JOB_ID:$sambamba_merge_sam_files_2_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0635_T.0.12696679ab10ed992039faeb62d4cb68.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0635_T.0.12696679ab10ed992039faeb62d4cb68.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0635_T && \
touch alignment/realign/SISJ0635_T && \
mkdir -p alignment/SISJ0635_N/realign && \
touch alignment/SISJ0635_N/realign && \
mkdir -p alignment/SISJ0635_T/realign && \
touch alignment/SISJ0635_T/realign && \
cd alignment/realign/SISJ0635_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/0.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 1 \
  --intervals 2 \
  --intervals 3 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.0.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/0.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 1 \
  --intervals 2 \
  --intervals 3 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.0.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.0.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.0.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.0.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.0.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.0.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.0.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.0.bai
gatk_indel_realigner.SISJ0635_T.0.12696679ab10ed992039faeb62d4cb68.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_2_JOB_ID: gatk_indel_realigner.SISJ0635_T.1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0635_T.1
JOB_DEPENDENCIES=$sambamba_merge_sam_files_1_JOB_ID:$sambamba_merge_sam_files_2_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0635_T.1.e2fbb7cb9a1f6b2096e6d5173c3df5b5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0635_T.1.e2fbb7cb9a1f6b2096e6d5173c3df5b5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0635_T && \
touch alignment/realign/SISJ0635_T && \
mkdir -p alignment/SISJ0635_N/realign && \
touch alignment/SISJ0635_N/realign && \
mkdir -p alignment/SISJ0635_T/realign && \
touch alignment/SISJ0635_T/realign && \
cd alignment/realign/SISJ0635_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/1.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 4 \
  --intervals 5 \
  --intervals 6 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.1.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/1.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 4 \
  --intervals 5 \
  --intervals 6 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.1.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.1.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.1.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.1.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.1.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.1.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.1.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.1.bai
gatk_indel_realigner.SISJ0635_T.1.e2fbb7cb9a1f6b2096e6d5173c3df5b5.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_3_JOB_ID: gatk_indel_realigner.SISJ0635_T.2
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0635_T.2
JOB_DEPENDENCIES=$sambamba_merge_sam_files_1_JOB_ID:$sambamba_merge_sam_files_2_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0635_T.2.215069b9e9ae6fd6d70e7f3c9fe92aa6.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0635_T.2.215069b9e9ae6fd6d70e7f3c9fe92aa6.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0635_T && \
touch alignment/realign/SISJ0635_T && \
mkdir -p alignment/SISJ0635_N/realign && \
touch alignment/SISJ0635_N/realign && \
mkdir -p alignment/SISJ0635_T/realign && \
touch alignment/SISJ0635_T/realign && \
cd alignment/realign/SISJ0635_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/2.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 7 \
  --intervals 8 \
  --intervals 9 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.2.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/2.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 7 \
  --intervals 8 \
  --intervals 9 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.2.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.2.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.2.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.2.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.2.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.2.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.2.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.2.bai
gatk_indel_realigner.SISJ0635_T.2.215069b9e9ae6fd6d70e7f3c9fe92aa6.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_4_JOB_ID: gatk_indel_realigner.SISJ0635_T.3
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0635_T.3
JOB_DEPENDENCIES=$sambamba_merge_sam_files_1_JOB_ID:$sambamba_merge_sam_files_2_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0635_T.3.21343124403d38ace465decce7026747.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0635_T.3.21343124403d38ace465decce7026747.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0635_T && \
touch alignment/realign/SISJ0635_T && \
mkdir -p alignment/SISJ0635_N/realign && \
touch alignment/SISJ0635_N/realign && \
mkdir -p alignment/SISJ0635_T/realign && \
touch alignment/SISJ0635_T/realign && \
cd alignment/realign/SISJ0635_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/3.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 10 \
  --intervals 11 \
  --intervals 12 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.3.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/3.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 10 \
  --intervals 11 \
  --intervals 12 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.3.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.3.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.3.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.3.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.3.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.3.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.3.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.3.bai
gatk_indel_realigner.SISJ0635_T.3.21343124403d38ace465decce7026747.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_5_JOB_ID: gatk_indel_realigner.SISJ0635_T.4
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0635_T.4
JOB_DEPENDENCIES=$sambamba_merge_sam_files_1_JOB_ID:$sambamba_merge_sam_files_2_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0635_T.4.cf0aa7d03bf29ca5e9b5ec9b236bcd9b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0635_T.4.cf0aa7d03bf29ca5e9b5ec9b236bcd9b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0635_T && \
touch alignment/realign/SISJ0635_T && \
mkdir -p alignment/SISJ0635_N/realign && \
touch alignment/SISJ0635_N/realign && \
mkdir -p alignment/SISJ0635_T/realign && \
touch alignment/SISJ0635_T/realign && \
cd alignment/realign/SISJ0635_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/4.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 13 \
  --intervals 14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.4.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/4.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 13 \
  --intervals 14 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.4.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.4.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.4.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.4.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.4.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.4.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.4.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.4.bai
gatk_indel_realigner.SISJ0635_T.4.cf0aa7d03bf29ca5e9b5ec9b236bcd9b.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_6_JOB_ID: gatk_indel_realigner.SISJ0635_T.others
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0635_T.others
JOB_DEPENDENCIES=$sambamba_merge_sam_files_1_JOB_ID:$sambamba_merge_sam_files_2_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0635_T.others.ed0cde2b1c350f3436ac77c94d88c1bc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0635_T.others.ed0cde2b1c350f3436ac77c94d88c1bc.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0635_T && \
touch alignment/realign/SISJ0635_T && \
mkdir -p alignment/SISJ0635_N/realign && \
touch alignment/SISJ0635_N/realign && \
mkdir -p alignment/SISJ0635_T/realign && \
touch alignment/SISJ0635_T/realign && \
cd alignment/realign/SISJ0635_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/others.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --excludeIntervals 1 \
  --excludeIntervals 2 \
  --excludeIntervals 3 \
  --excludeIntervals 4 \
  --excludeIntervals 5 \
  --excludeIntervals 6 \
  --excludeIntervals 7 \
  --excludeIntervals 8 \
  --excludeIntervals 9 \
  --excludeIntervals 10 \
  --excludeIntervals 11 \
  --excludeIntervals 12 \
  --excludeIntervals 13 \
  --excludeIntervals 14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.others.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/others.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --excludeIntervals 1 \
  --excludeIntervals 2 \
  --excludeIntervals 3 \
  --excludeIntervals 4 \
  --excludeIntervals 5 \
  --excludeIntervals 6 \
  --excludeIntervals 7 \
  --excludeIntervals 8 \
  --excludeIntervals 9 \
  --excludeIntervals 10 \
  --excludeIntervals 11 \
  --excludeIntervals 12 \
  --excludeIntervals 13 \
  --excludeIntervals 14 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.others.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.others.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_N.sorted.realigned.others.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.others.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.others.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.others.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0635_T/SISJ0635_T.sorted.realigned.others.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.others.bai
gatk_indel_realigner.SISJ0635_T.others.ed0cde2b1c350f3436ac77c94d88c1bc.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_7_JOB_ID: gatk_indel_realigner.SISJ0732_T.0
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0732_T.0
JOB_DEPENDENCIES=$sambamba_merge_sam_files_3_JOB_ID:$sambamba_merge_sam_files_4_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0732_T.0.67839ad99cf22e25b735e1081f932c33.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0732_T.0.67839ad99cf22e25b735e1081f932c33.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0732_T && \
touch alignment/realign/SISJ0732_T && \
mkdir -p alignment/SISJ0732_N/realign && \
touch alignment/SISJ0732_N/realign && \
mkdir -p alignment/SISJ0732_T/realign && \
touch alignment/SISJ0732_T/realign && \
cd alignment/realign/SISJ0732_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/0.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 1 \
  --intervals 2 \
  --intervals 3 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.0.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/0.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 1 \
  --intervals 2 \
  --intervals 3 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.0.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.0.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.0.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.0.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.0.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.0.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.0.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.0.bai
gatk_indel_realigner.SISJ0732_T.0.67839ad99cf22e25b735e1081f932c33.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_8_JOB_ID: gatk_indel_realigner.SISJ0732_T.1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0732_T.1
JOB_DEPENDENCIES=$sambamba_merge_sam_files_3_JOB_ID:$sambamba_merge_sam_files_4_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0732_T.1.5deb2182b312c5db5ff9e8710064edc0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0732_T.1.5deb2182b312c5db5ff9e8710064edc0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0732_T && \
touch alignment/realign/SISJ0732_T && \
mkdir -p alignment/SISJ0732_N/realign && \
touch alignment/SISJ0732_N/realign && \
mkdir -p alignment/SISJ0732_T/realign && \
touch alignment/SISJ0732_T/realign && \
cd alignment/realign/SISJ0732_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/1.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 4 \
  --intervals 5 \
  --intervals 6 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.1.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/1.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 4 \
  --intervals 5 \
  --intervals 6 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.1.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.1.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.1.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.1.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.1.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.1.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.1.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.1.bai
gatk_indel_realigner.SISJ0732_T.1.5deb2182b312c5db5ff9e8710064edc0.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_9_JOB_ID: gatk_indel_realigner.SISJ0732_T.2
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0732_T.2
JOB_DEPENDENCIES=$sambamba_merge_sam_files_3_JOB_ID:$sambamba_merge_sam_files_4_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0732_T.2.5da3e29746a18dd46d5c97924ab11ca0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0732_T.2.5da3e29746a18dd46d5c97924ab11ca0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0732_T && \
touch alignment/realign/SISJ0732_T && \
mkdir -p alignment/SISJ0732_N/realign && \
touch alignment/SISJ0732_N/realign && \
mkdir -p alignment/SISJ0732_T/realign && \
touch alignment/SISJ0732_T/realign && \
cd alignment/realign/SISJ0732_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/2.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 7 \
  --intervals 8 \
  --intervals 9 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.2.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/2.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 7 \
  --intervals 8 \
  --intervals 9 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.2.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.2.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.2.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.2.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.2.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.2.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.2.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.2.bai
gatk_indel_realigner.SISJ0732_T.2.5da3e29746a18dd46d5c97924ab11ca0.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_10_JOB_ID: gatk_indel_realigner.SISJ0732_T.3
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0732_T.3
JOB_DEPENDENCIES=$sambamba_merge_sam_files_3_JOB_ID:$sambamba_merge_sam_files_4_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0732_T.3.9a311d25eca28b0c68127614f68a32c2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0732_T.3.9a311d25eca28b0c68127614f68a32c2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0732_T && \
touch alignment/realign/SISJ0732_T && \
mkdir -p alignment/SISJ0732_N/realign && \
touch alignment/SISJ0732_N/realign && \
mkdir -p alignment/SISJ0732_T/realign && \
touch alignment/SISJ0732_T/realign && \
cd alignment/realign/SISJ0732_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/3.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 10 \
  --intervals 11 \
  --intervals 12 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.3.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/3.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 10 \
  --intervals 11 \
  --intervals 12 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.3.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.3.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.3.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.3.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.3.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.3.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.3.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.3.bai
gatk_indel_realigner.SISJ0732_T.3.9a311d25eca28b0c68127614f68a32c2.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_11_JOB_ID: gatk_indel_realigner.SISJ0732_T.4
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0732_T.4
JOB_DEPENDENCIES=$sambamba_merge_sam_files_3_JOB_ID:$sambamba_merge_sam_files_4_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0732_T.4.e74c99fe655272113afcc12e06cd5ec2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0732_T.4.e74c99fe655272113afcc12e06cd5ec2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0732_T && \
touch alignment/realign/SISJ0732_T && \
mkdir -p alignment/SISJ0732_N/realign && \
touch alignment/SISJ0732_N/realign && \
mkdir -p alignment/SISJ0732_T/realign && \
touch alignment/SISJ0732_T/realign && \
cd alignment/realign/SISJ0732_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/4.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 13 \
  --intervals 14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.4.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/4.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 13 \
  --intervals 14 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.4.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.4.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.4.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.4.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.4.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.4.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.4.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.4.bai
gatk_indel_realigner.SISJ0732_T.4.e74c99fe655272113afcc12e06cd5ec2.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_12_JOB_ID: gatk_indel_realigner.SISJ0732_T.others
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.SISJ0732_T.others
JOB_DEPENDENCIES=$sambamba_merge_sam_files_3_JOB_ID:$sambamba_merge_sam_files_4_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.SISJ0732_T.others.adaee13d46512bdf35998e179d7d26fe.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.SISJ0732_T.others.adaee13d46512bdf35998e179d7d26fe.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/SISJ0732_T && \
touch alignment/realign/SISJ0732_T && \
mkdir -p alignment/SISJ0732_N/realign && \
touch alignment/SISJ0732_N/realign && \
mkdir -p alignment/SISJ0732_T/realign && \
touch alignment/SISJ0732_T/realign && \
cd alignment/realign/SISJ0732_T && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/others.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --excludeIntervals 1 \
  --excludeIntervals 2 \
  --excludeIntervals 3 \
  --excludeIntervals 4 \
  --excludeIntervals 5 \
  --excludeIntervals 6 \
  --excludeIntervals 7 \
  --excludeIntervals 8 \
  --excludeIntervals 9 \
  --excludeIntervals 10 \
  --excludeIntervals 11 \
  --excludeIntervals 12 \
  --excludeIntervals 13 \
  --excludeIntervals 14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.others.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/others.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --excludeIntervals 1 \
  --excludeIntervals 2 \
  --excludeIntervals 3 \
  --excludeIntervals 4 \
  --excludeIntervals 5 \
  --excludeIntervals 6 \
  --excludeIntervals 7 \
  --excludeIntervals 8 \
  --excludeIntervals 9 \
  --excludeIntervals 10 \
  --excludeIntervals 11 \
  --excludeIntervals 12 \
  --excludeIntervals 13 \
  --excludeIntervals 14 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.others.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.others.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_N.sorted.realigned.others.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.others.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.others.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.others.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/SISJ0732_T/SISJ0732_T.sorted.realigned.others.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.others.bai
gatk_indel_realigner.SISJ0732_T.others.adaee13d46512bdf35998e179d7d26fe.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_13_JOB_ID: gatk_indel_realigner.TCMG240_T1.0
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.TCMG240_T1.0
JOB_DEPENDENCIES=$sambamba_merge_sam_files_5_JOB_ID:$sambamba_merge_sam_files_6_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.TCMG240_T1.0.19dfc33af8d8f3e41f8e59b2b425c7d8.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.TCMG240_T1.0.19dfc33af8d8f3e41f8e59b2b425c7d8.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/TCMG240_T1 && \
touch alignment/realign/TCMG240_T1 && \
mkdir -p alignment/TCMG240_N/realign && \
touch alignment/TCMG240_N/realign && \
mkdir -p alignment/TCMG240_T1/realign && \
touch alignment/TCMG240_T1/realign && \
cd alignment/realign/TCMG240_T1 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/0.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 1 \
  --intervals 2 \
  --intervals 3 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.0.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/0.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 1 \
  --intervals 2 \
  --intervals 3 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.0.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.0.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.0.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.0.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.0.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.0.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.0.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.0.bai
gatk_indel_realigner.TCMG240_T1.0.19dfc33af8d8f3e41f8e59b2b425c7d8.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_13_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_13_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_13_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_14_JOB_ID: gatk_indel_realigner.TCMG240_T1.1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.TCMG240_T1.1
JOB_DEPENDENCIES=$sambamba_merge_sam_files_5_JOB_ID:$sambamba_merge_sam_files_6_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.TCMG240_T1.1.6be084b18915e77424f948fd2c9534a5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.TCMG240_T1.1.6be084b18915e77424f948fd2c9534a5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/TCMG240_T1 && \
touch alignment/realign/TCMG240_T1 && \
mkdir -p alignment/TCMG240_N/realign && \
touch alignment/TCMG240_N/realign && \
mkdir -p alignment/TCMG240_T1/realign && \
touch alignment/TCMG240_T1/realign && \
cd alignment/realign/TCMG240_T1 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/1.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 4 \
  --intervals 5 \
  --intervals 6 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.1.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/1.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 4 \
  --intervals 5 \
  --intervals 6 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.1.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.1.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.1.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.1.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.1.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.1.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.1.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.1.bai
gatk_indel_realigner.TCMG240_T1.1.6be084b18915e77424f948fd2c9534a5.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_14_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_14_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_14_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_15_JOB_ID: gatk_indel_realigner.TCMG240_T1.2
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.TCMG240_T1.2
JOB_DEPENDENCIES=$sambamba_merge_sam_files_5_JOB_ID:$sambamba_merge_sam_files_6_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.TCMG240_T1.2.082c9cd9c9e6e389a298422411334442.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.TCMG240_T1.2.082c9cd9c9e6e389a298422411334442.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/TCMG240_T1 && \
touch alignment/realign/TCMG240_T1 && \
mkdir -p alignment/TCMG240_N/realign && \
touch alignment/TCMG240_N/realign && \
mkdir -p alignment/TCMG240_T1/realign && \
touch alignment/TCMG240_T1/realign && \
cd alignment/realign/TCMG240_T1 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/2.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 7 \
  --intervals 8 \
  --intervals 9 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.2.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/2.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 7 \
  --intervals 8 \
  --intervals 9 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.2.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.2.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.2.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.2.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.2.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.2.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.2.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.2.bai
gatk_indel_realigner.TCMG240_T1.2.082c9cd9c9e6e389a298422411334442.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_15_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_15_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_15_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_16_JOB_ID: gatk_indel_realigner.TCMG240_T1.3
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.TCMG240_T1.3
JOB_DEPENDENCIES=$sambamba_merge_sam_files_5_JOB_ID:$sambamba_merge_sam_files_6_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.TCMG240_T1.3.4cdde710e7fff6421e450da7e6c9a88f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.TCMG240_T1.3.4cdde710e7fff6421e450da7e6c9a88f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/TCMG240_T1 && \
touch alignment/realign/TCMG240_T1 && \
mkdir -p alignment/TCMG240_N/realign && \
touch alignment/TCMG240_N/realign && \
mkdir -p alignment/TCMG240_T1/realign && \
touch alignment/TCMG240_T1/realign && \
cd alignment/realign/TCMG240_T1 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/3.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 10 \
  --intervals 11 \
  --intervals 12 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.3.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/3.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 10 \
  --intervals 11 \
  --intervals 12 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.3.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.3.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.3.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.3.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.3.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.3.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.3.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.3.bai
gatk_indel_realigner.TCMG240_T1.3.4cdde710e7fff6421e450da7e6c9a88f.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_16_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_16_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_16_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_17_JOB_ID: gatk_indel_realigner.TCMG240_T1.4
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.TCMG240_T1.4
JOB_DEPENDENCIES=$sambamba_merge_sam_files_5_JOB_ID:$sambamba_merge_sam_files_6_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.TCMG240_T1.4.152e136a012bfa63d18da949b402ac9f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.TCMG240_T1.4.152e136a012bfa63d18da949b402ac9f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/TCMG240_T1 && \
touch alignment/realign/TCMG240_T1 && \
mkdir -p alignment/TCMG240_N/realign && \
touch alignment/TCMG240_N/realign && \
mkdir -p alignment/TCMG240_T1/realign && \
touch alignment/TCMG240_T1/realign && \
cd alignment/realign/TCMG240_T1 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/4.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 13 \
  --intervals 14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.4.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/4.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --intervals 13 \
  --intervals 14 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.4.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.4.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.4.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.4.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.4.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.4.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.4.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.4.bai
gatk_indel_realigner.TCMG240_T1.4.152e136a012bfa63d18da949b402ac9f.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_17_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_17_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_17_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_indel_realigner_18_JOB_ID: gatk_indel_realigner.TCMG240_T1.others
#-------------------------------------------------------------------------------
JOB_NAME=gatk_indel_realigner.TCMG240_T1.others
JOB_DEPENDENCIES=$sambamba_merge_sam_files_5_JOB_ID:$sambamba_merge_sam_files_6_JOB_ID
JOB_DONE=job_output/gatk_indel_realigner/gatk_indel_realigner.TCMG240_T1.others.e5f51641b31fb7c8004ee81655254e1b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_indel_realigner.TCMG240_T1.others.e5f51641b31fb7c8004ee81655254e1b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.8 && \
mkdir -p alignment/realign/TCMG240_T1 && \
touch alignment/realign/TCMG240_T1 && \
mkdir -p alignment/TCMG240_N/realign && \
touch alignment/TCMG240_N/realign && \
mkdir -p alignment/TCMG240_T1/realign && \
touch alignment/TCMG240_T1/realign && \
cd alignment/realign/TCMG240_T1 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type RealignerTargetCreator -nt 1 \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --out /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/others.intervals \
  --known /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --excludeIntervals 1 \
  --excludeIntervals 2 \
  --excludeIntervals 3 \
  --excludeIntervals 4 \
  --excludeIntervals 5 \
  --excludeIntervals 6 \
  --excludeIntervals 7 \
  --excludeIntervals 8 \
  --excludeIntervals 9 \
  --excludeIntervals 10 \
  --excludeIntervals 11 \
  --excludeIntervals 12 \
  --excludeIntervals 13 \
  --excludeIntervals 14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12G -jar $GATK_JAR \
  --analysis_type IndelRealigner  \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --nWayOut .realigned.others.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.bam \
  --input_file /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.bam \
  --targetIntervals /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/others.intervals \
   \
  --knownAlleles /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --excludeIntervals 1 \
  --excludeIntervals 2 \
  --excludeIntervals 3 \
  --excludeIntervals 4 \
  --excludeIntervals 5 \
  --excludeIntervals 6 \
  --excludeIntervals 7 \
  --excludeIntervals 8 \
  --excludeIntervals 9 \
  --excludeIntervals 10 \
  --excludeIntervals 11 \
  --excludeIntervals 12 \
  --excludeIntervals 13 \
  --excludeIntervals 14 \
  --maxReadsInMemory 500000 && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.others.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.others.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_N.sorted.realigned.others.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.others.bai && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.others.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.others.bam && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/realign/TCMG240_T1/TCMG240_T1.sorted.realigned.others.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.others.bai
gatk_indel_realigner.TCMG240_T1.others.e5f51641b31fb7c8004ee81655254e1b.mugqic.done
chmod 755 $COMMAND
gatk_indel_realigner_18_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_indel_realigner_18_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_indel_realigner_18_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sambamba_merge_realigned
#-------------------------------------------------------------------------------
STEP=sambamba_merge_realigned
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_realigned_1_JOB_ID: sambamba_merge_realigned.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_realigned.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$gatk_indel_realigner_1_JOB_ID:$gatk_indel_realigner_2_JOB_ID:$gatk_indel_realigner_3_JOB_ID:$gatk_indel_realigner_4_JOB_ID:$gatk_indel_realigner_5_JOB_ID:$gatk_indel_realigner_6_JOB_ID
JOB_DONE=job_output/sambamba_merge_realigned/sambamba_merge_realigned.SISJ0635_T.SISJ0635_N.9ebb05a77eaee69d19d18e7318ed3287.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_realigned.SISJ0635_T.SISJ0635_N.9ebb05a77eaee69d19d18e7318ed3287.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba merge -t 16 \
  alignment/SISJ0635_N/SISJ0635_N.sorted.realigned.bam \
   \
  alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.0.bam \
  alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.1.bam \
  alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.2.bam \
  alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.3.bam \
  alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.4.bam \
  alignment/SISJ0635_N/realign/SISJ0635_N.sorted.realigned.others.bam
sambamba_merge_realigned.SISJ0635_T.SISJ0635_N.9ebb05a77eaee69d19d18e7318ed3287.mugqic.done
chmod 755 $COMMAND
sambamba_merge_realigned_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 48G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_realigned_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_realigned_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_realigned_2_JOB_ID: sambamba_merge_realigned.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_realigned.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$gatk_indel_realigner_1_JOB_ID:$gatk_indel_realigner_2_JOB_ID:$gatk_indel_realigner_3_JOB_ID:$gatk_indel_realigner_4_JOB_ID:$gatk_indel_realigner_5_JOB_ID:$gatk_indel_realigner_6_JOB_ID
JOB_DONE=job_output/sambamba_merge_realigned/sambamba_merge_realigned.SISJ0635_T.SISJ0635_T.0f0f6b3951c6dfa8a1afda9d1cae969d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_realigned.SISJ0635_T.SISJ0635_T.0f0f6b3951c6dfa8a1afda9d1cae969d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba merge -t 16 \
  alignment/SISJ0635_T/SISJ0635_T.sorted.realigned.bam \
   \
  alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.0.bam \
  alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.1.bam \
  alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.2.bam \
  alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.3.bam \
  alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.4.bam \
  alignment/SISJ0635_T/realign/SISJ0635_T.sorted.realigned.others.bam
sambamba_merge_realigned.SISJ0635_T.SISJ0635_T.0f0f6b3951c6dfa8a1afda9d1cae969d.mugqic.done
chmod 755 $COMMAND
sambamba_merge_realigned_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 48G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_realigned_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_realigned_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_realigned_3_JOB_ID: sambamba_merge_realigned.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_realigned.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$gatk_indel_realigner_7_JOB_ID:$gatk_indel_realigner_8_JOB_ID:$gatk_indel_realigner_9_JOB_ID:$gatk_indel_realigner_10_JOB_ID:$gatk_indel_realigner_11_JOB_ID:$gatk_indel_realigner_12_JOB_ID
JOB_DONE=job_output/sambamba_merge_realigned/sambamba_merge_realigned.SISJ0732_T.SISJ0732_N.93505161f41371ffd57c7fe2ca195ea1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_realigned.SISJ0732_T.SISJ0732_N.93505161f41371ffd57c7fe2ca195ea1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba merge -t 16 \
  alignment/SISJ0732_N/SISJ0732_N.sorted.realigned.bam \
   \
  alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.0.bam \
  alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.1.bam \
  alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.2.bam \
  alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.3.bam \
  alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.4.bam \
  alignment/SISJ0732_N/realign/SISJ0732_N.sorted.realigned.others.bam
sambamba_merge_realigned.SISJ0732_T.SISJ0732_N.93505161f41371ffd57c7fe2ca195ea1.mugqic.done
chmod 755 $COMMAND
sambamba_merge_realigned_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 48G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_realigned_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_realigned_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_realigned_4_JOB_ID: sambamba_merge_realigned.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_realigned.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$gatk_indel_realigner_7_JOB_ID:$gatk_indel_realigner_8_JOB_ID:$gatk_indel_realigner_9_JOB_ID:$gatk_indel_realigner_10_JOB_ID:$gatk_indel_realigner_11_JOB_ID:$gatk_indel_realigner_12_JOB_ID
JOB_DONE=job_output/sambamba_merge_realigned/sambamba_merge_realigned.SISJ0732_T.SISJ0732_T.bdff9a3fa0a068b0024a94ceaa7e1059.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_realigned.SISJ0732_T.SISJ0732_T.bdff9a3fa0a068b0024a94ceaa7e1059.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba merge -t 16 \
  alignment/SISJ0732_T/SISJ0732_T.sorted.realigned.bam \
   \
  alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.0.bam \
  alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.1.bam \
  alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.2.bam \
  alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.3.bam \
  alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.4.bam \
  alignment/SISJ0732_T/realign/SISJ0732_T.sorted.realigned.others.bam
sambamba_merge_realigned.SISJ0732_T.SISJ0732_T.bdff9a3fa0a068b0024a94ceaa7e1059.mugqic.done
chmod 755 $COMMAND
sambamba_merge_realigned_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 48G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_realigned_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_realigned_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_realigned_5_JOB_ID: sambamba_merge_realigned.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_realigned.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$gatk_indel_realigner_13_JOB_ID:$gatk_indel_realigner_14_JOB_ID:$gatk_indel_realigner_15_JOB_ID:$gatk_indel_realigner_16_JOB_ID:$gatk_indel_realigner_17_JOB_ID:$gatk_indel_realigner_18_JOB_ID
JOB_DONE=job_output/sambamba_merge_realigned/sambamba_merge_realigned.TCMG240_T1.TCMG240_N.a42ff776f156a89dba970bcabad882e7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_realigned.TCMG240_T1.TCMG240_N.a42ff776f156a89dba970bcabad882e7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba merge -t 16 \
  alignment/TCMG240_N/TCMG240_N.sorted.realigned.bam \
   \
  alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.0.bam \
  alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.1.bam \
  alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.2.bam \
  alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.3.bam \
  alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.4.bam \
  alignment/TCMG240_N/realign/TCMG240_N.sorted.realigned.others.bam
sambamba_merge_realigned.TCMG240_T1.TCMG240_N.a42ff776f156a89dba970bcabad882e7.mugqic.done
chmod 755 $COMMAND
sambamba_merge_realigned_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 48G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_realigned_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_realigned_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_merge_realigned_6_JOB_ID: sambamba_merge_realigned.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_merge_realigned.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$gatk_indel_realigner_13_JOB_ID:$gatk_indel_realigner_14_JOB_ID:$gatk_indel_realigner_15_JOB_ID:$gatk_indel_realigner_16_JOB_ID:$gatk_indel_realigner_17_JOB_ID:$gatk_indel_realigner_18_JOB_ID
JOB_DONE=job_output/sambamba_merge_realigned/sambamba_merge_realigned.TCMG240_T1.TCMG240_T1.dd4d47eaaa5464f1ec977c6dabf9b107.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_merge_realigned.TCMG240_T1.TCMG240_T1.dd4d47eaaa5464f1ec977c6dabf9b107.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba merge -t 16 \
  alignment/TCMG240_T1/TCMG240_T1.sorted.realigned.bam \
   \
  alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.0.bam \
  alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.1.bam \
  alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.2.bam \
  alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.3.bam \
  alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.4.bam \
  alignment/TCMG240_T1/realign/TCMG240_T1.sorted.realigned.others.bam
sambamba_merge_realigned.TCMG240_T1.TCMG240_T1.dd4d47eaaa5464f1ec977c6dabf9b107.mugqic.done
chmod 755 $COMMAND
sambamba_merge_realigned_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 48G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_merge_realigned_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_merge_realigned_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sambamba_mark_duplicates
#-------------------------------------------------------------------------------
STEP=sambamba_mark_duplicates
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sambamba_mark_duplicates_1_JOB_ID: sambamba_mark_duplicates.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_mark_duplicates.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$sambamba_merge_realigned_1_JOB_ID
JOB_DONE=job_output/sambamba_mark_duplicates/sambamba_mark_duplicates.SISJ0635_T.SISJ0635_N.7f81353c283a9eb5411569e78bf6fd09.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_mark_duplicates.SISJ0635_T.SISJ0635_N.7f81353c283a9eb5411569e78bf6fd09.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba markdup -t 16 \
  alignment/SISJ0635_N/SISJ0635_N.sorted.realigned.bam \
  --tmpdir tmp_dir \
  alignment/SISJ0635_N/SISJ0635_N.sorted.dup.bam
sambamba_mark_duplicates.SISJ0635_T.SISJ0635_N.7f81353c283a9eb5411569e78bf6fd09.mugqic.done
chmod 755 $COMMAND
sambamba_mark_duplicates_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_mark_duplicates_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_mark_duplicates_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_mark_duplicates_2_JOB_ID: sambamba_mark_duplicates.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_mark_duplicates.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$sambamba_merge_realigned_2_JOB_ID
JOB_DONE=job_output/sambamba_mark_duplicates/sambamba_mark_duplicates.SISJ0635_T.SISJ0635_T.4c4ff054a22e0c7e6b6e9da58f42b00e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_mark_duplicates.SISJ0635_T.SISJ0635_T.4c4ff054a22e0c7e6b6e9da58f42b00e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba markdup -t 16 \
  alignment/SISJ0635_T/SISJ0635_T.sorted.realigned.bam \
  --tmpdir tmp_dir \
  alignment/SISJ0635_T/SISJ0635_T.sorted.dup.bam
sambamba_mark_duplicates.SISJ0635_T.SISJ0635_T.4c4ff054a22e0c7e6b6e9da58f42b00e.mugqic.done
chmod 755 $COMMAND
sambamba_mark_duplicates_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_mark_duplicates_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_mark_duplicates_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_mark_duplicates_3_JOB_ID: sambamba_mark_duplicates.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_mark_duplicates.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$sambamba_merge_realigned_3_JOB_ID
JOB_DONE=job_output/sambamba_mark_duplicates/sambamba_mark_duplicates.SISJ0732_T.SISJ0732_N.e216bbbdfe2ccaececf442c86143e438.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_mark_duplicates.SISJ0732_T.SISJ0732_N.e216bbbdfe2ccaececf442c86143e438.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba markdup -t 16 \
  alignment/SISJ0732_N/SISJ0732_N.sorted.realigned.bam \
  --tmpdir tmp_dir \
  alignment/SISJ0732_N/SISJ0732_N.sorted.dup.bam
sambamba_mark_duplicates.SISJ0732_T.SISJ0732_N.e216bbbdfe2ccaececf442c86143e438.mugqic.done
chmod 755 $COMMAND
sambamba_mark_duplicates_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_mark_duplicates_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_mark_duplicates_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_mark_duplicates_4_JOB_ID: sambamba_mark_duplicates.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_mark_duplicates.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$sambamba_merge_realigned_4_JOB_ID
JOB_DONE=job_output/sambamba_mark_duplicates/sambamba_mark_duplicates.SISJ0732_T.SISJ0732_T.55b3cec251dafec1a4fabdc5550ea405.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_mark_duplicates.SISJ0732_T.SISJ0732_T.55b3cec251dafec1a4fabdc5550ea405.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba markdup -t 16 \
  alignment/SISJ0732_T/SISJ0732_T.sorted.realigned.bam \
  --tmpdir tmp_dir \
  alignment/SISJ0732_T/SISJ0732_T.sorted.dup.bam
sambamba_mark_duplicates.SISJ0732_T.SISJ0732_T.55b3cec251dafec1a4fabdc5550ea405.mugqic.done
chmod 755 $COMMAND
sambamba_mark_duplicates_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_mark_duplicates_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_mark_duplicates_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_mark_duplicates_5_JOB_ID: sambamba_mark_duplicates.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_mark_duplicates.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$sambamba_merge_realigned_5_JOB_ID
JOB_DONE=job_output/sambamba_mark_duplicates/sambamba_mark_duplicates.TCMG240_T1.TCMG240_N.68b1b6a844fd47720b6644c20413eb23.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_mark_duplicates.TCMG240_T1.TCMG240_N.68b1b6a844fd47720b6644c20413eb23.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba markdup -t 16 \
  alignment/TCMG240_N/TCMG240_N.sorted.realigned.bam \
  --tmpdir tmp_dir \
  alignment/TCMG240_N/TCMG240_N.sorted.dup.bam
sambamba_mark_duplicates.TCMG240_T1.TCMG240_N.68b1b6a844fd47720b6644c20413eb23.mugqic.done
chmod 755 $COMMAND
sambamba_mark_duplicates_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_mark_duplicates_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_mark_duplicates_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sambamba_mark_duplicates_6_JOB_ID: sambamba_mark_duplicates.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sambamba_mark_duplicates.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$sambamba_merge_realigned_6_JOB_ID
JOB_DONE=job_output/sambamba_mark_duplicates/sambamba_mark_duplicates.TCMG240_T1.TCMG240_T1.db583f8d171dd7475d6292bae2479d66.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sambamba_mark_duplicates.TCMG240_T1.TCMG240_T1.db583f8d171dd7475d6292bae2479d66.mugqic.done' > $COMMAND
module purge && \
module load mugqic/sambamba/0.8.0 && \
sambamba markdup -t 16 \
  alignment/TCMG240_T1/TCMG240_T1.sorted.realigned.bam \
  --tmpdir tmp_dir \
  alignment/TCMG240_T1/TCMG240_T1.sorted.dup.bam
sambamba_mark_duplicates.TCMG240_T1.TCMG240_T1.db583f8d171dd7475d6292bae2479d66.mugqic.done
chmod 755 $COMMAND
sambamba_mark_duplicates_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sambamba_mark_duplicates_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sambamba_mark_duplicates_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: recalibration
#-------------------------------------------------------------------------------
STEP=recalibration
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: recalibration_1_JOB_ID: gatk_base_recalibrator.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=gatk_base_recalibrator.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_1_JOB_ID
JOB_DONE=job_output/recalibration/gatk_base_recalibrator.SISJ0635_T.SISJ0635_N.b7ef7eaa7f162f4526c4fb25daa3687b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_base_recalibrator.SISJ0635_T.SISJ0635_N.b7ef7eaa7f162f4526c4fb25daa3687b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx55G" \
  BaseRecalibratorSpark --bqsr-baq-gap-open-penalty 30 \
  --input alignment/SISJ0635_N/SISJ0635_N.sorted.dup.bam \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa  \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gnomad.exomes.r2.0.1.sites.no-VEP.nohist.tidy.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --spark-master local[32] \
  --output alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recalibration_report.grp
gatk_base_recalibrator.SISJ0635_T.SISJ0635_N.b7ef7eaa7f162f4526c4fb25daa3687b.mugqic.done
chmod 755 $COMMAND
recalibration_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_2_JOB_ID: gatk_print_reads.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=gatk_print_reads.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_1_JOB_ID:$recalibration_1_JOB_ID
JOB_DONE=job_output/recalibration/gatk_print_reads.SISJ0635_T.SISJ0635_N.0a94400cdb25818c989a740c645881ca.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_print_reads.SISJ0635_T.SISJ0635_N.0a94400cdb25818c989a740c645881ca.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
rm -rf alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam* && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  ApplyBQSRSpark  --create-output-bam-index true \
  --input alignment/SISJ0635_N/SISJ0635_N.sorted.dup.bam \
  --bqsr-recal-file alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recalibration_report.grp \
  --spark-master local[6] \
  --output alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam
gatk_print_reads.SISJ0635_T.SISJ0635_N.0a94400cdb25818c989a740c645881ca.mugqic.done
chmod 755 $COMMAND
recalibration_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=96:00:00 --mem 36G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_3_JOB_ID: gatk_base_recalibrator.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_base_recalibrator.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_2_JOB_ID
JOB_DONE=job_output/recalibration/gatk_base_recalibrator.SISJ0635_T.SISJ0635_T.c181b1f4db6fc336273017d7705882f6.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_base_recalibrator.SISJ0635_T.SISJ0635_T.c181b1f4db6fc336273017d7705882f6.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx55G" \
  BaseRecalibratorSpark --bqsr-baq-gap-open-penalty 30 \
  --input alignment/SISJ0635_T/SISJ0635_T.sorted.dup.bam \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa  \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gnomad.exomes.r2.0.1.sites.no-VEP.nohist.tidy.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --spark-master local[32] \
  --output alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recalibration_report.grp
gatk_base_recalibrator.SISJ0635_T.SISJ0635_T.c181b1f4db6fc336273017d7705882f6.mugqic.done
chmod 755 $COMMAND
recalibration_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_4_JOB_ID: gatk_print_reads.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_print_reads.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_2_JOB_ID:$recalibration_3_JOB_ID
JOB_DONE=job_output/recalibration/gatk_print_reads.SISJ0635_T.SISJ0635_T.2fb802989ba583cc79f8cba5c6e82d64.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_print_reads.SISJ0635_T.SISJ0635_T.2fb802989ba583cc79f8cba5c6e82d64.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
rm -rf alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam* && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  ApplyBQSRSpark  --create-output-bam-index true \
  --input alignment/SISJ0635_T/SISJ0635_T.sorted.dup.bam \
  --bqsr-recal-file alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recalibration_report.grp \
  --spark-master local[6] \
  --output alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam
gatk_print_reads.SISJ0635_T.SISJ0635_T.2fb802989ba583cc79f8cba5c6e82d64.mugqic.done
chmod 755 $COMMAND
recalibration_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=96:00:00 --mem 36G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_5_JOB_ID: gatk_base_recalibrator.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=gatk_base_recalibrator.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_3_JOB_ID
JOB_DONE=job_output/recalibration/gatk_base_recalibrator.SISJ0732_T.SISJ0732_N.7246d519ede236b1d7f31a429c57e715.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_base_recalibrator.SISJ0732_T.SISJ0732_N.7246d519ede236b1d7f31a429c57e715.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx55G" \
  BaseRecalibratorSpark --bqsr-baq-gap-open-penalty 30 \
  --input alignment/SISJ0732_N/SISJ0732_N.sorted.dup.bam \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa  \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gnomad.exomes.r2.0.1.sites.no-VEP.nohist.tidy.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --spark-master local[32] \
  --output alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recalibration_report.grp
gatk_base_recalibrator.SISJ0732_T.SISJ0732_N.7246d519ede236b1d7f31a429c57e715.mugqic.done
chmod 755 $COMMAND
recalibration_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_6_JOB_ID: gatk_print_reads.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=gatk_print_reads.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_3_JOB_ID:$recalibration_5_JOB_ID
JOB_DONE=job_output/recalibration/gatk_print_reads.SISJ0732_T.SISJ0732_N.dd5b75f4704888d9dfd7d91adfac1d89.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_print_reads.SISJ0732_T.SISJ0732_N.dd5b75f4704888d9dfd7d91adfac1d89.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
rm -rf alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam* && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  ApplyBQSRSpark  --create-output-bam-index true \
  --input alignment/SISJ0732_N/SISJ0732_N.sorted.dup.bam \
  --bqsr-recal-file alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recalibration_report.grp \
  --spark-master local[6] \
  --output alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam
gatk_print_reads.SISJ0732_T.SISJ0732_N.dd5b75f4704888d9dfd7d91adfac1d89.mugqic.done
chmod 755 $COMMAND
recalibration_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=96:00:00 --mem 36G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_7_JOB_ID: gatk_base_recalibrator.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_base_recalibrator.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_4_JOB_ID
JOB_DONE=job_output/recalibration/gatk_base_recalibrator.SISJ0732_T.SISJ0732_T.79857c4651a9c522ad8748052e190130.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_base_recalibrator.SISJ0732_T.SISJ0732_T.79857c4651a9c522ad8748052e190130.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx55G" \
  BaseRecalibratorSpark --bqsr-baq-gap-open-penalty 30 \
  --input alignment/SISJ0732_T/SISJ0732_T.sorted.dup.bam \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa  \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gnomad.exomes.r2.0.1.sites.no-VEP.nohist.tidy.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --spark-master local[32] \
  --output alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recalibration_report.grp
gatk_base_recalibrator.SISJ0732_T.SISJ0732_T.79857c4651a9c522ad8748052e190130.mugqic.done
chmod 755 $COMMAND
recalibration_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_8_JOB_ID: gatk_print_reads.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_print_reads.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_4_JOB_ID:$recalibration_7_JOB_ID
JOB_DONE=job_output/recalibration/gatk_print_reads.SISJ0732_T.SISJ0732_T.5e243ae992ee49f8e5e26c7c91945ca9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_print_reads.SISJ0732_T.SISJ0732_T.5e243ae992ee49f8e5e26c7c91945ca9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
rm -rf alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam* && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  ApplyBQSRSpark  --create-output-bam-index true \
  --input alignment/SISJ0732_T/SISJ0732_T.sorted.dup.bam \
  --bqsr-recal-file alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recalibration_report.grp \
  --spark-master local[6] \
  --output alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam
gatk_print_reads.SISJ0732_T.SISJ0732_T.5e243ae992ee49f8e5e26c7c91945ca9.mugqic.done
chmod 755 $COMMAND
recalibration_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=96:00:00 --mem 36G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_9_JOB_ID: gatk_base_recalibrator.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=gatk_base_recalibrator.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_5_JOB_ID
JOB_DONE=job_output/recalibration/gatk_base_recalibrator.TCMG240_T1.TCMG240_N.3a2c6b72c5a34df1a92087d78d5fd6e3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_base_recalibrator.TCMG240_T1.TCMG240_N.3a2c6b72c5a34df1a92087d78d5fd6e3.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx55G" \
  BaseRecalibratorSpark --bqsr-baq-gap-open-penalty 30 \
  --input alignment/TCMG240_N/TCMG240_N.sorted.dup.bam \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa  \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gnomad.exomes.r2.0.1.sites.no-VEP.nohist.tidy.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --spark-master local[32] \
  --output alignment/TCMG240_N/TCMG240_N.sorted.dup.recalibration_report.grp
gatk_base_recalibrator.TCMG240_T1.TCMG240_N.3a2c6b72c5a34df1a92087d78d5fd6e3.mugqic.done
chmod 755 $COMMAND
recalibration_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_10_JOB_ID: gatk_print_reads.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=gatk_print_reads.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_5_JOB_ID:$recalibration_9_JOB_ID
JOB_DONE=job_output/recalibration/gatk_print_reads.TCMG240_T1.TCMG240_N.af1673ad8f6ae3961a909cbb563744c7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_print_reads.TCMG240_T1.TCMG240_N.af1673ad8f6ae3961a909cbb563744c7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
rm -rf alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam* && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  ApplyBQSRSpark  --create-output-bam-index true \
  --input alignment/TCMG240_N/TCMG240_N.sorted.dup.bam \
  --bqsr-recal-file alignment/TCMG240_N/TCMG240_N.sorted.dup.recalibration_report.grp \
  --spark-master local[6] \
  --output alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam
gatk_print_reads.TCMG240_T1.TCMG240_N.af1673ad8f6ae3961a909cbb563744c7.mugqic.done
chmod 755 $COMMAND
recalibration_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=96:00:00 --mem 36G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_11_JOB_ID: gatk_base_recalibrator.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_base_recalibrator.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$sambamba_mark_duplicates_6_JOB_ID
JOB_DONE=job_output/recalibration/gatk_base_recalibrator.TCMG240_T1.TCMG240_T1.5556de9d6384745e5fae4d7c218483cc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_base_recalibrator.TCMG240_T1.TCMG240_T1.5556de9d6384745e5fae4d7c218483cc.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx55G" \
  BaseRecalibratorSpark --bqsr-baq-gap-open-penalty 30 \
  --input alignment/TCMG240_T1/TCMG240_T1.sorted.dup.bam \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa  \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gnomad.exomes.r2.0.1.sites.no-VEP.nohist.tidy.vcf.gz \
  --known-sites /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Mills_and_1000G_gold_standard.indels.vcf.gz \
  --spark-master local[32] \
  --output alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recalibration_report.grp
gatk_base_recalibrator.TCMG240_T1.TCMG240_T1.5556de9d6384745e5fae4d7c218483cc.mugqic.done
chmod 755 $COMMAND
recalibration_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: recalibration_12_JOB_ID: gatk_print_reads.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_print_reads.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$sambamba_mark_duplicates_6_JOB_ID:$recalibration_11_JOB_ID
JOB_DONE=job_output/recalibration/gatk_print_reads.TCMG240_T1.TCMG240_T1.1fe725af016fdc1763456b0879e506b6.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_print_reads.TCMG240_T1.TCMG240_T1.1fe725af016fdc1763456b0879e506b6.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
rm -rf alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam* && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  ApplyBQSRSpark  --create-output-bam-index true \
  --input alignment/TCMG240_T1/TCMG240_T1.sorted.dup.bam \
  --bqsr-recal-file alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recalibration_report.grp \
  --spark-master local[6] \
  --output alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam
gatk_print_reads.TCMG240_T1.TCMG240_T1.1fe725af016fdc1763456b0879e506b6.mugqic.done
chmod 755 $COMMAND
recalibration_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=96:00:00 --mem 36G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$recalibration_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$recalibration_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: conpair_concordance_contamination
#-------------------------------------------------------------------------------
STEP=conpair_concordance_contamination
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_1_JOB_ID: conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_1_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_N.7e5e4d8557926ae35f2a9d8fc5ef1726.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_N.7e5e4d8557926ae35f2a9d8fc5ef1726.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/python/3.9.1 mugqic/GenomeAnalysisTK/3.8 mugqic/Conpair/0.2 && \
python3 $CONPAIR_SCRIPTS/run_gatk_pileup_for_sample.py -t ${SLURM_TMPDIR} \
  -m 6G \
  -G $GATK_JAR \
  -D $CONPAIR_DIR \
  -R /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -M ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.bed \
  -B alignment/SISJ0635_N/SISJ0635_N.sorted.dup.bam \
  -O alignment/SISJ0635_N/SISJ0635_N.gatkPileup 
conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_N.7e5e4d8557926ae35f2a9d8fc5ef1726.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_2_JOB_ID: conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_2_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_T.c58ff28ec958e6734d7095fde76c1dde.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_T.c58ff28ec958e6734d7095fde76c1dde.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/python/3.9.1 mugqic/GenomeAnalysisTK/3.8 mugqic/Conpair/0.2 && \
python3 $CONPAIR_SCRIPTS/run_gatk_pileup_for_sample.py -t ${SLURM_TMPDIR} \
  -m 6G \
  -G $GATK_JAR \
  -D $CONPAIR_DIR \
  -R /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -M ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.bed \
  -B alignment/SISJ0635_T/SISJ0635_T.sorted.dup.bam \
  -O alignment/SISJ0635_T/SISJ0635_T.gatkPileup 
conpair_concordance_contamination.pileup.SISJ0635_T.SISJ0635_T.c58ff28ec958e6734d7095fde76c1dde.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_3_JOB_ID: conpair_concordance_contamination.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.SISJ0635_T
JOB_DEPENDENCIES=$conpair_concordance_contamination_1_JOB_ID:$conpair_concordance_contamination_2_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.SISJ0635_T.47deb46336bf8e4d4cd88bd996d69b52.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.SISJ0635_T.47deb46336bf8e4d4cd88bd996d69b52.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.9.1 mugqic/Conpair/0.2 && \
mkdir -p metrics && \
touch metrics && \
python3 $CONPAIR_SCRIPTS/verify_concordance.py --normal_homozygous_markers_only \
  --markers ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.txt \
  --normal_pileup alignment/SISJ0635_N/SISJ0635_N.gatkPileup \
  --tumor_pileup alignment/SISJ0635_T/SISJ0635_T.gatkPileup \
  --outfile metrics/SISJ0635_T.concordance.tsv && \
python3 $CONPAIR_SCRIPTS/estimate_tumor_normal_contamination.py  \
  --markers ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.txt \
  --normal_pileup alignment/SISJ0635_N/SISJ0635_N.gatkPileup \
  --tumor_pileup alignment/SISJ0635_T/SISJ0635_T.gatkPileup \
  --outfile metrics/SISJ0635_T.contamination.tsv
conpair_concordance_contamination.SISJ0635_T.47deb46336bf8e4d4cd88bd996d69b52.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_4_JOB_ID: conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_3_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_N.94130f0a1e26151c10f5423d633ca355.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_N.94130f0a1e26151c10f5423d633ca355.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/python/3.9.1 mugqic/GenomeAnalysisTK/3.8 mugqic/Conpair/0.2 && \
python3 $CONPAIR_SCRIPTS/run_gatk_pileup_for_sample.py -t ${SLURM_TMPDIR} \
  -m 6G \
  -G $GATK_JAR \
  -D $CONPAIR_DIR \
  -R /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -M ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.bed \
  -B alignment/SISJ0732_N/SISJ0732_N.sorted.dup.bam \
  -O alignment/SISJ0732_N/SISJ0732_N.gatkPileup 
conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_N.94130f0a1e26151c10f5423d633ca355.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_5_JOB_ID: conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_4_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_T.269a928397205c00003d6e61a0fbe8cb.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_T.269a928397205c00003d6e61a0fbe8cb.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/python/3.9.1 mugqic/GenomeAnalysisTK/3.8 mugqic/Conpair/0.2 && \
python3 $CONPAIR_SCRIPTS/run_gatk_pileup_for_sample.py -t ${SLURM_TMPDIR} \
  -m 6G \
  -G $GATK_JAR \
  -D $CONPAIR_DIR \
  -R /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -M ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.bed \
  -B alignment/SISJ0732_T/SISJ0732_T.sorted.dup.bam \
  -O alignment/SISJ0732_T/SISJ0732_T.gatkPileup 
conpair_concordance_contamination.pileup.SISJ0732_T.SISJ0732_T.269a928397205c00003d6e61a0fbe8cb.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_6_JOB_ID: conpair_concordance_contamination.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.SISJ0732_T
JOB_DEPENDENCIES=$conpair_concordance_contamination_4_JOB_ID:$conpair_concordance_contamination_5_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.SISJ0732_T.d42307a71c841cf3924fa7a0471823fe.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.SISJ0732_T.d42307a71c841cf3924fa7a0471823fe.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.9.1 mugqic/Conpair/0.2 && \
mkdir -p metrics && \
touch metrics && \
python3 $CONPAIR_SCRIPTS/verify_concordance.py --normal_homozygous_markers_only \
  --markers ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.txt \
  --normal_pileup alignment/SISJ0732_N/SISJ0732_N.gatkPileup \
  --tumor_pileup alignment/SISJ0732_T/SISJ0732_T.gatkPileup \
  --outfile metrics/SISJ0732_T.concordance.tsv && \
python3 $CONPAIR_SCRIPTS/estimate_tumor_normal_contamination.py  \
  --markers ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.txt \
  --normal_pileup alignment/SISJ0732_N/SISJ0732_N.gatkPileup \
  --tumor_pileup alignment/SISJ0732_T/SISJ0732_T.gatkPileup \
  --outfile metrics/SISJ0732_T.contamination.tsv
conpair_concordance_contamination.SISJ0732_T.d42307a71c841cf3924fa7a0471823fe.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_7_JOB_ID: conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_5_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_N.002cb3bbae7719dee6267fcbaf1c3e64.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_N.002cb3bbae7719dee6267fcbaf1c3e64.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/python/3.9.1 mugqic/GenomeAnalysisTK/3.8 mugqic/Conpair/0.2 && \
python3 $CONPAIR_SCRIPTS/run_gatk_pileup_for_sample.py -t ${SLURM_TMPDIR} \
  -m 6G \
  -G $GATK_JAR \
  -D $CONPAIR_DIR \
  -R /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -M ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.bed \
  -B alignment/TCMG240_N/TCMG240_N.sorted.dup.bam \
  -O alignment/TCMG240_N/TCMG240_N.gatkPileup 
conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_N.002cb3bbae7719dee6267fcbaf1c3e64.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_8_JOB_ID: conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$sambamba_mark_duplicates_6_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_T1.cc1d50d6451c8828c1a2b203e6beb5a2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_T1.cc1d50d6451c8828c1a2b203e6beb5a2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/python/3.9.1 mugqic/GenomeAnalysisTK/3.8 mugqic/Conpair/0.2 && \
python3 $CONPAIR_SCRIPTS/run_gatk_pileup_for_sample.py -t ${SLURM_TMPDIR} \
  -m 6G \
  -G $GATK_JAR \
  -D $CONPAIR_DIR \
  -R /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -M ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.bed \
  -B alignment/TCMG240_T1/TCMG240_T1.sorted.dup.bam \
  -O alignment/TCMG240_T1/TCMG240_T1.gatkPileup 
conpair_concordance_contamination.pileup.TCMG240_T1.TCMG240_T1.cc1d50d6451c8828c1a2b203e6beb5a2.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: conpair_concordance_contamination_9_JOB_ID: conpair_concordance_contamination.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=conpair_concordance_contamination.TCMG240_T1
JOB_DEPENDENCIES=$conpair_concordance_contamination_7_JOB_ID:$conpair_concordance_contamination_8_JOB_ID
JOB_DONE=job_output/conpair_concordance_contamination/conpair_concordance_contamination.TCMG240_T1.122068194bf7dc6b583be4f8671ca02b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'conpair_concordance_contamination.TCMG240_T1.122068194bf7dc6b583be4f8671ca02b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.9.1 mugqic/Conpair/0.2 && \
mkdir -p metrics && \
touch metrics && \
python3 $CONPAIR_SCRIPTS/verify_concordance.py --normal_homozygous_markers_only \
  --markers ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.txt \
  --normal_pileup alignment/TCMG240_N/TCMG240_N.gatkPileup \
  --tumor_pileup alignment/TCMG240_T1/TCMG240_T1.gatkPileup \
  --outfile metrics/TCMG240_T1.concordance.tsv && \
python3 $CONPAIR_SCRIPTS/estimate_tumor_normal_contamination.py  \
  --markers ${CONPAIR_DATA}/markers/GRCh37.autosomes.phase3_shapeit2_mvncall_integrated.20130502.SNV.genotype.sselect_v4_MAF_0.4_LD_0.8.txt \
  --normal_pileup alignment/TCMG240_N/TCMG240_N.gatkPileup \
  --tumor_pileup alignment/TCMG240_T1/TCMG240_T1.gatkPileup \
  --outfile metrics/TCMG240_T1.contamination.tsv
conpair_concordance_contamination.TCMG240_T1.122068194bf7dc6b583be4f8671ca02b.mugqic.done
chmod 755 $COMMAND
conpair_concordance_contamination_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 6G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$conpair_concordance_contamination_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$conpair_concordance_contamination_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: metrics_dna_picard_metrics
#-------------------------------------------------------------------------------
STEP=metrics_dna_picard_metrics
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_1_JOB_ID: picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_N.a4ef71b2f1bdcc3f5fc3c7e1d638a8ca.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_N.a4ef71b2f1bdcc3f5fc3c7e1d638a8ca.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_N/picard_metrics && \
touch metrics/dna/SISJ0635_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx11G" \
  CollectMultipleMetrics \
  --PROGRAM CollectAlignmentSummaryMetrics \
  --PROGRAM CollectInsertSizeMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --TMP_DIR ${SLURM_TMPDIR} \
  --REFERENCE_SEQUENCE /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --INPUT alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.all.metrics \
  --MAX_RECORDS_IN_RAM 1000000
picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_N.a4ef71b2f1bdcc3f5fc3c7e1d638a8ca.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_2_JOB_ID: picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_N.f867c8763f804ddccc4b73db588db554.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_N.f867c8763f804ddccc4b73db588db554.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_N/picard_metrics && \
touch metrics/dna/SISJ0635_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectOxoGMetrics \
  --VALIDATION_STRINGENCY SILENT  \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.oxog_metrics.txt \
  --DB_SNP $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_N.f867c8763f804ddccc4b73db588db554.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_3_JOB_ID: picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_N.341944ef2e5deadd59e5010826ead010.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_N.341944ef2e5deadd59e5010826ead010.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_N/picard_metrics && \
touch metrics/dna/SISJ0635_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectGcBiasMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --ALSO_IGNORE_DUPLICATES TRUE \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.qcbias_metrics.txt \
  --CHART metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.qcbias_metrics.pdf \
  --SUMMARY_OUTPUT metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.qcbias_summary_metrics.txt \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_N.341944ef2e5deadd59e5010826ead010.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_4_JOB_ID: picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_T.4ab10460c3f6e618048ac86fa15bffe9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_T.4ab10460c3f6e618048ac86fa15bffe9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_T/picard_metrics && \
touch metrics/dna/SISJ0635_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx11G" \
  CollectMultipleMetrics \
  --PROGRAM CollectAlignmentSummaryMetrics \
  --PROGRAM CollectInsertSizeMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --TMP_DIR ${SLURM_TMPDIR} \
  --REFERENCE_SEQUENCE /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --INPUT alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.all.metrics \
  --MAX_RECORDS_IN_RAM 1000000
picard_collect_multiple_metrics.SISJ0635_T.SISJ0635_T.4ab10460c3f6e618048ac86fa15bffe9.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_5_JOB_ID: picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_T.7b9d2911b1c7c0eddd0ac9ea740e74b4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_T.7b9d2911b1c7c0eddd0ac9ea740e74b4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_T/picard_metrics && \
touch metrics/dna/SISJ0635_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectOxoGMetrics \
  --VALIDATION_STRINGENCY SILENT  \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.oxog_metrics.txt \
  --DB_SNP $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_oxog_metrics.SISJ0635_T.SISJ0635_T.7b9d2911b1c7c0eddd0ac9ea740e74b4.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_6_JOB_ID: picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_T.550aeb2dbe3507a0a498b99d99a7c6db.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_T.550aeb2dbe3507a0a498b99d99a7c6db.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_T/picard_metrics && \
touch metrics/dna/SISJ0635_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectGcBiasMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --ALSO_IGNORE_DUPLICATES TRUE \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.qcbias_metrics.txt \
  --CHART metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.qcbias_metrics.pdf \
  --SUMMARY_OUTPUT metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.qcbias_summary_metrics.txt \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_gcbias_metrics.SISJ0635_T.SISJ0635_T.550aeb2dbe3507a0a498b99d99a7c6db.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_7_JOB_ID: picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_N.a9c436ccd52229f5cc2c080bf4f3dcee.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_N.a9c436ccd52229f5cc2c080bf4f3dcee.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_N/picard_metrics && \
touch metrics/dna/SISJ0635_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12000M" \
 CollectSequencingArtifactMetrics \
  --VALIDATION_STRINGENCY SILENT --FILE_EXTENSION ".txt" \
  --INPUT alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_N.a9c436ccd52229f5cc2c080bf4f3dcee.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_8_JOB_ID: picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_T.236377b441a2c799a1a64b4b05d113ed.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_T.236377b441a2c799a1a64b4b05d113ed.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0635_T/picard_metrics && \
touch metrics/dna/SISJ0635_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12000M" \
 CollectSequencingArtifactMetrics \
  --VALIDATION_STRINGENCY SILENT --FILE_EXTENSION ".txt" \
  --INPUT alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_sequencing_artifacts_metrics.SISJ0635_T.SISJ0635_T.236377b441a2c799a1a64b4b05d113ed.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_9_JOB_ID: picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_N.c837ca2d3097d2b59ba9b4b53cc8874d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_N.c837ca2d3097d2b59ba9b4b53cc8874d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_N/picard_metrics && \
touch metrics/dna/SISJ0732_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx11G" \
  CollectMultipleMetrics \
  --PROGRAM CollectAlignmentSummaryMetrics \
  --PROGRAM CollectInsertSizeMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --TMP_DIR ${SLURM_TMPDIR} \
  --REFERENCE_SEQUENCE /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --INPUT alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.all.metrics \
  --MAX_RECORDS_IN_RAM 1000000
picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_N.c837ca2d3097d2b59ba9b4b53cc8874d.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_10_JOB_ID: picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_N.bc02eedc22b45c7fa6dd9e8c04cd6a1a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_N.bc02eedc22b45c7fa6dd9e8c04cd6a1a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_N/picard_metrics && \
touch metrics/dna/SISJ0732_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectOxoGMetrics \
  --VALIDATION_STRINGENCY SILENT  \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.oxog_metrics.txt \
  --DB_SNP $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_N.bc02eedc22b45c7fa6dd9e8c04cd6a1a.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_11_JOB_ID: picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_N.6fa6bf9ac25e27abf7b68e57659b1b83.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_N.6fa6bf9ac25e27abf7b68e57659b1b83.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_N/picard_metrics && \
touch metrics/dna/SISJ0732_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectGcBiasMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --ALSO_IGNORE_DUPLICATES TRUE \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.qcbias_metrics.txt \
  --CHART metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.qcbias_metrics.pdf \
  --SUMMARY_OUTPUT metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.qcbias_summary_metrics.txt \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_N.6fa6bf9ac25e27abf7b68e57659b1b83.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_12_JOB_ID: picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_T.cacc1c09a847e1ac03b97adbcaeeb17a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_T.cacc1c09a847e1ac03b97adbcaeeb17a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_T/picard_metrics && \
touch metrics/dna/SISJ0732_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx11G" \
  CollectMultipleMetrics \
  --PROGRAM CollectAlignmentSummaryMetrics \
  --PROGRAM CollectInsertSizeMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --TMP_DIR ${SLURM_TMPDIR} \
  --REFERENCE_SEQUENCE /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --INPUT alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.all.metrics \
  --MAX_RECORDS_IN_RAM 1000000
picard_collect_multiple_metrics.SISJ0732_T.SISJ0732_T.cacc1c09a847e1ac03b97adbcaeeb17a.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_13_JOB_ID: picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_T.ca7fb9e7f01ebbcffd5944359ba72a4f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_T.ca7fb9e7f01ebbcffd5944359ba72a4f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_T/picard_metrics && \
touch metrics/dna/SISJ0732_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectOxoGMetrics \
  --VALIDATION_STRINGENCY SILENT  \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.oxog_metrics.txt \
  --DB_SNP $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_oxog_metrics.SISJ0732_T.SISJ0732_T.ca7fb9e7f01ebbcffd5944359ba72a4f.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_13_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_13_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_13_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_14_JOB_ID: picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_T.e7c16b3ac1c6ac3ac87b2122f1815beb.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_T.e7c16b3ac1c6ac3ac87b2122f1815beb.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_T/picard_metrics && \
touch metrics/dna/SISJ0732_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectGcBiasMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --ALSO_IGNORE_DUPLICATES TRUE \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.qcbias_metrics.txt \
  --CHART metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.qcbias_metrics.pdf \
  --SUMMARY_OUTPUT metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.qcbias_summary_metrics.txt \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_gcbias_metrics.SISJ0732_T.SISJ0732_T.e7c16b3ac1c6ac3ac87b2122f1815beb.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_14_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_14_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_14_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_15_JOB_ID: picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_N.3415f18a3933df746a4f9fc925c6809c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_N.3415f18a3933df746a4f9fc925c6809c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_N/picard_metrics && \
touch metrics/dna/SISJ0732_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12000M" \
 CollectSequencingArtifactMetrics \
  --VALIDATION_STRINGENCY SILENT --FILE_EXTENSION ".txt" \
  --INPUT alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_N.3415f18a3933df746a4f9fc925c6809c.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_15_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_15_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_15_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_16_JOB_ID: picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_T.3a60e210d7a8842b09e29319d97a7427.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_T.3a60e210d7a8842b09e29319d97a7427.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/SISJ0732_T/picard_metrics && \
touch metrics/dna/SISJ0732_T/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12000M" \
 CollectSequencingArtifactMetrics \
  --VALIDATION_STRINGENCY SILENT --FILE_EXTENSION ".txt" \
  --INPUT alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_sequencing_artifacts_metrics.SISJ0732_T.SISJ0732_T.3a60e210d7a8842b09e29319d97a7427.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_16_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_16_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_16_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_17_JOB_ID: picard_collect_multiple_metrics.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_multiple_metrics.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_multiple_metrics.TCMG240_T1.TCMG240_N.448b090d240e12c7503737fae298196f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_multiple_metrics.TCMG240_T1.TCMG240_N.448b090d240e12c7503737fae298196f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_N/picard_metrics && \
touch metrics/dna/TCMG240_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx11G" \
  CollectMultipleMetrics \
  --PROGRAM CollectAlignmentSummaryMetrics \
  --PROGRAM CollectInsertSizeMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --TMP_DIR ${SLURM_TMPDIR} \
  --REFERENCE_SEQUENCE /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --INPUT alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.all.metrics \
  --MAX_RECORDS_IN_RAM 1000000
picard_collect_multiple_metrics.TCMG240_T1.TCMG240_N.448b090d240e12c7503737fae298196f.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_17_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_17_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_17_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_18_JOB_ID: picard_collect_oxog_metrics.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_oxog_metrics.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_oxog_metrics.TCMG240_T1.TCMG240_N.823ac6e67ff140ae5dbd061b7075d032.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_oxog_metrics.TCMG240_T1.TCMG240_N.823ac6e67ff140ae5dbd061b7075d032.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_N/picard_metrics && \
touch metrics/dna/TCMG240_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectOxoGMetrics \
  --VALIDATION_STRINGENCY SILENT  \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.oxog_metrics.txt \
  --DB_SNP $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_oxog_metrics.TCMG240_T1.TCMG240_N.823ac6e67ff140ae5dbd061b7075d032.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_18_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_18_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_18_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_19_JOB_ID: picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_N.e84fc380be8c5ac60a3708075fe547ea.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_N.e84fc380be8c5ac60a3708075fe547ea.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_N/picard_metrics && \
touch metrics/dna/TCMG240_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectGcBiasMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --ALSO_IGNORE_DUPLICATES TRUE \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.qcbias_metrics.txt \
  --CHART metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.qcbias_metrics.pdf \
  --SUMMARY_OUTPUT metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.qcbias_summary_metrics.txt \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_N.e84fc380be8c5ac60a3708075fe547ea.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_19_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_19_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_19_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_20_JOB_ID: picard_collect_multiple_metrics.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_multiple_metrics.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_multiple_metrics.TCMG240_T1.TCMG240_T1.89963b8556bd0b00e7653d71ebc0a700.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_multiple_metrics.TCMG240_T1.TCMG240_T1.89963b8556bd0b00e7653d71ebc0a700.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_T1/picard_metrics && \
touch metrics/dna/TCMG240_T1/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx11G" \
  CollectMultipleMetrics \
  --PROGRAM CollectAlignmentSummaryMetrics \
  --PROGRAM CollectInsertSizeMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --TMP_DIR ${SLURM_TMPDIR} \
  --REFERENCE_SEQUENCE /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --INPUT alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.all.metrics \
  --MAX_RECORDS_IN_RAM 1000000
picard_collect_multiple_metrics.TCMG240_T1.TCMG240_T1.89963b8556bd0b00e7653d71ebc0a700.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_20_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_20_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_20_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_21_JOB_ID: picard_collect_oxog_metrics.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_oxog_metrics.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_oxog_metrics.TCMG240_T1.TCMG240_T1.1f0fd861aea3e93627db179e30767278.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_oxog_metrics.TCMG240_T1.TCMG240_T1.1f0fd861aea3e93627db179e30767278.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_T1/picard_metrics && \
touch metrics/dna/TCMG240_T1/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectOxoGMetrics \
  --VALIDATION_STRINGENCY SILENT  \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.oxog_metrics.txt \
  --DB_SNP $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_oxog_metrics.TCMG240_T1.TCMG240_T1.1f0fd861aea3e93627db179e30767278.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_21_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_21_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_21_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_22_JOB_ID: picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_T1.a4bd18de1b35e694c80ff1fc8727396f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_T1.a4bd18de1b35e694c80ff1fc8727396f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.2.2.0 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_T1/picard_metrics && \
touch metrics/dna/TCMG240_T1/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12G" \
  CollectGcBiasMetrics \
  --VALIDATION_STRINGENCY SILENT \
  --ALSO_IGNORE_DUPLICATES TRUE \
  --TMP_DIR ${SLURM_TMPDIR} \
  --INPUT alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.qcbias_metrics.txt \
  --CHART metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.qcbias_metrics.pdf \
  --SUMMARY_OUTPUT metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.qcbias_summary_metrics.txt \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_gcbias_metrics.TCMG240_T1.TCMG240_T1.a4bd18de1b35e694c80ff1fc8727396f.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_22_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 13G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_22_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_22_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_23_JOB_ID: picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_N.9670aff7dce93a280390340ba14a777c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_N.9670aff7dce93a280390340ba14a777c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_N/picard_metrics && \
touch metrics/dna/TCMG240_N/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12000M" \
 CollectSequencingArtifactMetrics \
  --VALIDATION_STRINGENCY SILENT --FILE_EXTENSION ".txt" \
  --INPUT alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_N/picard_metrics/TCMG240_N \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_N.9670aff7dce93a280390340ba14a777c.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_23_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_23_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_23_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_picard_metrics_24_JOB_ID: picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/metrics_dna_picard_metrics/picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_T1.6cd5a47645740472abae8f8ed0c5b26b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_T1.6cd5a47645740472abae8f8ed0c5b26b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p metrics/dna/TCMG240_T1/picard_metrics && \
touch metrics/dna/TCMG240_T1/picard_metrics && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx12000M" \
 CollectSequencingArtifactMetrics \
  --VALIDATION_STRINGENCY SILENT --FILE_EXTENSION ".txt" \
  --INPUT alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --OUTPUT metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1 \
  --REFERENCE_SEQUENCE $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --MAX_RECORDS_IN_RAM 4000000
picard_collect_sequencing_artifacts_metrics.TCMG240_T1.TCMG240_T1.6cd5a47645740472abae8f8ed0c5b26b.mugqic.done
chmod 755 $COMMAND
metrics_dna_picard_metrics_24_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_picard_metrics_24_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_picard_metrics_24_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: metrics_dna_sample_qualimap
#-------------------------------------------------------------------------------
STEP=metrics_dna_sample_qualimap
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: metrics_dna_sample_qualimap_1_JOB_ID: dna_sample_qualimap.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=dna_sample_qualimap.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/metrics_dna_sample_qualimap/dna_sample_qualimap.SISJ0635_T.SISJ0635_N.54533326bd9c86782994a33bed508645.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'dna_sample_qualimap.SISJ0635_T.SISJ0635_N.54533326bd9c86782994a33bed508645.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/qualimap/2.2.2dev && \
mkdir -p metrics/dna/SISJ0635_N/qualimap/SISJ0635_N && \
touch metrics/dna/SISJ0635_N/qualimap/SISJ0635_N && \
qualimap bamqc --skip-duplicated -nt 1 -gd HUMAN \
  -bam alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam -outdir metrics/dna/SISJ0635_N/qualimap/SISJ0635_N \
  --java-mem-size=60G
dna_sample_qualimap.SISJ0635_T.SISJ0635_N.54533326bd9c86782994a33bed508645.mugqic.done
chmod 755 $COMMAND
metrics_dna_sample_qualimap_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 60G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_sample_qualimap_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_sample_qualimap_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_sample_qualimap_2_JOB_ID: dna_sample_qualimap.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=dna_sample_qualimap.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/metrics_dna_sample_qualimap/dna_sample_qualimap.SISJ0635_T.SISJ0635_T.605f265d640bd69d3615225e0dddcf1b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'dna_sample_qualimap.SISJ0635_T.SISJ0635_T.605f265d640bd69d3615225e0dddcf1b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/qualimap/2.2.2dev && \
mkdir -p metrics/dna/SISJ0635_T/qualimap/SISJ0635_T && \
touch metrics/dna/SISJ0635_T/qualimap/SISJ0635_T && \
qualimap bamqc --skip-duplicated -nt 1 -gd HUMAN \
  -bam alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam -outdir metrics/dna/SISJ0635_T/qualimap/SISJ0635_T \
  --java-mem-size=60G
dna_sample_qualimap.SISJ0635_T.SISJ0635_T.605f265d640bd69d3615225e0dddcf1b.mugqic.done
chmod 755 $COMMAND
metrics_dna_sample_qualimap_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 60G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_sample_qualimap_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_sample_qualimap_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_sample_qualimap_3_JOB_ID: dna_sample_qualimap.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=dna_sample_qualimap.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/metrics_dna_sample_qualimap/dna_sample_qualimap.SISJ0732_T.SISJ0732_N.77e90e9f218c01eb74804e6f5d7e0869.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'dna_sample_qualimap.SISJ0732_T.SISJ0732_N.77e90e9f218c01eb74804e6f5d7e0869.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/qualimap/2.2.2dev && \
mkdir -p metrics/dna/SISJ0732_N/qualimap/SISJ0732_N && \
touch metrics/dna/SISJ0732_N/qualimap/SISJ0732_N && \
qualimap bamqc --skip-duplicated -nt 1 -gd HUMAN \
  -bam alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam -outdir metrics/dna/SISJ0732_N/qualimap/SISJ0732_N \
  --java-mem-size=60G
dna_sample_qualimap.SISJ0732_T.SISJ0732_N.77e90e9f218c01eb74804e6f5d7e0869.mugqic.done
chmod 755 $COMMAND
metrics_dna_sample_qualimap_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 60G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_sample_qualimap_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_sample_qualimap_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_sample_qualimap_4_JOB_ID: dna_sample_qualimap.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=dna_sample_qualimap.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/metrics_dna_sample_qualimap/dna_sample_qualimap.SISJ0732_T.SISJ0732_T.186d74eaf0bc8a15b62b0c4be1f545a9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'dna_sample_qualimap.SISJ0732_T.SISJ0732_T.186d74eaf0bc8a15b62b0c4be1f545a9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/qualimap/2.2.2dev && \
mkdir -p metrics/dna/SISJ0732_T/qualimap/SISJ0732_T && \
touch metrics/dna/SISJ0732_T/qualimap/SISJ0732_T && \
qualimap bamqc --skip-duplicated -nt 1 -gd HUMAN \
  -bam alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam -outdir metrics/dna/SISJ0732_T/qualimap/SISJ0732_T \
  --java-mem-size=60G
dna_sample_qualimap.SISJ0732_T.SISJ0732_T.186d74eaf0bc8a15b62b0c4be1f545a9.mugqic.done
chmod 755 $COMMAND
metrics_dna_sample_qualimap_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 60G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_sample_qualimap_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_sample_qualimap_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_sample_qualimap_5_JOB_ID: dna_sample_qualimap.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=dna_sample_qualimap.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/metrics_dna_sample_qualimap/dna_sample_qualimap.TCMG240_T1.TCMG240_N.6643da0fe7eb090e23b655aa12e7462b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'dna_sample_qualimap.TCMG240_T1.TCMG240_N.6643da0fe7eb090e23b655aa12e7462b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/qualimap/2.2.2dev && \
mkdir -p metrics/dna/TCMG240_N/qualimap/TCMG240_N && \
touch metrics/dna/TCMG240_N/qualimap/TCMG240_N && \
qualimap bamqc --skip-duplicated -nt 1 -gd HUMAN \
  -bam alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam -outdir metrics/dna/TCMG240_N/qualimap/TCMG240_N \
  --java-mem-size=60G
dna_sample_qualimap.TCMG240_T1.TCMG240_N.6643da0fe7eb090e23b655aa12e7462b.mugqic.done
chmod 755 $COMMAND
metrics_dna_sample_qualimap_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 60G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_sample_qualimap_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_sample_qualimap_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_sample_qualimap_6_JOB_ID: dna_sample_qualimap.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=dna_sample_qualimap.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/metrics_dna_sample_qualimap/dna_sample_qualimap.TCMG240_T1.TCMG240_T1.810cb4dca754e152535ed4a577e389aa.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'dna_sample_qualimap.TCMG240_T1.TCMG240_T1.810cb4dca754e152535ed4a577e389aa.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/qualimap/2.2.2dev && \
mkdir -p metrics/dna/TCMG240_T1/qualimap/TCMG240_T1 && \
touch metrics/dna/TCMG240_T1/qualimap/TCMG240_T1 && \
qualimap bamqc --skip-duplicated -nt 1 -gd HUMAN \
  -bam alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam -outdir metrics/dna/TCMG240_T1/qualimap/TCMG240_T1 \
  --java-mem-size=60G
dna_sample_qualimap.TCMG240_T1.TCMG240_T1.810cb4dca754e152535ed4a577e389aa.mugqic.done
chmod 755 $COMMAND
metrics_dna_sample_qualimap_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem 60G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_sample_qualimap_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_sample_qualimap_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: metrics_dna_fastqc
#-------------------------------------------------------------------------------
STEP=metrics_dna_fastqc
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: metrics_dna_fastqc_1_JOB_ID: fastqc.SISJ0635_T.SISJ0635_N
#-------------------------------------------------------------------------------
JOB_NAME=fastqc.SISJ0635_T.SISJ0635_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_1_JOB_ID
JOB_DONE=job_output/metrics_dna_fastqc/fastqc.SISJ0635_T.SISJ0635_N.902a99dcb83ae60a88b4d568283cc5dd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'fastqc.SISJ0635_T.SISJ0635_N.902a99dcb83ae60a88b4d568283cc5dd.mugqic.done' > $COMMAND
module purge && \
module load mugqic/fastqc/0.11.5 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p metrics/dna/SISJ0635_N/fastqc && \
touch metrics/dna/SISJ0635_N/fastqc && \
`cat > metrics/dna/SISJ0635_N/fastqc/adapter.tsv << END
>Adapter1	AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2	 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
fastqc \
  -o metrics/dna/SISJ0635_N/fastqc \
  -t 4 \
  -a metrics/dna/SISJ0635_N/fastqc/adapter.tsv \
  -f bam \
  alignment/SISJ0635_N/SISJ0635_N.sorted.dup.bam
fastqc.SISJ0635_T.SISJ0635_N.902a99dcb83ae60a88b4d568283cc5dd.mugqic.done
chmod 755 $COMMAND
metrics_dna_fastqc_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem-per-cpu 3900M -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_fastqc_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_fastqc_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_fastqc_2_JOB_ID: fastqc.SISJ0635_T.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=fastqc.SISJ0635_T.SISJ0635_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_2_JOB_ID
JOB_DONE=job_output/metrics_dna_fastqc/fastqc.SISJ0635_T.SISJ0635_T.80d4b8e17a624ade6e14adb941632e97.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'fastqc.SISJ0635_T.SISJ0635_T.80d4b8e17a624ade6e14adb941632e97.mugqic.done' > $COMMAND
module purge && \
module load mugqic/fastqc/0.11.5 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p metrics/dna/SISJ0635_T/fastqc && \
touch metrics/dna/SISJ0635_T/fastqc && \
`cat > metrics/dna/SISJ0635_T/fastqc/adapter.tsv << END
>Adapter1	AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2	 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
fastqc \
  -o metrics/dna/SISJ0635_T/fastqc \
  -t 4 \
  -a metrics/dna/SISJ0635_T/fastqc/adapter.tsv \
  -f bam \
  alignment/SISJ0635_T/SISJ0635_T.sorted.dup.bam
fastqc.SISJ0635_T.SISJ0635_T.80d4b8e17a624ade6e14adb941632e97.mugqic.done
chmod 755 $COMMAND
metrics_dna_fastqc_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem-per-cpu 3900M -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_fastqc_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_fastqc_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_fastqc_3_JOB_ID: fastqc.SISJ0732_T.SISJ0732_N
#-------------------------------------------------------------------------------
JOB_NAME=fastqc.SISJ0732_T.SISJ0732_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_3_JOB_ID
JOB_DONE=job_output/metrics_dna_fastqc/fastqc.SISJ0732_T.SISJ0732_N.178a926f8e2ad227f517bc148313a11c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'fastqc.SISJ0732_T.SISJ0732_N.178a926f8e2ad227f517bc148313a11c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/fastqc/0.11.5 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p metrics/dna/SISJ0732_N/fastqc && \
touch metrics/dna/SISJ0732_N/fastqc && \
`cat > metrics/dna/SISJ0732_N/fastqc/adapter.tsv << END
>Adapter1	AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2	 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
fastqc \
  -o metrics/dna/SISJ0732_N/fastqc \
  -t 4 \
  -a metrics/dna/SISJ0732_N/fastqc/adapter.tsv \
  -f bam \
  alignment/SISJ0732_N/SISJ0732_N.sorted.dup.bam
fastqc.SISJ0732_T.SISJ0732_N.178a926f8e2ad227f517bc148313a11c.mugqic.done
chmod 755 $COMMAND
metrics_dna_fastqc_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem-per-cpu 3900M -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_fastqc_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_fastqc_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_fastqc_4_JOB_ID: fastqc.SISJ0732_T.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=fastqc.SISJ0732_T.SISJ0732_T
JOB_DEPENDENCIES=$sambamba_mark_duplicates_4_JOB_ID
JOB_DONE=job_output/metrics_dna_fastqc/fastqc.SISJ0732_T.SISJ0732_T.cec9844a6919c21da97e0884e18320f9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'fastqc.SISJ0732_T.SISJ0732_T.cec9844a6919c21da97e0884e18320f9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/fastqc/0.11.5 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p metrics/dna/SISJ0732_T/fastqc && \
touch metrics/dna/SISJ0732_T/fastqc && \
`cat > metrics/dna/SISJ0732_T/fastqc/adapter.tsv << END
>Adapter1	AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2	 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
fastqc \
  -o metrics/dna/SISJ0732_T/fastqc \
  -t 4 \
  -a metrics/dna/SISJ0732_T/fastqc/adapter.tsv \
  -f bam \
  alignment/SISJ0732_T/SISJ0732_T.sorted.dup.bam
fastqc.SISJ0732_T.SISJ0732_T.cec9844a6919c21da97e0884e18320f9.mugqic.done
chmod 755 $COMMAND
metrics_dna_fastqc_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem-per-cpu 3900M -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_fastqc_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_fastqc_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_fastqc_5_JOB_ID: fastqc.TCMG240_T1.TCMG240_N
#-------------------------------------------------------------------------------
JOB_NAME=fastqc.TCMG240_T1.TCMG240_N
JOB_DEPENDENCIES=$sambamba_mark_duplicates_5_JOB_ID
JOB_DONE=job_output/metrics_dna_fastqc/fastqc.TCMG240_T1.TCMG240_N.989e38b013d04831c6a55c17f0211677.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'fastqc.TCMG240_T1.TCMG240_N.989e38b013d04831c6a55c17f0211677.mugqic.done' > $COMMAND
module purge && \
module load mugqic/fastqc/0.11.5 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p metrics/dna/TCMG240_N/fastqc && \
touch metrics/dna/TCMG240_N/fastqc && \
`cat > metrics/dna/TCMG240_N/fastqc/adapter.tsv << END
>Adapter1	AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2	 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
fastqc \
  -o metrics/dna/TCMG240_N/fastqc \
  -t 4 \
  -a metrics/dna/TCMG240_N/fastqc/adapter.tsv \
  -f bam \
  alignment/TCMG240_N/TCMG240_N.sorted.dup.bam
fastqc.TCMG240_T1.TCMG240_N.989e38b013d04831c6a55c17f0211677.mugqic.done
chmod 755 $COMMAND
metrics_dna_fastqc_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem-per-cpu 3900M -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_fastqc_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_fastqc_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: metrics_dna_fastqc_6_JOB_ID: fastqc.TCMG240_T1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=fastqc.TCMG240_T1.TCMG240_T1
JOB_DEPENDENCIES=$sambamba_mark_duplicates_6_JOB_ID
JOB_DONE=job_output/metrics_dna_fastqc/fastqc.TCMG240_T1.TCMG240_T1.92c4ce5e8c3ef92c55a10fd863b075a1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'fastqc.TCMG240_T1.TCMG240_T1.92c4ce5e8c3ef92c55a10fd863b075a1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/fastqc/0.11.5 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p metrics/dna/TCMG240_T1/fastqc && \
touch metrics/dna/TCMG240_T1/fastqc && \
`cat > metrics/dna/TCMG240_T1/fastqc/adapter.tsv << END
>Adapter1	AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC
>Adapter2	 AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
END` && \
fastqc \
  -o metrics/dna/TCMG240_T1/fastqc \
  -t 4 \
  -a metrics/dna/TCMG240_T1/fastqc/adapter.tsv \
  -f bam \
  alignment/TCMG240_T1/TCMG240_T1.sorted.dup.bam
fastqc.TCMG240_T1.TCMG240_T1.92c4ce5e8c3ef92c55a10fd863b075a1.mugqic.done
chmod 755 $COMMAND
metrics_dna_fastqc_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=35:00:00 --mem-per-cpu 3900M -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_dna_fastqc_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_dna_fastqc_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sequenza
#-------------------------------------------------------------------------------
STEP=sequenza
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sequenza_1_JOB_ID: sequenza.create_seqz.1.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.1.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.1.SISJ0635_T.b778d2d50a1e1d37838f233a817317d8.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.1.SISJ0635_T.b778d2d50a1e1d37838f233a817317d8.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 1 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.1.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.1.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.1.gz
sequenza.create_seqz.1.SISJ0635_T.b778d2d50a1e1d37838f233a817317d8.mugqic.done
chmod 755 $COMMAND
sequenza_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_2_JOB_ID: sequenza.create_seqz.2.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.2.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.2.SISJ0635_T.c84e5d8ac9747abd8775471912c180d0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.2.SISJ0635_T.c84e5d8ac9747abd8775471912c180d0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 2 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.2.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.2.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.2.gz
sequenza.create_seqz.2.SISJ0635_T.c84e5d8ac9747abd8775471912c180d0.mugqic.done
chmod 755 $COMMAND
sequenza_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_3_JOB_ID: sequenza.create_seqz.3.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.3.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.3.SISJ0635_T.a3133f6eb29fca0daeccdf65205ad760.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.3.SISJ0635_T.a3133f6eb29fca0daeccdf65205ad760.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 3 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.3.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.3.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.3.gz
sequenza.create_seqz.3.SISJ0635_T.a3133f6eb29fca0daeccdf65205ad760.mugqic.done
chmod 755 $COMMAND
sequenza_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_4_JOB_ID: sequenza.create_seqz.4.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.4.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.4.SISJ0635_T.69965f328810e6c619820a86a6720e36.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.4.SISJ0635_T.69965f328810e6c619820a86a6720e36.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 4 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.4.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.4.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.4.gz
sequenza.create_seqz.4.SISJ0635_T.69965f328810e6c619820a86a6720e36.mugqic.done
chmod 755 $COMMAND
sequenza_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_5_JOB_ID: sequenza.create_seqz.5.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.5.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.5.SISJ0635_T.d6c642a05018dd582c158c1d0d1b2a13.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.5.SISJ0635_T.d6c642a05018dd582c158c1d0d1b2a13.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 5 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.5.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.5.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.5.gz
sequenza.create_seqz.5.SISJ0635_T.d6c642a05018dd582c158c1d0d1b2a13.mugqic.done
chmod 755 $COMMAND
sequenza_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_6_JOB_ID: sequenza.create_seqz.6.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.6.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.6.SISJ0635_T.9ab16d071aa0c5f7883494ce6f7ad686.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.6.SISJ0635_T.9ab16d071aa0c5f7883494ce6f7ad686.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 6 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.6.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.6.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.6.gz
sequenza.create_seqz.6.SISJ0635_T.9ab16d071aa0c5f7883494ce6f7ad686.mugqic.done
chmod 755 $COMMAND
sequenza_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_7_JOB_ID: sequenza.create_seqz.7.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.7.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.7.SISJ0635_T.c3312416e0df9be3d7d22929df4431f4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.7.SISJ0635_T.c3312416e0df9be3d7d22929df4431f4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 7 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.7.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.7.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.7.gz
sequenza.create_seqz.7.SISJ0635_T.c3312416e0df9be3d7d22929df4431f4.mugqic.done
chmod 755 $COMMAND
sequenza_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_8_JOB_ID: sequenza.create_seqz.8.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.8.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.8.SISJ0635_T.3ec6ec1f0b5821fb69fb3ca085d61cd7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.8.SISJ0635_T.3ec6ec1f0b5821fb69fb3ca085d61cd7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 8 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.8.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.8.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.8.gz
sequenza.create_seqz.8.SISJ0635_T.3ec6ec1f0b5821fb69fb3ca085d61cd7.mugqic.done
chmod 755 $COMMAND
sequenza_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_9_JOB_ID: sequenza.create_seqz.9.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.9.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.9.SISJ0635_T.bb80fe5787d67097b8c5375cdbd5f91c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.9.SISJ0635_T.bb80fe5787d67097b8c5375cdbd5f91c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 9 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.9.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.9.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.9.gz
sequenza.create_seqz.9.SISJ0635_T.bb80fe5787d67097b8c5375cdbd5f91c.mugqic.done
chmod 755 $COMMAND
sequenza_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_10_JOB_ID: sequenza.create_seqz.10.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.10.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.10.SISJ0635_T.eb680cb1e1028c004361855c4d0d35b5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.10.SISJ0635_T.eb680cb1e1028c004361855c4d0d35b5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 10 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.10.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.10.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.10.gz
sequenza.create_seqz.10.SISJ0635_T.eb680cb1e1028c004361855c4d0d35b5.mugqic.done
chmod 755 $COMMAND
sequenza_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_11_JOB_ID: sequenza.create_seqz.11.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.11.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.11.SISJ0635_T.c53319acfacbbc0c1d28c17e432d988f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.11.SISJ0635_T.c53319acfacbbc0c1d28c17e432d988f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 11 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.11.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.11.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.11.gz
sequenza.create_seqz.11.SISJ0635_T.c53319acfacbbc0c1d28c17e432d988f.mugqic.done
chmod 755 $COMMAND
sequenza_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_12_JOB_ID: sequenza.create_seqz.12.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.12.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.12.SISJ0635_T.faa0649118edcade312820ee4d9f64b9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.12.SISJ0635_T.faa0649118edcade312820ee4d9f64b9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 12 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.12.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.12.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.12.gz
sequenza.create_seqz.12.SISJ0635_T.faa0649118edcade312820ee4d9f64b9.mugqic.done
chmod 755 $COMMAND
sequenza_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_13_JOB_ID: sequenza.create_seqz.13.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.13.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.13.SISJ0635_T.e1e44e14f6b8a025e7ddb87f9971a761.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.13.SISJ0635_T.e1e44e14f6b8a025e7ddb87f9971a761.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 13 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.13.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.13.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.13.gz
sequenza.create_seqz.13.SISJ0635_T.e1e44e14f6b8a025e7ddb87f9971a761.mugqic.done
chmod 755 $COMMAND
sequenza_13_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_13_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_13_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_14_JOB_ID: sequenza.create_seqz.14.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.14.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.14.SISJ0635_T.406d036dae348648a69c7eb54a0e1228.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.14.SISJ0635_T.406d036dae348648a69c7eb54a0e1228.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 14 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.14.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.14.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.14.gz
sequenza.create_seqz.14.SISJ0635_T.406d036dae348648a69c7eb54a0e1228.mugqic.done
chmod 755 $COMMAND
sequenza_14_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_14_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_14_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_15_JOB_ID: sequenza.create_seqz.15.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.15.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.15.SISJ0635_T.25d0c1c61387450b87eb3ddf1e77f27b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.15.SISJ0635_T.25d0c1c61387450b87eb3ddf1e77f27b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 15 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.15.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.15.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.15.gz
sequenza.create_seqz.15.SISJ0635_T.25d0c1c61387450b87eb3ddf1e77f27b.mugqic.done
chmod 755 $COMMAND
sequenza_15_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_15_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_15_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_16_JOB_ID: sequenza.create_seqz.16.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.16.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.16.SISJ0635_T.28baa728cbaddb4efd2ab91cc709c071.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.16.SISJ0635_T.28baa728cbaddb4efd2ab91cc709c071.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 16 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.16.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.16.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.16.gz
sequenza.create_seqz.16.SISJ0635_T.28baa728cbaddb4efd2ab91cc709c071.mugqic.done
chmod 755 $COMMAND
sequenza_16_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_16_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_16_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_17_JOB_ID: sequenza.create_seqz.17.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.17.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.17.SISJ0635_T.425e9adc28ac682fee751f4f9dfb5398.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.17.SISJ0635_T.425e9adc28ac682fee751f4f9dfb5398.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 17 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.17.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.17.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.17.gz
sequenza.create_seqz.17.SISJ0635_T.425e9adc28ac682fee751f4f9dfb5398.mugqic.done
chmod 755 $COMMAND
sequenza_17_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_17_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_17_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_18_JOB_ID: sequenza.create_seqz.18.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.18.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.18.SISJ0635_T.5a8db6ad97fdd04b8ed8a821d246130f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.18.SISJ0635_T.5a8db6ad97fdd04b8ed8a821d246130f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 18 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.18.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.18.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.18.gz
sequenza.create_seqz.18.SISJ0635_T.5a8db6ad97fdd04b8ed8a821d246130f.mugqic.done
chmod 755 $COMMAND
sequenza_18_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_18_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_18_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_19_JOB_ID: sequenza.create_seqz.19.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.19.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.19.SISJ0635_T.c6ea8ae0bd06a1d2b97a36930fd03732.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.19.SISJ0635_T.c6ea8ae0bd06a1d2b97a36930fd03732.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 19 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.19.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.19.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.19.gz
sequenza.create_seqz.19.SISJ0635_T.c6ea8ae0bd06a1d2b97a36930fd03732.mugqic.done
chmod 755 $COMMAND
sequenza_19_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_19_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_19_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_20_JOB_ID: sequenza.create_seqz.20.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.20.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.20.SISJ0635_T.2643229cb7c06c6ab511fa05dddbfabd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.20.SISJ0635_T.2643229cb7c06c6ab511fa05dddbfabd.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 20 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.20.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.20.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.20.gz
sequenza.create_seqz.20.SISJ0635_T.2643229cb7c06c6ab511fa05dddbfabd.mugqic.done
chmod 755 $COMMAND
sequenza_20_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_20_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_20_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_21_JOB_ID: sequenza.create_seqz.21.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.21.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.21.SISJ0635_T.22256d54cee4d78471d781746e050ae1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.21.SISJ0635_T.22256d54cee4d78471d781746e050ae1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 21 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.21.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.21.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.21.gz
sequenza.create_seqz.21.SISJ0635_T.22256d54cee4d78471d781746e050ae1.mugqic.done
chmod 755 $COMMAND
sequenza_21_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_21_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_21_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_22_JOB_ID: sequenza.create_seqz.22.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.22.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.22.SISJ0635_T.d9f76d59484aa3c75d012ab99e75edd3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.22.SISJ0635_T.d9f76d59484aa3c75d012ab99e75edd3.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 22 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.22.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.22.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.22.gz
sequenza.create_seqz.22.SISJ0635_T.d9f76d59484aa3c75d012ab99e75edd3.mugqic.done
chmod 755 $COMMAND
sequenza_22_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_22_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_22_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_23_JOB_ID: sequenza.create_seqz.X.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.X.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.X.SISJ0635_T.12f5238308a5a357d3e8e0099213b290.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.X.SISJ0635_T.12f5238308a5a357d3e8e0099213b290.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome X \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.X.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.X.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.X.gz
sequenza.create_seqz.X.SISJ0635_T.12f5238308a5a357d3e8e0099213b290.mugqic.done
chmod 755 $COMMAND
sequenza_23_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_23_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_23_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_24_JOB_ID: sequenza.create_seqz.Y.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.Y.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.Y.SISJ0635_T.4ddf26097e8f7a0fb8335706865db0fc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.Y.SISJ0635_T.4ddf26097e8f7a0fb8335706865db0fc.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome Y \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.Y.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.Y.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.Y.gz
sequenza.create_seqz.Y.SISJ0635_T.4ddf26097e8f7a0fb8335706865db0fc.mugqic.done
chmod 755 $COMMAND
sequenza_24_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_24_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_24_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_25_JOB_ID: sequenza.create_seqz.MT.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.MT.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.MT.SISJ0635_T.45270b6d21ceb2fb967f0822b9466311.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.MT.SISJ0635_T.45270b6d21ceb2fb967f0822b9466311.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome MT \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.MT.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.seqz.MT.gz \
    -o pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.MT.gz
sequenza.create_seqz.MT.SISJ0635_T.45270b6d21ceb2fb967f0822b9466311.mugqic.done
chmod 755 $COMMAND
sequenza_25_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_25_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_25_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_26_JOB_ID: sequenza.merge_binned_seqz.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.merge_binned_seqz.SISJ0635_T
JOB_DEPENDENCIES=$sequenza_1_JOB_ID:$sequenza_2_JOB_ID:$sequenza_3_JOB_ID:$sequenza_4_JOB_ID:$sequenza_5_JOB_ID:$sequenza_6_JOB_ID:$sequenza_7_JOB_ID:$sequenza_8_JOB_ID:$sequenza_9_JOB_ID:$sequenza_10_JOB_ID:$sequenza_11_JOB_ID:$sequenza_12_JOB_ID:$sequenza_13_JOB_ID:$sequenza_14_JOB_ID:$sequenza_15_JOB_ID:$sequenza_16_JOB_ID:$sequenza_17_JOB_ID:$sequenza_18_JOB_ID:$sequenza_19_JOB_ID:$sequenza_20_JOB_ID:$sequenza_21_JOB_ID:$sequenza_22_JOB_ID:$sequenza_23_JOB_ID:$sequenza_24_JOB_ID:$sequenza_25_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.merge_binned_seqz.SISJ0635_T.c8ad0edc8785b24dc7d7ac76191460ec.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.merge_binned_seqz.SISJ0635_T.c8ad0edc8785b24dc7d7ac76191460ec.mugqic.done' > $COMMAND
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
zcat pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.1.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.2.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.3.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.4.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.5.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.6.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.7.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.8.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.9.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.10.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.11.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.12.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.13.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.14.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.15.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.16.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.17.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.18.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.19.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.20.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.21.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.22.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.X.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.Y.gz \
pairedVariants/SISJ0635_T/sequenza/rawSequenza/SISJ0635_T.binned.seqz.MT.gz \
 | gawk 'FNR==1 && NR==1{print;}{ if($1!="chromosome" && $1!="MT" && $1!="chrMT" && $1!="chrM") {print $0} }' |  \
 gzip -cf > pairedVariants/SISJ0635_T/sequenza/SISJ0635_T.binned.merged.seqz.gz
sequenza.merge_binned_seqz.SISJ0635_T.c8ad0edc8785b24dc7d7ac76191460ec.mugqic.done
chmod 755 $COMMAND
sequenza_26_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_26_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_26_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_27_JOB_ID: sequenza.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.SISJ0635_T
JOB_DEPENDENCIES=$sequenza_26_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.SISJ0635_T.8908840c2850b4b68b786bf9cc4efc8e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.SISJ0635_T.8908840c2850b4b68b786bf9cc4efc8e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0635_T/sequenza/rawSequenza && \
\
Rscript $R_TOOLS/RunSequenza_analysis.R \
    pairedVariants/SISJ0635_T/sequenza/SISJ0635_T.binned.merged.seqz.gz   \
    pairedVariants/SISJ0635_T/sequenza   \
    SISJ0635_T
sequenza.SISJ0635_T.8908840c2850b4b68b786bf9cc4efc8e.mugqic.done
chmod 755 $COMMAND
sequenza_27_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_27_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_27_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_28_JOB_ID: sequenza.create_seqz.1.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.1.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.1.SISJ0732_T.c42680f073532d0a5d8281aeff6c9210.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.1.SISJ0732_T.c42680f073532d0a5d8281aeff6c9210.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 1 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.1.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.1.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.1.gz
sequenza.create_seqz.1.SISJ0732_T.c42680f073532d0a5d8281aeff6c9210.mugqic.done
chmod 755 $COMMAND
sequenza_28_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_28_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_28_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_29_JOB_ID: sequenza.create_seqz.2.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.2.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.2.SISJ0732_T.9c6a2cc6a0adc0378e000ada9bde8d8c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.2.SISJ0732_T.9c6a2cc6a0adc0378e000ada9bde8d8c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 2 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.2.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.2.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.2.gz
sequenza.create_seqz.2.SISJ0732_T.9c6a2cc6a0adc0378e000ada9bde8d8c.mugqic.done
chmod 755 $COMMAND
sequenza_29_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_29_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_29_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_30_JOB_ID: sequenza.create_seqz.3.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.3.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.3.SISJ0732_T.e0f36fa328709a2eadb617638ed2318e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.3.SISJ0732_T.e0f36fa328709a2eadb617638ed2318e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 3 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.3.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.3.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.3.gz
sequenza.create_seqz.3.SISJ0732_T.e0f36fa328709a2eadb617638ed2318e.mugqic.done
chmod 755 $COMMAND
sequenza_30_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_30_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_30_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_31_JOB_ID: sequenza.create_seqz.4.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.4.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.4.SISJ0732_T.c650cc2f6934c04a514df8376715de5e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.4.SISJ0732_T.c650cc2f6934c04a514df8376715de5e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 4 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.4.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.4.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.4.gz
sequenza.create_seqz.4.SISJ0732_T.c650cc2f6934c04a514df8376715de5e.mugqic.done
chmod 755 $COMMAND
sequenza_31_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_31_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_31_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_32_JOB_ID: sequenza.create_seqz.5.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.5.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.5.SISJ0732_T.04484b3c5972921387a64508afa29399.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.5.SISJ0732_T.04484b3c5972921387a64508afa29399.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 5 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.5.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.5.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.5.gz
sequenza.create_seqz.5.SISJ0732_T.04484b3c5972921387a64508afa29399.mugqic.done
chmod 755 $COMMAND
sequenza_32_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_32_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_32_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_33_JOB_ID: sequenza.create_seqz.6.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.6.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.6.SISJ0732_T.e2d103497a5324fbf148b157503b7b0b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.6.SISJ0732_T.e2d103497a5324fbf148b157503b7b0b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 6 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.6.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.6.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.6.gz
sequenza.create_seqz.6.SISJ0732_T.e2d103497a5324fbf148b157503b7b0b.mugqic.done
chmod 755 $COMMAND
sequenza_33_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_33_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_33_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_34_JOB_ID: sequenza.create_seqz.7.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.7.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.7.SISJ0732_T.2fd7b614477fac89809d6002c3af1411.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.7.SISJ0732_T.2fd7b614477fac89809d6002c3af1411.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 7 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.7.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.7.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.7.gz
sequenza.create_seqz.7.SISJ0732_T.2fd7b614477fac89809d6002c3af1411.mugqic.done
chmod 755 $COMMAND
sequenza_34_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_34_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_34_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_35_JOB_ID: sequenza.create_seqz.8.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.8.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.8.SISJ0732_T.73495617a3962d416f0d453ec4fdca38.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.8.SISJ0732_T.73495617a3962d416f0d453ec4fdca38.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 8 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.8.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.8.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.8.gz
sequenza.create_seqz.8.SISJ0732_T.73495617a3962d416f0d453ec4fdca38.mugqic.done
chmod 755 $COMMAND
sequenza_35_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_35_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_35_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_36_JOB_ID: sequenza.create_seqz.9.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.9.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.9.SISJ0732_T.02fded0397f09170aa52b3f096a4031d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.9.SISJ0732_T.02fded0397f09170aa52b3f096a4031d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 9 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.9.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.9.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.9.gz
sequenza.create_seqz.9.SISJ0732_T.02fded0397f09170aa52b3f096a4031d.mugqic.done
chmod 755 $COMMAND
sequenza_36_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_36_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_36_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_37_JOB_ID: sequenza.create_seqz.10.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.10.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.10.SISJ0732_T.68185018aa3fc168e33b0b4edebb9cb2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.10.SISJ0732_T.68185018aa3fc168e33b0b4edebb9cb2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 10 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.10.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.10.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.10.gz
sequenza.create_seqz.10.SISJ0732_T.68185018aa3fc168e33b0b4edebb9cb2.mugqic.done
chmod 755 $COMMAND
sequenza_37_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_37_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_37_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_38_JOB_ID: sequenza.create_seqz.11.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.11.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.11.SISJ0732_T.31d30606522136318104d990aaf3bf74.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.11.SISJ0732_T.31d30606522136318104d990aaf3bf74.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 11 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.11.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.11.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.11.gz
sequenza.create_seqz.11.SISJ0732_T.31d30606522136318104d990aaf3bf74.mugqic.done
chmod 755 $COMMAND
sequenza_38_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_38_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_38_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_39_JOB_ID: sequenza.create_seqz.12.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.12.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.12.SISJ0732_T.1bb8ed4255146201b297cb8a21b82095.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.12.SISJ0732_T.1bb8ed4255146201b297cb8a21b82095.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 12 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.12.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.12.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.12.gz
sequenza.create_seqz.12.SISJ0732_T.1bb8ed4255146201b297cb8a21b82095.mugqic.done
chmod 755 $COMMAND
sequenza_39_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_39_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_39_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_40_JOB_ID: sequenza.create_seqz.13.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.13.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.13.SISJ0732_T.a49190c10086c6bb66c0f8a368747667.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.13.SISJ0732_T.a49190c10086c6bb66c0f8a368747667.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 13 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.13.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.13.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.13.gz
sequenza.create_seqz.13.SISJ0732_T.a49190c10086c6bb66c0f8a368747667.mugqic.done
chmod 755 $COMMAND
sequenza_40_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_40_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_40_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_41_JOB_ID: sequenza.create_seqz.14.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.14.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.14.SISJ0732_T.f98f168170d923fad177ba2bb231e167.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.14.SISJ0732_T.f98f168170d923fad177ba2bb231e167.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 14 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.14.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.14.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.14.gz
sequenza.create_seqz.14.SISJ0732_T.f98f168170d923fad177ba2bb231e167.mugqic.done
chmod 755 $COMMAND
sequenza_41_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_41_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_41_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_42_JOB_ID: sequenza.create_seqz.15.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.15.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.15.SISJ0732_T.019fa6795cbfed2a76039d7983476eda.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.15.SISJ0732_T.019fa6795cbfed2a76039d7983476eda.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 15 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.15.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.15.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.15.gz
sequenza.create_seqz.15.SISJ0732_T.019fa6795cbfed2a76039d7983476eda.mugqic.done
chmod 755 $COMMAND
sequenza_42_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_42_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_42_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_43_JOB_ID: sequenza.create_seqz.16.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.16.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.16.SISJ0732_T.31124b3fcf326061d7baa3a3a22d123c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.16.SISJ0732_T.31124b3fcf326061d7baa3a3a22d123c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 16 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.16.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.16.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.16.gz
sequenza.create_seqz.16.SISJ0732_T.31124b3fcf326061d7baa3a3a22d123c.mugqic.done
chmod 755 $COMMAND
sequenza_43_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_43_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_43_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_44_JOB_ID: sequenza.create_seqz.17.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.17.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.17.SISJ0732_T.59d32afb1863691b50c2c6250edcb8a4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.17.SISJ0732_T.59d32afb1863691b50c2c6250edcb8a4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 17 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.17.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.17.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.17.gz
sequenza.create_seqz.17.SISJ0732_T.59d32afb1863691b50c2c6250edcb8a4.mugqic.done
chmod 755 $COMMAND
sequenza_44_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_44_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_44_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_45_JOB_ID: sequenza.create_seqz.18.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.18.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.18.SISJ0732_T.968bb6e63b42d8f4ad25161284cd7d20.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.18.SISJ0732_T.968bb6e63b42d8f4ad25161284cd7d20.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 18 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.18.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.18.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.18.gz
sequenza.create_seqz.18.SISJ0732_T.968bb6e63b42d8f4ad25161284cd7d20.mugqic.done
chmod 755 $COMMAND
sequenza_45_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_45_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_45_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_46_JOB_ID: sequenza.create_seqz.19.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.19.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.19.SISJ0732_T.aa2fc00189b23180b4a5c451fb671dfe.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.19.SISJ0732_T.aa2fc00189b23180b4a5c451fb671dfe.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 19 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.19.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.19.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.19.gz
sequenza.create_seqz.19.SISJ0732_T.aa2fc00189b23180b4a5c451fb671dfe.mugqic.done
chmod 755 $COMMAND
sequenza_46_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_46_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_46_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_47_JOB_ID: sequenza.create_seqz.20.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.20.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.20.SISJ0732_T.0c749abaf9589b0d09af2d8010b9cffd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.20.SISJ0732_T.0c749abaf9589b0d09af2d8010b9cffd.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 20 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.20.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.20.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.20.gz
sequenza.create_seqz.20.SISJ0732_T.0c749abaf9589b0d09af2d8010b9cffd.mugqic.done
chmod 755 $COMMAND
sequenza_47_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_47_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_47_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_48_JOB_ID: sequenza.create_seqz.21.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.21.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.21.SISJ0732_T.be2b536a98ff6a0461690103aa1d7c8e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.21.SISJ0732_T.be2b536a98ff6a0461690103aa1d7c8e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 21 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.21.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.21.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.21.gz
sequenza.create_seqz.21.SISJ0732_T.be2b536a98ff6a0461690103aa1d7c8e.mugqic.done
chmod 755 $COMMAND
sequenza_48_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_48_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_48_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_49_JOB_ID: sequenza.create_seqz.22.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.22.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.22.SISJ0732_T.d25f29ff4ca7dca68b3779bcd6cf7b37.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.22.SISJ0732_T.d25f29ff4ca7dca68b3779bcd6cf7b37.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 22 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.22.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.22.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.22.gz
sequenza.create_seqz.22.SISJ0732_T.d25f29ff4ca7dca68b3779bcd6cf7b37.mugqic.done
chmod 755 $COMMAND
sequenza_49_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_49_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_49_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_50_JOB_ID: sequenza.create_seqz.X.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.X.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.X.SISJ0732_T.cab0ca7bc5e5bc363ab15bc31e6ec8a4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.X.SISJ0732_T.cab0ca7bc5e5bc363ab15bc31e6ec8a4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome X \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.X.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.X.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.X.gz
sequenza.create_seqz.X.SISJ0732_T.cab0ca7bc5e5bc363ab15bc31e6ec8a4.mugqic.done
chmod 755 $COMMAND
sequenza_50_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_50_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_50_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_51_JOB_ID: sequenza.create_seqz.Y.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.Y.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.Y.SISJ0732_T.67404388d6f33238a42443c153871ebb.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.Y.SISJ0732_T.67404388d6f33238a42443c153871ebb.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome Y \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.Y.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.Y.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.Y.gz
sequenza.create_seqz.Y.SISJ0732_T.67404388d6f33238a42443c153871ebb.mugqic.done
chmod 755 $COMMAND
sequenza_51_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_51_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_51_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_52_JOB_ID: sequenza.create_seqz.MT.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.MT.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.MT.SISJ0732_T.de2a1358ff71fd767199cdef639e905a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.MT.SISJ0732_T.de2a1358ff71fd767199cdef639e905a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome MT \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
    --tumor alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
    --output pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.MT.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.seqz.MT.gz \
    -o pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.MT.gz
sequenza.create_seqz.MT.SISJ0732_T.de2a1358ff71fd767199cdef639e905a.mugqic.done
chmod 755 $COMMAND
sequenza_52_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_52_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_52_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_53_JOB_ID: sequenza.merge_binned_seqz.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.merge_binned_seqz.SISJ0732_T
JOB_DEPENDENCIES=$sequenza_28_JOB_ID:$sequenza_29_JOB_ID:$sequenza_30_JOB_ID:$sequenza_31_JOB_ID:$sequenza_32_JOB_ID:$sequenza_33_JOB_ID:$sequenza_34_JOB_ID:$sequenza_35_JOB_ID:$sequenza_36_JOB_ID:$sequenza_37_JOB_ID:$sequenza_38_JOB_ID:$sequenza_39_JOB_ID:$sequenza_40_JOB_ID:$sequenza_41_JOB_ID:$sequenza_42_JOB_ID:$sequenza_43_JOB_ID:$sequenza_44_JOB_ID:$sequenza_45_JOB_ID:$sequenza_46_JOB_ID:$sequenza_47_JOB_ID:$sequenza_48_JOB_ID:$sequenza_49_JOB_ID:$sequenza_50_JOB_ID:$sequenza_51_JOB_ID:$sequenza_52_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.merge_binned_seqz.SISJ0732_T.f52baa4a013ef128020cfdc8e918c6dc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.merge_binned_seqz.SISJ0732_T.f52baa4a013ef128020cfdc8e918c6dc.mugqic.done' > $COMMAND
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
zcat pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.1.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.2.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.3.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.4.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.5.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.6.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.7.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.8.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.9.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.10.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.11.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.12.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.13.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.14.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.15.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.16.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.17.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.18.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.19.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.20.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.21.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.22.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.X.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.Y.gz \
pairedVariants/SISJ0732_T/sequenza/rawSequenza/SISJ0732_T.binned.seqz.MT.gz \
 | gawk 'FNR==1 && NR==1{print;}{ if($1!="chromosome" && $1!="MT" && $1!="chrMT" && $1!="chrM") {print $0} }' |  \
 gzip -cf > pairedVariants/SISJ0732_T/sequenza/SISJ0732_T.binned.merged.seqz.gz
sequenza.merge_binned_seqz.SISJ0732_T.f52baa4a013ef128020cfdc8e918c6dc.mugqic.done
chmod 755 $COMMAND
sequenza_53_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_53_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_53_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_54_JOB_ID: sequenza.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.SISJ0732_T
JOB_DEPENDENCIES=$sequenza_53_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.SISJ0732_T.552a2133f2f03311b31012ae4d734f68.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.SISJ0732_T.552a2133f2f03311b31012ae4d734f68.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
touch pairedVariants/SISJ0732_T/sequenza/rawSequenza && \
\
Rscript $R_TOOLS/RunSequenza_analysis.R \
    pairedVariants/SISJ0732_T/sequenza/SISJ0732_T.binned.merged.seqz.gz   \
    pairedVariants/SISJ0732_T/sequenza   \
    SISJ0732_T
sequenza.SISJ0732_T.552a2133f2f03311b31012ae4d734f68.mugqic.done
chmod 755 $COMMAND
sequenza_54_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_54_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_54_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_55_JOB_ID: sequenza.create_seqz.1.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.1.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.1.TCMG240_T1.a1d74b01af4fe66bff37ab70da084669.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.1.TCMG240_T1.a1d74b01af4fe66bff37ab70da084669.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 1 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.1.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.1.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.1.gz
sequenza.create_seqz.1.TCMG240_T1.a1d74b01af4fe66bff37ab70da084669.mugqic.done
chmod 755 $COMMAND
sequenza_55_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_55_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_55_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_56_JOB_ID: sequenza.create_seqz.2.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.2.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.2.TCMG240_T1.1f6b920a3ace610b6cb1c20aca62bc73.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.2.TCMG240_T1.1f6b920a3ace610b6cb1c20aca62bc73.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 2 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.2.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.2.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.2.gz
sequenza.create_seqz.2.TCMG240_T1.1f6b920a3ace610b6cb1c20aca62bc73.mugqic.done
chmod 755 $COMMAND
sequenza_56_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_56_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_56_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_57_JOB_ID: sequenza.create_seqz.3.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.3.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.3.TCMG240_T1.eaef6dee782a549ebeed9cf1a1c7af34.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.3.TCMG240_T1.eaef6dee782a549ebeed9cf1a1c7af34.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 3 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.3.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.3.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.3.gz
sequenza.create_seqz.3.TCMG240_T1.eaef6dee782a549ebeed9cf1a1c7af34.mugqic.done
chmod 755 $COMMAND
sequenza_57_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_57_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_57_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_58_JOB_ID: sequenza.create_seqz.4.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.4.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.4.TCMG240_T1.69fa820c89d404e29dd17176b12f4f3c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.4.TCMG240_T1.69fa820c89d404e29dd17176b12f4f3c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 4 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.4.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.4.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.4.gz
sequenza.create_seqz.4.TCMG240_T1.69fa820c89d404e29dd17176b12f4f3c.mugqic.done
chmod 755 $COMMAND
sequenza_58_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_58_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_58_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_59_JOB_ID: sequenza.create_seqz.5.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.5.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.5.TCMG240_T1.00dd83ee4e6a0c835b152efbfee927b9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.5.TCMG240_T1.00dd83ee4e6a0c835b152efbfee927b9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 5 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.5.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.5.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.5.gz
sequenza.create_seqz.5.TCMG240_T1.00dd83ee4e6a0c835b152efbfee927b9.mugqic.done
chmod 755 $COMMAND
sequenza_59_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_59_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_59_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_60_JOB_ID: sequenza.create_seqz.6.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.6.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.6.TCMG240_T1.eea84a9ca573648861df6447f34612d9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.6.TCMG240_T1.eea84a9ca573648861df6447f34612d9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 6 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.6.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.6.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.6.gz
sequenza.create_seqz.6.TCMG240_T1.eea84a9ca573648861df6447f34612d9.mugqic.done
chmod 755 $COMMAND
sequenza_60_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_60_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_60_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_61_JOB_ID: sequenza.create_seqz.7.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.7.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.7.TCMG240_T1.3329e3020c52de546b2d0f4a75f1aa32.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.7.TCMG240_T1.3329e3020c52de546b2d0f4a75f1aa32.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 7 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.7.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.7.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.7.gz
sequenza.create_seqz.7.TCMG240_T1.3329e3020c52de546b2d0f4a75f1aa32.mugqic.done
chmod 755 $COMMAND
sequenza_61_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_61_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_61_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_62_JOB_ID: sequenza.create_seqz.8.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.8.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.8.TCMG240_T1.49bceebb517087f2fabafe6d2fcb3af2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.8.TCMG240_T1.49bceebb517087f2fabafe6d2fcb3af2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 8 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.8.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.8.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.8.gz
sequenza.create_seqz.8.TCMG240_T1.49bceebb517087f2fabafe6d2fcb3af2.mugqic.done
chmod 755 $COMMAND
sequenza_62_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_62_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_62_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_63_JOB_ID: sequenza.create_seqz.9.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.9.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.9.TCMG240_T1.a8d62404e8fd5a97c5300e2839d22571.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.9.TCMG240_T1.a8d62404e8fd5a97c5300e2839d22571.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 9 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.9.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.9.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.9.gz
sequenza.create_seqz.9.TCMG240_T1.a8d62404e8fd5a97c5300e2839d22571.mugqic.done
chmod 755 $COMMAND
sequenza_63_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_63_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_63_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_64_JOB_ID: sequenza.create_seqz.10.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.10.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.10.TCMG240_T1.a64bd79862aff4e87c94fd53ddeca80d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.10.TCMG240_T1.a64bd79862aff4e87c94fd53ddeca80d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 10 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.10.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.10.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.10.gz
sequenza.create_seqz.10.TCMG240_T1.a64bd79862aff4e87c94fd53ddeca80d.mugqic.done
chmod 755 $COMMAND
sequenza_64_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_64_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_64_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_65_JOB_ID: sequenza.create_seqz.11.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.11.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.11.TCMG240_T1.e6e06a2f0759c31b6a986fbadbac63cf.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.11.TCMG240_T1.e6e06a2f0759c31b6a986fbadbac63cf.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 11 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.11.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.11.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.11.gz
sequenza.create_seqz.11.TCMG240_T1.e6e06a2f0759c31b6a986fbadbac63cf.mugqic.done
chmod 755 $COMMAND
sequenza_65_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_65_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_65_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_66_JOB_ID: sequenza.create_seqz.12.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.12.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.12.TCMG240_T1.e0e4e682e34f51dd10bc9538d259e417.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.12.TCMG240_T1.e0e4e682e34f51dd10bc9538d259e417.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 12 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.12.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.12.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.12.gz
sequenza.create_seqz.12.TCMG240_T1.e0e4e682e34f51dd10bc9538d259e417.mugqic.done
chmod 755 $COMMAND
sequenza_66_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_66_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_66_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_67_JOB_ID: sequenza.create_seqz.13.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.13.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.13.TCMG240_T1.892a95fb28081679eea9250bb33925c4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.13.TCMG240_T1.892a95fb28081679eea9250bb33925c4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 13 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.13.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.13.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.13.gz
sequenza.create_seqz.13.TCMG240_T1.892a95fb28081679eea9250bb33925c4.mugqic.done
chmod 755 $COMMAND
sequenza_67_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_67_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_67_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_68_JOB_ID: sequenza.create_seqz.14.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.14.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.14.TCMG240_T1.05982430794cb61ccaee7d5bbe7b5904.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.14.TCMG240_T1.05982430794cb61ccaee7d5bbe7b5904.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 14 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.14.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.14.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.14.gz
sequenza.create_seqz.14.TCMG240_T1.05982430794cb61ccaee7d5bbe7b5904.mugqic.done
chmod 755 $COMMAND
sequenza_68_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_68_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_68_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_69_JOB_ID: sequenza.create_seqz.15.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.15.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.15.TCMG240_T1.a9bf167d5f3eede2b0405c36033d11c4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.15.TCMG240_T1.a9bf167d5f3eede2b0405c36033d11c4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 15 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.15.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.15.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.15.gz
sequenza.create_seqz.15.TCMG240_T1.a9bf167d5f3eede2b0405c36033d11c4.mugqic.done
chmod 755 $COMMAND
sequenza_69_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_69_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_69_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_70_JOB_ID: sequenza.create_seqz.16.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.16.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.16.TCMG240_T1.5ae49b414756d2a00e9921d8011140d7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.16.TCMG240_T1.5ae49b414756d2a00e9921d8011140d7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 16 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.16.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.16.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.16.gz
sequenza.create_seqz.16.TCMG240_T1.5ae49b414756d2a00e9921d8011140d7.mugqic.done
chmod 755 $COMMAND
sequenza_70_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_70_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_70_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_71_JOB_ID: sequenza.create_seqz.17.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.17.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.17.TCMG240_T1.76a683cefc66c94d54e5006d78e91d7a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.17.TCMG240_T1.76a683cefc66c94d54e5006d78e91d7a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 17 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.17.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.17.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.17.gz
sequenza.create_seqz.17.TCMG240_T1.76a683cefc66c94d54e5006d78e91d7a.mugqic.done
chmod 755 $COMMAND
sequenza_71_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_71_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_71_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_72_JOB_ID: sequenza.create_seqz.18.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.18.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.18.TCMG240_T1.e26a1235a65a460ff64b92dd0fd06294.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.18.TCMG240_T1.e26a1235a65a460ff64b92dd0fd06294.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 18 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.18.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.18.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.18.gz
sequenza.create_seqz.18.TCMG240_T1.e26a1235a65a460ff64b92dd0fd06294.mugqic.done
chmod 755 $COMMAND
sequenza_72_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_72_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_72_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_73_JOB_ID: sequenza.create_seqz.19.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.19.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.19.TCMG240_T1.4e2a64328d8791402d0b8a63a9243f46.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.19.TCMG240_T1.4e2a64328d8791402d0b8a63a9243f46.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 19 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.19.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.19.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.19.gz
sequenza.create_seqz.19.TCMG240_T1.4e2a64328d8791402d0b8a63a9243f46.mugqic.done
chmod 755 $COMMAND
sequenza_73_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_73_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_73_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_74_JOB_ID: sequenza.create_seqz.20.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.20.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.20.TCMG240_T1.c690f64cc0ae5f1571cfde477f25e48d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.20.TCMG240_T1.c690f64cc0ae5f1571cfde477f25e48d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 20 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.20.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.20.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.20.gz
sequenza.create_seqz.20.TCMG240_T1.c690f64cc0ae5f1571cfde477f25e48d.mugqic.done
chmod 755 $COMMAND
sequenza_74_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_74_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_74_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_75_JOB_ID: sequenza.create_seqz.21.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.21.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.21.TCMG240_T1.c1f0b6f1debc97c03f00621ef5357f00.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.21.TCMG240_T1.c1f0b6f1debc97c03f00621ef5357f00.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 21 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.21.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.21.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.21.gz
sequenza.create_seqz.21.TCMG240_T1.c1f0b6f1debc97c03f00621ef5357f00.mugqic.done
chmod 755 $COMMAND
sequenza_75_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_75_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_75_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_76_JOB_ID: sequenza.create_seqz.22.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.22.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.22.TCMG240_T1.bba7195493188d2aa40381ff0fdda797.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.22.TCMG240_T1.bba7195493188d2aa40381ff0fdda797.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome 22 \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.22.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.22.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.22.gz
sequenza.create_seqz.22.TCMG240_T1.bba7195493188d2aa40381ff0fdda797.mugqic.done
chmod 755 $COMMAND
sequenza_76_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_76_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_76_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_77_JOB_ID: sequenza.create_seqz.X.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.X.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.X.TCMG240_T1.84fd85bb859556a367e69066f76009d5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.X.TCMG240_T1.84fd85bb859556a367e69066f76009d5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome X \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.X.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.X.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.X.gz
sequenza.create_seqz.X.TCMG240_T1.84fd85bb859556a367e69066f76009d5.mugqic.done
chmod 755 $COMMAND
sequenza_77_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_77_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_77_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_78_JOB_ID: sequenza.create_seqz.Y.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.Y.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.Y.TCMG240_T1.8f30c35ec63a0cbb046f09d816e9e69a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.Y.TCMG240_T1.8f30c35ec63a0cbb046f09d816e9e69a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome Y \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.Y.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.Y.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.Y.gz
sequenza.create_seqz.Y.TCMG240_T1.8f30c35ec63a0cbb046f09d816e9e69a.mugqic.done
chmod 755 $COMMAND
sequenza_78_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_78_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_78_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_79_JOB_ID: sequenza.create_seqz.MT.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.create_seqz.MT.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.create_seqz.MT.TCMG240_T1.96e991e6d11cbb63d28dc8eda5943a07.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.create_seqz.MT.TCMG240_T1.96e991e6d11cbb63d28dc8eda5943a07.mugqic.done' > $COMMAND
module purge && \
module load mugqic/Sequenza-utils/3.0.0 mugqic/samtools/1.12 mugqic/htslib/1.14 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
sequenza-utils \
    bam2seqz -q 20 -N 30 --samtools samtools --tabix tabix \
    \
    --chromosome MT \
    -gc $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.gc50Base.txt \
    --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
    --tumor alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
    --output pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.MT.gz && \
\
sequenza-utils  \
    seqz_binning  \
    -w 50  \
    -s pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.seqz.MT.gz \
    -o pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.MT.gz
sequenza.create_seqz.MT.TCMG240_T1.96e991e6d11cbb63d28dc8eda5943a07.mugqic.done
chmod 755 $COMMAND
sequenza_79_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_79_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_79_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_80_JOB_ID: sequenza.merge_binned_seqz.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.merge_binned_seqz.TCMG240_T1
JOB_DEPENDENCIES=$sequenza_55_JOB_ID:$sequenza_56_JOB_ID:$sequenza_57_JOB_ID:$sequenza_58_JOB_ID:$sequenza_59_JOB_ID:$sequenza_60_JOB_ID:$sequenza_61_JOB_ID:$sequenza_62_JOB_ID:$sequenza_63_JOB_ID:$sequenza_64_JOB_ID:$sequenza_65_JOB_ID:$sequenza_66_JOB_ID:$sequenza_67_JOB_ID:$sequenza_68_JOB_ID:$sequenza_69_JOB_ID:$sequenza_70_JOB_ID:$sequenza_71_JOB_ID:$sequenza_72_JOB_ID:$sequenza_73_JOB_ID:$sequenza_74_JOB_ID:$sequenza_75_JOB_ID:$sequenza_76_JOB_ID:$sequenza_77_JOB_ID:$sequenza_78_JOB_ID:$sequenza_79_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.merge_binned_seqz.TCMG240_T1.3c4a631c8c25c5b455ed628842a898c3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.merge_binned_seqz.TCMG240_T1.3c4a631c8c25c5b455ed628842a898c3.mugqic.done' > $COMMAND
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
zcat pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.1.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.2.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.3.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.4.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.5.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.6.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.7.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.8.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.9.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.10.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.11.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.12.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.13.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.14.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.15.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.16.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.17.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.18.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.19.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.20.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.21.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.22.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.X.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.Y.gz \
pairedVariants/TCMG240_T1/sequenza/rawSequenza/TCMG240_T1.binned.seqz.MT.gz \
 | gawk 'FNR==1 && NR==1{print;}{ if($1!="chromosome" && $1!="MT" && $1!="chrMT" && $1!="chrM") {print $0} }' |  \
 gzip -cf > pairedVariants/TCMG240_T1/sequenza/TCMG240_T1.binned.merged.seqz.gz
sequenza.merge_binned_seqz.TCMG240_T1.3c4a631c8c25c5b455ed628842a898c3.mugqic.done
chmod 755 $COMMAND
sequenza_80_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_80_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_80_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sequenza_81_JOB_ID: sequenza.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=sequenza.TCMG240_T1
JOB_DEPENDENCIES=$sequenza_80_JOB_ID
JOB_DONE=job_output/sequenza/sequenza.TCMG240_T1.fb9fcb5357270abf6e27ec5960c493cc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sequenza.TCMG240_T1.fb9fcb5357270abf6e27ec5960c493cc.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/R_Bioconductor/3.5.0_3.7 && \
mkdir -p pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
touch pairedVariants/TCMG240_T1/sequenza/rawSequenza && \
\
Rscript $R_TOOLS/RunSequenza_analysis.R \
    pairedVariants/TCMG240_T1/sequenza/TCMG240_T1.binned.merged.seqz.gz   \
    pairedVariants/TCMG240_T1/sequenza   \
    TCMG240_T1
sequenza.TCMG240_T1.fb9fcb5357270abf6e27ec5960c493cc.mugqic.done
chmod 755 $COMMAND
sequenza_81_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sequenza_81_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sequenza_81_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: manta_sv_calls
#-------------------------------------------------------------------------------
STEP=manta_sv_calls
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: manta_sv_calls_1_JOB_ID: manta_sv.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=manta_sv.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/manta_sv_calls/manta_sv.SISJ0635_T.90e31c512c25efaf01314922f1be461e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'manta_sv.SISJ0635_T.90e31c512c25efaf01314922f1be461e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.14 mugqic/Manta/1.5.0 && \
rm -r -f SVariants/SISJ0635_T/rawManta && \
mkdir -p SVariants/SISJ0635_T/rawManta && \
touch SVariants/SISJ0635_T/rawManta && \
 python $MANTA_HOME/bin/configManta.py \
        --normalBam alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
        --tumorBam alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
        --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
        --exome  \
        --runDir SVariants/SISJ0635_T/rawManta && \
python SVariants/SISJ0635_T/rawManta/runWorkflow.py \
        -m local  \
        -j 32 \
        -g 55 \
        --quiet && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/rawManta/results/variants/somaticSV.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/SISJ0635_T.manta.somatic.vcf.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/rawManta/results/variants/somaticSV.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/SISJ0635_T.manta.somatic.vcf.gz.tbi && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/rawManta/results/variants/diploidSV.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/SISJ0635_T.manta.germline.vcf.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/rawManta/results/variants/diploidSV.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0635_T/SISJ0635_T.manta.germline.vcf.gz.tbi
manta_sv.SISJ0635_T.90e31c512c25efaf01314922f1be461e.mugqic.done
chmod 755 $COMMAND
manta_sv_calls_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$manta_sv_calls_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$manta_sv_calls_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: manta_sv_calls_2_JOB_ID: manta_sv.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=manta_sv.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/manta_sv_calls/manta_sv.SISJ0732_T.14bd29e9dfd8f92063f21f86f6fc9644.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'manta_sv.SISJ0732_T.14bd29e9dfd8f92063f21f86f6fc9644.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.14 mugqic/Manta/1.5.0 && \
rm -r -f SVariants/SISJ0732_T/rawManta && \
mkdir -p SVariants/SISJ0732_T/rawManta && \
touch SVariants/SISJ0732_T/rawManta && \
 python $MANTA_HOME/bin/configManta.py \
        --normalBam alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
        --tumorBam alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
        --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
        --exome  \
        --runDir SVariants/SISJ0732_T/rawManta && \
python SVariants/SISJ0732_T/rawManta/runWorkflow.py \
        -m local  \
        -j 32 \
        -g 55 \
        --quiet && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/rawManta/results/variants/somaticSV.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/SISJ0732_T.manta.somatic.vcf.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/rawManta/results/variants/somaticSV.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/SISJ0732_T.manta.somatic.vcf.gz.tbi && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/rawManta/results/variants/diploidSV.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/SISJ0732_T.manta.germline.vcf.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/rawManta/results/variants/diploidSV.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/SISJ0732_T/SISJ0732_T.manta.germline.vcf.gz.tbi
manta_sv.SISJ0732_T.14bd29e9dfd8f92063f21f86f6fc9644.mugqic.done
chmod 755 $COMMAND
manta_sv_calls_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$manta_sv_calls_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$manta_sv_calls_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: manta_sv_calls_3_JOB_ID: manta_sv.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=manta_sv.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/manta_sv_calls/manta_sv.TCMG240_T1.7232e21e79db8034dda60af38e74b01d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'manta_sv.TCMG240_T1.7232e21e79db8034dda60af38e74b01d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.14 mugqic/Manta/1.5.0 && \
rm -r -f SVariants/TCMG240_T1/rawManta && \
mkdir -p SVariants/TCMG240_T1/rawManta && \
touch SVariants/TCMG240_T1/rawManta && \
 python $MANTA_HOME/bin/configManta.py \
        --normalBam alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
        --tumorBam alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
        --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
        --exome  \
        --runDir SVariants/TCMG240_T1/rawManta && \
python SVariants/TCMG240_T1/rawManta/runWorkflow.py \
        -m local  \
        -j 32 \
        -g 55 \
        --quiet && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/rawManta/results/variants/somaticSV.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/TCMG240_T1.manta.somatic.vcf.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/rawManta/results/variants/somaticSV.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/TCMG240_T1.manta.somatic.vcf.gz.tbi && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/rawManta/results/variants/diploidSV.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/TCMG240_T1.manta.germline.vcf.gz && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/rawManta/results/variants/diploidSV.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/SVariants/TCMG240_T1/TCMG240_T1.manta.germline.vcf.gz.tbi
manta_sv.TCMG240_T1.7232e21e79db8034dda60af38e74b01d.mugqic.done
chmod 755 $COMMAND
manta_sv_calls_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$manta_sv_calls_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$manta_sv_calls_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: strelka2_paired_somatic
#-------------------------------------------------------------------------------
STEP=strelka2_paired_somatic
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_somatic_1_JOB_ID: strelka2_paired_somatic.call.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_somatic.call.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/strelka2_paired_somatic/strelka2_paired_somatic.call.SISJ0635_T.4204b3c52b70aeb68f667f97f13b2c22.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_somatic.call.SISJ0635_T.4204b3c52b70aeb68f667f97f13b2c22.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.18 mugqic/Strelka2/2.9.10 && \
rm -r -f pairedVariants/SISJ0635_T/rawStrelka2_somatic && \
rm -f pairedVariants/SISJ0635_T/rawStrelka2_somatic/runWorkflow.py && \
python $STRELKA2_HOME/bin/configureStrelkaSomaticWorkflow.py \
  --normalBam alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --tumorBam alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --exome \
  --callRegions $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.strelka2.bed.gz  \
  --runDir pairedVariants/SISJ0635_T/rawStrelka2_somatic && \
python pairedVariants/SISJ0635_T/rawStrelka2_somatic/runWorkflow.py \
  -m local  \
  -j 32 \
  -g 55 \
  --quiet
strelka2_paired_somatic.call.SISJ0635_T.4204b3c52b70aeb68f667f97f13b2c22.mugqic.done
chmod 755 $COMMAND
strelka2_paired_somatic_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_somatic_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_somatic_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_somatic_2_JOB_ID: strelka2_paired_somatic.filter.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_somatic.filter.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_somatic_1_JOB_ID
JOB_DONE=job_output/strelka2_paired_somatic/strelka2_paired_somatic.filter.SISJ0635_T.ab9c97559271f31f9c6d4952108c9723.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_somatic.filter.SISJ0635_T.ab9c97559271f31f9c6d4952108c9723.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/mugqic_tools/2.10.5 mugqic/python/3.9.1 && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/SISJ0635_T/rawStrelka2_somatic/results/variants/somatic.snvs.vcf.gz \
  pairedVariants/SISJ0635_T/rawStrelka2_somatic/results/variants/somatic.indels.vcf.gz | \
sed 's/TUMOR/SISJ0635_T/g' | sed 's/NORMAL/SISJ0635_N/g' | sed 's/Number=R/Number=./g' | grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.vcf.gz && \
zless pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.vt.vcf.gz && \
	python3 $PYTHON_TOOLS/update_genotypes_strelka.py \
	    -i pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.vt.vcf.gz \
	    -o pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.gt.vcf.gz \
	    -n SISJ0635_N \
	    -t SISJ0635_T && \
bcftools \
  view -f PASS -Oz \
   \
 -o pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.vt.vcf.gz \
 pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.gt.vcf.gz
strelka2_paired_somatic.filter.SISJ0635_T.ab9c97559271f31f9c6d4952108c9723.mugqic.done
chmod 755 $COMMAND
strelka2_paired_somatic_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_somatic_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_somatic_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_somatic_3_JOB_ID: strelka2_paired_somatic.call.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_somatic.call.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/strelka2_paired_somatic/strelka2_paired_somatic.call.SISJ0732_T.7f31f19eb79af7d929124648e5ff1856.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_somatic.call.SISJ0732_T.7f31f19eb79af7d929124648e5ff1856.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.18 mugqic/Strelka2/2.9.10 && \
rm -r -f pairedVariants/SISJ0732_T/rawStrelka2_somatic && \
rm -f pairedVariants/SISJ0732_T/rawStrelka2_somatic/runWorkflow.py && \
python $STRELKA2_HOME/bin/configureStrelkaSomaticWorkflow.py \
  --normalBam alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --tumorBam alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --exome \
  --callRegions $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.strelka2.bed.gz  \
  --runDir pairedVariants/SISJ0732_T/rawStrelka2_somatic && \
python pairedVariants/SISJ0732_T/rawStrelka2_somatic/runWorkflow.py \
  -m local  \
  -j 32 \
  -g 55 \
  --quiet
strelka2_paired_somatic.call.SISJ0732_T.7f31f19eb79af7d929124648e5ff1856.mugqic.done
chmod 755 $COMMAND
strelka2_paired_somatic_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_somatic_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_somatic_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_somatic_4_JOB_ID: strelka2_paired_somatic.filter.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_somatic.filter.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_somatic_3_JOB_ID
JOB_DONE=job_output/strelka2_paired_somatic/strelka2_paired_somatic.filter.SISJ0732_T.3f00d7ec08b7d0d44f79069b465857d3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_somatic.filter.SISJ0732_T.3f00d7ec08b7d0d44f79069b465857d3.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/mugqic_tools/2.10.5 mugqic/python/3.9.1 && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/SISJ0732_T/rawStrelka2_somatic/results/variants/somatic.snvs.vcf.gz \
  pairedVariants/SISJ0732_T/rawStrelka2_somatic/results/variants/somatic.indels.vcf.gz | \
sed 's/TUMOR/SISJ0732_T/g' | sed 's/NORMAL/SISJ0732_N/g' | sed 's/Number=R/Number=./g' | grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.vcf.gz && \
zless pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.vt.vcf.gz && \
	python3 $PYTHON_TOOLS/update_genotypes_strelka.py \
	    -i pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.vt.vcf.gz \
	    -o pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.gt.vcf.gz \
	    -n SISJ0732_N \
	    -t SISJ0732_T && \
bcftools \
  view -f PASS -Oz \
   \
 -o pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.vt.vcf.gz \
 pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.gt.vcf.gz
strelka2_paired_somatic.filter.SISJ0732_T.3f00d7ec08b7d0d44f79069b465857d3.mugqic.done
chmod 755 $COMMAND
strelka2_paired_somatic_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_somatic_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_somatic_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_somatic_5_JOB_ID: strelka2_paired_somatic.call.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_somatic.call.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/strelka2_paired_somatic/strelka2_paired_somatic.call.TCMG240_T1.c3ee474002b788da49362f1622862553.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_somatic.call.TCMG240_T1.c3ee474002b788da49362f1622862553.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.18 mugqic/Strelka2/2.9.10 && \
rm -r -f pairedVariants/TCMG240_T1/rawStrelka2_somatic && \
rm -f pairedVariants/TCMG240_T1/rawStrelka2_somatic/runWorkflow.py && \
python $STRELKA2_HOME/bin/configureStrelkaSomaticWorkflow.py \
  --normalBam alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --tumorBam alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --exome \
  --callRegions $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.strelka2.bed.gz  \
  --runDir pairedVariants/TCMG240_T1/rawStrelka2_somatic && \
python pairedVariants/TCMG240_T1/rawStrelka2_somatic/runWorkflow.py \
  -m local  \
  -j 32 \
  -g 55 \
  --quiet
strelka2_paired_somatic.call.TCMG240_T1.c3ee474002b788da49362f1622862553.mugqic.done
chmod 755 $COMMAND
strelka2_paired_somatic_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_somatic_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_somatic_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_somatic_6_JOB_ID: strelka2_paired_somatic.filter.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_somatic.filter.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_somatic_5_JOB_ID
JOB_DONE=job_output/strelka2_paired_somatic/strelka2_paired_somatic.filter.TCMG240_T1.f296250b762978a43259641e9ef0e563.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_somatic.filter.TCMG240_T1.f296250b762978a43259641e9ef0e563.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/mugqic_tools/2.10.5 mugqic/python/3.9.1 && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/TCMG240_T1/rawStrelka2_somatic/results/variants/somatic.snvs.vcf.gz \
  pairedVariants/TCMG240_T1/rawStrelka2_somatic/results/variants/somatic.indels.vcf.gz | \
sed 's/TUMOR/TCMG240_T1/g' | sed 's/NORMAL/TCMG240_N/g' | sed 's/Number=R/Number=./g' | grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.vcf.gz && \
zless pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.vt.vcf.gz && \
	python3 $PYTHON_TOOLS/update_genotypes_strelka.py \
	    -i pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.vt.vcf.gz \
	    -o pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.gt.vcf.gz \
	    -n TCMG240_N \
	    -t TCMG240_T1 && \
bcftools \
  view -f PASS -Oz \
   \
 -o pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.vt.vcf.gz \
 pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.gt.vcf.gz
strelka2_paired_somatic.filter.TCMG240_T1.f296250b762978a43259641e9ef0e563.mugqic.done
chmod 755 $COMMAND
strelka2_paired_somatic_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_somatic_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_somatic_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: strelka2_paired_germline
#-------------------------------------------------------------------------------
STEP=strelka2_paired_germline
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_1_JOB_ID: strelka2_paired_germline.call.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline.call.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline/strelka2_paired_germline.call.SISJ0635_T.787b728b8d409a2f66eca2c7e41ad04e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline.call.SISJ0635_T.787b728b8d409a2f66eca2c7e41ad04e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.18 mugqic/Strelka2/2.9.10 && \
rm -r -f pairedVariants/SISJ0635_T/rawStrelka2_germline && \
rm -f pairedVariants/SISJ0635_T/rawStrelka2_germline/runWorkflow.py && \
python $STRELKA2_HOME/bin/configureStrelkaGermlineWorkflow.py \
   \
  --bam alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --bam alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --exome \
  --callRegions $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.strelka2.bed.gz \
  --runDir pairedVariants/SISJ0635_T/rawStrelka2_germline && \
python pairedVariants/SISJ0635_T/rawStrelka2_germline/runWorkflow.py \
  -m local  \
  -j 32 \
  -g 55 \
  --quiet
strelka2_paired_germline.call.SISJ0635_T.787b728b8d409a2f66eca2c7e41ad04e.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_2_JOB_ID: strelka2_paired_germline.filter.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline.filter.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_germline_1_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline/strelka2_paired_germline.filter.SISJ0635_T.7d48ed7edadce202f446afd69f929602.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline.filter.SISJ0635_T.7d48ed7edadce202f446afd69f929602.mugqic.done' > $COMMAND
module purge && \
module load mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/bcftools/1.15 && \
zcat pairedVariants/SISJ0635_T/rawStrelka2_germline/results/variants/variants.vcf.gz | sed 's/TUMOR/SISJ0635_T/g' | sed 's/NORMAL/SISJ0635_N/g' | sed 's/Number=R/Number=./g' | grep -vE 'GL00|hs37d5' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.vcf.gz && \
zless pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.gt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.gt.vcf.gz && \
bcftools \
  view -f PASS -Oz -e 'GT[*]="RR"' \
   \
 -o pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.vt.vcf.gz \
 pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.gt.vcf.gz
strelka2_paired_germline.filter.SISJ0635_T.7d48ed7edadce202f446afd69f929602.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_3_JOB_ID: strelka2_paired_germline.call.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline.call.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline/strelka2_paired_germline.call.SISJ0732_T.435dbf5626c288adaaf30f75d002db9f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline.call.SISJ0732_T.435dbf5626c288adaaf30f75d002db9f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.18 mugqic/Strelka2/2.9.10 && \
rm -r -f pairedVariants/SISJ0732_T/rawStrelka2_germline && \
rm -f pairedVariants/SISJ0732_T/rawStrelka2_germline/runWorkflow.py && \
python $STRELKA2_HOME/bin/configureStrelkaGermlineWorkflow.py \
   \
  --bam alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --bam alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --exome \
  --callRegions $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.strelka2.bed.gz \
  --runDir pairedVariants/SISJ0732_T/rawStrelka2_germline && \
python pairedVariants/SISJ0732_T/rawStrelka2_germline/runWorkflow.py \
  -m local  \
  -j 32 \
  -g 55 \
  --quiet
strelka2_paired_germline.call.SISJ0732_T.435dbf5626c288adaaf30f75d002db9f.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_4_JOB_ID: strelka2_paired_germline.filter.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline.filter.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_germline_3_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline/strelka2_paired_germline.filter.SISJ0732_T.ffd2a931e3fbee73e6ba845646e35e04.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline.filter.SISJ0732_T.ffd2a931e3fbee73e6ba845646e35e04.mugqic.done' > $COMMAND
module purge && \
module load mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/bcftools/1.15 && \
zcat pairedVariants/SISJ0732_T/rawStrelka2_germline/results/variants/variants.vcf.gz | sed 's/TUMOR/SISJ0732_T/g' | sed 's/NORMAL/SISJ0732_N/g' | sed 's/Number=R/Number=./g' | grep -vE 'GL00|hs37d5' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.vcf.gz && \
zless pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.gt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.gt.vcf.gz && \
bcftools \
  view -f PASS -Oz -e 'GT[*]="RR"' \
   \
 -o pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.vt.vcf.gz \
 pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.gt.vcf.gz
strelka2_paired_germline.filter.SISJ0732_T.ffd2a931e3fbee73e6ba845646e35e04.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_5_JOB_ID: strelka2_paired_germline.call.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline.call.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline/strelka2_paired_germline.call.TCMG240_T1.ac4f2d4bc327bcd3bb4c3fc3567e010d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline.call.TCMG240_T1.ac4f2d4bc327bcd3bb4c3fc3567e010d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/2.7.18 mugqic/Strelka2/2.9.10 && \
rm -r -f pairedVariants/TCMG240_T1/rawStrelka2_germline && \
rm -f pairedVariants/TCMG240_T1/rawStrelka2_germline/runWorkflow.py && \
python $STRELKA2_HOME/bin/configureStrelkaGermlineWorkflow.py \
   \
  --bam alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --bam alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --referenceFasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --exome \
  --callRegions $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.strelka2.bed.gz \
  --runDir pairedVariants/TCMG240_T1/rawStrelka2_germline && \
python pairedVariants/TCMG240_T1/rawStrelka2_germline/runWorkflow.py \
  -m local  \
  -j 32 \
  -g 55 \
  --quiet
strelka2_paired_germline.call.TCMG240_T1.ac4f2d4bc327bcd3bb4c3fc3567e010d.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_6_JOB_ID: strelka2_paired_germline.filter.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline.filter.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_germline_5_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline/strelka2_paired_germline.filter.TCMG240_T1.5027b423986d46d43e0ead39082f4ea8.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline.filter.TCMG240_T1.5027b423986d46d43e0ead39082f4ea8.mugqic.done' > $COMMAND
module purge && \
module load mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/bcftools/1.15 && \
zcat pairedVariants/TCMG240_T1/rawStrelka2_germline/results/variants/variants.vcf.gz | sed 's/TUMOR/TCMG240_T1/g' | sed 's/NORMAL/TCMG240_N/g' | sed 's/Number=R/Number=./g' | grep -vE 'GL00|hs37d5' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.vcf.gz && \
zless pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.gt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.gt.vcf.gz && \
bcftools \
  view -f PASS -Oz -e 'GT[*]="RR"' \
   \
 -o pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.vt.vcf.gz \
 pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.gt.vcf.gz
strelka2_paired_germline.filter.TCMG240_T1.5027b423986d46d43e0ead39082f4ea8.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 55G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: strelka2_paired_germline_snpeff
#-------------------------------------------------------------------------------
STEP=strelka2_paired_germline_snpeff
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_1_JOB_ID: strelka2_paired_germline_snpeff.split.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.split.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_germline_2_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.split.SISJ0635_T.33b919f59c89395202c7b7e94d237387.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.split.SISJ0635_T.33b919f59c89395202c7b7e94d237387.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 && \
bcftools \
  +split -Oz -i'GT="alt"' \
  pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.vt.vcf.gz \
  -o pairedVariants/SISJ0635_T
strelka2_paired_germline_snpeff.split.SISJ0635_T.33b919f59c89395202c7b7e94d237387.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_2_JOB_ID: strelka2_paired_germline_snpeff.normal.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.normal.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_germline_snpeff_1_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.normal.SISJ0635_T.b93cded2c2db99a44dd98143f24d6603.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.normal.SISJ0635_T.b93cded2c2db99a44dd98143f24d6603.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/snpEff/4.3 mugqic/htslib/1.14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:ParallelGCThreads=1 -Xmx12000M -jar $SNPEFF_HOME/snpEff.jar eff  \
   \
  -c $SNPEFF_HOME/snpEff.config \
  -i vcf \
  -o vcf \
  -csvStats pairedVariants/SISJ0635_T/SISJ0635_N.snpeff.vcf.stats.csv \
  -stats pairedVariants/SISJ0635_T/SISJ0635_N.snpeff.vcf.stats.html \
  hg19 \
  pairedVariants/SISJ0635_T/SISJ0635_N.vcf.gz \
  > pairedVariants/SISJ0635_T/SISJ0635_N.snpeff.vcf && \
bgzip -cf \
 \
 pairedVariants/SISJ0635_T/SISJ0635_N.snpeff.vcf > \
pairedVariants/SISJ0635_T/SISJ0635_N.snpeff.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_N.snpeff.vcf.gz
strelka2_paired_germline_snpeff.normal.SISJ0635_T.b93cded2c2db99a44dd98143f24d6603.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_3_JOB_ID: strelka2_paired_germline_snpeff.tumor.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.tumor.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_germline_snpeff_1_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.tumor.SISJ0635_T.d36b93e20272a930419fc179678d0f22.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.tumor.SISJ0635_T.d36b93e20272a930419fc179678d0f22.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/snpEff/4.3 mugqic/htslib/1.14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:ParallelGCThreads=1 -Xmx12000M -jar $SNPEFF_HOME/snpEff.jar eff  \
   \
  -c $SNPEFF_HOME/snpEff.config \
  -i vcf \
  -o vcf \
  -csvStats pairedVariants/SISJ0635_T/SISJ0635_T.snpeff.vcf.stats.csv \
  -stats pairedVariants/SISJ0635_T/SISJ0635_T.snpeff.vcf.stats.html \
  hg19 \
  pairedVariants/SISJ0635_T/SISJ0635_T.vcf.gz \
  > pairedVariants/SISJ0635_T/SISJ0635_T.snpeff.vcf && \
bgzip -cf \
 \
 pairedVariants/SISJ0635_T/SISJ0635_T.snpeff.vcf > \
pairedVariants/SISJ0635_T/SISJ0635_T.snpeff.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.snpeff.vcf.gz
strelka2_paired_germline_snpeff.tumor.SISJ0635_T.d36b93e20272a930419fc179678d0f22.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_4_JOB_ID: strelka2_paired_germline_snpeff.split.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.split.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_germline_4_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.split.SISJ0732_T.21c1e7e6525e125f6520d65b022d9495.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.split.SISJ0732_T.21c1e7e6525e125f6520d65b022d9495.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 && \
bcftools \
  +split -Oz -i'GT="alt"' \
  pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.vt.vcf.gz \
  -o pairedVariants/SISJ0732_T
strelka2_paired_germline_snpeff.split.SISJ0732_T.21c1e7e6525e125f6520d65b022d9495.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_5_JOB_ID: strelka2_paired_germline_snpeff.normal.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.normal.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_germline_snpeff_4_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.normal.SISJ0732_T.5ecca915bf9491e8d8a825f7ed47ae0c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.normal.SISJ0732_T.5ecca915bf9491e8d8a825f7ed47ae0c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/snpEff/4.3 mugqic/htslib/1.14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:ParallelGCThreads=1 -Xmx12000M -jar $SNPEFF_HOME/snpEff.jar eff  \
   \
  -c $SNPEFF_HOME/snpEff.config \
  -i vcf \
  -o vcf \
  -csvStats pairedVariants/SISJ0732_T/SISJ0732_N.snpeff.vcf.stats.csv \
  -stats pairedVariants/SISJ0732_T/SISJ0732_N.snpeff.vcf.stats.html \
  hg19 \
  pairedVariants/SISJ0732_T/SISJ0732_N.vcf.gz \
  > pairedVariants/SISJ0732_T/SISJ0732_N.snpeff.vcf && \
bgzip -cf \
 \
 pairedVariants/SISJ0732_T/SISJ0732_N.snpeff.vcf > \
pairedVariants/SISJ0732_T/SISJ0732_N.snpeff.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_N.snpeff.vcf.gz
strelka2_paired_germline_snpeff.normal.SISJ0732_T.5ecca915bf9491e8d8a825f7ed47ae0c.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_6_JOB_ID: strelka2_paired_germline_snpeff.tumor.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.tumor.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_germline_snpeff_4_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.tumor.SISJ0732_T.4037cf27f4a0ac4026b976249e8f28ad.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.tumor.SISJ0732_T.4037cf27f4a0ac4026b976249e8f28ad.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/snpEff/4.3 mugqic/htslib/1.14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:ParallelGCThreads=1 -Xmx12000M -jar $SNPEFF_HOME/snpEff.jar eff  \
   \
  -c $SNPEFF_HOME/snpEff.config \
  -i vcf \
  -o vcf \
  -csvStats pairedVariants/SISJ0732_T/SISJ0732_T.snpeff.vcf.stats.csv \
  -stats pairedVariants/SISJ0732_T/SISJ0732_T.snpeff.vcf.stats.html \
  hg19 \
  pairedVariants/SISJ0732_T/SISJ0732_T.vcf.gz \
  > pairedVariants/SISJ0732_T/SISJ0732_T.snpeff.vcf && \
bgzip -cf \
 \
 pairedVariants/SISJ0732_T/SISJ0732_T.snpeff.vcf > \
pairedVariants/SISJ0732_T/SISJ0732_T.snpeff.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.snpeff.vcf.gz
strelka2_paired_germline_snpeff.tumor.SISJ0732_T.4037cf27f4a0ac4026b976249e8f28ad.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_7_JOB_ID: strelka2_paired_germline_snpeff.split.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.split.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_germline_6_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.split.TCMG240_T1.ae6806b82218e3ed1ebb31c64482494d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.split.TCMG240_T1.ae6806b82218e3ed1ebb31c64482494d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 && \
bcftools \
  +split -Oz -i'GT="alt"' \
  pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.vt.vcf.gz \
  -o pairedVariants/TCMG240_T1
strelka2_paired_germline_snpeff.split.TCMG240_T1.ae6806b82218e3ed1ebb31c64482494d.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_8_JOB_ID: strelka2_paired_germline_snpeff.normal.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.normal.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_germline_snpeff_7_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.normal.TCMG240_T1.eea0d81119335ffec3cd04264ea8877f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.normal.TCMG240_T1.eea0d81119335ffec3cd04264ea8877f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/snpEff/4.3 mugqic/htslib/1.14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:ParallelGCThreads=1 -Xmx12000M -jar $SNPEFF_HOME/snpEff.jar eff  \
   \
  -c $SNPEFF_HOME/snpEff.config \
  -i vcf \
  -o vcf \
  -csvStats pairedVariants/TCMG240_T1/TCMG240_N.snpeff.vcf.stats.csv \
  -stats pairedVariants/TCMG240_T1/TCMG240_N.snpeff.vcf.stats.html \
  hg19 \
  pairedVariants/TCMG240_T1/TCMG240_N.vcf.gz \
  > pairedVariants/TCMG240_T1/TCMG240_N.snpeff.vcf && \
bgzip -cf \
 \
 pairedVariants/TCMG240_T1/TCMG240_N.snpeff.vcf > \
pairedVariants/TCMG240_T1/TCMG240_N.snpeff.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_N.snpeff.vcf.gz
strelka2_paired_germline_snpeff.normal.TCMG240_T1.eea0d81119335ffec3cd04264ea8877f.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: strelka2_paired_germline_snpeff_9_JOB_ID: strelka2_paired_germline_snpeff.tumor.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=strelka2_paired_germline_snpeff.tumor.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_germline_snpeff_7_JOB_ID
JOB_DONE=job_output/strelka2_paired_germline_snpeff/strelka2_paired_germline_snpeff.tumor.TCMG240_T1.c9af61d7118856d69756a1fdb2651829.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'strelka2_paired_germline_snpeff.tumor.TCMG240_T1.c9af61d7118856d69756a1fdb2651829.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/snpEff/4.3 mugqic/htslib/1.14 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:ParallelGCThreads=1 -Xmx12000M -jar $SNPEFF_HOME/snpEff.jar eff  \
   \
  -c $SNPEFF_HOME/snpEff.config \
  -i vcf \
  -o vcf \
  -csvStats pairedVariants/TCMG240_T1/TCMG240_T1.snpeff.vcf.stats.csv \
  -stats pairedVariants/TCMG240_T1/TCMG240_T1.snpeff.vcf.stats.html \
  hg19 \
  pairedVariants/TCMG240_T1/TCMG240_T1.vcf.gz \
  > pairedVariants/TCMG240_T1/TCMG240_T1.snpeff.vcf && \
bgzip -cf \
 \
 pairedVariants/TCMG240_T1/TCMG240_T1.snpeff.vcf > \
pairedVariants/TCMG240_T1/TCMG240_T1.snpeff.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.snpeff.vcf.gz
strelka2_paired_germline_snpeff.tumor.TCMG240_T1.c9af61d7118856d69756a1fdb2651829.mugqic.done
chmod 755 $COMMAND
strelka2_paired_germline_snpeff_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$strelka2_paired_germline_snpeff_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$strelka2_paired_germline_snpeff_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: purple
#-------------------------------------------------------------------------------
STEP=purple
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: purple_1_JOB_ID: purple.convert_strelka2.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.convert_strelka2.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_somatic_2_JOB_ID
JOB_DONE=job_output/purple/purple.convert_strelka2.SISJ0635_T.10116cc7d63d808051b2ef9c030d9f01.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.convert_strelka2.SISJ0635_T.10116cc7d63d808051b2ef9c030d9f01.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/purple/2.53 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16G -cp $PURPLE_JAR com.hartwig.hmftools.purple.tools.AnnotateStrelkaWithAllelicDepth \
  -in pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.vt.vcf.gz \
  -out pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.purple.vcf.gz
purple.convert_strelka2.SISJ0635_T.10116cc7d63d808051b2ef9c030d9f01.mugqic.done
chmod 755 $COMMAND
purple_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_2_JOB_ID: purple.amber.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.amber.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/purple/purple.amber.SISJ0635_T.982e615a9438bbc0e92b8970e11acf25.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.amber.SISJ0635_T.982e615a9438bbc0e92b8970e11acf25.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/amber/3.5 && \
mkdir -p pairedVariants/SISJ0635_T/purple/rawAmber && \
touch pairedVariants/SISJ0635_T/purple/rawAmber && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16000M -jar $AMBER_JAR \
  -threads 8 \
  -reference SISJ0635_N \
  -reference_bam alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  -tumor SISJ0635_T \
  -tumor_bam alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  -loci $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GermlineHetPon.vcf.gz \
  -output_dir pairedVariants/SISJ0635_T/purple/rawAmber
purple.amber.SISJ0635_T.982e615a9438bbc0e92b8970e11acf25.mugqic.done
chmod 755 $COMMAND
purple_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_3_JOB_ID: purple.cobalt.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.cobalt.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/purple/purple.cobalt.SISJ0635_T.82a9af2418fcaead4790ee64278d8800.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.cobalt.SISJ0635_T.82a9af2418fcaead4790ee64278d8800.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/cobalt/1.11 && \
mkdir -p pairedVariants/SISJ0635_T/purple/rawCobalt && \
touch pairedVariants/SISJ0635_T/purple/rawCobalt && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16000M -jar $COBALT_JAR \
  -threads 8 \
  -reference SISJ0635_N \
  -reference_bam alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  -tumor SISJ0635_T \
  -tumor_bam alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  -gc_profile $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GC_profile.1000bp.cnp \
  -output_dir pairedVariants/SISJ0635_T/purple/rawCobalt
purple.cobalt.SISJ0635_T.82a9af2418fcaead4790ee64278d8800.mugqic.done
chmod 755 $COMMAND
purple_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_4_JOB_ID: purple.purity.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.purity.SISJ0635_T
JOB_DEPENDENCIES=$purple_1_JOB_ID:$purple_2_JOB_ID:$purple_3_JOB_ID
JOB_DONE=job_output/purple/purple.purity.SISJ0635_T.9b4c02b02811c86ca69dfa15bed3e733.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.purity.SISJ0635_T.9b4c02b02811c86ca69dfa15bed3e733.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/perl/5.34.0 mugqic/circos/0.69-6 mugqic/cobalt/1.11 mugqic/purple/2.53 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16G -jar $PURPLE_JAR \
  -ref_genome /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -reference SISJ0635_N \
  -tumor SISJ0635_T \
  -cobalt pairedVariants/SISJ0635_T/purple/rawCobalt \
  -amber pairedVariants/SISJ0635_T/purple/rawAmber \
  -gc_profile $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GC_profile.1000bp.cnp \
  -circos circos \
  -somatic_vcf pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.purple.vcf.gz \
  -output_dir pairedVariants/SISJ0635_T/purple
purple.purity.SISJ0635_T.9b4c02b02811c86ca69dfa15bed3e733.mugqic.done
chmod 755 $COMMAND
purple_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_5_JOB_ID: purple.convert_strelka2.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.convert_strelka2.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_somatic_4_JOB_ID
JOB_DONE=job_output/purple/purple.convert_strelka2.SISJ0732_T.cf1bb5c6e9f68a9622d048dbd2645925.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.convert_strelka2.SISJ0732_T.cf1bb5c6e9f68a9622d048dbd2645925.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/purple/2.53 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16G -cp $PURPLE_JAR com.hartwig.hmftools.purple.tools.AnnotateStrelkaWithAllelicDepth \
  -in pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.vt.vcf.gz \
  -out pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.purple.vcf.gz
purple.convert_strelka2.SISJ0732_T.cf1bb5c6e9f68a9622d048dbd2645925.mugqic.done
chmod 755 $COMMAND
purple_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_6_JOB_ID: purple.amber.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.amber.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/purple/purple.amber.SISJ0732_T.d28687d06fa2ef8000326571d46b572b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.amber.SISJ0732_T.d28687d06fa2ef8000326571d46b572b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/amber/3.5 && \
mkdir -p pairedVariants/SISJ0732_T/purple/rawAmber && \
touch pairedVariants/SISJ0732_T/purple/rawAmber && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16000M -jar $AMBER_JAR \
  -threads 8 \
  -reference SISJ0732_N \
  -reference_bam alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  -tumor SISJ0732_T \
  -tumor_bam alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  -loci $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GermlineHetPon.vcf.gz \
  -output_dir pairedVariants/SISJ0732_T/purple/rawAmber
purple.amber.SISJ0732_T.d28687d06fa2ef8000326571d46b572b.mugqic.done
chmod 755 $COMMAND
purple_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_7_JOB_ID: purple.cobalt.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.cobalt.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/purple/purple.cobalt.SISJ0732_T.ca5f89e0ee1e3f02c7d2590e511122f3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.cobalt.SISJ0732_T.ca5f89e0ee1e3f02c7d2590e511122f3.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/cobalt/1.11 && \
mkdir -p pairedVariants/SISJ0732_T/purple/rawCobalt && \
touch pairedVariants/SISJ0732_T/purple/rawCobalt && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16000M -jar $COBALT_JAR \
  -threads 8 \
  -reference SISJ0732_N \
  -reference_bam alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  -tumor SISJ0732_T \
  -tumor_bam alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  -gc_profile $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GC_profile.1000bp.cnp \
  -output_dir pairedVariants/SISJ0732_T/purple/rawCobalt
purple.cobalt.SISJ0732_T.ca5f89e0ee1e3f02c7d2590e511122f3.mugqic.done
chmod 755 $COMMAND
purple_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_8_JOB_ID: purple.purity.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=purple.purity.SISJ0732_T
JOB_DEPENDENCIES=$purple_5_JOB_ID:$purple_6_JOB_ID:$purple_7_JOB_ID
JOB_DONE=job_output/purple/purple.purity.SISJ0732_T.3159ba4ea794e27da4e0d0e85a8d9287.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.purity.SISJ0732_T.3159ba4ea794e27da4e0d0e85a8d9287.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/perl/5.34.0 mugqic/circos/0.69-6 mugqic/cobalt/1.11 mugqic/purple/2.53 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16G -jar $PURPLE_JAR \
  -ref_genome /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -reference SISJ0732_N \
  -tumor SISJ0732_T \
  -cobalt pairedVariants/SISJ0732_T/purple/rawCobalt \
  -amber pairedVariants/SISJ0732_T/purple/rawAmber \
  -gc_profile $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GC_profile.1000bp.cnp \
  -circos circos \
  -somatic_vcf pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.purple.vcf.gz \
  -output_dir pairedVariants/SISJ0732_T/purple
purple.purity.SISJ0732_T.3159ba4ea794e27da4e0d0e85a8d9287.mugqic.done
chmod 755 $COMMAND
purple_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_9_JOB_ID: purple.convert_strelka2.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=purple.convert_strelka2.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_somatic_6_JOB_ID
JOB_DONE=job_output/purple/purple.convert_strelka2.TCMG240_T1.44e35e37f2ab8bd6e6c2072c8c572820.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.convert_strelka2.TCMG240_T1.44e35e37f2ab8bd6e6c2072c8c572820.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/purple/2.53 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16G -cp $PURPLE_JAR com.hartwig.hmftools.purple.tools.AnnotateStrelkaWithAllelicDepth \
  -in pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.vt.vcf.gz \
  -out pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.purple.vcf.gz
purple.convert_strelka2.TCMG240_T1.44e35e37f2ab8bd6e6c2072c8c572820.mugqic.done
chmod 755 $COMMAND
purple_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_10_JOB_ID: purple.amber.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=purple.amber.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/purple/purple.amber.TCMG240_T1.46c60b79a7d9cf9ac626b0f5df318d53.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.amber.TCMG240_T1.46c60b79a7d9cf9ac626b0f5df318d53.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/amber/3.5 && \
mkdir -p pairedVariants/TCMG240_T1/purple/rawAmber && \
touch pairedVariants/TCMG240_T1/purple/rawAmber && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16000M -jar $AMBER_JAR \
  -threads 8 \
  -reference TCMG240_N \
  -reference_bam alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  -tumor TCMG240_T1 \
  -tumor_bam alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  -loci $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GermlineHetPon.vcf.gz \
  -output_dir pairedVariants/TCMG240_T1/purple/rawAmber
purple.amber.TCMG240_T1.46c60b79a7d9cf9ac626b0f5df318d53.mugqic.done
chmod 755 $COMMAND
purple_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_11_JOB_ID: purple.cobalt.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=purple.cobalt.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/purple/purple.cobalt.TCMG240_T1.ac82a5f64cde699b2b7e9fb52ede1dc7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.cobalt.TCMG240_T1.ac82a5f64cde699b2b7e9fb52ede1dc7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/cobalt/1.11 && \
mkdir -p pairedVariants/TCMG240_T1/purple/rawCobalt && \
touch pairedVariants/TCMG240_T1/purple/rawCobalt && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16000M -jar $COBALT_JAR \
  -threads 8 \
  -reference TCMG240_N \
  -reference_bam alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  -tumor TCMG240_T1 \
  -tumor_bam alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  -gc_profile $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GC_profile.1000bp.cnp \
  -output_dir pairedVariants/TCMG240_T1/purple/rawCobalt
purple.cobalt.TCMG240_T1.ac82a5f64cde699b2b7e9fb52ede1dc7.mugqic.done
chmod 755 $COMMAND
purple_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: purple_12_JOB_ID: purple.purity.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=purple.purity.TCMG240_T1
JOB_DEPENDENCIES=$purple_9_JOB_ID:$purple_10_JOB_ID:$purple_11_JOB_ID
JOB_DONE=job_output/purple/purple.purity.TCMG240_T1.6273e851aecea4400640f4bc6451873a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'purple.purity.TCMG240_T1.6273e851aecea4400640f4bc6451873a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/perl/5.34.0 mugqic/circos/0.69-6 mugqic/cobalt/1.11 mugqic/purple/2.53 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx16G -jar $PURPLE_JAR \
  -ref_genome /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -reference TCMG240_N \
  -tumor TCMG240_T1 \
  -cobalt pairedVariants/TCMG240_T1/purple/rawCobalt \
  -amber pairedVariants/TCMG240_T1/purple/rawAmber \
  -gc_profile $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.GC_profile.1000bp.cnp \
  -circos circos \
  -somatic_vcf pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.purple.vcf.gz \
  -output_dir pairedVariants/TCMG240_T1/purple
purple.purity.TCMG240_T1.6273e851aecea4400640f4bc6451873a.mugqic.done
chmod 755 $COMMAND
purple_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 17G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$purple_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$purple_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: rawmpileup
#-------------------------------------------------------------------------------
STEP=rawmpileup
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: rawmpileup_1_JOB_ID: rawmpileup.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=rawmpileup.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/rawmpileup/rawmpileup.SISJ0635_T.e7568f6e06473a56fadad563c7328755.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'rawmpileup.SISJ0635_T.e7568f6e06473a56fadad563c7328755.mugqic.done' > $COMMAND
module purge && \
module load mugqic/samtools/1.12 && \
mkdir -p pairedVariants/SISJ0635_T/rawVarscan2 && \
touch pairedVariants/SISJ0635_T/rawVarscan2 && \
samtools mpileup -d 1000 -L 1000 -B -q 11 -Q 10 \
  -f /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
   \
   \
  alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  > pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.mpileup
rawmpileup.SISJ0635_T.e7568f6e06473a56fadad563c7328755.mugqic.done
chmod 755 $COMMAND
rawmpileup_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 8G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$rawmpileup_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$rawmpileup_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: rawmpileup_2_JOB_ID: rawmpileup.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=rawmpileup.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/rawmpileup/rawmpileup.SISJ0732_T.81806a439062431bdf7838cb06c582fa.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'rawmpileup.SISJ0732_T.81806a439062431bdf7838cb06c582fa.mugqic.done' > $COMMAND
module purge && \
module load mugqic/samtools/1.12 && \
mkdir -p pairedVariants/SISJ0732_T/rawVarscan2 && \
touch pairedVariants/SISJ0732_T/rawVarscan2 && \
samtools mpileup -d 1000 -L 1000 -B -q 11 -Q 10 \
  -f /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
   \
   \
  alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  > pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.mpileup
rawmpileup.SISJ0732_T.81806a439062431bdf7838cb06c582fa.mugqic.done
chmod 755 $COMMAND
rawmpileup_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 8G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$rawmpileup_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$rawmpileup_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: rawmpileup_3_JOB_ID: rawmpileup.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=rawmpileup.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/rawmpileup/rawmpileup.TCMG240_T1.e416ec29f4517b4f3dc09ff390af08f4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'rawmpileup.TCMG240_T1.e416ec29f4517b4f3dc09ff390af08f4.mugqic.done' > $COMMAND
module purge && \
module load mugqic/samtools/1.12 && \
mkdir -p pairedVariants/TCMG240_T1/rawVarscan2 && \
touch pairedVariants/TCMG240_T1/rawVarscan2 && \
samtools mpileup -d 1000 -L 1000 -B -q 11 -Q 10 \
  -f /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
   \
   \
  alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  > pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.mpileup
rawmpileup.TCMG240_T1.e416ec29f4517b4f3dc09ff390af08f4.mugqic.done
chmod 755 $COMMAND
rawmpileup_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 8G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$rawmpileup_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$rawmpileup_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: paired_varscan2
#-------------------------------------------------------------------------------
STEP=paired_varscan2
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: paired_varscan2_1_JOB_ID: varscan2_somatic.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=varscan2_somatic.SISJ0635_T
JOB_DEPENDENCIES=$rawmpileup_1_JOB_ID
JOB_DONE=job_output/paired_varscan2/varscan2_somatic.SISJ0635_T.0183c871a9b2f353ae43d6e95d1655d5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'varscan2_somatic.SISJ0635_T.0183c871a9b2f353ae43d6e95d1655d5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/VarScan/2.4.3 mugqic/htslib/1.14 mugqic/bcftools/1.15 && \
mkdir -p pairedVariants/SISJ0635_T/rawVarscan2 && \
touch pairedVariants/SISJ0635_T/rawVarscan2 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx4000M -jar $VARSCAN2_JAR somatic \
  pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.mpileup \
  pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T \
  --min-coverage 3 --min-var-freq 0.05 --p-value 0.10 --somatic-p-value 0.05 --strand-filter 0 \
  --output-vcf 1 --mpileup 1 && \
bgzip -cf \
 \
 pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.snp.vcf > \
pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.snp.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.snp.vcf.gz && \
bgzip -cf \
 \
 pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.indel.vcf > \
pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.indel.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.indel.vcf.gz && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.snp.vcf.gz \
  pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.indel.vcf.gz | \
sed 's/TUMOR/SISJ0635_T/g' | sed 's/NORMAL/SISJ0635_N/g' | grep -v "INFO=<ID=SSC" | sed -E "s/SSC=(.*);//g" > pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.varscan2.vcf && \
bgzip -cf \
 \
 pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.varscan2.vcf > \
pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.varscan2.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.varscan2.vcf.gz
varscan2_somatic.SISJ0635_T.0183c871a9b2f353ae43d6e95d1655d5.mugqic.done
chmod 755 $COMMAND
paired_varscan2_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 4G -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$paired_varscan2_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$paired_varscan2_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: paired_varscan2_2_JOB_ID: varscan2_somatic.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=varscan2_somatic.SISJ0732_T
JOB_DEPENDENCIES=$rawmpileup_2_JOB_ID
JOB_DONE=job_output/paired_varscan2/varscan2_somatic.SISJ0732_T.d7c238088a94c2db3d184fe4b0b58de2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'varscan2_somatic.SISJ0732_T.d7c238088a94c2db3d184fe4b0b58de2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/VarScan/2.4.3 mugqic/htslib/1.14 mugqic/bcftools/1.15 && \
mkdir -p pairedVariants/SISJ0732_T/rawVarscan2 && \
touch pairedVariants/SISJ0732_T/rawVarscan2 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx4000M -jar $VARSCAN2_JAR somatic \
  pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.mpileup \
  pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T \
  --min-coverage 3 --min-var-freq 0.05 --p-value 0.10 --somatic-p-value 0.05 --strand-filter 0 \
  --output-vcf 1 --mpileup 1 && \
bgzip -cf \
 \
 pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.snp.vcf > \
pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.snp.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.snp.vcf.gz && \
bgzip -cf \
 \
 pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.indel.vcf > \
pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.indel.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.indel.vcf.gz && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.snp.vcf.gz \
  pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.indel.vcf.gz | \
sed 's/TUMOR/SISJ0732_T/g' | sed 's/NORMAL/SISJ0732_N/g' | grep -v "INFO=<ID=SSC" | sed -E "s/SSC=(.*);//g" > pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.varscan2.vcf && \
bgzip -cf \
 \
 pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.varscan2.vcf > \
pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.varscan2.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.varscan2.vcf.gz
varscan2_somatic.SISJ0732_T.d7c238088a94c2db3d184fe4b0b58de2.mugqic.done
chmod 755 $COMMAND
paired_varscan2_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 4G -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$paired_varscan2_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$paired_varscan2_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: paired_varscan2_3_JOB_ID: varscan2_somatic.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=varscan2_somatic.TCMG240_T1
JOB_DEPENDENCIES=$rawmpileup_3_JOB_ID
JOB_DONE=job_output/paired_varscan2/varscan2_somatic.TCMG240_T1.14e5cabf0edb78808798265a28c8a208.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'varscan2_somatic.TCMG240_T1.14e5cabf0edb78808798265a28c8a208.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/VarScan/2.4.3 mugqic/htslib/1.14 mugqic/bcftools/1.15 && \
mkdir -p pairedVariants/TCMG240_T1/rawVarscan2 && \
touch pairedVariants/TCMG240_T1/rawVarscan2 && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx4000M -jar $VARSCAN2_JAR somatic \
  pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.mpileup \
  pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1 \
  --min-coverage 3 --min-var-freq 0.05 --p-value 0.10 --somatic-p-value 0.05 --strand-filter 0 \
  --output-vcf 1 --mpileup 1 && \
bgzip -cf \
 \
 pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.snp.vcf > \
pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.snp.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.snp.vcf.gz && \
bgzip -cf \
 \
 pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.indel.vcf > \
pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.indel.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.indel.vcf.gz && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.snp.vcf.gz \
  pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.indel.vcf.gz | \
sed 's/TUMOR/TCMG240_T1/g' | sed 's/NORMAL/TCMG240_N/g' | grep -v "INFO=<ID=SSC" | sed -E "s/SSC=(.*);//g" > pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.varscan2.vcf && \
bgzip -cf \
 \
 pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.varscan2.vcf > \
pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.varscan2.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.varscan2.vcf.gz
varscan2_somatic.TCMG240_T1.14e5cabf0edb78808798265a28c8a208.mugqic.done
chmod 755 $COMMAND
paired_varscan2_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:00 --mem 4G -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$paired_varscan2_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$paired_varscan2_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: merge_varscan2
#-------------------------------------------------------------------------------
STEP=merge_varscan2
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: merge_varscan2_1_JOB_ID: merge_varscan2.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=merge_varscan2.SISJ0635_T
JOB_DEPENDENCIES=$paired_varscan2_1_JOB_ID
JOB_DONE=job_output/merge_varscan2/merge_varscan2.SISJ0635_T.b5acb702529b37ed9a119fe7d2f2f7f3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_varscan2.SISJ0635_T.b5acb702529b37ed9a119fe7d2f2f7f3.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/mugqic_tools/2.10.5 mugqic/python/3.9.1 mugqic/htslib/1.14 mugqic/vt/0.57 && \
bcftools \
  view  \
   \
 pairedVariants/SISJ0635_T/rawVarscan2/SISJ0635_T.varscan2.vcf.gz | \
python3 $PYTHON_TOOLS/fixVS2VCF.py   \
     | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $4) } {print}' | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $5) } {print}' | \
awk -F$'\t' -v OFS='\t' '$1!~/^#/ && $4 == $5 {next} {print}' | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vcf.gz && \
zless pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vt.vcf.gz && \
bcftools \
  view -Oz -i 'SS="2"' \
   \
 -o pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.somatic.vt.vcf.gz \
 pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vt.vcf.gz && \
tabix -pvcf  \
pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.somatic.vt.vcf.gz && \
bcftools \
  view -Oz -i 'SS="1"|SS="3"' \
   \
 pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.vt.vcf.gz | \
bcftools \
  view -e 'GT[*]="RR"' \
   | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.germline.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.germline.vt.vcf.gz
merge_varscan2.SISJ0635_T.b5acb702529b37ed9a119fe7d2f2f7f3.mugqic.done
chmod 755 $COMMAND
merge_varscan2_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 8G -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_varscan2_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_varscan2_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: merge_varscan2_2_JOB_ID: merge_varscan2.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=merge_varscan2.SISJ0732_T
JOB_DEPENDENCIES=$paired_varscan2_2_JOB_ID
JOB_DONE=job_output/merge_varscan2/merge_varscan2.SISJ0732_T.44ce1d7295cbce989a8c7c22c492b092.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_varscan2.SISJ0732_T.44ce1d7295cbce989a8c7c22c492b092.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/mugqic_tools/2.10.5 mugqic/python/3.9.1 mugqic/htslib/1.14 mugqic/vt/0.57 && \
bcftools \
  view  \
   \
 pairedVariants/SISJ0732_T/rawVarscan2/SISJ0732_T.varscan2.vcf.gz | \
python3 $PYTHON_TOOLS/fixVS2VCF.py   \
     | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $4) } {print}' | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $5) } {print}' | \
awk -F$'\t' -v OFS='\t' '$1!~/^#/ && $4 == $5 {next} {print}' | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vcf.gz && \
zless pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vt.vcf.gz && \
bcftools \
  view -Oz -i 'SS="2"' \
   \
 -o pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.somatic.vt.vcf.gz \
 pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vt.vcf.gz && \
tabix -pvcf  \
pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.somatic.vt.vcf.gz && \
bcftools \
  view -Oz -i 'SS="1"|SS="3"' \
   \
 pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.vt.vcf.gz | \
bcftools \
  view -e 'GT[*]="RR"' \
   | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.germline.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.germline.vt.vcf.gz
merge_varscan2.SISJ0732_T.44ce1d7295cbce989a8c7c22c492b092.mugqic.done
chmod 755 $COMMAND
merge_varscan2_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 8G -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_varscan2_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_varscan2_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: merge_varscan2_3_JOB_ID: merge_varscan2.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=merge_varscan2.TCMG240_T1
JOB_DEPENDENCIES=$paired_varscan2_3_JOB_ID
JOB_DONE=job_output/merge_varscan2/merge_varscan2.TCMG240_T1.2063dfc845db2ff7fd3bc71ac79a7b5a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_varscan2.TCMG240_T1.2063dfc845db2ff7fd3bc71ac79a7b5a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/mugqic_tools/2.10.5 mugqic/python/3.9.1 mugqic/htslib/1.14 mugqic/vt/0.57 && \
bcftools \
  view  \
   \
 pairedVariants/TCMG240_T1/rawVarscan2/TCMG240_T1.varscan2.vcf.gz | \
python3 $PYTHON_TOOLS/fixVS2VCF.py   \
     | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $4) } {print}' | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $5) } {print}' | \
awk -F$'\t' -v OFS='\t' '$1!~/^#/ && $4 == $5 {next} {print}' | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vcf.gz && \
zless pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vt.vcf.gz && \
bcftools \
  view -Oz -i 'SS="2"' \
   \
 -o pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.somatic.vt.vcf.gz \
 pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vt.vcf.gz && \
tabix -pvcf  \
pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.somatic.vt.vcf.gz && \
bcftools \
  view -Oz -i 'SS="1"|SS="3"' \
   \
 pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.vt.vcf.gz | \
bcftools \
  view -e 'GT[*]="RR"' \
   | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.germline.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.germline.vt.vcf.gz
merge_varscan2.TCMG240_T1.2063dfc845db2ff7fd3bc71ac79a7b5a.mugqic.done
chmod 755 $COMMAND
merge_varscan2_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 8G -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_varscan2_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_varscan2_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: paired_mutect2
#-------------------------------------------------------------------------------
STEP=paired_mutect2
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: paired_mutect2_1_JOB_ID: gatk_mutect2.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_mutect2.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/paired_mutect2/gatk_mutect2.SISJ0635_T.e86fef4235216c881412dd759a883304.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_mutect2.SISJ0635_T.e86fef4235216c881412dd759a883304.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
mkdir -p pairedVariants/SISJ0635_T/rawMuTect2 && \
touch pairedVariants/SISJ0635_T/rawMuTect2 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  Mutect2 --pair-hmm-implementation AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 16 --max-reads-per-alignment-start 0 --read-validation-stringency LENIENT --af-of-alleles-not-in-resource 0.0000025 \
  --f1r2-tar-gz pairedVariants/SISJ0635_T/rawMuTect2/SISJ0635_T.f1r2.tar.gz \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --tumor-sample SISJ0635_T \
  --input alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  --normal-sample SISJ0635_N \
  --germline-resource /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.af-only-gnomad.vcf.gz \
  --output pairedVariants/SISJ0635_T/rawMuTect2/SISJ0635_T.mutect2.vcf.gz
gatk_mutect2.SISJ0635_T.e86fef4235216c881412dd759a883304.mugqic.done
chmod 755 $COMMAND
paired_mutect2_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$paired_mutect2_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$paired_mutect2_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: paired_mutect2_2_JOB_ID: gatk_mutect2.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_mutect2.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/paired_mutect2/gatk_mutect2.SISJ0732_T.e06a5219d68647473632ba8253aab836.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_mutect2.SISJ0732_T.e06a5219d68647473632ba8253aab836.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
mkdir -p pairedVariants/SISJ0732_T/rawMuTect2 && \
touch pairedVariants/SISJ0732_T/rawMuTect2 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  Mutect2 --pair-hmm-implementation AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 16 --max-reads-per-alignment-start 0 --read-validation-stringency LENIENT --af-of-alleles-not-in-resource 0.0000025 \
  --f1r2-tar-gz pairedVariants/SISJ0732_T/rawMuTect2/SISJ0732_T.f1r2.tar.gz \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --tumor-sample SISJ0732_T \
  --input alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  --normal-sample SISJ0732_N \
  --germline-resource /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.af-only-gnomad.vcf.gz \
  --output pairedVariants/SISJ0732_T/rawMuTect2/SISJ0732_T.mutect2.vcf.gz
gatk_mutect2.SISJ0732_T.e06a5219d68647473632ba8253aab836.mugqic.done
chmod 755 $COMMAND
paired_mutect2_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$paired_mutect2_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$paired_mutect2_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: paired_mutect2_3_JOB_ID: gatk_mutect2.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_mutect2.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/paired_mutect2/gatk_mutect2.TCMG240_T1.1872723fce2b49ec67703adea1d1c7e7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_mutect2.TCMG240_T1.1872723fce2b49ec67703adea1d1c7e7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 && \
mkdir -p pairedVariants/TCMG240_T1/rawMuTect2 && \
touch pairedVariants/TCMG240_T1/rawMuTect2 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx36000M" \
  Mutect2 --pair-hmm-implementation AVX_LOGLESS_CACHING_OMP --native-pair-hmm-threads 16 --max-reads-per-alignment-start 0 --read-validation-stringency LENIENT --af-of-alleles-not-in-resource 0.0000025 \
  --f1r2-tar-gz pairedVariants/TCMG240_T1/rawMuTect2/TCMG240_T1.f1r2.tar.gz \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --tumor-sample TCMG240_T1 \
  --input alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  --normal-sample TCMG240_N \
  --germline-resource /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.af-only-gnomad.vcf.gz \
  --output pairedVariants/TCMG240_T1/rawMuTect2/TCMG240_T1.mutect2.vcf.gz
gatk_mutect2.TCMG240_T1.1872723fce2b49ec67703adea1d1c7e7.mugqic.done
chmod 755 $COMMAND
paired_mutect2_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem 36G -c 16 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$paired_mutect2_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$paired_mutect2_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: merge_mutect2
#-------------------------------------------------------------------------------
STEP=merge_mutect2
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: merge_mutect2_1_JOB_ID: merge_filter_mutect2.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=merge_filter_mutect2.SISJ0635_T
JOB_DEPENDENCIES=$paired_mutect2_1_JOB_ID
JOB_DONE=job_output/merge_mutect2/merge_filter_mutect2.SISJ0635_T.830034482bd41ce71fe42e1b51ef19bb.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_filter_mutect2.SISJ0635_T.830034482bd41ce71fe42e1b51ef19bb.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/bcftools/1.15 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx16000M" \
  LearnReadOrientationModel  \
   \
  --input pairedVariants/SISJ0635_T/rawMuTect2/SISJ0635_T.f1r2.tar.gz \
  --output pairedVariants/SISJ0635_T/SISJ0635_T.f1r2.tar.gz && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx16000M" \
  FilterMutectCalls  \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --variant pairedVariants/SISJ0635_T/rawMuTect2/SISJ0635_T.mutect2.vcf.gz \
      \
 --ob-priors pairedVariants/SISJ0635_T/SISJ0635_T.f1r2.tar.gz \
  --output pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.flt.vcf.gz && \
zless pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.flt.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
 grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -vE 'EBV|hs37d5' | sed -e 's#/\.##g' | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.vt.vcf.gz && \
bcftools \
  view -f PASS \
   \
 pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.vt.vcf.gz | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.somatic.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.somatic.vt.vcf.gz
merge_filter_mutect2.SISJ0635_T.830034482bd41ce71fe42e1b51ef19bb.mugqic.done
chmod 755 $COMMAND
merge_mutect2_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 10G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_mutect2_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_mutect2_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: merge_mutect2_2_JOB_ID: merge_filter_mutect2.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=merge_filter_mutect2.SISJ0732_T
JOB_DEPENDENCIES=$paired_mutect2_2_JOB_ID
JOB_DONE=job_output/merge_mutect2/merge_filter_mutect2.SISJ0732_T.86c1498c52f4dab45af2840590548bec.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_filter_mutect2.SISJ0732_T.86c1498c52f4dab45af2840590548bec.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/bcftools/1.15 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx16000M" \
  LearnReadOrientationModel  \
   \
  --input pairedVariants/SISJ0732_T/rawMuTect2/SISJ0732_T.f1r2.tar.gz \
  --output pairedVariants/SISJ0732_T/SISJ0732_T.f1r2.tar.gz && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx16000M" \
  FilterMutectCalls  \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --variant pairedVariants/SISJ0732_T/rawMuTect2/SISJ0732_T.mutect2.vcf.gz \
      \
 --ob-priors pairedVariants/SISJ0732_T/SISJ0732_T.f1r2.tar.gz \
  --output pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.flt.vcf.gz && \
zless pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.flt.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
 grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -vE 'EBV|hs37d5' | sed -e 's#/\.##g' | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.vt.vcf.gz && \
bcftools \
  view -f PASS \
   \
 pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.vt.vcf.gz | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.somatic.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.somatic.vt.vcf.gz
merge_filter_mutect2.SISJ0732_T.86c1498c52f4dab45af2840590548bec.mugqic.done
chmod 755 $COMMAND
merge_mutect2_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 10G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_mutect2_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_mutect2_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: merge_mutect2_3_JOB_ID: merge_filter_mutect2.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=merge_filter_mutect2.TCMG240_T1
JOB_DEPENDENCIES=$paired_mutect2_3_JOB_ID
JOB_DONE=job_output/merge_mutect2/merge_filter_mutect2.TCMG240_T1.f2f8a5c536934f17cad2d94b4dce0fd7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_filter_mutect2.TCMG240_T1.f2f8a5c536934f17cad2d94b4dce0fd7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/4.1.8.1 mugqic/htslib/1.14 mugqic/vt/0.57 mugqic/bcftools/1.15 && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx16000M" \
  LearnReadOrientationModel  \
   \
  --input pairedVariants/TCMG240_T1/rawMuTect2/TCMG240_T1.f1r2.tar.gz \
  --output pairedVariants/TCMG240_T1/TCMG240_T1.f1r2.tar.gz && \
gatk --java-options "-Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Dsamjdk.use_async_io_read_samtools=true -Dsamjdk.use_async_io_write_samtools=true -Dsamjdk.use_async_io_write_tribble=false -Xmx16000M" \
  FilterMutectCalls  \
  --reference /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --variant pairedVariants/TCMG240_T1/rawMuTect2/TCMG240_T1.mutect2.vcf.gz \
      \
 --ob-priors pairedVariants/TCMG240_T1/TCMG240_T1.f1r2.tar.gz \
  --output pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.flt.vcf.gz && \
zless pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.flt.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
 grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -vE 'EBV|hs37d5' | sed -e 's#/\.##g' | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.vt.vcf.gz && \
bcftools \
  view -f PASS \
   \
 pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.vt.vcf.gz | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.somatic.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.somatic.vt.vcf.gz
merge_filter_mutect2.TCMG240_T1.f2f8a5c536934f17cad2d94b4dce0fd7.mugqic.done
chmod 755 $COMMAND
merge_mutect2_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 10G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_mutect2_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_mutect2_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: vardict_paired
#-------------------------------------------------------------------------------
STEP=vardict_paired
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: vardict_paired_1_JOB_ID: vardict.genome.beds.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=vardict.genome.beds.SISJ0635_T
JOB_DEPENDENCIES=
JOB_DONE=job_output/vardict_paired/vardict.genome.beds.SISJ0635_T.bd8b18c1636a664de9c66ec4da8be746.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'vardict.genome.beds.SISJ0635_T.bd8b18c1636a664de9c66ec4da8be746.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/2.7.18 && \
mkdir -p pairedVariants/SISJ0635_T/rawVardict && \
touch pairedVariants/SISJ0635_T/rawVardict && \
dict2BEDs.py \
  --dict /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.dict \
  --beds pairedVariants/SISJ0635_T/rawVardict/chr.0.bed -c 5000 -o 250
vardict.genome.beds.SISJ0635_T.bd8b18c1636a664de9c66ec4da8be746.mugqic.done
chmod 755 $COMMAND
vardict_paired_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$vardict_paired_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$vardict_paired_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: vardict_paired_2_JOB_ID: vardict_paired.SISJ0635_T.0
#-------------------------------------------------------------------------------
JOB_NAME=vardict_paired.SISJ0635_T.0
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID:$vardict_paired_1_JOB_ID
JOB_DONE=job_output/vardict_paired/vardict_paired.SISJ0635_T.0.049548277e5cee8ed0adf02a4fe184aa.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'vardict_paired.SISJ0635_T.0.049548277e5cee8ed0adf02a4fe184aa.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/VarDictJava/1.4.8 mugqic/samtools/1.12 mugqic/perl/5.34.0 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/htslib/1.14 && \
mkdir -p pairedVariants/SISJ0635_T/rawVardict && \
touch pairedVariants/SISJ0635_T/rawVardict && \
java -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Djava.io.tmpdir=${SLURM_TMPDIR} -Xms768m -Xmx16000M -classpath $VARDICT_HOME/lib/VarDict-1.4.8.jar:$VARDICT_HOME/lib/commons-cli-1.2.jar:$VARDICT_HOME/lib/jregex-1.2_01.jar:$VARDICT_HOME/lib/htsjdk-2.8.0.jar com.astrazeneca.vardict.Main \
  -G /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -N SISJ0635_T \
  -b "alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam|alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam" \
  -f 0.03 -Q 10 -c 1 -S 2 -E 3 -g 4 -th 3 -x 100 \
  pairedVariants/SISJ0635_T/rawVardict/chr.0.bed | \
$VARDICT_BIN/testsomatic.R   | \
perl $VARDICT_BIN/var2vcf_paired.pl \
    -N "SISJ0635_T|SISJ0635_N" \
    -f 0.03 -P 0.9 -m 4.25 -M | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/rawVardict/SISJ0635_T.0.vardict.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/rawVardict/SISJ0635_T.0.vardict.vcf.gz
vardict_paired.SISJ0635_T.0.049548277e5cee8ed0adf02a4fe184aa.mugqic.done
chmod 755 $COMMAND
vardict_paired_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=72:00:00 --mem 16G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$vardict_paired_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$vardict_paired_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: vardict_paired_3_JOB_ID: vardict.genome.beds.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=vardict.genome.beds.SISJ0732_T
JOB_DEPENDENCIES=
JOB_DONE=job_output/vardict_paired/vardict.genome.beds.SISJ0732_T.1249358aa7096d910b27e0a07e34c7fb.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'vardict.genome.beds.SISJ0732_T.1249358aa7096d910b27e0a07e34c7fb.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/2.7.18 && \
mkdir -p pairedVariants/SISJ0732_T/rawVardict && \
touch pairedVariants/SISJ0732_T/rawVardict && \
dict2BEDs.py \
  --dict /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.dict \
  --beds pairedVariants/SISJ0732_T/rawVardict/chr.0.bed -c 5000 -o 250
vardict.genome.beds.SISJ0732_T.1249358aa7096d910b27e0a07e34c7fb.mugqic.done
chmod 755 $COMMAND
vardict_paired_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$vardict_paired_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$vardict_paired_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: vardict_paired_4_JOB_ID: vardict_paired.SISJ0732_T.0
#-------------------------------------------------------------------------------
JOB_NAME=vardict_paired.SISJ0732_T.0
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID:$vardict_paired_3_JOB_ID
JOB_DONE=job_output/vardict_paired/vardict_paired.SISJ0732_T.0.ab2a39fdf88cc674b6ec1ed85214a3ad.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'vardict_paired.SISJ0732_T.0.ab2a39fdf88cc674b6ec1ed85214a3ad.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/VarDictJava/1.4.8 mugqic/samtools/1.12 mugqic/perl/5.34.0 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/htslib/1.14 && \
mkdir -p pairedVariants/SISJ0732_T/rawVardict && \
touch pairedVariants/SISJ0732_T/rawVardict && \
java -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Djava.io.tmpdir=${SLURM_TMPDIR} -Xms768m -Xmx16000M -classpath $VARDICT_HOME/lib/VarDict-1.4.8.jar:$VARDICT_HOME/lib/commons-cli-1.2.jar:$VARDICT_HOME/lib/jregex-1.2_01.jar:$VARDICT_HOME/lib/htsjdk-2.8.0.jar com.astrazeneca.vardict.Main \
  -G /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -N SISJ0732_T \
  -b "alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam|alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam" \
  -f 0.03 -Q 10 -c 1 -S 2 -E 3 -g 4 -th 3 -x 100 \
  pairedVariants/SISJ0732_T/rawVardict/chr.0.bed | \
$VARDICT_BIN/testsomatic.R   | \
perl $VARDICT_BIN/var2vcf_paired.pl \
    -N "SISJ0732_T|SISJ0732_N" \
    -f 0.03 -P 0.9 -m 4.25 -M | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/rawVardict/SISJ0732_T.0.vardict.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/rawVardict/SISJ0732_T.0.vardict.vcf.gz
vardict_paired.SISJ0732_T.0.ab2a39fdf88cc674b6ec1ed85214a3ad.mugqic.done
chmod 755 $COMMAND
vardict_paired_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=72:00:00 --mem 16G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$vardict_paired_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$vardict_paired_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: vardict_paired_5_JOB_ID: vardict.genome.beds.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=vardict.genome.beds.TCMG240_T1
JOB_DEPENDENCIES=
JOB_DONE=job_output/vardict_paired/vardict.genome.beds.TCMG240_T1.754be947ec766932f3d788e81add16b9.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'vardict.genome.beds.TCMG240_T1.754be947ec766932f3d788e81add16b9.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/2.7.18 && \
mkdir -p pairedVariants/TCMG240_T1/rawVardict && \
touch pairedVariants/TCMG240_T1/rawVardict && \
dict2BEDs.py \
  --dict /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.dict \
  --beds pairedVariants/TCMG240_T1/rawVardict/chr.0.bed -c 5000 -o 250
vardict.genome.beds.TCMG240_T1.754be947ec766932f3d788e81add16b9.mugqic.done
chmod 755 $COMMAND
vardict_paired_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$vardict_paired_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$vardict_paired_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: vardict_paired_6_JOB_ID: vardict_paired.TCMG240_T1.0
#-------------------------------------------------------------------------------
JOB_NAME=vardict_paired.TCMG240_T1.0
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID:$vardict_paired_5_JOB_ID
JOB_DONE=job_output/vardict_paired/vardict_paired.TCMG240_T1.0.3d7ee3c66d9e815a3a9732ad9df26937.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'vardict_paired.TCMG240_T1.0.3d7ee3c66d9e815a3a9732ad9df26937.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/VarDictJava/1.4.8 mugqic/samtools/1.12 mugqic/perl/5.34.0 mugqic/R_Bioconductor/3.5.0_3.7 mugqic/htslib/1.14 && \
mkdir -p pairedVariants/TCMG240_T1/rawVardict && \
touch pairedVariants/TCMG240_T1/rawVardict && \
java -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Djava.io.tmpdir=${SLURM_TMPDIR} -Xms768m -Xmx16000M -classpath $VARDICT_HOME/lib/VarDict-1.4.8.jar:$VARDICT_HOME/lib/commons-cli-1.2.jar:$VARDICT_HOME/lib/jregex-1.2_01.jar:$VARDICT_HOME/lib/htsjdk-2.8.0.jar com.astrazeneca.vardict.Main \
  -G /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  -N TCMG240_T1 \
  -b "alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam|alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam" \
  -f 0.03 -Q 10 -c 1 -S 2 -E 3 -g 4 -th 3 -x 100 \
  pairedVariants/TCMG240_T1/rawVardict/chr.0.bed | \
$VARDICT_BIN/testsomatic.R   | \
perl $VARDICT_BIN/var2vcf_paired.pl \
    -N "TCMG240_T1|TCMG240_N" \
    -f 0.03 -P 0.9 -m 4.25 -M | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/rawVardict/TCMG240_T1.0.vardict.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/rawVardict/TCMG240_T1.0.vardict.vcf.gz
vardict_paired.TCMG240_T1.0.3d7ee3c66d9e815a3a9732ad9df26937.mugqic.done
chmod 755 $COMMAND
vardict_paired_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=72:00:00 --mem 16G -c 4 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$vardict_paired_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$vardict_paired_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: merge_filter_paired_vardict
#-------------------------------------------------------------------------------
STEP=merge_filter_paired_vardict
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: merge_filter_paired_vardict_1_JOB_ID: merge_filter_paired_vardict.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=merge_filter_paired_vardict.SISJ0635_T
JOB_DEPENDENCIES=$vardict_paired_2_JOB_ID
JOB_DONE=job_output/merge_filter_paired_vardict/merge_filter_paired_vardict.SISJ0635_T.14153c70b88bebbed0e1f44c9c3916e0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_filter_paired_vardict.SISJ0635_T.14153c70b88bebbed0e1f44c9c3916e0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/htslib/1.14 mugqic/vt/0.57 && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/SISJ0635_T/rawVardict/SISJ0635_T.0.vardict.vcf.gz | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $4) } {print}' | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $5) } {print}' | \
awk -F$'\t' -v OFS='\t' '$1!~/^#/ && $4 == $5 {next} {print}' | grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vcf.gz && \
zless pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vt.vcf.gz && \
bcftools \
  view -f PASS -i 'INFO/STATUS~".*Somatic"' \
   \
 pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vt.vcf.gz | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.vardict.somatic.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.vardict.somatic.vt.vcf.gz && \
bcftools \
  view -f PASS -i 'INFO/STATUS~"Germline"|INFO/STATUS~".*LOH"' \
   \
 pairedVariants/SISJ0635_T/SISJ0635_T.vardict.vt.vcf.gz | \
bcftools \
  view -e 'GT[*]="RR"' \
   | \
bgzip -cf \
 > \
pairedVariants/SISJ0635_T/SISJ0635_T.vardict.germline.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0635_T/SISJ0635_T.vardict.germline.vt.vcf.gz
merge_filter_paired_vardict.SISJ0635_T.14153c70b88bebbed0e1f44c9c3916e0.mugqic.done
chmod 755 $COMMAND
merge_filter_paired_vardict_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_filter_paired_vardict_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_filter_paired_vardict_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: merge_filter_paired_vardict_2_JOB_ID: merge_filter_paired_vardict.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=merge_filter_paired_vardict.SISJ0732_T
JOB_DEPENDENCIES=$vardict_paired_4_JOB_ID
JOB_DONE=job_output/merge_filter_paired_vardict/merge_filter_paired_vardict.SISJ0732_T.538dc8f4be52e894f610cc037c82b741.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_filter_paired_vardict.SISJ0732_T.538dc8f4be52e894f610cc037c82b741.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/htslib/1.14 mugqic/vt/0.57 && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/SISJ0732_T/rawVardict/SISJ0732_T.0.vardict.vcf.gz | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $4) } {print}' | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $5) } {print}' | \
awk -F$'\t' -v OFS='\t' '$1!~/^#/ && $4 == $5 {next} {print}' | grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vcf.gz && \
zless pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vt.vcf.gz && \
bcftools \
  view -f PASS -i 'INFO/STATUS~".*Somatic"' \
   \
 pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vt.vcf.gz | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.vardict.somatic.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.vardict.somatic.vt.vcf.gz && \
bcftools \
  view -f PASS -i 'INFO/STATUS~"Germline"|INFO/STATUS~".*LOH"' \
   \
 pairedVariants/SISJ0732_T/SISJ0732_T.vardict.vt.vcf.gz | \
bcftools \
  view -e 'GT[*]="RR"' \
   | \
bgzip -cf \
 > \
pairedVariants/SISJ0732_T/SISJ0732_T.vardict.germline.vt.vcf.gz && \
tabix -pvcf pairedVariants/SISJ0732_T/SISJ0732_T.vardict.germline.vt.vcf.gz
merge_filter_paired_vardict.SISJ0732_T.538dc8f4be52e894f610cc037c82b741.mugqic.done
chmod 755 $COMMAND
merge_filter_paired_vardict_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_filter_paired_vardict_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_filter_paired_vardict_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: merge_filter_paired_vardict_3_JOB_ID: merge_filter_paired_vardict.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=merge_filter_paired_vardict.TCMG240_T1
JOB_DEPENDENCIES=$vardict_paired_6_JOB_ID
JOB_DONE=job_output/merge_filter_paired_vardict/merge_filter_paired_vardict.TCMG240_T1.43d5c1d40a75388c736e37e23873aea8.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_filter_paired_vardict.TCMG240_T1.43d5c1d40a75388c736e37e23873aea8.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/htslib/1.14 mugqic/vt/0.57 && \
bcftools \
  concat -a  \
   \
   \
  pairedVariants/TCMG240_T1/rawVardict/TCMG240_T1.0.vardict.vcf.gz | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $4) } {print}' | \
awk -F$'\t' -v OFS='\t' '{if ($0 !~ /^#/) gsub(/[KMRYSWBVHDX]/, "N", $5) } {print}' | \
awk -F$'\t' -v OFS='\t' '$1!~/^#/ && $4 == $5 {next} {print}' | grep -v 'GL00' | grep -Ev 'chrUn|random' | grep -v 'EBV' | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vcf.gz && \
zless pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vcf.gz | sed 's/ID=AD,Number=./ID=AD,Number=R/' | vt decompose -s - | vt normalize -r /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa - | sed -e '#0/.#0/0#' \
          | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vt.vcf.gz && \
bcftools \
  view -f PASS -i 'INFO/STATUS~".*Somatic"' \
   \
 pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vt.vcf.gz | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.vardict.somatic.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.vardict.somatic.vt.vcf.gz && \
bcftools \
  view -f PASS -i 'INFO/STATUS~"Germline"|INFO/STATUS~".*LOH"' \
   \
 pairedVariants/TCMG240_T1/TCMG240_T1.vardict.vt.vcf.gz | \
bcftools \
  view -e 'GT[*]="RR"' \
   | \
bgzip -cf \
 > \
pairedVariants/TCMG240_T1/TCMG240_T1.vardict.germline.vt.vcf.gz && \
tabix -pvcf pairedVariants/TCMG240_T1/TCMG240_T1.vardict.germline.vt.vcf.gz
merge_filter_paired_vardict.TCMG240_T1.43d5c1d40a75388c736e37e23873aea8.mugqic.done
chmod 755 $COMMAND
merge_filter_paired_vardict_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$merge_filter_paired_vardict_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_filter_paired_vardict_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: ensemble_somatic
#-------------------------------------------------------------------------------
STEP=ensemble_somatic
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: ensemble_somatic_1_JOB_ID: bcbio_ensemble_somatic.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=bcbio_ensemble_somatic.SISJ0635_T
JOB_DEPENDENCIES=$purple_1_JOB_ID:$merge_varscan2_1_JOB_ID:$merge_mutect2_1_JOB_ID:$merge_filter_paired_vardict_1_JOB_ID
JOB_DONE=job_output/ensemble_somatic/bcbio_ensemble_somatic.SISJ0635_T.5f749a09d3a69c5b0b82c612d0440cb5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bcbio_ensemble_somatic.SISJ0635_T.5f749a09d3a69c5b0b82c612d0440cb5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcbio.variation.recall/0.2.6 mugqic/bcftools/1.15 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p pairedVariants/ensemble/SISJ0635_T && \
touch pairedVariants/ensemble/SISJ0635_T && \
$BCBIO_VARIATION_RECALL_HOME/bcbio.variation.recall ensemble \
  --cores 6 --numpass 1 --names mutect2,strelka2,vardict,varscan2 \
  pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.vcf.gz \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    \
  pairedVariants/SISJ0635_T/SISJ0635_T.mutect2.somatic.vt.vcf.gz    \
  pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.somatic.purple.vcf.gz    \
  pairedVariants/SISJ0635_T/SISJ0635_T.vardict.somatic.vt.vcf.gz    \
  pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.somatic.vt.vcf.gz
bcbio_ensemble_somatic.SISJ0635_T.5f749a09d3a69c5b0b82c612d0440cb5.mugqic.done
chmod 755 $COMMAND
ensemble_somatic_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 24G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ensemble_somatic_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ensemble_somatic_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ensemble_somatic_2_JOB_ID: bcbio_ensemble_somatic.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=bcbio_ensemble_somatic.SISJ0732_T
JOB_DEPENDENCIES=$purple_5_JOB_ID:$merge_varscan2_2_JOB_ID:$merge_mutect2_2_JOB_ID:$merge_filter_paired_vardict_2_JOB_ID
JOB_DONE=job_output/ensemble_somatic/bcbio_ensemble_somatic.SISJ0732_T.03b462c1672f9218e0bf6df00a8e08f1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bcbio_ensemble_somatic.SISJ0732_T.03b462c1672f9218e0bf6df00a8e08f1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcbio.variation.recall/0.2.6 mugqic/bcftools/1.15 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p pairedVariants/ensemble/SISJ0732_T && \
touch pairedVariants/ensemble/SISJ0732_T && \
$BCBIO_VARIATION_RECALL_HOME/bcbio.variation.recall ensemble \
  --cores 6 --numpass 1 --names mutect2,strelka2,vardict,varscan2 \
  pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.vcf.gz \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    \
  pairedVariants/SISJ0732_T/SISJ0732_T.mutect2.somatic.vt.vcf.gz    \
  pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.somatic.purple.vcf.gz    \
  pairedVariants/SISJ0732_T/SISJ0732_T.vardict.somatic.vt.vcf.gz    \
  pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.somatic.vt.vcf.gz
bcbio_ensemble_somatic.SISJ0732_T.03b462c1672f9218e0bf6df00a8e08f1.mugqic.done
chmod 755 $COMMAND
ensemble_somatic_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 24G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ensemble_somatic_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ensemble_somatic_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ensemble_somatic_3_JOB_ID: bcbio_ensemble_somatic.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=bcbio_ensemble_somatic.TCMG240_T1
JOB_DEPENDENCIES=$purple_9_JOB_ID:$merge_varscan2_3_JOB_ID:$merge_mutect2_3_JOB_ID:$merge_filter_paired_vardict_3_JOB_ID
JOB_DONE=job_output/ensemble_somatic/bcbio_ensemble_somatic.TCMG240_T1.3ce6a0c6a7a92c24235182931070c11b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bcbio_ensemble_somatic.TCMG240_T1.3ce6a0c6a7a92c24235182931070c11b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcbio.variation.recall/0.2.6 mugqic/bcftools/1.15 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p pairedVariants/ensemble/TCMG240_T1 && \
touch pairedVariants/ensemble/TCMG240_T1 && \
$BCBIO_VARIATION_RECALL_HOME/bcbio.variation.recall ensemble \
  --cores 6 --numpass 1 --names mutect2,strelka2,vardict,varscan2 \
  pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.vcf.gz \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    \
  pairedVariants/TCMG240_T1/TCMG240_T1.mutect2.somatic.vt.vcf.gz    \
  pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.somatic.purple.vcf.gz    \
  pairedVariants/TCMG240_T1/TCMG240_T1.vardict.somatic.vt.vcf.gz    \
  pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.somatic.vt.vcf.gz
bcbio_ensemble_somatic.TCMG240_T1.3ce6a0c6a7a92c24235182931070c11b.mugqic.done
chmod 755 $COMMAND
ensemble_somatic_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 24G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ensemble_somatic_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ensemble_somatic_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: gatk_variant_annotator_somatic
#-------------------------------------------------------------------------------
STEP=gatk_variant_annotator_somatic
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: gatk_variant_annotator_somatic_1_JOB_ID: gatk_variant_annotator_somatic.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_variant_annotator_somatic.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID:$ensemble_somatic_1_JOB_ID
JOB_DONE=job_output/gatk_variant_annotator_somatic/gatk_variant_annotator_somatic.SISJ0635_T.534dac54cea1d48b45b24267e51a2cb1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_variant_annotator_somatic.SISJ0635_T.534dac54cea1d48b45b24267e51a2cb1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.7 && \
mkdir -p pairedVariants/ensemble/SISJ0635_T/rawAnnotation && \
touch pairedVariants/ensemble/SISJ0635_T/rawAnnotation && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12000M -jar $GATK_JAR \
  --analysis_type VariantAnnotator -nt 2 --dbsnp $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz -G StandardAnnotation -G StandardSomaticAnnotation -A HomopolymerRun -A Coverage -A DepthPerAlleleBySample -A ClippingRankSumTest -A BaseQualityRankSumTest -A MappingQualityRankSumTest -A MappingQualityZeroBySample -A LowMQ -A ReadPosRankSumTest -A GCContent \
  --disable_auto_index_creation_and_locking_when_reading_rods \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam --input_file alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --variant pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.vcf.gz \
  --out pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz
gatk_variant_annotator_somatic.SISJ0635_T.534dac54cea1d48b45b24267e51a2cb1.mugqic.done
chmod 755 $COMMAND
gatk_variant_annotator_somatic_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_variant_annotator_somatic_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_variant_annotator_somatic_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_variant_annotator_somatic_2_JOB_ID: gatk_variant_annotator_somatic.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_variant_annotator_somatic.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID:$ensemble_somatic_2_JOB_ID
JOB_DONE=job_output/gatk_variant_annotator_somatic/gatk_variant_annotator_somatic.SISJ0732_T.684a5b09b0838226b4e6dc9e9fa59e55.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_variant_annotator_somatic.SISJ0732_T.684a5b09b0838226b4e6dc9e9fa59e55.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.7 && \
mkdir -p pairedVariants/ensemble/SISJ0732_T/rawAnnotation && \
touch pairedVariants/ensemble/SISJ0732_T/rawAnnotation && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12000M -jar $GATK_JAR \
  --analysis_type VariantAnnotator -nt 2 --dbsnp $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz -G StandardAnnotation -G StandardSomaticAnnotation -A HomopolymerRun -A Coverage -A DepthPerAlleleBySample -A ClippingRankSumTest -A BaseQualityRankSumTest -A MappingQualityRankSumTest -A MappingQualityZeroBySample -A LowMQ -A ReadPosRankSumTest -A GCContent \
  --disable_auto_index_creation_and_locking_when_reading_rods \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam --input_file alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --variant pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.vcf.gz \
  --out pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz
gatk_variant_annotator_somatic.SISJ0732_T.684a5b09b0838226b4e6dc9e9fa59e55.mugqic.done
chmod 755 $COMMAND
gatk_variant_annotator_somatic_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_variant_annotator_somatic_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_variant_annotator_somatic_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_variant_annotator_somatic_3_JOB_ID: gatk_variant_annotator_somatic.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_variant_annotator_somatic.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID:$ensemble_somatic_3_JOB_ID
JOB_DONE=job_output/gatk_variant_annotator_somatic/gatk_variant_annotator_somatic.TCMG240_T1.c47b1349a8da99914e98bf24accdc6d6.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_variant_annotator_somatic.TCMG240_T1.c47b1349a8da99914e98bf24accdc6d6.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.7 && \
mkdir -p pairedVariants/ensemble/TCMG240_T1/rawAnnotation && \
touch pairedVariants/ensemble/TCMG240_T1/rawAnnotation && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12000M -jar $GATK_JAR \
  --analysis_type VariantAnnotator -nt 2 --dbsnp $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz -G StandardAnnotation -G StandardSomaticAnnotation -A HomopolymerRun -A Coverage -A DepthPerAlleleBySample -A ClippingRankSumTest -A BaseQualityRankSumTest -A MappingQualityRankSumTest -A MappingQualityZeroBySample -A LowMQ -A ReadPosRankSumTest -A GCContent \
  --disable_auto_index_creation_and_locking_when_reading_rods \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam --input_file alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --variant pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.vcf.gz \
  --out pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz
gatk_variant_annotator_somatic.TCMG240_T1.c47b1349a8da99914e98bf24accdc6d6.mugqic.done
chmod 755 $COMMAND
gatk_variant_annotator_somatic_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_variant_annotator_somatic_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_variant_annotator_somatic_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: ensemble_germline_loh
#-------------------------------------------------------------------------------
STEP=ensemble_germline_loh
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: ensemble_germline_loh_1_JOB_ID: bcbio_ensemble_germline.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=bcbio_ensemble_germline.SISJ0635_T
JOB_DEPENDENCIES=$strelka2_paired_germline_2_JOB_ID:$merge_varscan2_1_JOB_ID:$merge_filter_paired_vardict_1_JOB_ID
JOB_DONE=job_output/ensemble_germline_loh/bcbio_ensemble_germline.SISJ0635_T.8cce696d3c3cc53c41f4b088be357c71.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bcbio_ensemble_germline.SISJ0635_T.8cce696d3c3cc53c41f4b088be357c71.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcbio.variation.recall/0.2.6 mugqic/bcftools/1.15 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p pairedVariants/ensemble/SISJ0635_T && \
touch pairedVariants/ensemble/SISJ0635_T && \
$BCBIO_VARIATION_RECALL_HOME/bcbio.variation.recall ensemble \
  --cores 6 --numpass 1 --names strelka2,vardict,varscan2 \
  pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.vcf.gz \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    \
  pairedVariants/SISJ0635_T/SISJ0635_T.strelka2.germline.vt.vcf.gz    \
  pairedVariants/SISJ0635_T/SISJ0635_T.vardict.germline.vt.vcf.gz    \
  pairedVariants/SISJ0635_T/SISJ0635_T.varscan2.germline.vt.vcf.gz
bcbio_ensemble_germline.SISJ0635_T.8cce696d3c3cc53c41f4b088be357c71.mugqic.done
chmod 755 $COMMAND
ensemble_germline_loh_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 24G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ensemble_germline_loh_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ensemble_germline_loh_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ensemble_germline_loh_2_JOB_ID: bcbio_ensemble_germline.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=bcbio_ensemble_germline.SISJ0732_T
JOB_DEPENDENCIES=$strelka2_paired_germline_4_JOB_ID:$merge_varscan2_2_JOB_ID:$merge_filter_paired_vardict_2_JOB_ID
JOB_DONE=job_output/ensemble_germline_loh/bcbio_ensemble_germline.SISJ0732_T.d2427f5536bd345f83b55e93e36e7019.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bcbio_ensemble_germline.SISJ0732_T.d2427f5536bd345f83b55e93e36e7019.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcbio.variation.recall/0.2.6 mugqic/bcftools/1.15 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p pairedVariants/ensemble/SISJ0732_T && \
touch pairedVariants/ensemble/SISJ0732_T && \
$BCBIO_VARIATION_RECALL_HOME/bcbio.variation.recall ensemble \
  --cores 6 --numpass 1 --names strelka2,vardict,varscan2 \
  pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.vcf.gz \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    \
  pairedVariants/SISJ0732_T/SISJ0732_T.strelka2.germline.vt.vcf.gz    \
  pairedVariants/SISJ0732_T/SISJ0732_T.vardict.germline.vt.vcf.gz    \
  pairedVariants/SISJ0732_T/SISJ0732_T.varscan2.germline.vt.vcf.gz
bcbio_ensemble_germline.SISJ0732_T.d2427f5536bd345f83b55e93e36e7019.mugqic.done
chmod 755 $COMMAND
ensemble_germline_loh_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 24G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ensemble_germline_loh_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ensemble_germline_loh_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ensemble_germline_loh_3_JOB_ID: bcbio_ensemble_germline.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=bcbio_ensemble_germline.TCMG240_T1
JOB_DEPENDENCIES=$strelka2_paired_germline_6_JOB_ID:$merge_varscan2_3_JOB_ID:$merge_filter_paired_vardict_3_JOB_ID
JOB_DONE=job_output/ensemble_germline_loh/bcbio_ensemble_germline.TCMG240_T1.1a9b6ddf892504d2ad1bb0df3c0a6a68.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'bcbio_ensemble_germline.TCMG240_T1.1a9b6ddf892504d2ad1bb0df3c0a6a68.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcbio.variation.recall/0.2.6 mugqic/bcftools/1.15 mugqic/java/openjdk-jdk1.8.0_72 && \
mkdir -p pairedVariants/ensemble/TCMG240_T1 && \
touch pairedVariants/ensemble/TCMG240_T1 && \
$BCBIO_VARIATION_RECALL_HOME/bcbio.variation.recall ensemble \
  --cores 6 --numpass 1 --names strelka2,vardict,varscan2 \
  pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.vcf.gz \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
    \
  pairedVariants/TCMG240_T1/TCMG240_T1.strelka2.germline.vt.vcf.gz    \
  pairedVariants/TCMG240_T1/TCMG240_T1.vardict.germline.vt.vcf.gz    \
  pairedVariants/TCMG240_T1/TCMG240_T1.varscan2.germline.vt.vcf.gz
bcbio_ensemble_germline.TCMG240_T1.1a9b6ddf892504d2ad1bb0df3c0a6a68.mugqic.done
chmod 755 $COMMAND
ensemble_germline_loh_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 24G -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ensemble_germline_loh_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ensemble_germline_loh_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: gatk_variant_annotator_germline
#-------------------------------------------------------------------------------
STEP=gatk_variant_annotator_germline
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: gatk_variant_annotator_germline_1_JOB_ID: gatk_variant_annotator_germline.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_variant_annotator_germline.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID:$ensemble_germline_loh_1_JOB_ID
JOB_DONE=job_output/gatk_variant_annotator_germline/gatk_variant_annotator_germline.SISJ0635_T.f3b088e58f7fca42bd35450ce6b541a5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_variant_annotator_germline.SISJ0635_T.f3b088e58f7fca42bd35450ce6b541a5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.7 && \
mkdir -p pairedVariants/ensemble/SISJ0635_T/rawAnnotation && \
touch pairedVariants/ensemble/SISJ0635_T/rawAnnotation && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12000M -jar $GATK_JAR \
  --analysis_type VariantAnnotator -nt 2 --dbsnp $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz -A HomopolymerRun -A Coverage -A DepthPerAlleleBySample -A ClippingRankSumTest -A BaseQualityRankSumTest -A MappingQualityRankSumTest -A MappingQualityZeroBySample -A LowMQ -A ReadPosRankSumTest -A GCContent \
  --disable_auto_index_creation_and_locking_when_reading_rods \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam --input_file alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  --variant pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.vcf.gz \
  --out pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz
gatk_variant_annotator_germline.SISJ0635_T.f3b088e58f7fca42bd35450ce6b541a5.mugqic.done
chmod 755 $COMMAND
gatk_variant_annotator_germline_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_variant_annotator_germline_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_variant_annotator_germline_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_variant_annotator_germline_2_JOB_ID: gatk_variant_annotator_germline.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=gatk_variant_annotator_germline.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID:$ensemble_germline_loh_2_JOB_ID
JOB_DONE=job_output/gatk_variant_annotator_germline/gatk_variant_annotator_germline.SISJ0732_T.d4820015fe4cca1dda68c1eda937c71f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_variant_annotator_germline.SISJ0732_T.d4820015fe4cca1dda68c1eda937c71f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.7 && \
mkdir -p pairedVariants/ensemble/SISJ0732_T/rawAnnotation && \
touch pairedVariants/ensemble/SISJ0732_T/rawAnnotation && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12000M -jar $GATK_JAR \
  --analysis_type VariantAnnotator -nt 2 --dbsnp $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz -A HomopolymerRun -A Coverage -A DepthPerAlleleBySample -A ClippingRankSumTest -A BaseQualityRankSumTest -A MappingQualityRankSumTest -A MappingQualityZeroBySample -A LowMQ -A ReadPosRankSumTest -A GCContent \
  --disable_auto_index_creation_and_locking_when_reading_rods \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam --input_file alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  --variant pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.vcf.gz \
  --out pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz
gatk_variant_annotator_germline.SISJ0732_T.d4820015fe4cca1dda68c1eda937c71f.mugqic.done
chmod 755 $COMMAND
gatk_variant_annotator_germline_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_variant_annotator_germline_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_variant_annotator_germline_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: gatk_variant_annotator_germline_3_JOB_ID: gatk_variant_annotator_germline.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=gatk_variant_annotator_germline.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID:$ensemble_germline_loh_3_JOB_ID
JOB_DONE=job_output/gatk_variant_annotator_germline/gatk_variant_annotator_germline.TCMG240_T1.b1606816f1ed0d839152e40c16fd012f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'gatk_variant_annotator_germline.TCMG240_T1.b1606816f1ed0d839152e40c16fd012f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/java/openjdk-jdk1.8.0_72 mugqic/GenomeAnalysisTK/3.7 && \
mkdir -p pairedVariants/ensemble/TCMG240_T1/rawAnnotation && \
touch pairedVariants/ensemble/TCMG240_T1/rawAnnotation && \
java -Djava.io.tmpdir=${SLURM_TMPDIR} -XX:+UseParallelGC -XX:ParallelGCThreads=1 -Dsamjdk.buffer_size=4194304 -Xmx12000M -jar $GATK_JAR \
  --analysis_type VariantAnnotator -nt 2 --dbsnp $MUGQIC_INSTALL_HOME/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.dbSNP142.vcf.gz -A HomopolymerRun -A Coverage -A DepthPerAlleleBySample -A ClippingRankSumTest -A BaseQualityRankSumTest -A MappingQualityRankSumTest -A MappingQualityZeroBySample -A LowMQ -A ReadPosRankSumTest -A GCContent \
  --disable_auto_index_creation_and_locking_when_reading_rods \
  --reference_sequence /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --input_file alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam --input_file alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  --variant pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.vcf.gz \
  --out pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz
gatk_variant_annotator_germline.TCMG240_T1.b1606816f1ed0d839152e40c16fd012f.mugqic.done
chmod 755 $COMMAND
gatk_variant_annotator_germline_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 2 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$gatk_variant_annotator_germline_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$gatk_variant_annotator_germline_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: cnvkit_batch
#-------------------------------------------------------------------------------
STEP=cnvkit_batch
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_1_JOB_ID: cnvkit_batch.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.SISJ0635_T
JOB_DEPENDENCIES=$recalibration_2_JOB_ID:$recalibration_4_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.SISJ0635_T.08b6852eee06a3b7cdb73cb908d3ca14.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.SISJ0635_T.08b6852eee06a3b7cdb73cb908d3ca14.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/SISJ0635_T/rawCNVkit && \
touch SVariants/SISJ0635_T/rawCNVkit && \
cnvkit.py batch -m hybrid --short-names --targets /lustre06/project/6037386/data-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-09-08-PROJECT22044_OS_EZHIP_hg/SureSelectHumanAllExonV7.baits.sym.bed \
  -p 6 \
  --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --access /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.access-5k-mappable.bed \
  --annotate /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Ensembl75.ref_flat.tsv \
   \
   \
  --output-reference SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.reference.cnn \
  --output-dir SVariants/SISJ0635_T/rawCNVkit \
  --normal alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam
cnvkit_batch.SISJ0635_T.08b6852eee06a3b7cdb73cb908d3ca14.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_2_JOB_ID: cnvkit_batch.correction.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.correction.SISJ0635_T
JOB_DEPENDENCIES=$cnvkit_batch_1_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.correction.SISJ0635_T.d28fcce72ecb7f2aebd5f7f1fc0ceeb7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.correction.SISJ0635_T.d28fcce72ecb7f2aebd5f7f1fc0ceeb7.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/SISJ0635_T/rawCNVkit && \
touch SVariants/SISJ0635_T/rawCNVkit && \
cnvkit.py fix  \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.sorted.dup.targetcoverage.cnn \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.sorted.dup.antitargetcoverage.cnn \
   \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.reference.cnn \
  -o SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cnr && \
cnvkit.py segment  \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cnr   \
  -o SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cns
cnvkit_batch.correction.SISJ0635_T.d28fcce72ecb7f2aebd5f7f1fc0ceeb7.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_3_JOB_ID: cnvkit_batch.call.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.call.SISJ0635_T
JOB_DEPENDENCIES=$cnvkit_batch_2_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.call.SISJ0635_T.94bb9bfa90602991de864156b9525999.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.call.SISJ0635_T.94bb9bfa90602991de864156b9525999.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 mugqic/htslib/1.14 && \
mkdir -p SVariants/SISJ0635_T/rawCNVkit && \
touch SVariants/SISJ0635_T/rawCNVkit && \
cnvkit.py call  \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cns \
  -o SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.call.cns && \
cnvkit.py export vcf \
  -i "SISJ0635_T" \
   \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.call.cns | \
bgzip -cf \
 > \
SVariants/SISJ0635_T/SISJ0635_T.cnvkit.vcf.gz && \
tabix -pvcf SVariants/SISJ0635_T/SISJ0635_T.cnvkit.vcf.gz
cnvkit_batch.call.SISJ0635_T.94bb9bfa90602991de864156b9525999.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_4_JOB_ID: cnvkit_batch.metrics.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.metrics.SISJ0635_T
JOB_DEPENDENCIES=$cnvkit_batch_2_JOB_ID:$cnvkit_batch_3_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.metrics.SISJ0635_T.1e22126004b2783cb748f581891d83dd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.metrics.SISJ0635_T.1e22126004b2783cb748f581891d83dd.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/SISJ0635_T/rawCNVkit && \
touch SVariants/SISJ0635_T/rawCNVkit && \
cnvkit.py metrics  \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cnr \
  -s SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.call.cns \
  -o SVariants/cnvkit_reference/SISJ0635_T.metrics.tsv && \
cnvkit.py scatter  \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cnr \
  -s SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.call.cns \
  -o SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.scatter.pdf    && \
cnvkit.py diagram  \
  SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.cnr \
  -s SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.call.cns \
  -o SVariants/SISJ0635_T/rawCNVkit/SISJ0635_T.diagram.pdf
cnvkit_batch.metrics.SISJ0635_T.1e22126004b2783cb748f581891d83dd.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_5_JOB_ID: cnvkit_batch.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.SISJ0732_T
JOB_DEPENDENCIES=$recalibration_6_JOB_ID:$recalibration_8_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.SISJ0732_T.2c18a72412033848d5eeb900ac77beac.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.SISJ0732_T.2c18a72412033848d5eeb900ac77beac.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/SISJ0732_T/rawCNVkit && \
touch SVariants/SISJ0732_T/rawCNVkit && \
cnvkit.py batch -m hybrid --short-names --targets /lustre06/project/6037386/data-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-09-08-PROJECT22044_OS_EZHIP_hg/SureSelectHumanAllExonV7.baits.sym.bed \
  -p 6 \
  --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --access /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.access-5k-mappable.bed \
  --annotate /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Ensembl75.ref_flat.tsv \
   \
   \
  --output-reference SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.reference.cnn \
  --output-dir SVariants/SISJ0732_T/rawCNVkit \
  --normal alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam
cnvkit_batch.SISJ0732_T.2c18a72412033848d5eeb900ac77beac.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_6_JOB_ID: cnvkit_batch.correction.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.correction.SISJ0732_T
JOB_DEPENDENCIES=$cnvkit_batch_5_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.correction.SISJ0732_T.4efcf50c0d4a3844eede71db59e4476f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.correction.SISJ0732_T.4efcf50c0d4a3844eede71db59e4476f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/SISJ0732_T/rawCNVkit && \
touch SVariants/SISJ0732_T/rawCNVkit && \
cnvkit.py fix  \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.sorted.dup.targetcoverage.cnn \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.sorted.dup.antitargetcoverage.cnn \
   \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.reference.cnn \
  -o SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cnr && \
cnvkit.py segment  \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cnr   \
  -o SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cns
cnvkit_batch.correction.SISJ0732_T.4efcf50c0d4a3844eede71db59e4476f.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_7_JOB_ID: cnvkit_batch.call.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.call.SISJ0732_T
JOB_DEPENDENCIES=$cnvkit_batch_6_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.call.SISJ0732_T.5c9598eeaad9385c6d0598d96e5c7495.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.call.SISJ0732_T.5c9598eeaad9385c6d0598d96e5c7495.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 mugqic/htslib/1.14 && \
mkdir -p SVariants/SISJ0732_T/rawCNVkit && \
touch SVariants/SISJ0732_T/rawCNVkit && \
cnvkit.py call  \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cns \
  -o SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.call.cns && \
cnvkit.py export vcf \
  -i "SISJ0732_T" \
   \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.call.cns | \
bgzip -cf \
 > \
SVariants/SISJ0732_T/SISJ0732_T.cnvkit.vcf.gz && \
tabix -pvcf SVariants/SISJ0732_T/SISJ0732_T.cnvkit.vcf.gz
cnvkit_batch.call.SISJ0732_T.5c9598eeaad9385c6d0598d96e5c7495.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_8_JOB_ID: cnvkit_batch.metrics.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.metrics.SISJ0732_T
JOB_DEPENDENCIES=$cnvkit_batch_6_JOB_ID:$cnvkit_batch_7_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.metrics.SISJ0732_T.e000e6da44674a6a72a8a6f3ee604344.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.metrics.SISJ0732_T.e000e6da44674a6a72a8a6f3ee604344.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/SISJ0732_T/rawCNVkit && \
touch SVariants/SISJ0732_T/rawCNVkit && \
cnvkit.py metrics  \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cnr \
  -s SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.call.cns \
  -o SVariants/cnvkit_reference/SISJ0732_T.metrics.tsv && \
cnvkit.py scatter  \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cnr \
  -s SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.call.cns \
  -o SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.scatter.pdf    && \
cnvkit.py diagram  \
  SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.cnr \
  -s SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.call.cns \
  -o SVariants/SISJ0732_T/rawCNVkit/SISJ0732_T.diagram.pdf
cnvkit_batch.metrics.SISJ0732_T.e000e6da44674a6a72a8a6f3ee604344.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_9_JOB_ID: cnvkit_batch.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.TCMG240_T1
JOB_DEPENDENCIES=$recalibration_10_JOB_ID:$recalibration_12_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.TCMG240_T1.cb5caa461d2323dc034b3dd8c068e023.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.TCMG240_T1.cb5caa461d2323dc034b3dd8c068e023.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/TCMG240_T1/rawCNVkit && \
touch SVariants/TCMG240_T1/rawCNVkit && \
cnvkit.py batch -m hybrid --short-names --targets /lustre06/project/6037386/data-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-09-08-PROJECT22044_OS_EZHIP_hg/SureSelectHumanAllExonV7.baits.sym.bed \
  -p 6 \
  --fasta /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/genome/Homo_sapiens.GRCh37.fa \
  --access /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.access-5k-mappable.bed \
  --annotate /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.GRCh37/annotations/Homo_sapiens.GRCh37.Ensembl75.ref_flat.tsv \
   \
   \
  --output-reference SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.reference.cnn \
  --output-dir SVariants/TCMG240_T1/rawCNVkit \
  --normal alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam
cnvkit_batch.TCMG240_T1.cb5caa461d2323dc034b3dd8c068e023.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_10_JOB_ID: cnvkit_batch.correction.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.correction.TCMG240_T1
JOB_DEPENDENCIES=$cnvkit_batch_9_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.correction.TCMG240_T1.9cd8382b2542f1a576c72dde0d4f838b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.correction.TCMG240_T1.9cd8382b2542f1a576c72dde0d4f838b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/TCMG240_T1/rawCNVkit && \
touch SVariants/TCMG240_T1/rawCNVkit && \
cnvkit.py fix  \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.sorted.dup.targetcoverage.cnn \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.sorted.dup.antitargetcoverage.cnn \
   \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.reference.cnn \
  -o SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cnr && \
cnvkit.py segment  \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cnr   \
  -o SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cns
cnvkit_batch.correction.TCMG240_T1.9cd8382b2542f1a576c72dde0d4f838b.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_11_JOB_ID: cnvkit_batch.call.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.call.TCMG240_T1
JOB_DEPENDENCIES=$cnvkit_batch_10_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.call.TCMG240_T1.2605cee63867b30e632917e25b233492.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.call.TCMG240_T1.2605cee63867b30e632917e25b233492.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 mugqic/htslib/1.14 && \
mkdir -p SVariants/TCMG240_T1/rawCNVkit && \
touch SVariants/TCMG240_T1/rawCNVkit && \
cnvkit.py call  \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cns \
  -o SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.call.cns && \
cnvkit.py export vcf \
  -i "TCMG240_T1" \
   \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.call.cns | \
bgzip -cf \
 > \
SVariants/TCMG240_T1/TCMG240_T1.cnvkit.vcf.gz && \
tabix -pvcf SVariants/TCMG240_T1/TCMG240_T1.cnvkit.vcf.gz
cnvkit_batch.call.TCMG240_T1.2605cee63867b30e632917e25b233492.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: cnvkit_batch_12_JOB_ID: cnvkit_batch.metrics.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=cnvkit_batch.metrics.TCMG240_T1
JOB_DEPENDENCIES=$cnvkit_batch_10_JOB_ID:$cnvkit_batch_11_JOB_ID
JOB_DONE=job_output/cnvkit_batch/cnvkit_batch.metrics.TCMG240_T1.4cd474ba59b9a4ca9ef2646e8742a92a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'cnvkit_batch.metrics.TCMG240_T1.4cd474ba59b9a4ca9ef2646e8742a92a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/CNVkit/0.9.9 mugqic/R_Bioconductor/3.2.3_3.2 && \
mkdir -p SVariants/TCMG240_T1/rawCNVkit && \
touch SVariants/TCMG240_T1/rawCNVkit && \
cnvkit.py metrics  \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cnr \
  -s SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.call.cns \
  -o SVariants/cnvkit_reference/TCMG240_T1.metrics.tsv && \
cnvkit.py scatter  \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cnr \
  -s SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.call.cns \
  -o SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.scatter.pdf    && \
cnvkit.py diagram  \
  SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.cnr \
  -s SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.call.cns \
  -o SVariants/TCMG240_T1/rawCNVkit/TCMG240_T1.diagram.pdf
cnvkit_batch.metrics.TCMG240_T1.4cd474ba59b9a4ca9ef2646e8742a92a.mugqic.done
chmod 755 $COMMAND
cnvkit_batch_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=48:00:00 --mem-per-cpu 3900M -c 6 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$cnvkit_batch_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$cnvkit_batch_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: filter_ensemble_germline
#-------------------------------------------------------------------------------
STEP=filter_ensemble_germline
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: filter_ensemble_germline_1_JOB_ID: filter_ensemble.germline.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=filter_ensemble.germline.SISJ0635_T
JOB_DEPENDENCIES=$gatk_variant_annotator_germline_1_JOB_ID
JOB_DONE=job_output/filter_ensemble_germline/filter_ensemble.germline.SISJ0635_T.53f44e8e6f9c91684374e138002f8d11.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'filter_ensemble.germline.SISJ0635_T.53f44e8e6f9c91684374e138002f8d11.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/3.10.4 mugqic/bcftools/1.15 mugqic/htslib/1.14 && \
python3 $PYTHON_TOOLS/format2pcgr.py \
	-i pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz \
	-o pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.2caller.vcf.gz \
	-f 2 \
	-v germline \
	-t SISJ0635_T && \
bcftools \
  view -Oz -i'TDP>=10 && TVAF>=0.05 && NDP>=10 && NVAF>=0.05' \
   \
 pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.2caller.vcf.gz | \
bcftools \
  view -Oz -s ^SISJ0635_N \
   | \
bcftools \
  sort -Oz \
   \
 -o pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.2caller.flt.vcf.gz && \
tabix -pvcf  \
pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.2caller.flt.vcf.gz
filter_ensemble.germline.SISJ0635_T.53f44e8e6f9c91684374e138002f8d11.mugqic.done
chmod 755 $COMMAND
filter_ensemble_germline_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$filter_ensemble_germline_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$filter_ensemble_germline_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: filter_ensemble_germline_2_JOB_ID: filter_ensemble.germline.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=filter_ensemble.germline.SISJ0732_T
JOB_DEPENDENCIES=$gatk_variant_annotator_germline_2_JOB_ID
JOB_DONE=job_output/filter_ensemble_germline/filter_ensemble.germline.SISJ0732_T.8cfbdf8aaf840d2ab4cd1653d763c7ac.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'filter_ensemble.germline.SISJ0732_T.8cfbdf8aaf840d2ab4cd1653d763c7ac.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/3.10.4 mugqic/bcftools/1.15 mugqic/htslib/1.14 && \
python3 $PYTHON_TOOLS/format2pcgr.py \
	-i pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz \
	-o pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.2caller.vcf.gz \
	-f 2 \
	-v germline \
	-t SISJ0732_T && \
bcftools \
  view -Oz -i'TDP>=10 && TVAF>=0.05 && NDP>=10 && NVAF>=0.05' \
   \
 pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.2caller.vcf.gz | \
bcftools \
  view -Oz -s ^SISJ0732_N \
   | \
bcftools \
  sort -Oz \
   \
 -o pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.2caller.flt.vcf.gz && \
tabix -pvcf  \
pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.2caller.flt.vcf.gz
filter_ensemble.germline.SISJ0732_T.8cfbdf8aaf840d2ab4cd1653d763c7ac.mugqic.done
chmod 755 $COMMAND
filter_ensemble_germline_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$filter_ensemble_germline_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$filter_ensemble_germline_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: filter_ensemble_germline_3_JOB_ID: filter_ensemble.germline.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=filter_ensemble.germline.TCMG240_T1
JOB_DEPENDENCIES=$gatk_variant_annotator_germline_3_JOB_ID
JOB_DONE=job_output/filter_ensemble_germline/filter_ensemble.germline.TCMG240_T1.24452c80f9de88e6090a611d23733e2d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'filter_ensemble.germline.TCMG240_T1.24452c80f9de88e6090a611d23733e2d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/3.10.4 mugqic/bcftools/1.15 mugqic/htslib/1.14 && \
python3 $PYTHON_TOOLS/format2pcgr.py \
	-i pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz \
	-o pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.2caller.vcf.gz \
	-f 2 \
	-v germline \
	-t TCMG240_T1 && \
bcftools \
  view -Oz -i'TDP>=10 && TVAF>=0.05 && NDP>=10 && NVAF>=0.05' \
   \
 pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.2caller.vcf.gz | \
bcftools \
  view -Oz -s ^TCMG240_N \
   | \
bcftools \
  sort -Oz \
   \
 -o pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.2caller.flt.vcf.gz && \
tabix -pvcf  \
pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.2caller.flt.vcf.gz
filter_ensemble.germline.TCMG240_T1.24452c80f9de88e6090a611d23733e2d.mugqic.done
chmod 755 $COMMAND
filter_ensemble_germline_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$filter_ensemble_germline_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$filter_ensemble_germline_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: filter_ensemble_somatic
#-------------------------------------------------------------------------------
STEP=filter_ensemble_somatic
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: filter_ensemble_somatic_1_JOB_ID: filter_ensemble.somatic.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=filter_ensemble.somatic.SISJ0635_T
JOB_DEPENDENCIES=$gatk_variant_annotator_somatic_1_JOB_ID
JOB_DONE=job_output/filter_ensemble_somatic/filter_ensemble.somatic.SISJ0635_T.a9899a15bf467b00a837fa8321c570a0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'filter_ensemble.somatic.SISJ0635_T.a9899a15bf467b00a837fa8321c570a0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/3.10.4 mugqic/bcftools/1.15 mugqic/htslib/1.14 && \
python3 $PYTHON_TOOLS/format2pcgr.py \
	-i pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz \
	-o pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.2caller.vcf.gz \
	-f 2 \
	-v somatic \
	-t SISJ0635_T && \
bcftools \
  view -Oz -i'TDP>=10 && TVAF>=0.05 && NDP>=10 && NVAF<=0.05' \
   \
 -o pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.2caller.flt.vcf.gz \
 pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.2caller.vcf.gz && \
tabix -pvcf  \
pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.2caller.flt.vcf.gz
filter_ensemble.somatic.SISJ0635_T.a9899a15bf467b00a837fa8321c570a0.mugqic.done
chmod 755 $COMMAND
filter_ensemble_somatic_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$filter_ensemble_somatic_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$filter_ensemble_somatic_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: filter_ensemble_somatic_2_JOB_ID: filter_ensemble.somatic.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=filter_ensemble.somatic.SISJ0732_T
JOB_DEPENDENCIES=$gatk_variant_annotator_somatic_2_JOB_ID
JOB_DONE=job_output/filter_ensemble_somatic/filter_ensemble.somatic.SISJ0732_T.7663e43b7c6a9de674ebd17b05f2c842.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'filter_ensemble.somatic.SISJ0732_T.7663e43b7c6a9de674ebd17b05f2c842.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/3.10.4 mugqic/bcftools/1.15 mugqic/htslib/1.14 && \
python3 $PYTHON_TOOLS/format2pcgr.py \
	-i pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz \
	-o pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.2caller.vcf.gz \
	-f 2 \
	-v somatic \
	-t SISJ0732_T && \
bcftools \
  view -Oz -i'TDP>=10 && TVAF>=0.05 && NDP>=10 && NVAF<=0.05' \
   \
 -o pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.2caller.flt.vcf.gz \
 pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.2caller.vcf.gz && \
tabix -pvcf  \
pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.2caller.flt.vcf.gz
filter_ensemble.somatic.SISJ0732_T.7663e43b7c6a9de674ebd17b05f2c842.mugqic.done
chmod 755 $COMMAND
filter_ensemble_somatic_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$filter_ensemble_somatic_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$filter_ensemble_somatic_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: filter_ensemble_somatic_3_JOB_ID: filter_ensemble.somatic.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=filter_ensemble.somatic.TCMG240_T1
JOB_DEPENDENCIES=$gatk_variant_annotator_somatic_3_JOB_ID
JOB_DONE=job_output/filter_ensemble_somatic/filter_ensemble.somatic.TCMG240_T1.0cdf6c2bf43b77df2fbc75a335d32f86.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'filter_ensemble.somatic.TCMG240_T1.0cdf6c2bf43b77df2fbc75a335d32f86.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.10.5 mugqic/python/3.10.4 mugqic/bcftools/1.15 mugqic/htslib/1.14 && \
python3 $PYTHON_TOOLS/format2pcgr.py \
	-i pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz \
	-o pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.2caller.vcf.gz \
	-f 2 \
	-v somatic \
	-t TCMG240_T1 && \
bcftools \
  view -Oz -i'TDP>=10 && TVAF>=0.05 && NDP>=10 && NVAF<=0.05' \
   \
 -o pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.2caller.flt.vcf.gz \
 pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.2caller.vcf.gz && \
tabix -pvcf  \
pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.2caller.flt.vcf.gz
filter_ensemble.somatic.TCMG240_T1.0cdf6c2bf43b77df2fbc75a335d32f86.mugqic.done
chmod 755 $COMMAND
filter_ensemble_somatic_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 12G -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$filter_ensemble_somatic_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$filter_ensemble_somatic_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: report_cpsr
#-------------------------------------------------------------------------------
STEP=report_cpsr
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: report_cpsr_1_JOB_ID: report_cpsr.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=report_cpsr.SISJ0635_T
JOB_DEPENDENCIES=$filter_ensemble_germline_1_JOB_ID
JOB_DONE=job_output/report_cpsr/report_cpsr.SISJ0635_T.970d1f386889c4ffb7909c7359f357e2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'report_cpsr.SISJ0635_T.970d1f386889c4ffb7909c7359f357e2.mugqic.done' > $COMMAND
module purge && \
module load mugqic/cpsr/0.6.2 && \
mkdir -p pairedVariants/ensemble/SISJ0635_T/cpsr && \
touch pairedVariants/ensemble/SISJ0635_T/cpsr && \
cpsr.py --no_vcf_validate --force_overwrite --no_docker --secondary_findings --gwas_findings --panel_id 0 \
    --input_vcf pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.2caller.flt.vcf.gz \
    --pcgr_dir $PCGR_DATA \
    --output_dir pairedVariants/ensemble/SISJ0635_T/cpsr \
    --genome_assembly grch37 \
    --sample_id SISJ0635_T
report_cpsr.SISJ0635_T.970d1f386889c4ffb7909c7359f357e2.mugqic.done
chmod 755 $COMMAND
report_cpsr_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 36G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$report_cpsr_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$report_cpsr_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: report_cpsr_2_JOB_ID: report_cpsr.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=report_cpsr.SISJ0732_T
JOB_DEPENDENCIES=$filter_ensemble_germline_2_JOB_ID
JOB_DONE=job_output/report_cpsr/report_cpsr.SISJ0732_T.2e3ffc8c33ce32ea445a6b755b0cbfa1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'report_cpsr.SISJ0732_T.2e3ffc8c33ce32ea445a6b755b0cbfa1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/cpsr/0.6.2 && \
mkdir -p pairedVariants/ensemble/SISJ0732_T/cpsr && \
touch pairedVariants/ensemble/SISJ0732_T/cpsr && \
cpsr.py --no_vcf_validate --force_overwrite --no_docker --secondary_findings --gwas_findings --panel_id 0 \
    --input_vcf pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.2caller.flt.vcf.gz \
    --pcgr_dir $PCGR_DATA \
    --output_dir pairedVariants/ensemble/SISJ0732_T/cpsr \
    --genome_assembly grch37 \
    --sample_id SISJ0732_T
report_cpsr.SISJ0732_T.2e3ffc8c33ce32ea445a6b755b0cbfa1.mugqic.done
chmod 755 $COMMAND
report_cpsr_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 36G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$report_cpsr_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$report_cpsr_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: report_cpsr_3_JOB_ID: report_cpsr.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=report_cpsr.TCMG240_T1
JOB_DEPENDENCIES=$filter_ensemble_germline_3_JOB_ID
JOB_DONE=job_output/report_cpsr/report_cpsr.TCMG240_T1.b43617bbbba30e480ffeec2c10bec38d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'report_cpsr.TCMG240_T1.b43617bbbba30e480ffeec2c10bec38d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/cpsr/0.6.2 && \
mkdir -p pairedVariants/ensemble/TCMG240_T1/cpsr && \
touch pairedVariants/ensemble/TCMG240_T1/cpsr && \
cpsr.py --no_vcf_validate --force_overwrite --no_docker --secondary_findings --gwas_findings --panel_id 0 \
    --input_vcf pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.2caller.flt.vcf.gz \
    --pcgr_dir $PCGR_DATA \
    --output_dir pairedVariants/ensemble/TCMG240_T1/cpsr \
    --genome_assembly grch37 \
    --sample_id TCMG240_T1
report_cpsr.TCMG240_T1.b43617bbbba30e480ffeec2c10bec38d.mugqic.done
chmod 755 $COMMAND
report_cpsr_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 36G -c 8 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$report_cpsr_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$report_cpsr_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: report_pcgr
#-------------------------------------------------------------------------------
STEP=report_pcgr
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: report_pcgr_1_JOB_ID: report_pcgr.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=report_pcgr.SISJ0635_T
JOB_DEPENDENCIES=$cnvkit_batch_3_JOB_ID:$filter_ensemble_somatic_1_JOB_ID:$report_cpsr_1_JOB_ID
JOB_DONE=job_output/report_pcgr/report_pcgr.SISJ0635_T.d73ee082b28f5baf9afbfca26c22000d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'report_pcgr.SISJ0635_T.d73ee082b28f5baf9afbfca26c22000d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/pcgr/0.9.2 && \
mkdir -p pairedVariants/ensemble/SISJ0635_T/pcgr && \
touch pairedVariants/ensemble/SISJ0635_T/pcgr && \
`cat > SVariants/header << END
Chromosome	Start	End	Segment_Mean
END` && \
bcftools \
  query -f '%CHROM\t%POS\t%END\t%FOLD_CHANGE_LOG\n' \
   \
 -o SVariants/SISJ0635_T.cnvkit.body.tsv \
 SVariants/SISJ0635_T/SISJ0635_T.cnvkit.vcf.gz && \
cat SVariants/header SVariants/SISJ0635_T.cnvkit.body.tsv > SVariants/SISJ0635_T.cnvkit.cna.tsv && \
pcgr.py --no_vcf_validate --force_overwrite --no_docker --vep_buffer_size 500 --vep_regulatory --show_noncoding --vcf2maf \
    --tumor_site 0 \
    --assay WES \
    --call_conf_tag TAL --tumor_dp_tag TDP --tumor_af_tag TVAF --tumor_dp_min 10 --tumor_af_min 0.05 \
    --control_dp_tag NDP --control_af_tag NVAF --control_dp_min 10 --control_af_max 0.05 \
    --estimate_signatures \
    --estimate_tmb --tmb_algorithm nonsyn \
    --estimate_msi_status \
    --input_vcf pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.2caller.flt.vcf.gz \
    --cpsr_report pairedVariants/ensemble/SISJ0635_T/cpsr/SISJ0635_T.cpsr.grch37.json.gz \
    --input_cna SVariants/SISJ0635_T.cnvkit.cna.tsv \
    --pcgr_dir $PCGR_DATA \
    --output_dir pairedVariants/ensemble/SISJ0635_T/pcgr \
    --genome_assembly grch37 \
    --sample_id SISJ0635_T
report_pcgr.SISJ0635_T.d73ee082b28f5baf9afbfca26c22000d.mugqic.done
chmod 755 $COMMAND
report_pcgr_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 36G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$report_pcgr_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$report_pcgr_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: report_pcgr_2_JOB_ID: report_pcgr.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=report_pcgr.SISJ0732_T
JOB_DEPENDENCIES=$cnvkit_batch_7_JOB_ID:$filter_ensemble_somatic_2_JOB_ID:$report_cpsr_2_JOB_ID:$report_pcgr_1_JOB_ID
JOB_DONE=job_output/report_pcgr/report_pcgr.SISJ0732_T.d01eb93dd1727c9bbebc8550d69af313.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'report_pcgr.SISJ0732_T.d01eb93dd1727c9bbebc8550d69af313.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/pcgr/0.9.2 && \
mkdir -p pairedVariants/ensemble/SISJ0732_T/pcgr && \
touch pairedVariants/ensemble/SISJ0732_T/pcgr && \
`cat > SVariants/header << END
Chromosome	Start	End	Segment_Mean
END` && \
bcftools \
  query -f '%CHROM\t%POS\t%END\t%FOLD_CHANGE_LOG\n' \
   \
 -o SVariants/SISJ0732_T.cnvkit.body.tsv \
 SVariants/SISJ0732_T/SISJ0732_T.cnvkit.vcf.gz && \
cat SVariants/header SVariants/SISJ0732_T.cnvkit.body.tsv > SVariants/SISJ0732_T.cnvkit.cna.tsv && \
pcgr.py --no_vcf_validate --force_overwrite --no_docker --vep_buffer_size 500 --vep_regulatory --show_noncoding --vcf2maf \
    --tumor_site 0 \
    --assay WES \
    --call_conf_tag TAL --tumor_dp_tag TDP --tumor_af_tag TVAF --tumor_dp_min 10 --tumor_af_min 0.05 \
    --control_dp_tag NDP --control_af_tag NVAF --control_dp_min 10 --control_af_max 0.05 \
    --estimate_signatures \
    --estimate_tmb --tmb_algorithm nonsyn \
    --estimate_msi_status \
    --input_vcf pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.2caller.flt.vcf.gz \
    --cpsr_report pairedVariants/ensemble/SISJ0732_T/cpsr/SISJ0732_T.cpsr.grch37.json.gz \
    --input_cna SVariants/SISJ0732_T.cnvkit.cna.tsv \
    --pcgr_dir $PCGR_DATA \
    --output_dir pairedVariants/ensemble/SISJ0732_T/pcgr \
    --genome_assembly grch37 \
    --sample_id SISJ0732_T
report_pcgr.SISJ0732_T.d01eb93dd1727c9bbebc8550d69af313.mugqic.done
chmod 755 $COMMAND
report_pcgr_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 36G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$report_pcgr_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$report_pcgr_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: report_pcgr_3_JOB_ID: report_pcgr.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=report_pcgr.TCMG240_T1
JOB_DEPENDENCIES=$cnvkit_batch_11_JOB_ID:$filter_ensemble_somatic_3_JOB_ID:$report_cpsr_3_JOB_ID:$report_pcgr_1_JOB_ID:$report_pcgr_2_JOB_ID
JOB_DONE=job_output/report_pcgr/report_pcgr.TCMG240_T1.ae7d5989cda6080b6373b5f308e5eac8.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'report_pcgr.TCMG240_T1.ae7d5989cda6080b6373b5f308e5eac8.mugqic.done' > $COMMAND
module purge && \
module load mugqic/bcftools/1.15 mugqic/pcgr/0.9.2 && \
mkdir -p pairedVariants/ensemble/TCMG240_T1/pcgr && \
touch pairedVariants/ensemble/TCMG240_T1/pcgr && \
`cat > SVariants/header << END
Chromosome	Start	End	Segment_Mean
END` && \
bcftools \
  query -f '%CHROM\t%POS\t%END\t%FOLD_CHANGE_LOG\n' \
   \
 -o SVariants/TCMG240_T1.cnvkit.body.tsv \
 SVariants/TCMG240_T1/TCMG240_T1.cnvkit.vcf.gz && \
cat SVariants/header SVariants/TCMG240_T1.cnvkit.body.tsv > SVariants/TCMG240_T1.cnvkit.cna.tsv && \
pcgr.py --no_vcf_validate --force_overwrite --no_docker --vep_buffer_size 500 --vep_regulatory --show_noncoding --vcf2maf \
    --tumor_site 0 \
    --assay WES \
    --call_conf_tag TAL --tumor_dp_tag TDP --tumor_af_tag TVAF --tumor_dp_min 10 --tumor_af_min 0.05 \
    --control_dp_tag NDP --control_af_tag NVAF --control_dp_min 10 --control_af_max 0.05 \
    --estimate_signatures \
    --estimate_tmb --tmb_algorithm nonsyn \
    --estimate_msi_status \
    --input_vcf pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.2caller.flt.vcf.gz \
    --cpsr_report pairedVariants/ensemble/TCMG240_T1/cpsr/TCMG240_T1.cpsr.grch37.json.gz \
    --input_cna SVariants/TCMG240_T1.cnvkit.cna.tsv \
    --pcgr_dir $PCGR_DATA \
    --output_dir pairedVariants/ensemble/TCMG240_T1/pcgr \
    --genome_assembly grch37 \
    --sample_id TCMG240_T1
report_pcgr.TCMG240_T1.ae7d5989cda6080b6373b5f308e5eac8.mugqic.done
chmod 755 $COMMAND
report_pcgr_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem 36G -c 32 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$report_pcgr_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$report_pcgr_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: run_pair_multiqc
#-------------------------------------------------------------------------------
STEP=run_pair_multiqc
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: run_pair_multiqc_1_JOB_ID: multiqc.SISJ0635_T
#-------------------------------------------------------------------------------
JOB_NAME=multiqc.SISJ0635_T
JOB_DEPENDENCIES=$metrics_dna_picard_metrics_1_JOB_ID:$metrics_dna_picard_metrics_2_JOB_ID:$metrics_dna_picard_metrics_3_JOB_ID:$metrics_dna_picard_metrics_4_JOB_ID:$metrics_dna_picard_metrics_5_JOB_ID:$metrics_dna_picard_metrics_6_JOB_ID:$metrics_dna_sample_qualimap_1_JOB_ID:$metrics_dna_sample_qualimap_2_JOB_ID:$metrics_dna_fastqc_1_JOB_ID:$metrics_dna_fastqc_2_JOB_ID
JOB_DONE=job_output/run_pair_multiqc/multiqc.SISJ0635_T.2e3932c3a0de0ad9c9ff4784f35ca3e0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'multiqc.SISJ0635_T.2e3932c3a0de0ad9c9ff4784f35ca3e0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MultiQC/1.9 && \
multiqc -f  \
 \
  metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.oxog_metrics.txt  \
  metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.qcbias_metrics.txt  \
  metrics/dna/SISJ0635_N/picard_metrics/SISJ0635_N.all.metrics.quality_distribution.pdf  \
  metrics/dna/SISJ0635_N/qualimap/SISJ0635_N/genome_results.txt  \
  metrics/dna/SISJ0635_N/fastqc/SISJ0635_N.sorted.dup_fastqc.zip  \
  metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.oxog_metrics.txt  \
  metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.qcbias_metrics.txt  \
  metrics/dna/SISJ0635_T/picard_metrics/SISJ0635_T.all.metrics.quality_distribution.pdf  \
  metrics/dna/SISJ0635_T/qualimap/SISJ0635_T/genome_results.txt  \
  metrics/dna/SISJ0635_T/fastqc/SISJ0635_T.sorted.dup_fastqc.zip \
-n metrics/dna/SISJ0635_T.multiqc.html
multiqc.SISJ0635_T.2e3932c3a0de0ad9c9ff4784f35ca3e0.mugqic.done
chmod 755 $COMMAND
run_pair_multiqc_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=02:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$run_pair_multiqc_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$run_pair_multiqc_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: run_pair_multiqc_2_JOB_ID: multiqc.SISJ0732_T
#-------------------------------------------------------------------------------
JOB_NAME=multiqc.SISJ0732_T
JOB_DEPENDENCIES=$metrics_dna_picard_metrics_9_JOB_ID:$metrics_dna_picard_metrics_10_JOB_ID:$metrics_dna_picard_metrics_11_JOB_ID:$metrics_dna_picard_metrics_12_JOB_ID:$metrics_dna_picard_metrics_13_JOB_ID:$metrics_dna_picard_metrics_14_JOB_ID:$metrics_dna_sample_qualimap_3_JOB_ID:$metrics_dna_sample_qualimap_4_JOB_ID:$metrics_dna_fastqc_3_JOB_ID:$metrics_dna_fastqc_4_JOB_ID
JOB_DONE=job_output/run_pair_multiqc/multiqc.SISJ0732_T.26d2fa16bfc308e43064308105eaf834.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'multiqc.SISJ0732_T.26d2fa16bfc308e43064308105eaf834.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MultiQC/1.9 && \
multiqc -f  \
 \
  metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.oxog_metrics.txt  \
  metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.qcbias_metrics.txt  \
  metrics/dna/SISJ0732_N/picard_metrics/SISJ0732_N.all.metrics.quality_distribution.pdf  \
  metrics/dna/SISJ0732_N/qualimap/SISJ0732_N/genome_results.txt  \
  metrics/dna/SISJ0732_N/fastqc/SISJ0732_N.sorted.dup_fastqc.zip  \
  metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.oxog_metrics.txt  \
  metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.qcbias_metrics.txt  \
  metrics/dna/SISJ0732_T/picard_metrics/SISJ0732_T.all.metrics.quality_distribution.pdf  \
  metrics/dna/SISJ0732_T/qualimap/SISJ0732_T/genome_results.txt  \
  metrics/dna/SISJ0732_T/fastqc/SISJ0732_T.sorted.dup_fastqc.zip \
-n metrics/dna/SISJ0732_T.multiqc.html
multiqc.SISJ0732_T.26d2fa16bfc308e43064308105eaf834.mugqic.done
chmod 755 $COMMAND
run_pair_multiqc_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=02:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$run_pair_multiqc_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$run_pair_multiqc_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: run_pair_multiqc_3_JOB_ID: multiqc.TCMG240_T1
#-------------------------------------------------------------------------------
JOB_NAME=multiqc.TCMG240_T1
JOB_DEPENDENCIES=$metrics_dna_picard_metrics_17_JOB_ID:$metrics_dna_picard_metrics_18_JOB_ID:$metrics_dna_picard_metrics_19_JOB_ID:$metrics_dna_picard_metrics_20_JOB_ID:$metrics_dna_picard_metrics_21_JOB_ID:$metrics_dna_picard_metrics_22_JOB_ID:$metrics_dna_sample_qualimap_5_JOB_ID:$metrics_dna_sample_qualimap_6_JOB_ID:$metrics_dna_fastqc_5_JOB_ID:$metrics_dna_fastqc_6_JOB_ID
JOB_DONE=job_output/run_pair_multiqc/multiqc.TCMG240_T1.25d0befb5accdb052a8d57a0925e5a05.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'multiqc.TCMG240_T1.25d0befb5accdb052a8d57a0925e5a05.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MultiQC/1.9 && \
multiqc -f  \
 \
  metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.oxog_metrics.txt  \
  metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.qcbias_metrics.txt  \
  metrics/dna/TCMG240_N/picard_metrics/TCMG240_N.all.metrics.quality_distribution.pdf  \
  metrics/dna/TCMG240_N/qualimap/TCMG240_N/genome_results.txt  \
  metrics/dna/TCMG240_N/fastqc/TCMG240_N.sorted.dup_fastqc.zip  \
  metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.oxog_metrics.txt  \
  metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.qcbias_metrics.txt  \
  metrics/dna/TCMG240_T1/picard_metrics/TCMG240_T1.all.metrics.quality_distribution.pdf  \
  metrics/dna/TCMG240_T1/qualimap/TCMG240_T1/genome_results.txt  \
  metrics/dna/TCMG240_T1/fastqc/TCMG240_T1.sorted.dup_fastqc.zip \
-n metrics/dna/TCMG240_T1.multiqc.html
multiqc.TCMG240_T1.25d0befb5accdb052a8d57a0925e5a05.mugqic.done
chmod 755 $COMMAND
run_pair_multiqc_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=02:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$run_pair_multiqc_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$run_pair_multiqc_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sym_link_fastq_pair
#-------------------------------------------------------------------------------
STEP=sym_link_fastq_pair
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_1_JOB_ID: sym_link_fastq.pairs.0.SISJ0635_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.0.SISJ0635_T.Normal
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.0.SISJ0635_T.Normal.bbe9b62f08ea463019a2f0671887520a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.0.SISJ0635_T.Normal.bbe9b62f08ea463019a2f0671887520a.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_N/reads/raw/173137_SISJ0635_N_WES_blood_43580_S10_L001_R1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads/173137_SISJ0635_N_WES_blood_43580_S10_L001_R1.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads/173137_SISJ0635_N_WES_blood_43580_S10_L001_R1.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads/173137_SISJ0635_N_WES_blood_43580_S10_L001_R1.fastq.gz.md5
sym_link_fastq.pairs.0.SISJ0635_T.Normal.bbe9b62f08ea463019a2f0671887520a.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_2_JOB_ID: sym_link_fastq.pairs.1.SISJ0635_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.1.SISJ0635_T.Normal
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.1.SISJ0635_T.Normal.1845537433d98119bfb9f74944818f5f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.1.SISJ0635_T.Normal.1845537433d98119bfb9f74944818f5f.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_N/reads/raw/173137_SISJ0635_N_WES_blood_43580_S10_L001_R2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads/173137_SISJ0635_N_WES_blood_43580_S10_L001_R2.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads/173137_SISJ0635_N_WES_blood_43580_S10_L001_R2.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/raw_reads/173137_SISJ0635_N_WES_blood_43580_S10_L001_R2.fastq.gz.md5
sym_link_fastq.pairs.1.SISJ0635_T.Normal.1845537433d98119bfb9f74944818f5f.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_3_JOB_ID: sym_link_fastq.pairs.0.SISJ0635_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.0.SISJ0635_T.Tumor
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.0.SISJ0635_T.Tumor.0107dbf08900c862cf05f75cb90ed551.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.0.SISJ0635_T.Tumor.0107dbf08900c862cf05f75cb90ed551.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_T/reads/raw/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R1.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R1.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R1.fastq.gz.md5
sym_link_fastq.pairs.0.SISJ0635_T.Tumor.0107dbf08900c862cf05f75cb90ed551.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_4_JOB_ID: sym_link_fastq.pairs.1.SISJ0635_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.1.SISJ0635_T.Tumor
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.1.SISJ0635_T.Tumor.de4cc7bef9036221593496eb6c8228a3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.1.SISJ0635_T.Tumor.de4cc7bef9036221593496eb6c8228a3.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0635_T/reads/raw/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R2.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R2.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/raw_reads/173137_SISJ0635_T_WES_osteosarcoma_43568_S11_L001_R2.fastq.gz.md5
sym_link_fastq.pairs.1.SISJ0635_T.Tumor.de4cc7bef9036221593496eb6c8228a3.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_5_JOB_ID: sym_link_fastq.pairs.0.SISJ0732_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.0.SISJ0732_T.Normal
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.0.SISJ0732_T.Normal.0b6ebc99e49d87c1a86a739ff6ac719a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.0.SISJ0732_T.Normal.0b6ebc99e49d87c1a86a739ff6ac719a.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_N/reads/raw/176397_SISJ0732_N_WES_blood_44103_S3_L001_R1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads/176397_SISJ0732_N_WES_blood_44103_S3_L001_R1.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads/176397_SISJ0732_N_WES_blood_44103_S3_L001_R1.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads/176397_SISJ0732_N_WES_blood_44103_S3_L001_R1.fastq.gz.md5
sym_link_fastq.pairs.0.SISJ0732_T.Normal.0b6ebc99e49d87c1a86a739ff6ac719a.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_6_JOB_ID: sym_link_fastq.pairs.1.SISJ0732_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.1.SISJ0732_T.Normal
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.1.SISJ0732_T.Normal.a9728b1379e211814211272a6aba5ebd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.1.SISJ0732_T.Normal.a9728b1379e211814211272a6aba5ebd.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_N/reads/raw/176397_SISJ0732_N_WES_blood_44103_S3_L001_R2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads/176397_SISJ0732_N_WES_blood_44103_S3_L001_R2.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads/176397_SISJ0732_N_WES_blood_44103_S3_L001_R2.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/raw_reads/176397_SISJ0732_N_WES_blood_44103_S3_L001_R2.fastq.gz.md5
sym_link_fastq.pairs.1.SISJ0732_T.Normal.a9728b1379e211814211272a6aba5ebd.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_7_JOB_ID: sym_link_fastq.pairs.0.SISJ0732_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.0.SISJ0732_T.Tumor
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.0.SISJ0732_T.Tumor.f5f974e1cc7d7e2077c2c638005dff73.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.0.SISJ0732_T.Tumor.f5f974e1cc7d7e2077c2c638005dff73.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_T/reads/raw/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R1.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R1.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R1.fastq.gz.md5
sym_link_fastq.pairs.0.SISJ0732_T.Tumor.f5f974e1cc7d7e2077c2c638005dff73.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_8_JOB_ID: sym_link_fastq.pairs.1.SISJ0732_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.1.SISJ0732_T.Tumor
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.1.SISJ0732_T.Tumor.d4344918ae1ba09906d96b2bc2b34373.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.1.SISJ0732_T.Tumor.d4344918ae1ba09906d96b2bc2b34373.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/SISJ0732_T/reads/raw/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R2.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R2.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/raw_reads/176397_SISJ0732_T_WES_osteosarcoma_44088_S4_L001_R2.fastq.gz.md5
sym_link_fastq.pairs.1.SISJ0732_T.Tumor.d4344918ae1ba09906d96b2bc2b34373.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_9_JOB_ID: sym_link_fastq.pairs.0.TCMG240_T1.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.0.TCMG240_T1.Normal
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.0.TCMG240_T1.Normal.e4d58202f4f092409b055110d451dfd3.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.0.TCMG240_T1.Normal.e4d58202f4f092409b055110d451dfd3.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_N/reads/raw/166081_TCMG240_N_WES_blood_42467_S3_L001_R1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads/166081_TCMG240_N_WES_blood_42467_S3_L001_R1.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads/166081_TCMG240_N_WES_blood_42467_S3_L001_R1.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads/166081_TCMG240_N_WES_blood_42467_S3_L001_R1.fastq.gz.md5
sym_link_fastq.pairs.0.TCMG240_T1.Normal.e4d58202f4f092409b055110d451dfd3.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_10_JOB_ID: sym_link_fastq.pairs.1.TCMG240_T1.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.1.TCMG240_T1.Normal
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.1.TCMG240_T1.Normal.15a92a0f0db9cc538769b8286b5bd375.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.1.TCMG240_T1.Normal.15a92a0f0db9cc538769b8286b5bd375.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_N/reads/raw/166081_TCMG240_N_WES_blood_42467_S3_L001_R2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads/166081_TCMG240_N_WES_blood_42467_S3_L001_R2.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads/166081_TCMG240_N_WES_blood_42467_S3_L001_R2.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/raw_reads/166081_TCMG240_N_WES_blood_42467_S3_L001_R2.fastq.gz.md5
sym_link_fastq.pairs.1.TCMG240_T1.Normal.15a92a0f0db9cc538769b8286b5bd375.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_11_JOB_ID: sym_link_fastq.pairs.0.TCMG240_T1.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.0.TCMG240_T1.Tumor
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.0.TCMG240_T1.Tumor.230a686f88b9308df3ae3b3c29a7ff9a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.0.TCMG240_T1.Tumor.230a686f88b9308df3ae3b3c29a7ff9a.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_T1/reads/raw/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R1.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R1.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R1.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R1.fastq.gz.md5
sym_link_fastq.pairs.0.TCMG240_T1.Tumor.230a686f88b9308df3ae3b3c29a7ff9a.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_fastq_pair_12_JOB_ID: sym_link_fastq.pairs.1.TCMG240_T1.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.pairs.1.TCMG240_T1.Tumor
JOB_DEPENDENCIES=
JOB_DONE=job_output/sym_link_fastq_pair/sym_link_fastq.pairs.1.TCMG240_T1.Tumor.e2240076386a4940e27a67b51e67edf5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.pairs.1.TCMG240_T1.Tumor.e2240076386a4940e27a67b51e67edf5.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads && \
ln -s -f \
  /home/alvann/projects/rrg-kleinman/pipeline/v0/levels1-2/njabado/WES/2022-12-16_Clinical_WES_OS_hg/TCMG240_T1/reads/raw/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R2.fastq.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R2.fastq.gz && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R2.fastq.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/raw_reads/166081_TCMG240_T1_WES_osteosarcoma_43890_S7_L002_R2.fastq.gz.md5
sym_link_fastq.pairs.1.TCMG240_T1.Tumor.e2240076386a4940e27a67b51e67edf5.mugqic.done
chmod 755 $COMMAND
sym_link_fastq_pair_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_fastq_pair_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_fastq_pair_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sym_link_final_bam
#-------------------------------------------------------------------------------
STEP=sym_link_final_bam
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_1_JOB_ID: sym_link_final_bam.pairs.0.SISJ0635_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.0.SISJ0635_T.Normal
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.0.SISJ0635_T.Normal.1b5857517dc9fffec1a5bc782cc451de.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.0.SISJ0635_T.Normal.1b5857517dc9fffec1a5bc782cc451de.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment/SISJ0635_N.sorted.dup.recal.bam && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment/SISJ0635_N.sorted.dup.recal.bam.md5
sym_link_final_bam.pairs.0.SISJ0635_T.Normal.1b5857517dc9fffec1a5bc782cc451de.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_2_JOB_ID: sym_link_final_bam.pairs.1.SISJ0635_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.1.SISJ0635_T.Normal
JOB_DEPENDENCIES=$recalibration_2_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.1.SISJ0635_T.Normal.b483f933ad1cebd5e9733d55ba4fb0c7.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.1.SISJ0635_T.Normal.b483f933ad1cebd5e9733d55ba4fb0c7.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam.bai \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam.bai.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment/SISJ0635_N.sorted.dup.recal.bam.bai && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_N/SISJ0635_N.sorted.dup.recal.bam.bai.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_N/wgs/alignment/SISJ0635_N.sorted.dup.recal.bam.bai.md5
sym_link_final_bam.pairs.1.SISJ0635_T.Normal.b483f933ad1cebd5e9733d55ba4fb0c7.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_3_JOB_ID: sym_link_final_bam.pairs.0.SISJ0635_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.0.SISJ0635_T.Tumor
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.0.SISJ0635_T.Tumor.b9d6c163558d9b59a04a6ecf0aa0d124.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.0.SISJ0635_T.Tumor.b9d6c163558d9b59a04a6ecf0aa0d124.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment/SISJ0635_T.sorted.dup.recal.bam && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment/SISJ0635_T.sorted.dup.recal.bam.md5
sym_link_final_bam.pairs.0.SISJ0635_T.Tumor.b9d6c163558d9b59a04a6ecf0aa0d124.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_4_JOB_ID: sym_link_final_bam.pairs.1.SISJ0635_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.1.SISJ0635_T.Tumor
JOB_DEPENDENCIES=$recalibration_4_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.1.SISJ0635_T.Tumor.c89b727f8c50c00590da587c7a4ed3fe.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.1.SISJ0635_T.Tumor.c89b727f8c50c00590da587c7a4ed3fe.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam.bai \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam.bai.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment/SISJ0635_T.sorted.dup.recal.bam.bai && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0635_T/SISJ0635_T.sorted.dup.recal.bam.bai.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/alignment/SISJ0635_T.sorted.dup.recal.bam.bai.md5
sym_link_final_bam.pairs.1.SISJ0635_T.Tumor.c89b727f8c50c00590da587c7a4ed3fe.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_5_JOB_ID: sym_link_final_bam.pairs.0.SISJ0732_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.0.SISJ0732_T.Normal
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.0.SISJ0732_T.Normal.d8dfa62571ccbf00925b69847c083b7f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.0.SISJ0732_T.Normal.d8dfa62571ccbf00925b69847c083b7f.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment/SISJ0732_N.sorted.dup.recal.bam && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment/SISJ0732_N.sorted.dup.recal.bam.md5
sym_link_final_bam.pairs.0.SISJ0732_T.Normal.d8dfa62571ccbf00925b69847c083b7f.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_6_JOB_ID: sym_link_final_bam.pairs.1.SISJ0732_T.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.1.SISJ0732_T.Normal
JOB_DEPENDENCIES=$recalibration_6_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.1.SISJ0732_T.Normal.d49a6307b3ad5474780bbbc310468969.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.1.SISJ0732_T.Normal.d49a6307b3ad5474780bbbc310468969.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam.bai \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam.bai.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment/SISJ0732_N.sorted.dup.recal.bam.bai && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_N/SISJ0732_N.sorted.dup.recal.bam.bai.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_N/wgs/alignment/SISJ0732_N.sorted.dup.recal.bam.bai.md5
sym_link_final_bam.pairs.1.SISJ0732_T.Normal.d49a6307b3ad5474780bbbc310468969.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_7_JOB_ID: sym_link_final_bam.pairs.0.SISJ0732_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.0.SISJ0732_T.Tumor
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.0.SISJ0732_T.Tumor.0a84ac66a2434ed8d52613a455b7a02a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.0.SISJ0732_T.Tumor.0a84ac66a2434ed8d52613a455b7a02a.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment/SISJ0732_T.sorted.dup.recal.bam && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment/SISJ0732_T.sorted.dup.recal.bam.md5
sym_link_final_bam.pairs.0.SISJ0732_T.Tumor.0a84ac66a2434ed8d52613a455b7a02a.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_8_JOB_ID: sym_link_final_bam.pairs.1.SISJ0732_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.1.SISJ0732_T.Tumor
JOB_DEPENDENCIES=$recalibration_8_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.1.SISJ0732_T.Tumor.f823b519248364da83fa45b5b4c7c1e2.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.1.SISJ0732_T.Tumor.f823b519248364da83fa45b5b4c7c1e2.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam.bai \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam.bai.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment/SISJ0732_T.sorted.dup.recal.bam.bai && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/SISJ0732_T/SISJ0732_T.sorted.dup.recal.bam.bai.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/alignment/SISJ0732_T.sorted.dup.recal.bam.bai.md5
sym_link_final_bam.pairs.1.SISJ0732_T.Tumor.f823b519248364da83fa45b5b4c7c1e2.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_9_JOB_ID: sym_link_final_bam.pairs.0.TCMG240_T1.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.0.TCMG240_T1.Normal
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.0.TCMG240_T1.Normal.af45628887691eb28996fc6afe6b8857.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.0.TCMG240_T1.Normal.af45628887691eb28996fc6afe6b8857.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment/TCMG240_N.sorted.dup.recal.bam && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment/TCMG240_N.sorted.dup.recal.bam.md5
sym_link_final_bam.pairs.0.TCMG240_T1.Normal.af45628887691eb28996fc6afe6b8857.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_10_JOB_ID: sym_link_final_bam.pairs.1.TCMG240_T1.Normal
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.1.TCMG240_T1.Normal
JOB_DEPENDENCIES=$recalibration_10_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.1.TCMG240_T1.Normal.c60449d3ef349b46ae8176579fa7886f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.1.TCMG240_T1.Normal.c60449d3ef349b46ae8176579fa7886f.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam.bai \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam.bai.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment/TCMG240_N.sorted.dup.recal.bam.bai && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_N/TCMG240_N.sorted.dup.recal.bam.bai.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_N/wgs/alignment/TCMG240_N.sorted.dup.recal.bam.bai.md5
sym_link_final_bam.pairs.1.TCMG240_T1.Normal.c60449d3ef349b46ae8176579fa7886f.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_11_JOB_ID: sym_link_final_bam.pairs.0.TCMG240_T1.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.0.TCMG240_T1.Tumor
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.0.TCMG240_T1.Tumor.05e1327aaff2e888a83072ea64140301.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.0.TCMG240_T1.Tumor.05e1327aaff2e888a83072ea64140301.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment/TCMG240_T1.sorted.dup.recal.bam && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment/TCMG240_T1.sorted.dup.recal.bam.md5
sym_link_final_bam.pairs.0.TCMG240_T1.Tumor.05e1327aaff2e888a83072ea64140301.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_final_bam_12_JOB_ID: sym_link_final_bam.pairs.1.TCMG240_T1.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_final_bam.pairs.1.TCMG240_T1.Tumor
JOB_DEPENDENCIES=$recalibration_12_JOB_ID
JOB_DONE=job_output/sym_link_final_bam/sym_link_final_bam.pairs.1.TCMG240_T1.Tumor.8467292bde18611e1a391def24a69843.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_final_bam.pairs.1.TCMG240_T1.Tumor.8467292bde18611e1a391def24a69843.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam.bai \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam.bai.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam.bai \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment/TCMG240_T1.sorted.dup.recal.bam.bai && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/alignment/TCMG240_T1/TCMG240_T1.sorted.dup.recal.bam.bai.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/alignment/TCMG240_T1.sorted.dup.recal.bam.bai.md5
sym_link_final_bam.pairs.1.TCMG240_T1.Tumor.8467292bde18611e1a391def24a69843.mugqic.done
chmod 755 $COMMAND
sym_link_final_bam_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_final_bam_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_final_bam_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sym_link_report
#-------------------------------------------------------------------------------
STEP=sym_link_report
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sym_link_report_1_JOB_ID: sym_link_fastq.report.0.SISJ0635_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.report.0.SISJ0635_T.Tumor
JOB_DEPENDENCIES=$run_pair_multiqc_1_JOB_ID
JOB_DONE=job_output/sym_link_report/sym_link_fastq.report.0.SISJ0635_T.Tumor.c93cdfda8c49c8411c6cbab3d32409b4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.report.0.SISJ0635_T.Tumor.c93cdfda8c49c8411c6cbab3d32409b4.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/metrics && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/metrics/dna/SISJ0635_T.multiqc.html \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/metrics/SISJ0635_T.multiqc.html
sym_link_fastq.report.0.SISJ0635_T.Tumor.c93cdfda8c49c8411c6cbab3d32409b4.mugqic.done
chmod 755 $COMMAND
sym_link_report_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_report_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_report_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_report_2_JOB_ID: sym_link_fastq.report.0.SISJ0732_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.report.0.SISJ0732_T.Tumor
JOB_DEPENDENCIES=$run_pair_multiqc_2_JOB_ID
JOB_DONE=job_output/sym_link_report/sym_link_fastq.report.0.SISJ0732_T.Tumor.8866f4ac9df839d8efe08bf61728825a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.report.0.SISJ0732_T.Tumor.8866f4ac9df839d8efe08bf61728825a.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/metrics && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/metrics/dna/SISJ0732_T.multiqc.html \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/metrics/SISJ0732_T.multiqc.html
sym_link_fastq.report.0.SISJ0732_T.Tumor.8866f4ac9df839d8efe08bf61728825a.mugqic.done
chmod 755 $COMMAND
sym_link_report_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_report_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_report_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_report_3_JOB_ID: sym_link_fastq.report.0.TCMG240_T1.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_fastq.report.0.TCMG240_T1.Tumor
JOB_DEPENDENCIES=$run_pair_multiqc_3_JOB_ID
JOB_DONE=job_output/sym_link_report/sym_link_fastq.report.0.TCMG240_T1.Tumor.b13855d96d51888ffdbbb62d1fad09a4.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_fastq.report.0.TCMG240_T1.Tumor.b13855d96d51888ffdbbb62d1fad09a4.mugqic.done' > $COMMAND
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/metrics && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/metrics/dna/TCMG240_T1.multiqc.html \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/metrics/TCMG240_T1.multiqc.html
sym_link_fastq.report.0.TCMG240_T1.Tumor.b13855d96d51888ffdbbb62d1fad09a4.mugqic.done
chmod 755 $COMMAND
sym_link_report_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=03:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_report_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_report_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: sym_link_ensemble
#-------------------------------------------------------------------------------
STEP=sym_link_ensemble
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: sym_link_ensemble_1_JOB_ID: sym_link_ensemble.0.SISJ0635_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_ensemble.0.SISJ0635_T.Tumor
JOB_DEPENDENCIES=$gatk_variant_annotator_somatic_1_JOB_ID:$gatk_variant_annotator_germline_1_JOB_ID
JOB_DONE=job_output/sym_link_ensemble/sym_link_ensemble.0.SISJ0635_T.Tumor.5542780d58e061ccf9de1a76865672ed.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_ensemble.0.SISJ0635_T.Tumor.5542780d58e061ccf9de1a76865672ed.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble/SISJ0635_T.ensemble.somatic.vt.annot.vcf.gz.tbi && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0635_T/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0635_T/SISJ0635_T/wgs/snv/ensemble/SISJ0635_T.ensemble.germline.vt.annot.vcf.gz.tbi
sym_link_ensemble.0.SISJ0635_T.Tumor.5542780d58e061ccf9de1a76865672ed.mugqic.done
chmod 755 $COMMAND
sym_link_ensemble_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_ensemble_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_ensemble_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_ensemble_2_JOB_ID: sym_link_ensemble.0.SISJ0732_T.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_ensemble.0.SISJ0732_T.Tumor
JOB_DEPENDENCIES=$gatk_variant_annotator_somatic_2_JOB_ID:$gatk_variant_annotator_germline_2_JOB_ID
JOB_DONE=job_output/sym_link_ensemble/sym_link_ensemble.0.SISJ0732_T.Tumor.9ee70a5692f337739f576ba926beb3e6.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_ensemble.0.SISJ0732_T.Tumor.9ee70a5692f337739f576ba926beb3e6.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble/SISJ0732_T.ensemble.somatic.vt.annot.vcf.gz.tbi && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/SISJ0732_T/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/SISJ0732_T/SISJ0732_T/wgs/snv/ensemble/SISJ0732_T.ensemble.germline.vt.annot.vcf.gz.tbi
sym_link_ensemble.0.SISJ0732_T.Tumor.9ee70a5692f337739f576ba926beb3e6.mugqic.done
chmod 755 $COMMAND
sym_link_ensemble_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_ensemble_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_ensemble_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: sym_link_ensemble_3_JOB_ID: sym_link_ensemble.0.TCMG240_T1.Tumor
#-------------------------------------------------------------------------------
JOB_NAME=sym_link_ensemble.0.TCMG240_T1.Tumor
JOB_DEPENDENCIES=$gatk_variant_annotator_somatic_3_JOB_ID:$gatk_variant_annotator_germline_3_JOB_ID
JOB_DONE=job_output/sym_link_ensemble/sym_link_ensemble.0.TCMG240_T1.Tumor.9727abe7b860a58706eb3c3bcda4455d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'sym_link_ensemble.0.TCMG240_T1.Tumor.9727abe7b860a58706eb3c3bcda4455d.mugqic.done' > $COMMAND
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble/TCMG240_T1.ensemble.somatic.vt.annot.vcf.gz.tbi && \
md5sum /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz \
  > /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz.md5 \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz.md5 && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz && \
mkdir -p /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble && \
ln -s -f \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/pairedVariants/ensemble/TCMG240_T1/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz.tbi \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/WES/clinical_seq_patients/out/01_genpipes_tumorpair_batch3/deliverables/TCMG240_T1/TCMG240_T1/wgs/snv/ensemble/TCMG240_T1.ensemble.germline.vt.annot.vcf.gz.tbi
sym_link_ensemble.0.TCMG240_T1.Tumor.9727abe7b860a58706eb3c3bcda4455d.mugqic.done
chmod 755 $COMMAND
sym_link_ensemble_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&     $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu 3900M -c 1 -N 1    --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$sym_link_ensemble_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$sym_link_ensemble_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# Call home with pipeline statistics
#-------------------------------------------------------------------------------
LOG_MD5=$(echo $USER-'10.80.49.4-TumorPair-SISJ0635_N.SISJ0635_N_RS1.SISJ0635_N_RS2,SISJ0635_T.SISJ0635_T_RS1.SISJ0635_T_RS2,SISJ0732_N.SISJ0732_N_RS1.SISJ0732_N_RS2,SISJ0732_T.SISJ0732_T_RS1.SISJ0732_T_RS2,TCMG240_T1.TCMG240_T1_RS1,TCMG240_N.TCMG240_N_RS1' | md5sum | awk '{ print $1 }')
if test -t 1; then ncolors=$(tput colors); if test -n "$ncolors" && test $ncolors -ge 8; then bold="$(tput bold)"; normal="$(tput sgr0)"; yellow="$(tput setaf 3)"; fi; fi
wget --quiet 'http://mugqic.hpc.mcgill.ca/cgi-bin/pipeline.cgi?hostname=narval4.narval.calcul.quebec&ip=10.80.49.4&pipeline=TumorPair&steps=picard_sam_to_fastq,skewer_trimming,bwa_mem_sambamba_sort_sam,sambamba_merge_sam_files,gatk_indel_realigner,sambamba_merge_realigned,sambamba_mark_duplicates,recalibration,conpair_concordance_contamination,metrics_dna_picard_metrics,metrics_dna_sample_qualimap,metrics_dna_fastqc,sequenza,manta_sv_calls,strelka2_paired_somatic,strelka2_paired_germline,strelka2_paired_germline_snpeff,purple,rawmpileup,paired_varscan2,merge_varscan2,paired_mutect2,merge_mutect2,vardict_paired,merge_filter_paired_vardict,ensemble_somatic,gatk_variant_annotator_somatic,merge_gatk_variant_annotator_somatic,ensemble_germline_loh,gatk_variant_annotator_germline,merge_gatk_variant_annotator_germline,cnvkit_batch,filter_ensemble_germline,filter_ensemble_somatic,report_cpsr,report_pcgr,run_pair_multiqc,sym_link_fastq_pair,sym_link_final_bam,sym_link_report,sym_link_ensemble&samples=6&md5=$LOG_MD5' -O /dev/null || echo "${bold}${yellow}Warning:${normal}${yellow} Genpipes ran successfully but was not send telemetry to mugqic.hpc.mcgill.ca. This error will not affect genpipes jobs you have submitted.${normal}"
