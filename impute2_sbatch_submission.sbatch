#!/bin/bash
#
#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --time=0-40:00
#SBATCH --mem 64000
#
#SBATCH --workdir="/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data"  
#
#SBATCH --mail-user=burook@g.harvard.edu
#SBATCH --mail-type=ALL
#

source ${scripts_dir1}/aliases_and_parameters.sh

# chromosome to be imputed
chrn=${1}


# determine the length of the chromosome
end_pos=$(cut -f4 ../Study_data/Data_chr_${chrn}_corrected.bim | sort -n | tail -n1)

# starting position for the chromosome
start_pos=$(cut -f4 ../Study_data/Data_chr_${chrn}_corrected.bim | sort -nr | tail -n1)  

# an interval to chop a chromosome into
interval_pos=5000000


for i in $(seq ${start_pos} ${interval_pos} ${end_pos})
do
${impute2_dir}/impute2 \
    -use_prephased_g \
    -m ${genetic_map_data_chrn} \
    -h ${phase3_chrn_haps} \
    -l ${phase3_chrn_legend} \
    -known_haps_g Data_chr_${chrn}_corrected.phased.haps \
    -int ${i} $((i+interval_pos)) \
    -Ne 20000 \
    -o temp_chr${chrn}.${i}\
    -phase
done

