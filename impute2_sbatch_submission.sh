#!/bin/sh

###
### this file calls the impute2 batch script for imputation of variants
###
 


#### 
#### First download impute2 binary if necessary
#### 

: <<'ENDCOMMENT'

cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Apps_and_programs
mkdir impute2
cd impute2
wget https://mathgen.stats.ox.ac.uk/impute/impute_v2.3.2_x86_64_static.tgz
tar -zxf impute_v2.3.2_x86_64_static.tgz
rm impute_v2.3.2_x86_64_static.tgz

ENDCOMMENT




source ../Scripts/aliases_and_parameters.sh
cd ../Study_data

for chrn in {1..22}; do
echo imputing chr ${chrn}

sbatch -o stdout.${chrn}.impute2.txt \
        -e stderr.${chrn}.impute2.txt \
       --job-name=impute2_chr_${chrn} \
      ../Scripts/impute2_sbatch_submission.sbatch ${chrn}

sleep 1 # pause in between submissions

done 


