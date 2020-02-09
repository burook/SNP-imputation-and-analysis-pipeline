#!/bin/bash
#
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --time=0-20:00
#SBATCH --mem 64000
#
#SBATCH --mail-user=burook@g.harvard.edu
#SBATCH --mail-type=ALL
#

source ${scripts_dir1}/aliases_and_parameters.sh
cd ${study_data_dir}

# chromosome to be reassembled
chrn=${1}

temp_gen_list=$(ls temp_chr${chrn}.*[0-9])
temp_sam_list=$(ls Data_chr_[].*_corrected.phased.sample)

${gtool_dir}/gtool \
    -M \
    --g ${temp_gen_list} \
    --s ${temp_sam_list} \
    --og imputed_data_${chrn}.gen



