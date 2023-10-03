#!/bin/bash
# Exit immediately on error

set -eu -o pipefail

#-------------------------------------------------------------------------------
# ChipSeq SLURM Job Submission Bash script
# Version: 3.6.2
# Created on: 2023-03-14T12:08:49
# Steps:
#   picard_sam_to_fastq: 0 job... skipping
#   trimmomatic: 0 job... skipping
#   merge_trimmomatic_stats: 1 job
#   mapping_bwa_mem_sambamba: 0 job... skipping
#   sambamba_merge_bam_files: 0 job... skipping
#   sambamba_mark_duplicates: 0 job... skipping
#   sambamba_view_filter: 0 job... skipping
#   metrics: 1 job
#   homer_make_tag_directory: 0 job... skipping
#   qc_metrics: 1 job
#   homer_make_ucsc_file: 0 job... skipping
#   macs2_callpeak: 13 jobs
#   homer_annotate_peaks: 7 jobs
#   homer_find_motifs_genome: 0 job... skipping
#   annotation_graphs: 1 job
#   run_spp: 1 job
#   differential_binding: 1 job
#   ihec_metrics: 8 jobs
#   multiqc_report: 1 job
#   cram_output: 0 job... skipping
#   TOTAL: 35 jobs
#-------------------------------------------------------------------------------

OUTPUT_DIR=/lustre06/project/6004736/alvann/from_narval/220318_EZHIP/ChIP/U2OS/out/01A_genpipes_chipseq
JOB_OUTPUT_DIR=$OUTPUT_DIR/job_output
TIMESTAMP=`date +%FT%H.%M.%S`
JOB_LIST=$JOB_OUTPUT_DIR/ChipSeq_job_list_$TIMESTAMP
export CONFIG_FILES="/cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/pipelines/chipseq/chipseq.base.ini,/cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/pipelines/chipseq/chipseq.beluga.ini"
mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR

#-------------------------------------------------------------------------------
# STEP: merge_trimmomatic_stats
#-------------------------------------------------------------------------------
STEP=merge_trimmomatic_stats
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: merge_trimmomatic_stats_1_JOB_ID: merge_trimmomatic_stats.
#-------------------------------------------------------------------------------
JOB_NAME=merge_trimmomatic_stats.
JOB_DEPENDENCIES=
JOB_DONE=job_output/merge_trimmomatic_stats/merge_trimmomatic_stats..f191694983c761cb01a5aaee661e4c3a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_trimmomatic_stats..f191694983c761cb01a5aaee661e4c3a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/pandoc/2.16.1 && \
mkdir -p metrics && \
touch metrics && \

echo -e "Sample\tReadset\tMark Name\tRaw Paired Reads #\tSurviving Paired Reads #\tSurviving Paired Reads %" > metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C1A/H3K27me3/rs1.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C1A\trs1\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C1A/H3K27me3/rs2.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C1A\trs2\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C1B/H3K27me3/rs3.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C1B\trs3\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C1B/H3K27me3/rs4.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C1B\trs4\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C1C/H3K27me3/rs5.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C1C\trs5\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C1C/H3K27me3/rs6.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C1C\trs6\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C54A/H3K27me3/rs7.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C54A\trs7\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C54A/H3K27me3/rs8.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C54A\trs8\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C54B/H3K27me3/rs9.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C54B\trs9\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C54B/H3K27me3/rs10.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C54B\trs10\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C54C/H3K27me3/rs11.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C54C\trs11\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
grep ^Input trim/U2OS_C54C/H3K27me3/rs12.trim.log | \
perl -pe 's/^Input Read Pairs: (\d+).*Both Surviving: (\d+).*Forward Only Surviving: (\d+).*$/U2OS_C54C\trs12\tH3K27me3\t\1\t\2/' | \
awk '{OFS="\t"; print $0, $5 / $4 * 100}' \
  >> metrics/trimReadsetTable.tsv && \
cut -f1,3- metrics/trimReadsetTable.tsv | awk -F"\t" '{OFS="\t"; if (NR==1) {if ($3=="Raw Paired Reads #") {paired=1};print "Sample", "Mark Name", "Raw Reads #", "Surviving Reads #", "Surviving %"} else {if (paired) {$3=$3*2; $4=$4*2}; sample[$1$2]=$1; markname[$1$2]=$2; raw[$1$2]+=$3; surviving[$1$2]+=$4}}END{for (samplemark in raw){print sample[samplemark], markname[samplemark], raw[samplemark], surviving[samplemark], surviving[samplemark] / raw[samplemark] * 100}}' \
  > metrics/trimSampleTable.tsv && \
mkdir -p report && \
cp metrics/trimReadsetTable.tsv metrics/trimSampleTable.tsv report/ && \
trim_readset_table_md=`LC_NUMERIC=en_CA awk -F "\t" '{OFS="|"; if (NR == 1) {$1 = $1; print $0; print "-----|-----|-----|-----:|-----:|-----:"} else {print $1, $2, $3, sprintf("%\47d", $4), sprintf("%\47d", $5), sprintf("%.1f", $6)}}' metrics/trimReadsetTable.tsv` && \
pandoc \
  /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/Illumina.merge_trimmomatic_stats.md \
  --template /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/Illumina.merge_trimmomatic_stats.md \
  --variable trailing_min_quality=30 \
  --variable min_length=50 \
  --variable read_type=Paired \
  --variable trim_readset_table="$trim_readset_table_md" \
  --to markdown \
  > report/Illumina.merge_trimmomatic_stats.md
merge_trimmomatic_stats..f191694983c761cb01a5aaee661e4c3a.mugqic.done
chmod 755 $COMMAND
merge_trimmomatic_stats_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=01:00:0 --mem-per-cpu=4700M -N 1 -c 1 | grep "[0-9]" | cut -d\  -f4)
echo "$merge_trimmomatic_stats_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$merge_trimmomatic_stats_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: metrics
#-------------------------------------------------------------------------------
STEP=metrics
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: metrics_1_JOB_ID: metrics_report
#-------------------------------------------------------------------------------
JOB_NAME=metrics_report
JOB_DEPENDENCIES=
JOB_DONE=job_output/metrics/metrics_report.4c7c49455410c28d69d89cb1a36c1bbd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'metrics_report.4c7c49455410c28d69d89cb1a36c1bbd.mugqic.done' > $COMMAND
module purge && \
module load mugqic/pandoc/2.16.1 && \
module load mugqic/sambamba/0.8.0 && \
mkdir -p metrics
cp /dev/null metrics/SampleMetrics.tsv && \
declare -A samples_associative_array=(["U2OS_C1A"]="H3K27me3" ["U2OS_C1B"]="H3K27me3" ["U2OS_C1C"]="H3K27me3" ["U2OS_C54A"]="H3K27me3" ["U2OS_C54B"]="H3K27me3" ["U2OS_C54C"]="H3K27me3") && \
for sample in ${!samples_associative_array[@]}
do
  for mark_name in ${samples_associative_array[$sample]}
  do
    raw_flagstat_file=metrics/$sample/$mark_name/$sample.$mark_name.sorted.dup.flagstat
    filtered_flagstat_file=metrics/$sample/$mark_name/$sample.$mark_name.sorted.dup.filtered.flagstat
    bam_file=alignment/$sample/$mark_name/$sample.$mark_name.sorted.dup.filtered.bam
    raw_supplementarysecondary_reads=`bc <<< $(grep "secondary" $raw_flagstat_file | sed -e 's/ + [[:digit:]]* secondary.*//')+$(grep "supplementary" $raw_flagstat_file | sed -e 's/ + [[:digit:]]* supplementary.*//')`
    mapped_reads=`bc <<< $(grep "mapped (" $raw_flagstat_file | sed -e 's/ + [[:digit:]]* mapped (.*)//')-$raw_supplementarysecondary_reads`
    filtered_supplementarysecondary_reads=`bc <<< $(grep "secondary" $filtered_flagstat_file | sed -e 's/ + [[:digit:]]* secondary.*//')+$(grep "supplementary" $filtered_flagstat_file | sed -e 's/ + [[:digit:]]* supplementary.*//')`
    filtered_reads=`bc <<< $(grep "in total" $filtered_flagstat_file | sed -e 's/ + [[:digit:]]* in total .*//')-$filtered_supplementarysecondary_reads`
    filtered_mapped_reads=`bc <<< $(grep "mapped (" $filtered_flagstat_file | sed -e 's/ + [[:digit:]]* mapped (.*)//')-$filtered_supplementarysecondary_reads`
    filtered_mapped_rate=`echo "scale=4; 100*$filtered_mapped_reads/$filtered_reads" | bc -l`
    filtered_dup_reads=`grep "duplicates" $filtered_flagstat_file | sed -e 's/ + [[:digit:]]* duplicates$//'`
    filtered_dup_rate=`echo "scale=4; 100*$filtered_dup_reads/$filtered_mapped_reads" | bc -l`
    filtered_dedup_reads=`echo "$filtered_mapped_reads-$filtered_dup_reads" | bc -l`
    if [[ -s metrics/trimSampleTable.tsv ]]
      then
        raw_reads=$(grep -P "${sample}\t${mark_name}" metrics/trimSampleTable.tsv | cut -f 3)
        raw_trimmed_reads=`bc <<< $(grep "in total" $raw_flagstat_file | sed -e 's/ + [[:digit:]]* in total .*//')-$raw_supplementarysecondary_reads`
        mapped_reads_rate=`echo "scale=4; 100*$mapped_reads/$raw_trimmed_reads" | bc -l`
        raw_trimmed_rate=`echo "scale=4; 100*$raw_trimmed_reads/$raw_reads" | bc -l`
        filtered_rate=`echo "scale=4; 100*$filtered_reads/$raw_trimmed_reads" | bc -l`
      else
        raw_reads=`bc <<< $(grep "in total" $raw_flagstat_file | sed -e 's/ + [[:digit:]]* in total .*//')-$raw_supplementarysecondary_reads`
        raw_trimmed_reads="NULL"
        mapped_reads_rate=`echo "scale=4; 100*$mapped_reads/$raw_reads" | bc -l`
        raw_trimmed_rate="NULL"
        filtered_rate=`echo "scale=4; 100*$filtered_reads/$raw_reads" | bc -l`
    fi
    filtered_mito_reads=$(sambamba view -F "not duplicate" -c $bam_file chrM)
    filtered_mito_rate=$(echo "scale=4; 100*$filtered_mito_reads/$filtered_mapped_reads" | bc -l)
    echo -e "$sample\t$mark_name\t$raw_reads\t$raw_trimmed_reads\t$raw_trimmed_rate\t$mapped_reads\t$mapped_reads_rate\t$filtered_reads\t$filtered_rate\t$filtered_mapped_reads\t$filtered_mapped_rate\t$filtered_dup_reads\t$filtered_dup_rate\t$filtered_dedup_reads\t$filtered_mito_reads\t$filtered_mito_rate" >> metrics/SampleMetrics.tsv
  done
done && \
sed -i -e "1 i\Sample\tMark Name\tRaw Reads #\tRemaining Reads after Trimming #\tRemaining Reads after Trimming %\tAligned Trimmed Reads #\tAligned Trimmed Reads %\tRemaining Reads after Filtering #\tRemaining Reads after Filtering %\tAligned Filtered Reads #\tAligned Filtered Reads %\tDuplicate Reads #\tDuplicate Reads %\tFinal Aligned Reads # without Duplicates\tMitochondrial Reads #\tMitochondrial Reads %" metrics/SampleMetrics.tsv && \
mkdir -p report && \
cp metrics/SampleMetrics.tsv report/SampleMetrics.tsv && \
sample_table=`LC_NUMERIC=en_CA awk -F "	" '{OFS="|"; if (NR == 1) {$1 = $1; print $0; print "-----|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-----:"} else {$1 = $1; print $0}}' report/SampleMetrics.tsv` && \
pandoc --to=markdown \
  --template /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.metrics.md \
  --variable sample_table="$sample_table" \
  /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.metrics.md \
  > report/ChipSeq.metrics.md

metrics_report.4c7c49455410c28d69d89cb1a36c1bbd.mugqic.done
chmod 755 $COMMAND
metrics_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=3:00:00 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$metrics_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$metrics_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: qc_metrics
#-------------------------------------------------------------------------------
STEP=qc_metrics
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: qc_metrics_1_JOB_ID: qc_plots_R
#-------------------------------------------------------------------------------
JOB_NAME=qc_plots_R
JOB_DEPENDENCIES=
JOB_DONE=job_output/qc_metrics/qc_plots_R.260be2addda1b097a6aa3125886424f1.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'qc_plots_R.260be2addda1b097a6aa3125886424f1.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/R_Bioconductor/4.0.3_3.12 && \
mkdir -p graphs && \
Rscript $R_TOOLS/chipSeqGenerateQCMetrics.R \
  ../../files/genpipes_files/readsets.noInput.tsv \
  /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/ChIP/U2OS/out/01A_genpipes_chipseq && \
cp /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.qc_metrics.md report/ChipSeq.qc_metrics.md && \
declare -A samples_associative_array=(["U2OS_C1A"]="H3K27me3" ["U2OS_C1B"]="H3K27me3" ["U2OS_C1C"]="H3K27me3" ["U2OS_C54A"]="H3K27me3" ["U2OS_C54B"]="H3K27me3" ["U2OS_C54C"]="H3K27me3") && \
for sample in ${!samples_associative_array[@]}
do
  for mark_name in ${samples_associative_array[$sample]}
  do
    cp --parents graphs/${sample}.${mark_name}_QC_Metrics.ps report/
    convert -rotate 90 graphs/${sample}.${mark_name}_QC_Metrics.ps report/graphs/${sample}.${mark_name}_QC_Metrics.png
    echo -e "----\n\n![QC Metrics for Sample $sample and Mark $mark_name ([download high-res image](graphs/${sample}.${mark_name}_QC_Metrics.ps))](graphs/${sample}.${mark_name}_QC_Metrics.png)\n" >> report/ChipSeq.qc_metrics.md
  done
done
qc_plots_R.260be2addda1b097a6aa3125886424f1.mugqic.done
chmod 755 $COMMAND
qc_metrics_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 1 | grep "[0-9]" | cut -d\  -f4)
echo "$qc_metrics_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$qc_metrics_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: macs2_callpeak
#-------------------------------------------------------------------------------
STEP=macs2_callpeak
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_1_JOB_ID: macs2_callpeak.U2OS_C1A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak.U2OS_C1A.H3K27me3
JOB_DEPENDENCIES=
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak.U2OS_C1A.H3K27me3.126ddf13e22330ad5dc5438df93a911b.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak.U2OS_C1A.H3K27me3.126ddf13e22330ad5dc5438df93a911b.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MACS2/2.2.7.1 && \
mkdir -p peak_call/U2OS_C1A/H3K27me3 && \
touch peak_call/U2OS_C1A/H3K27me3 && \
macs2 callpeak --format BAMPE --broad --nomodel \
  --tempdir ${SLURM_TMPDIR} \
  --gsize 2509729011.2 \
  --treatment \
  alignment/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.bam \
  --nolambda \
  --name peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3 \
  >& peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.diag.macs.out
macs2_callpeak.U2OS_C1A.H3K27me3.126ddf13e22330ad5dc5438df93a911b.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_2_JOB_ID: macs2_callpeak_bigBed.U2OS_C1A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_bigBed.U2OS_C1A.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_1_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_bigBed.U2OS_C1A.H3K27me3.e3bd68c7b6210dcbad7c8efe49959bba.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_bigBed.U2OS_C1A.H3K27me3.e3bd68c7b6210dcbad7c8efe49959bba.mugqic.done' > $COMMAND
module purge && \
module load mugqic/ucsc/v346 && \
awk '{if ($9 > 1000) {$9 = 1000}; printf( "%s\t%s\t%s\t%s\t%0.f\n", $1,$2,$3,$4,$9)}' peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3_peaks.broadPeak > peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3_peaks.broadPeak.bed && \
bedToBigBed \
  peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3_peaks.broadPeak.bed \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.hg19/genome/Homo_sapiens.hg19.fa.fai \
  peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3_peaks.broadPeak.bb
macs2_callpeak_bigBed.U2OS_C1A.H3K27me3.e3bd68c7b6210dcbad7c8efe49959bba.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_3_JOB_ID: macs2_callpeak.U2OS_C1B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak.U2OS_C1B.H3K27me3
JOB_DEPENDENCIES=
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak.U2OS_C1B.H3K27me3.8cf22d6ecb5a14a3758fd4affb1c3a30.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak.U2OS_C1B.H3K27me3.8cf22d6ecb5a14a3758fd4affb1c3a30.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MACS2/2.2.7.1 && \
mkdir -p peak_call/U2OS_C1B/H3K27me3 && \
touch peak_call/U2OS_C1B/H3K27me3 && \
macs2 callpeak --format BAMPE --broad --nomodel \
  --tempdir ${SLURM_TMPDIR} \
  --gsize 2509729011.2 \
  --treatment \
  alignment/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.bam \
  --nolambda \
  --name peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3 \
  >& peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.diag.macs.out
macs2_callpeak.U2OS_C1B.H3K27me3.8cf22d6ecb5a14a3758fd4affb1c3a30.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_4_JOB_ID: macs2_callpeak_bigBed.U2OS_C1B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_bigBed.U2OS_C1B.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_3_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_bigBed.U2OS_C1B.H3K27me3.f8348eb1314cd66f9c898c6d2b8d61a5.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_bigBed.U2OS_C1B.H3K27me3.f8348eb1314cd66f9c898c6d2b8d61a5.mugqic.done' > $COMMAND
module purge && \
module load mugqic/ucsc/v346 && \
awk '{if ($9 > 1000) {$9 = 1000}; printf( "%s\t%s\t%s\t%s\t%0.f\n", $1,$2,$3,$4,$9)}' peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3_peaks.broadPeak > peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3_peaks.broadPeak.bed && \
bedToBigBed \
  peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3_peaks.broadPeak.bed \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.hg19/genome/Homo_sapiens.hg19.fa.fai \
  peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3_peaks.broadPeak.bb
macs2_callpeak_bigBed.U2OS_C1B.H3K27me3.f8348eb1314cd66f9c898c6d2b8d61a5.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_5_JOB_ID: macs2_callpeak.U2OS_C1C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak.U2OS_C1C.H3K27me3
JOB_DEPENDENCIES=
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak.U2OS_C1C.H3K27me3.ba29934f217f91b0dbd1d0a2cd1ba43f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak.U2OS_C1C.H3K27me3.ba29934f217f91b0dbd1d0a2cd1ba43f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MACS2/2.2.7.1 && \
mkdir -p peak_call/U2OS_C1C/H3K27me3 && \
touch peak_call/U2OS_C1C/H3K27me3 && \
macs2 callpeak --format BAMPE --broad --nomodel \
  --tempdir ${SLURM_TMPDIR} \
  --gsize 2509729011.2 \
  --treatment \
  alignment/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.bam \
  --nolambda \
  --name peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3 \
  >& peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.diag.macs.out
macs2_callpeak.U2OS_C1C.H3K27me3.ba29934f217f91b0dbd1d0a2cd1ba43f.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_6_JOB_ID: macs2_callpeak_bigBed.U2OS_C1C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_bigBed.U2OS_C1C.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_5_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_bigBed.U2OS_C1C.H3K27me3.6bffa72872f43aeebfeeb4aa5c2ac822.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_bigBed.U2OS_C1C.H3K27me3.6bffa72872f43aeebfeeb4aa5c2ac822.mugqic.done' > $COMMAND
module purge && \
module load mugqic/ucsc/v346 && \
awk '{if ($9 > 1000) {$9 = 1000}; printf( "%s\t%s\t%s\t%s\t%0.f\n", $1,$2,$3,$4,$9)}' peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3_peaks.broadPeak > peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3_peaks.broadPeak.bed && \
bedToBigBed \
  peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3_peaks.broadPeak.bed \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.hg19/genome/Homo_sapiens.hg19.fa.fai \
  peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3_peaks.broadPeak.bb
macs2_callpeak_bigBed.U2OS_C1C.H3K27me3.6bffa72872f43aeebfeeb4aa5c2ac822.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_7_JOB_ID: macs2_callpeak.U2OS_C54A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak.U2OS_C54A.H3K27me3
JOB_DEPENDENCIES=
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak.U2OS_C54A.H3K27me3.7535807a115e0fa071463b45f1149bc0.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak.U2OS_C54A.H3K27me3.7535807a115e0fa071463b45f1149bc0.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MACS2/2.2.7.1 && \
mkdir -p peak_call/U2OS_C54A/H3K27me3 && \
touch peak_call/U2OS_C54A/H3K27me3 && \
macs2 callpeak --format BAMPE --broad --nomodel \
  --tempdir ${SLURM_TMPDIR} \
  --gsize 2509729011.2 \
  --treatment \
  alignment/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.bam \
  --nolambda \
  --name peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3 \
  >& peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.diag.macs.out
macs2_callpeak.U2OS_C54A.H3K27me3.7535807a115e0fa071463b45f1149bc0.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_8_JOB_ID: macs2_callpeak_bigBed.U2OS_C54A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_bigBed.U2OS_C54A.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_7_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_bigBed.U2OS_C54A.H3K27me3.fbd6dc39a1e411efeb26856257ad52fd.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_bigBed.U2OS_C54A.H3K27me3.fbd6dc39a1e411efeb26856257ad52fd.mugqic.done' > $COMMAND
module purge && \
module load mugqic/ucsc/v346 && \
awk '{if ($9 > 1000) {$9 = 1000}; printf( "%s\t%s\t%s\t%s\t%0.f\n", $1,$2,$3,$4,$9)}' peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak > peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak.bed && \
bedToBigBed \
  peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak.bed \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.hg19/genome/Homo_sapiens.hg19.fa.fai \
  peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak.bb
macs2_callpeak_bigBed.U2OS_C54A.H3K27me3.fbd6dc39a1e411efeb26856257ad52fd.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_9_JOB_ID: macs2_callpeak.U2OS_C54B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak.U2OS_C54B.H3K27me3
JOB_DEPENDENCIES=
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak.U2OS_C54B.H3K27me3.a87b96fd3eed40dbaa7950b3faca709f.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak.U2OS_C54B.H3K27me3.a87b96fd3eed40dbaa7950b3faca709f.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MACS2/2.2.7.1 && \
mkdir -p peak_call/U2OS_C54B/H3K27me3 && \
touch peak_call/U2OS_C54B/H3K27me3 && \
macs2 callpeak --format BAMPE --broad --nomodel \
  --tempdir ${SLURM_TMPDIR} \
  --gsize 2509729011.2 \
  --treatment \
  alignment/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.bam \
  --nolambda \
  --name peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3 \
  >& peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.diag.macs.out
macs2_callpeak.U2OS_C54B.H3K27me3.a87b96fd3eed40dbaa7950b3faca709f.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_9_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_9_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_9_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_10_JOB_ID: macs2_callpeak_bigBed.U2OS_C54B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_bigBed.U2OS_C54B.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_9_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_bigBed.U2OS_C54B.H3K27me3.51b54d55bed5cd54eb32059b00488820.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_bigBed.U2OS_C54B.H3K27me3.51b54d55bed5cd54eb32059b00488820.mugqic.done' > $COMMAND
module purge && \
module load mugqic/ucsc/v346 && \
awk '{if ($9 > 1000) {$9 = 1000}; printf( "%s\t%s\t%s\t%s\t%0.f\n", $1,$2,$3,$4,$9)}' peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak > peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak.bed && \
bedToBigBed \
  peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak.bed \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.hg19/genome/Homo_sapiens.hg19.fa.fai \
  peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak.bb
macs2_callpeak_bigBed.U2OS_C54B.H3K27me3.51b54d55bed5cd54eb32059b00488820.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_10_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_10_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_10_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_11_JOB_ID: macs2_callpeak.U2OS_C54C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak.U2OS_C54C.H3K27me3
JOB_DEPENDENCIES=
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak.U2OS_C54C.H3K27me3.ce837dc89b72b55e17b908bbcb27f9f8.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak.U2OS_C54C.H3K27me3.ce837dc89b72b55e17b908bbcb27f9f8.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MACS2/2.2.7.1 && \
mkdir -p peak_call/U2OS_C54C/H3K27me3 && \
touch peak_call/U2OS_C54C/H3K27me3 && \
macs2 callpeak --format BAMPE --broad --nomodel \
  --tempdir ${SLURM_TMPDIR} \
  --gsize 2509729011.2 \
  --treatment \
  alignment/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.bam \
  --nolambda \
  --name peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3 \
  >& peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.diag.macs.out
macs2_callpeak.U2OS_C54C.H3K27me3.ce837dc89b72b55e17b908bbcb27f9f8.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_11_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_11_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_11_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_12_JOB_ID: macs2_callpeak_bigBed.U2OS_C54C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_bigBed.U2OS_C54C.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_11_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_bigBed.U2OS_C54C.H3K27me3.7f41fab2517a7c8e2116f92a440a25ee.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_bigBed.U2OS_C54C.H3K27me3.7f41fab2517a7c8e2116f92a440a25ee.mugqic.done' > $COMMAND
module purge && \
module load mugqic/ucsc/v346 && \
awk '{if ($9 > 1000) {$9 = 1000}; printf( "%s\t%s\t%s\t%s\t%0.f\n", $1,$2,$3,$4,$9)}' peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak > peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak.bed && \
bedToBigBed \
  peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak.bed \
  /cvmfs/soft.mugqic/CentOS6/genomes/species/Homo_sapiens.hg19/genome/Homo_sapiens.hg19.fa.fai \
  peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak.bb
macs2_callpeak_bigBed.U2OS_C54C.H3K27me3.7f41fab2517a7c8e2116f92a440a25ee.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_12_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_12_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_12_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: macs2_callpeak_13_JOB_ID: macs2_callpeak_report
#-------------------------------------------------------------------------------
JOB_NAME=macs2_callpeak_report
JOB_DEPENDENCIES=$macs2_callpeak_1_JOB_ID:$macs2_callpeak_3_JOB_ID:$macs2_callpeak_5_JOB_ID:$macs2_callpeak_7_JOB_ID:$macs2_callpeak_9_JOB_ID:$macs2_callpeak_11_JOB_ID
JOB_DONE=job_output/macs2_callpeak/macs2_callpeak_report.ff156347436f4a442bbc0a209e3574cc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'macs2_callpeak_report.ff156347436f4a442bbc0a209e3574cc.mugqic.done' > $COMMAND
mkdir -p report && \
cp /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.macs2_callpeak.md report/ && \
declare -A samples_associative_array=(["U2OS_C1A"]="H3K27me3" ["U2OS_C1B"]="H3K27me3" ["U2OS_C1C"]="H3K27me3" ["U2OS_C54A"]="H3K27me3" ["U2OS_C54B"]="H3K27me3" ["U2OS_C54C"]="H3K27me3") && \
for sample in ${!samples_associative_array[@]}
do
  for mark_name in ${samples_associative_array[$sample]}
  do
    cp -a --parents peak_call/$sample/$mark_name/ report/ && \
    echo -e "* [Peak Calls File for Sample $sample and Mark $mark_name](peak_call/$sample/$mark_name/${sample}.${mark_name}_peaks.xls)" >> report/ChipSeq.macs2_callpeak.md
  done
done
macs2_callpeak_report.ff156347436f4a442bbc0a209e3574cc.mugqic.done
chmod 755 $COMMAND
macs2_callpeak_13_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$macs2_callpeak_13_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$macs2_callpeak_13_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: homer_annotate_peaks
#-------------------------------------------------------------------------------
STEP=homer_annotate_peaks
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_1_JOB_ID: homer_annotate_peaks.U2OS_C1A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks.U2OS_C1A.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_1_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks.U2OS_C1A.H3K27me3.7da6af4c06be3c9bb9a08132e83e3697.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks.U2OS_C1A.H3K27me3.7da6af4c06be3c9bb9a08132e83e3697.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/homer/4.11 mugqic/mugqic_tools/2.8.1 && \
mkdir -p annotation/U2OS_C1A/H3K27me3 && \
touch annotation/U2OS_C1A/H3K27me3 && \
annotatePeaks.pl \
    peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3_peaks.broadPeak \
    hg19 \
    -gsize hg19 \
    -cons -CpG \
    -go annotation/U2OS_C1A/H3K27me3 \
    -genomeOntology annotation/U2OS_C1A/H3K27me3 \
    > annotation/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.annotated.csv && \
    perl -MReadMetrics -e 'ReadMetrics::parseHomerAnnotations(
      "annotation/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.annotated.csv",
      "annotation/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3",
      -2000,
      -10000,
      -10000,
      -100000,
      100000
    )'
homer_annotate_peaks.U2OS_C1A.H3K27me3.7da6af4c06be3c9bb9a08132e83e3697.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 4 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_2_JOB_ID: homer_annotate_peaks.U2OS_C1B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks.U2OS_C1B.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_3_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks.U2OS_C1B.H3K27me3.57868af66608c3fcede45267ef3d7537.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks.U2OS_C1B.H3K27me3.57868af66608c3fcede45267ef3d7537.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/homer/4.11 mugqic/mugqic_tools/2.8.1 && \
mkdir -p annotation/U2OS_C1B/H3K27me3 && \
touch annotation/U2OS_C1B/H3K27me3 && \
annotatePeaks.pl \
    peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3_peaks.broadPeak \
    hg19 \
    -gsize hg19 \
    -cons -CpG \
    -go annotation/U2OS_C1B/H3K27me3 \
    -genomeOntology annotation/U2OS_C1B/H3K27me3 \
    > annotation/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.annotated.csv && \
    perl -MReadMetrics -e 'ReadMetrics::parseHomerAnnotations(
      "annotation/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.annotated.csv",
      "annotation/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3",
      -2000,
      -10000,
      -10000,
      -100000,
      100000
    )'
homer_annotate_peaks.U2OS_C1B.H3K27me3.57868af66608c3fcede45267ef3d7537.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 4 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_3_JOB_ID: homer_annotate_peaks.U2OS_C1C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks.U2OS_C1C.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_5_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks.U2OS_C1C.H3K27me3.78dbf6595e01267647f0884502c18902.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks.U2OS_C1C.H3K27me3.78dbf6595e01267647f0884502c18902.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/homer/4.11 mugqic/mugqic_tools/2.8.1 && \
mkdir -p annotation/U2OS_C1C/H3K27me3 && \
touch annotation/U2OS_C1C/H3K27me3 && \
annotatePeaks.pl \
    peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3_peaks.broadPeak \
    hg19 \
    -gsize hg19 \
    -cons -CpG \
    -go annotation/U2OS_C1C/H3K27me3 \
    -genomeOntology annotation/U2OS_C1C/H3K27me3 \
    > annotation/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.annotated.csv && \
    perl -MReadMetrics -e 'ReadMetrics::parseHomerAnnotations(
      "annotation/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.annotated.csv",
      "annotation/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3",
      -2000,
      -10000,
      -10000,
      -100000,
      100000
    )'
homer_annotate_peaks.U2OS_C1C.H3K27me3.78dbf6595e01267647f0884502c18902.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 4 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_4_JOB_ID: homer_annotate_peaks.U2OS_C54A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks.U2OS_C54A.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_7_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks.U2OS_C54A.H3K27me3.e2f7bf26d21839f6dbe4a96cbf310485.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks.U2OS_C54A.H3K27me3.e2f7bf26d21839f6dbe4a96cbf310485.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/homer/4.11 mugqic/mugqic_tools/2.8.1 && \
mkdir -p annotation/U2OS_C54A/H3K27me3 && \
touch annotation/U2OS_C54A/H3K27me3 && \
annotatePeaks.pl \
    peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak \
    hg19 \
    -gsize hg19 \
    -cons -CpG \
    -go annotation/U2OS_C54A/H3K27me3 \
    -genomeOntology annotation/U2OS_C54A/H3K27me3 \
    > annotation/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.annotated.csv && \
    perl -MReadMetrics -e 'ReadMetrics::parseHomerAnnotations(
      "annotation/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.annotated.csv",
      "annotation/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3",
      -2000,
      -10000,
      -10000,
      -100000,
      100000
    )'
homer_annotate_peaks.U2OS_C54A.H3K27me3.e2f7bf26d21839f6dbe4a96cbf310485.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 4 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_5_JOB_ID: homer_annotate_peaks.U2OS_C54B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks.U2OS_C54B.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_9_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks.U2OS_C54B.H3K27me3.b45b44dab1fe69601f5692063ccd885a.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks.U2OS_C54B.H3K27me3.b45b44dab1fe69601f5692063ccd885a.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/homer/4.11 mugqic/mugqic_tools/2.8.1 && \
mkdir -p annotation/U2OS_C54B/H3K27me3 && \
touch annotation/U2OS_C54B/H3K27me3 && \
annotatePeaks.pl \
    peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak \
    hg19 \
    -gsize hg19 \
    -cons -CpG \
    -go annotation/U2OS_C54B/H3K27me3 \
    -genomeOntology annotation/U2OS_C54B/H3K27me3 \
    > annotation/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.annotated.csv && \
    perl -MReadMetrics -e 'ReadMetrics::parseHomerAnnotations(
      "annotation/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.annotated.csv",
      "annotation/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3",
      -2000,
      -10000,
      -10000,
      -100000,
      100000
    )'
homer_annotate_peaks.U2OS_C54B.H3K27me3.b45b44dab1fe69601f5692063ccd885a.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 4 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_6_JOB_ID: homer_annotate_peaks.U2OS_C54C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks.U2OS_C54C.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_11_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks.U2OS_C54C.H3K27me3.c6d594e6b0eef77a9028ae25a69ba26d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks.U2OS_C54C.H3K27me3.c6d594e6b0eef77a9028ae25a69ba26d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/perl/5.22.1 mugqic/homer/4.11 mugqic/mugqic_tools/2.8.1 && \
mkdir -p annotation/U2OS_C54C/H3K27me3 && \
touch annotation/U2OS_C54C/H3K27me3 && \
annotatePeaks.pl \
    peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak \
    hg19 \
    -gsize hg19 \
    -cons -CpG \
    -go annotation/U2OS_C54C/H3K27me3 \
    -genomeOntology annotation/U2OS_C54C/H3K27me3 \
    > annotation/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.annotated.csv && \
    perl -MReadMetrics -e 'ReadMetrics::parseHomerAnnotations(
      "annotation/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.annotated.csv",
      "annotation/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3",
      -2000,
      -10000,
      -10000,
      -100000,
      100000
    )'
homer_annotate_peaks.U2OS_C54C.H3K27me3.c6d594e6b0eef77a9028ae25a69ba26d.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=12:00:0 --mem-per-cpu=4700M -N 1 -c 4 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: homer_annotate_peaks_7_JOB_ID: homer_annotate_peaks_report
#-------------------------------------------------------------------------------
JOB_NAME=homer_annotate_peaks_report
JOB_DEPENDENCIES=$homer_annotate_peaks_1_JOB_ID:$homer_annotate_peaks_2_JOB_ID:$homer_annotate_peaks_3_JOB_ID:$homer_annotate_peaks_4_JOB_ID:$homer_annotate_peaks_5_JOB_ID:$homer_annotate_peaks_6_JOB_ID
JOB_DONE=job_output/homer_annotate_peaks/homer_annotate_peaks_report.de911bdf5f28c7fed9bd60c442af2b70.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'homer_annotate_peaks_report.de911bdf5f28c7fed9bd60c442af2b70.mugqic.done' > $COMMAND
    mkdir -p report/annotation/ && \
    cp /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.homer_annotate_peaks.md report && \
    declare -A samples_associative_array=(["U2OS_C1A"]="H3K27me3" ["U2OS_C1B"]="H3K27me3" ["U2OS_C1C"]="H3K27me3" ["U2OS_C54A"]="H3K27me3" ["U2OS_C54B"]="H3K27me3" ["U2OS_C54C"]="H3K27me3") && \
    for sample in ${!samples_associative_array[@]}
    do
      for mark_name in ${samples_associative_array[$sample]}
      do
        rsync -rvP annotation/$sample report/annotation/ && \
        echo -e "* [Gene Annotations for Sample $sample and Mark $mark_name](annotation/$sample/$mark_name/${sample}.${mark_name}.annotated.csv)\n* [HOMER Gene Ontology Annotations for Sample $sample and Mark $mark_name](annotation/$sample/$mark_name/geneOntology.html)\n* [HOMER Genome Ontology Annotations for Sample $sample and Mark $mark_name](annotation/$sample/$mark_name/GenomeOntology.html)" >> report/ChipSeq.homer_annotate_peaks.md
      done
    done
homer_annotate_peaks_report.de911bdf5f28c7fed9bd60c442af2b70.mugqic.done
chmod 755 $COMMAND
homer_annotate_peaks_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=04:00:0 --mem-per-cpu=4700M -N 1 -c 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$homer_annotate_peaks_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$homer_annotate_peaks_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: annotation_graphs
#-------------------------------------------------------------------------------
STEP=annotation_graphs
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: annotation_graphs_1_JOB_ID: annotation_graphs
#-------------------------------------------------------------------------------
JOB_NAME=annotation_graphs
JOB_DEPENDENCIES=
JOB_DONE=job_output/annotation_graphs/annotation_graphs.a8cd2b76914c0f4d0a5608772aadcc1e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'annotation_graphs.a8cd2b76914c0f4d0a5608772aadcc1e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/R_Bioconductor/4.0.3_3.12 mugqic/pandoc/2.16.1 && \
    cp /dev/null annotation/peak_stats_AllSamples.csv && \
    mkdir -p graphs && \
    Rscript $R_TOOLS/chipSeqgenerateAnnotationGraphs.R \
      ../../files/genpipes_files/readsets.noInput.tsv \
      /lustre06/project/6004736/alvann/from_narval/220318_EZHIP/ChIP/U2OS/out/01A_genpipes_chipseq && \
    declare -A samples_associative_array=(["U2OS_C1A"]="" ["U2OS_C1B"]="" ["U2OS_C1C"]="" ["U2OS_C54A"]="" ["U2OS_C54B"]="" ["U2OS_C54C"]="") && \
    for sample in ${!samples_associative_array[@]}
    do
        header=$(head -n 1 annotation/$sample/peak_stats.csv)
        tail -n+2 annotation/$sample/peak_stats.csv >> annotation/peak_stats_AllSamples.csv
    done && \
    sed -i -e "1 i\\$header" annotation/peak_stats_AllSamples.csv && \
    mkdir -p report/annotation/$sample && \
    cp annotation/peak_stats_AllSamples.csv report/annotation/peak_stats_AllSamples.csv && \
    peak_stats_table=`LC_NUMERIC=en_CA awk -F "," '{OFS="|"; if (NR == 1) {$1 = $1; print $0; print "-----|-----|-----:|-----:|-----:|-----:|-----:|-----:"} else {print $1, $2,  sprintf("%\47d", $3), $4, sprintf("%\47.1f", $5), sprintf("%\47.1f", $6), sprintf("%\47.1f", $7), sprintf("%\47.1f", $8)}}' annotation/peak_stats_AllSamples.csv`
    pandoc --to=markdown \
        --template /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.annotation_graphs.md \
        --variable peak_stats_table="$peak_stats_table" \
        --variable proximal_distance="2" \
        --variable distal_distance="10" \
        --variable distance5d_lower="10" \
        --variable distance5d_upper="100" \
        --variable gene_desert_size="100" \
        /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.annotation_graphs.md \
        > report/ChipSeq.annotation_graphs.md && \
    for sample in ${!samples_associative_array[@]}
    do
      cp annotation/$sample/peak_stats.csv report/annotation/$sample/peak_stats.csv && \
      for mark_name in ${samples_associative_array[$sample]}
      do
        cp --parents graphs/${sample}.${mark_name}_Misc_Graphs.ps report/
        convert -rotate 90 graphs/${sample}.${mark_name}_Misc_Graphs.ps report/graphs/${sample}.${mark_name}_Misc_Graphs.png
        echo -e "----\n\n![Annotation Statistics for Sample $sample and Mark $mark_name ([download high-res image](graphs/${sample}.${mark_name}_Misc_Graphs.ps))](graphs/${sample}.${mark_name}_Misc_Graphs.png)\n" >> report/ChipSeq.annotation_graphs.md
      done
    done
annotation_graphs.a8cd2b76914c0f4d0a5608772aadcc1e.mugqic.done
chmod 755 $COMMAND
annotation_graphs_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=24:00:00 --mem-per-cpu=4700M -c 1 -N 1 | grep "[0-9]" | cut -d\  -f4)
echo "$annotation_graphs_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$annotation_graphs_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: run_spp
#-------------------------------------------------------------------------------
STEP=run_spp
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: run_spp_1_JOB_ID: run_spp_report
#-------------------------------------------------------------------------------
JOB_NAME=run_spp_report
JOB_DEPENDENCIES=
JOB_DONE=job_output/run_spp/run_spp_report.13ce21f48a4bb7941bf5e2019ae7ff6c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'run_spp_report.13ce21f48a4bb7941bf5e2019ae7ff6c.mugqic.done' > $COMMAND
    declare -A samples_associative_array=(["U2OS_C1A"]="H3K27me3" ["U2OS_C1B"]="H3K27me3" ["U2OS_C1C"]="H3K27me3" ["U2OS_C54A"]="H3K27me3" ["U2OS_C54B"]="H3K27me3" ["U2OS_C54C"]="H3K27me3") && \
    for sample in ${!samples_associative_array[@]}
    do
      echo -e "Filename\tnumReads\testFragLen\tcorr_estFragLen\tPhantomPeak\tcorr_phantomPeak\targmin_corr\tmin_corr\tNormalized SCC (NSC)\tRelative SCC (RSC)\tQualityTag)" > ihec_metrics/${sample}/${sample}.crosscor
      for mark_name in ${samples_associative_array[$sample]}
      do
        cat ihec_metrics/${sample}/${mark_name}/${sample}.${mark_name}.crosscor >> ihec_metrics/${sample}/${sample}.crosscor
      done
    done
run_spp_report.13ce21f48a4bb7941bf5e2019ae7ff6c.mugqic.done
chmod 755 $COMMAND
run_spp_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=00:10:00 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$run_spp_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$run_spp_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: differential_binding
#-------------------------------------------------------------------------------
STEP=differential_binding
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: differential_binding_1_JOB_ID: differential_binding.diffbind.contrast_Contrast_EZHIP_H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=differential_binding.diffbind.contrast_Contrast_EZHIP_H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_1_JOB_ID:$macs2_callpeak_3_JOB_ID:$macs2_callpeak_5_JOB_ID:$macs2_callpeak_7_JOB_ID:$macs2_callpeak_9_JOB_ID:$macs2_callpeak_11_JOB_ID
JOB_DONE=job_output/differential_binding/differential_binding.diffbind.contrast_Contrast_EZHIP_H3K27me3.4ced0510a21ee4beabdd4f9274795a65.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'differential_binding.diffbind.contrast_Contrast_EZHIP_H3K27me3.4ced0510a21ee4beabdd4f9274795a65.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/R_Bioconductor/4.0.3_3.12 && \
        mkdir -p differential_binding &&
cp $R_TOOLS/DiffBind.R differential_binding/diffbind_Contrast_EZHIP_H3K27me3_DBA_DESEQ2_dba.R &&
Rscript -e 'cur_dir=getwd();library(knitr);rmarkdown::render("differential_binding/diffbind_Contrast_EZHIP_H3K27me3_DBA_DESEQ2_dba.R",params=list(cur_wd=cur_dir,d="../../files/genpipes_files/design.tsv",r="../../files/genpipes_files/readsets.noInput.tsv",c="Contrast_EZHIP_H3K27me3",o="differential_binding/diffbind_Contrast_EZHIP_H3K27me3_DBA_DESEQ2_dba.txt",b="alignment",p="peak_call",dir="differential_binding",minOverlap="2",minMembers="2",method="DBA_DESEQ2"),output_file=file.path(cur_dir,"differential_binding/diffbind_Contrast_EZHIP_H3K27me3_DBA_DESEQ2_dba.html"));' &&
rm differential_binding/diffbind_Contrast_EZHIP_H3K27me3_DBA_DESEQ2_dba.R
differential_binding.diffbind.contrast_Contrast_EZHIP_H3K27me3.4ced0510a21ee4beabdd4f9274795a65.mugqic.done
chmod 755 $COMMAND
differential_binding_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=3:00:00 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$differential_binding_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$differential_binding_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: ihec_metrics
#-------------------------------------------------------------------------------
STEP=ihec_metrics
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_1_JOB_ID: IHEC_chipseq_metrics.U2OS_C1A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=IHEC_chipseq_metrics.U2OS_C1A.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_2_JOB_ID:$run_spp_1_JOB_ID
JOB_DONE=job_output/ihec_metrics/IHEC_chipseq_metrics.U2OS_C1A.H3K27me3.ba0459a708dfa981a07aab89f8e1d9eb.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'IHEC_chipseq_metrics.U2OS_C1A.H3K27me3.ba0459a708dfa981a07aab89f8e1d9eb.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/samtools/1.12 mugqic/sambamba/0.8.0 mugqic/deepTools/3.5.0 && \
mkdir -p ihec_metrics/U2OS_C1A && \
touch ihec_metrics/U2OS_C1A && \
IHEC_chipseq_metrics_max.sh \
    -d alignment/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.bam \
    -i None \
    -s U2OS_C1A \
    -j no_input \
    -t broad \
    -c H3K27me3 \
    -n 6 \
    -p peak_call/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3_peaks.broadPeak.bed \
    -o ihec_metrics/U2OS_C1A \
    -a hg19
IHEC_chipseq_metrics.U2OS_C1A.H3K27me3.ba0459a708dfa981a07aab89f8e1d9eb.mugqic.done
chmod 755 $COMMAND
ihec_metrics_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=8:00:0 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_2_JOB_ID: IHEC_chipseq_metrics.U2OS_C1B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=IHEC_chipseq_metrics.U2OS_C1B.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_4_JOB_ID:$run_spp_1_JOB_ID
JOB_DONE=job_output/ihec_metrics/IHEC_chipseq_metrics.U2OS_C1B.H3K27me3.bb6c25e85824cc09782cc01190d9c300.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'IHEC_chipseq_metrics.U2OS_C1B.H3K27me3.bb6c25e85824cc09782cc01190d9c300.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/samtools/1.12 mugqic/sambamba/0.8.0 mugqic/deepTools/3.5.0 && \
mkdir -p ihec_metrics/U2OS_C1B && \
touch ihec_metrics/U2OS_C1B && \
IHEC_chipseq_metrics_max.sh \
    -d alignment/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.bam \
    -i None \
    -s U2OS_C1B \
    -j no_input \
    -t broad \
    -c H3K27me3 \
    -n 6 \
    -p peak_call/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3_peaks.broadPeak.bed \
    -o ihec_metrics/U2OS_C1B \
    -a hg19
IHEC_chipseq_metrics.U2OS_C1B.H3K27me3.bb6c25e85824cc09782cc01190d9c300.mugqic.done
chmod 755 $COMMAND
ihec_metrics_2_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=8:00:0 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_2_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_2_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_3_JOB_ID: IHEC_chipseq_metrics.U2OS_C1C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=IHEC_chipseq_metrics.U2OS_C1C.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_6_JOB_ID:$run_spp_1_JOB_ID
JOB_DONE=job_output/ihec_metrics/IHEC_chipseq_metrics.U2OS_C1C.H3K27me3.5806d68cbc9ceed4be69e2a89b4afb10.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'IHEC_chipseq_metrics.U2OS_C1C.H3K27me3.5806d68cbc9ceed4be69e2a89b4afb10.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/samtools/1.12 mugqic/sambamba/0.8.0 mugqic/deepTools/3.5.0 && \
mkdir -p ihec_metrics/U2OS_C1C && \
touch ihec_metrics/U2OS_C1C && \
IHEC_chipseq_metrics_max.sh \
    -d alignment/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.bam \
    -i None \
    -s U2OS_C1C \
    -j no_input \
    -t broad \
    -c H3K27me3 \
    -n 6 \
    -p peak_call/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3_peaks.broadPeak.bed \
    -o ihec_metrics/U2OS_C1C \
    -a hg19
IHEC_chipseq_metrics.U2OS_C1C.H3K27me3.5806d68cbc9ceed4be69e2a89b4afb10.mugqic.done
chmod 755 $COMMAND
ihec_metrics_3_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=8:00:0 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_3_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_3_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_4_JOB_ID: IHEC_chipseq_metrics.U2OS_C54A.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=IHEC_chipseq_metrics.U2OS_C54A.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_8_JOB_ID:$run_spp_1_JOB_ID
JOB_DONE=job_output/ihec_metrics/IHEC_chipseq_metrics.U2OS_C54A.H3K27me3.263a52bbaeb595e2409fba195c7e09db.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'IHEC_chipseq_metrics.U2OS_C54A.H3K27me3.263a52bbaeb595e2409fba195c7e09db.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/samtools/1.12 mugqic/sambamba/0.8.0 mugqic/deepTools/3.5.0 && \
mkdir -p ihec_metrics/U2OS_C54A && \
touch ihec_metrics/U2OS_C54A && \
IHEC_chipseq_metrics_max.sh \
    -d alignment/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.bam \
    -i None \
    -s U2OS_C54A \
    -j no_input \
    -t broad \
    -c H3K27me3 \
    -n 6 \
    -p peak_call/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3_peaks.broadPeak.bed \
    -o ihec_metrics/U2OS_C54A \
    -a hg19
IHEC_chipseq_metrics.U2OS_C54A.H3K27me3.263a52bbaeb595e2409fba195c7e09db.mugqic.done
chmod 755 $COMMAND
ihec_metrics_4_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=8:00:0 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_4_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_4_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_5_JOB_ID: IHEC_chipseq_metrics.U2OS_C54B.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=IHEC_chipseq_metrics.U2OS_C54B.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_10_JOB_ID:$run_spp_1_JOB_ID
JOB_DONE=job_output/ihec_metrics/IHEC_chipseq_metrics.U2OS_C54B.H3K27me3.400cd183f82351b03baeb226f5c00376.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'IHEC_chipseq_metrics.U2OS_C54B.H3K27me3.400cd183f82351b03baeb226f5c00376.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/samtools/1.12 mugqic/sambamba/0.8.0 mugqic/deepTools/3.5.0 && \
mkdir -p ihec_metrics/U2OS_C54B && \
touch ihec_metrics/U2OS_C54B && \
IHEC_chipseq_metrics_max.sh \
    -d alignment/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.bam \
    -i None \
    -s U2OS_C54B \
    -j no_input \
    -t broad \
    -c H3K27me3 \
    -n 6 \
    -p peak_call/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3_peaks.broadPeak.bed \
    -o ihec_metrics/U2OS_C54B \
    -a hg19
IHEC_chipseq_metrics.U2OS_C54B.H3K27me3.400cd183f82351b03baeb226f5c00376.mugqic.done
chmod 755 $COMMAND
ihec_metrics_5_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=8:00:0 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_5_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_5_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_6_JOB_ID: IHEC_chipseq_metrics.U2OS_C54C.H3K27me3
#-------------------------------------------------------------------------------
JOB_NAME=IHEC_chipseq_metrics.U2OS_C54C.H3K27me3
JOB_DEPENDENCIES=$macs2_callpeak_12_JOB_ID:$run_spp_1_JOB_ID
JOB_DONE=job_output/ihec_metrics/IHEC_chipseq_metrics.U2OS_C54C.H3K27me3.ea97429f3a4663c15c386c5937cf412e.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'IHEC_chipseq_metrics.U2OS_C54C.H3K27me3.ea97429f3a4663c15c386c5937cf412e.mugqic.done' > $COMMAND
module purge && \
module load mugqic/mugqic_tools/2.8.1 mugqic/samtools/1.12 mugqic/sambamba/0.8.0 mugqic/deepTools/3.5.0 && \
mkdir -p ihec_metrics/U2OS_C54C && \
touch ihec_metrics/U2OS_C54C && \
IHEC_chipseq_metrics_max.sh \
    -d alignment/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.bam \
    -i None \
    -s U2OS_C54C \
    -j no_input \
    -t broad \
    -c H3K27me3 \
    -n 6 \
    -p peak_call/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3_peaks.broadPeak.bed \
    -o ihec_metrics/U2OS_C54C \
    -a hg19
IHEC_chipseq_metrics.U2OS_C54C.H3K27me3.ea97429f3a4663c15c386c5937cf412e.mugqic.done
chmod 755 $COMMAND
ihec_metrics_6_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=8:00:0 --mem-per-cpu=4700M -N 1 -c 5 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_6_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_6_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_7_JOB_ID: merge_ihec_metrics
#-------------------------------------------------------------------------------
JOB_NAME=merge_ihec_metrics
JOB_DEPENDENCIES=$ihec_metrics_1_JOB_ID:$ihec_metrics_2_JOB_ID:$ihec_metrics_3_JOB_ID:$ihec_metrics_4_JOB_ID:$ihec_metrics_5_JOB_ID:$ihec_metrics_6_JOB_ID
JOB_DONE=job_output/ihec_metrics/merge_ihec_metrics.16b422d837b3831d198115bb528afadc.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_ihec_metrics.16b422d837b3831d198115bb528afadc.mugqic.done' > $COMMAND
    cp /dev/null ihec_metrics/IHEC_chipseq_metrics_AllSamples.tsv && \
    for sample in ihec_metrics/U2OS_C1A/H3K27me3/IHEC_chipseq_metrics.U2OS_C1A.H3K27me3.tsv ihec_metrics/U2OS_C1B/H3K27me3/IHEC_chipseq_metrics.U2OS_C1B.H3K27me3.tsv ihec_metrics/U2OS_C1C/H3K27me3/IHEC_chipseq_metrics.U2OS_C1C.H3K27me3.tsv ihec_metrics/U2OS_C54A/H3K27me3/IHEC_chipseq_metrics.U2OS_C54A.H3K27me3.tsv ihec_metrics/U2OS_C54B/H3K27me3/IHEC_chipseq_metrics.U2OS_C54B.H3K27me3.tsv ihec_metrics/U2OS_C54C/H3K27me3/IHEC_chipseq_metrics.U2OS_C54C.H3K27me3.tsv
    do
        header=$(head -n 1 $sample | cut -f -3,5-17,30-33,35,37,39-)
        tail -n 1 $sample | cut -f -3,5-17,30-33,35,37,39- >> ihec_metrics/IHEC_chipseq_metrics_AllSamples.tsv
    done && \
    sample_name=`tail -n 1 $sample | cut -f 1` && \
    input_name=`tail -n 1 $sample | cut -f 4` && \
    input_chip_type="NA" && \
    genome_assembly=`tail -n 1 $sample | cut -f 5` && \
    input_core=`tail -n 1 $sample | cut -f 18-29` && \
    input_nsc=`tail -n 1 $sample | cut -f 34` && \
    input_rsc=`tail -n 1 $sample | cut -f 36` && \
    input_quality=`tail -n 1 $sample | cut -f 38` && \
    if [[ $input_name != "no_input" ]]
      then
        echo -e "${sample_name}\t${input_name}\t${input_chip_type}\t${genome_assembly}\t${input_core}\tNA\tNA\tNA\t${input_nsc}\t${input_rsc}\t${input_quality}\tNA\tNA" >> ihec_metrics/IHEC_chipseq_metrics_AllSamples.tsv
    fi && \
    sed -i -e "1 i\\$header" ihec_metrics/IHEC_chipseq_metrics_AllSamples.tsv
merge_ihec_metrics.16b422d837b3831d198115bb528afadc.mugqic.done
chmod 755 $COMMAND
ihec_metrics_7_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=1:00:0 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_7_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_7_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# JOB: ihec_metrics_8_JOB_ID: merge_ihec_metrics_report
#-------------------------------------------------------------------------------
JOB_NAME=merge_ihec_metrics_report
JOB_DEPENDENCIES=$ihec_metrics_7_JOB_ID
JOB_DONE=job_output/ihec_metrics/merge_ihec_metrics_report.f409b6f43331e057e41a880018aebb7c.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'merge_ihec_metrics_report.f409b6f43331e057e41a880018aebb7c.mugqic.done' > $COMMAND
module purge && \
module load mugqic/pandoc/2.16.1 && \
    mkdir -p report && \
    cp ihec_metrics/IHEC_chipseq_metrics_AllSamples.tsv report/IHEC_chipseq_metrics_AllSamples.tsv && \
    pandoc --to=markdown \
      --template /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.ihec_metrics.md \
      --variable ihec_metrics_merged_table="IHEC_chipseq_metrics_AllSamples.tsv" \
      /cvmfs/soft.mugqic/CentOS6/software/genpipes/genpipes-3.6.2/bfx/report/ChipSeq.ihec_metrics.md \
      > report/ChipSeq.ihec_metrics.md
merge_ihec_metrics_report.f409b6f43331e057e41a880018aebb7c.mugqic.done
chmod 755 $COMMAND
ihec_metrics_8_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=1:00:0 --mem-per-cpu=4700M -c 1 -N 1 --depend=afterok:$JOB_DEPENDENCIES | grep "[0-9]" | cut -d\  -f4)
echo "$ihec_metrics_8_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$ihec_metrics_8_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# STEP: multiqc_report
#-------------------------------------------------------------------------------
STEP=multiqc_report
mkdir -p $JOB_OUTPUT_DIR/$STEP

#-------------------------------------------------------------------------------
# JOB: multiqc_report_1_JOB_ID: multiqc_report
#-------------------------------------------------------------------------------
JOB_NAME=multiqc_report
JOB_DEPENDENCIES=
JOB_DONE=job_output/multiqc_report/multiqc_report.6550178a518572d2822660a07b6aa79d.mugqic.done
JOB_OUTPUT_RELATIVE_PATH=$STEP/${JOB_NAME}_$TIMESTAMP.o
JOB_OUTPUT=$JOB_OUTPUT_DIR/$JOB_OUTPUT_RELATIVE_PATH
COMMAND=$JOB_OUTPUT_DIR/$STEP/${JOB_NAME}_$TIMESTAMP.sh
cat << 'multiqc_report.6550178a518572d2822660a07b6aa79d.mugqic.done' > $COMMAND
module purge && \
module load mugqic/python/3.7.3 mugqic/MultiQC/1.9 && \
multiqc -f  \
 \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.base_distribution_by_cycle.pdf  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.alignment_summary_metrics  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_histogram.pdf  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_metrics  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle_metrics  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle.pdf  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution_metrics  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution.pdf  \
  metrics/U2OS_C1A/H3K27me3/U2OS_C1A.H3K27me3.sorted.dup.filtered.flagstat  \
  tags/U2OS_C1A/U2OS_C1A.H3K27me3/tagGCcontent.txt  \
  tags/U2OS_C1A/U2OS_C1A.H3K27me3/genomeGCcontent.txt  \
  tags/U2OS_C1A/U2OS_C1A.H3K27me3/tagLengthDistribution.txt  \
  tags/U2OS_C1A/U2OS_C1A.H3K27me3/tagInfo.txt  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.base_distribution_by_cycle.pdf  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.alignment_summary_metrics  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_histogram.pdf  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_metrics  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle_metrics  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle.pdf  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution_metrics  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution.pdf  \
  metrics/U2OS_C1B/H3K27me3/U2OS_C1B.H3K27me3.sorted.dup.filtered.flagstat  \
  tags/U2OS_C1B/U2OS_C1B.H3K27me3/tagGCcontent.txt  \
  tags/U2OS_C1B/U2OS_C1B.H3K27me3/genomeGCcontent.txt  \
  tags/U2OS_C1B/U2OS_C1B.H3K27me3/tagLengthDistribution.txt  \
  tags/U2OS_C1B/U2OS_C1B.H3K27me3/tagInfo.txt  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.base_distribution_by_cycle.pdf  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.alignment_summary_metrics  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_histogram.pdf  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_metrics  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle_metrics  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle.pdf  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution_metrics  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution.pdf  \
  metrics/U2OS_C1C/H3K27me3/U2OS_C1C.H3K27me3.sorted.dup.filtered.flagstat  \
  tags/U2OS_C1C/U2OS_C1C.H3K27me3/tagGCcontent.txt  \
  tags/U2OS_C1C/U2OS_C1C.H3K27me3/genomeGCcontent.txt  \
  tags/U2OS_C1C/U2OS_C1C.H3K27me3/tagLengthDistribution.txt  \
  tags/U2OS_C1C/U2OS_C1C.H3K27me3/tagInfo.txt  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.base_distribution_by_cycle.pdf  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.alignment_summary_metrics  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_histogram.pdf  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_metrics  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle_metrics  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle.pdf  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution_metrics  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution.pdf  \
  metrics/U2OS_C54A/H3K27me3/U2OS_C54A.H3K27me3.sorted.dup.filtered.flagstat  \
  tags/U2OS_C54A/U2OS_C54A.H3K27me3/tagGCcontent.txt  \
  tags/U2OS_C54A/U2OS_C54A.H3K27me3/genomeGCcontent.txt  \
  tags/U2OS_C54A/U2OS_C54A.H3K27me3/tagLengthDistribution.txt  \
  tags/U2OS_C54A/U2OS_C54A.H3K27me3/tagInfo.txt  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.base_distribution_by_cycle.pdf  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.alignment_summary_metrics  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_histogram.pdf  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_metrics  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle_metrics  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle.pdf  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution_metrics  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution.pdf  \
  metrics/U2OS_C54B/H3K27me3/U2OS_C54B.H3K27me3.sorted.dup.filtered.flagstat  \
  tags/U2OS_C54B/U2OS_C54B.H3K27me3/tagGCcontent.txt  \
  tags/U2OS_C54B/U2OS_C54B.H3K27me3/genomeGCcontent.txt  \
  tags/U2OS_C54B/U2OS_C54B.H3K27me3/tagLengthDistribution.txt  \
  tags/U2OS_C54B/U2OS_C54B.H3K27me3/tagInfo.txt  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.base_distribution_by_cycle.pdf  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.alignment_summary_metrics  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_histogram.pdf  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.insert_size_metrics  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle_metrics  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.quality_by_cycle.pdf  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution_metrics  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.all.metrics.quality_distribution.pdf  \
  metrics/U2OS_C54C/H3K27me3/U2OS_C54C.H3K27me3.sorted.dup.filtered.flagstat  \
  tags/U2OS_C54C/U2OS_C54C.H3K27me3/tagGCcontent.txt  \
  tags/U2OS_C54C/U2OS_C54C.H3K27me3/genomeGCcontent.txt  \
  tags/U2OS_C54C/U2OS_C54C.H3K27me3/tagLengthDistribution.txt  \
  tags/U2OS_C54C/U2OS_C54C.H3K27me3/tagInfo.txt \
-n report/multiqc_report.html
multiqc_report.6550178a518572d2822660a07b6aa79d.mugqic.done
chmod 755 $COMMAND
multiqc_report_1_JOB_ID=$(echo "#! /bin/bash
echo '#######################################'
echo 'SLURM FAKE PROLOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
rm -f $JOB_DONE &&    $COMMAND
MUGQIC_STATE=\$PIPESTATUS
echo MUGQICexitStatus:\$MUGQIC_STATE

if [ \$MUGQIC_STATE -eq 0 ] ; then touch $JOB_DONE ; fi
echo '#######################################'
echo 'SLURM FAKE EPILOGUE (MUGQIC)'
date
scontrol show job \$SLURM_JOBID
sstat -j \$SLURM_JOBID.batch
echo '#######################################'
exit \$MUGQIC_STATE" | \
sbatch --mail-type=END,FAIL --mail-user=$JOB_MAIL -A $RAP_ID -D $OUTPUT_DIR -o $JOB_OUTPUT -J $JOB_NAME --time=4:00:00 --mem-per-cpu=4700M -N 1 -c 5 | grep "[0-9]" | cut -d\  -f4)
echo "$multiqc_report_1_JOB_ID	$JOB_NAME	$JOB_DEPENDENCIES	$JOB_OUTPUT_RELATIVE_PATH" >> $JOB_LIST

echo "$multiqc_report_1_JOB_ID	$JOB_NAME submitted"
sleep 0.1

#-------------------------------------------------------------------------------
# Call home with pipeline statistics
#-------------------------------------------------------------------------------
LOG_MD5=$(echo $USER-'10.80.49.4-ChipSeq-U2OS_C54C.rs11.rs12,U2OS_C54B.rs9.rs10,U2OS_C54A.rs7.rs8,U2OS_C1B.rs3.rs4,U2OS_C1C.rs5.rs6,U2OS_C1A.rs1.rs2' | md5sum | awk '{ print $1 }')
if test -t 1; then ncolors=$(tput colors); if test -n "$ncolors" && test $ncolors -ge 8; then bold="$(tput bold)"; normal="$(tput sgr0)"; yellow="$(tput setaf 3)"; fi; fi
wget --quiet 'http://mugqic.hpc.mcgill.ca/cgi-bin/pipeline.cgi.example.com?hostname=narval4.narval.calcul.quebec&ip=10.80.49.4&pipeline=ChipSeq&steps=picard_sam_to_fastq,trimmomatic,merge_trimmomatic_stats,mapping_bwa_mem_sambamba,sambamba_merge_bam_files,sambamba_mark_duplicates,sambamba_view_filter,metrics,homer_make_tag_directory,qc_metrics,homer_make_ucsc_file,macs2_callpeak,homer_annotate_peaks,homer_find_motifs_genome,annotation_graphs,run_spp,differential_binding,ihec_metrics,multiqc_report,cram_output&samples=6&md5=$LOG_MD5' || echo "${bold}${yellow}Warning:${normal}${yellow} Genpipes ran successfully but was not send telemetry to mugqic.hpc.mcgill.ca. This error will not affect genpipes jobs you have submitted.${normal}"
