#!/bin/bash
#
#SBATCH -p serial_requeue # partition
#SBATCH -n 1   # one CPU
#SBATCH -N 1   # on one node
#SBATCH -t 0-5:00   # running time
#SBATCH --mem 32000   # memory request

#SBATCH --workdir="/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data"

#SBATCH --mail-user=burook@g.harvard.edu
#SBATCH --mail-type=ALL


source ../Scripts/aliases_and_parameters.sh


chrn=${1}

${shapeit_dir}/shapeit \
        --input-bed Data_chr_${chrn}_corrected_2.bed \
                    Data_chr_${chrn}_corrected_2.bim \
                    Data_chr_${chrn}_corrected_2.fam \
        --input-map ${impute_dir1}/Reference_data/genetic_map_b37/genetic_map_chr${chrn}_combined_b37.txt \
        --output-max Data_chr_${chrn}_corrected.phased.haps \
                     Data_chr_${chrn}_corrected.phased.sample




