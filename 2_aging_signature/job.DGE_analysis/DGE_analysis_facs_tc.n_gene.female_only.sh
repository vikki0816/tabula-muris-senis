#!/bin/bash
#SBATCH -c 4                               # Request 4 core
#SBATCH -N 1                               # Request one node (if you request more than one core with -c, also using
                                           # -N 1 means all cores will be on the same node)
#SBATCH -t 0-1:00                          # Runtime in D-HH:MM format
#SBATCH -p short                           # Partition to run in
#SBATCH --array=1-131                     # Partition to run in
#SBATCH --mem=32000                          # Memory total in MB (for all cores)
#SBATCH -o //home/jz286/code/tabula-muris-senis/2_aging_signature/job_info/hostname_%j.out  
#SBATCH -e /home/jz286/code/tabula-muris-senis/2_aging_signature/job_info/hostname_%j.err                 
#SBATCH --mail-type=None                    # Type of email notification- BEGIN,END,FAIL,ALL

ROOT_FOLDER="/n/groups/price/martin/tms_gene_data"

# i_analyte=1
i_analyte=$SLURM_ARRAY_TASK_ID
analyte=$(head -n ${i_analyte} "${ROOT_FOLDER}/DGE_result/facs.tc_list" | tail -1 )
analyte=${analyte// /_} 
echo $analyte

OUTPUT_FOLDER="${ROOT_FOLDER}/DGE_result/DGE_facs_tc.n_gene.female_only"
n_gene="T"
DATA_NAME="facs"
KEEP_SEX="F"

Rscript DGE_analysis.R $OUTPUT_FOLDER $DATA_NAME $n_gene $analyte $KEEP_SEX