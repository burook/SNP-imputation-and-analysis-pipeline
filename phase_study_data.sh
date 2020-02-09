#!/bin/sh

###
### pre-phasing the study data with SHAPEIT.
### 

############################################################################
#### 
#### First download shapeit binary if necessary
#### 
: <<'ENDCOMMENT'
cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Apps_and_programs
mkdir shapeit
cd shapeit
wget https://mathgen.stats.ox.ac.uk/genetics_software/shapeit/shapeit.v2.r837.GLIBCv2.12.Linux.static.tgz
tar -zxf shapeit.v2.r837.GLIBCv2.12.Linux.static.tgz
rm shapeit.v2.r837.GLIBCv2.12.Linux.static.tgz

ENDCOMMENT
 


source ${scripts_dir1}/aliases_and_parameters.sh
cd ${study_data_dir}

for chrn in {1..22}; do
echo phasing chr ${chrn}

sbatch -o stdout.${chrn}.phasing.txt \
        -e stderr.${chrn}.phasing.txt \
       --job-name=prephasing_chr_${chrn} \
      ../Scripts/phase_study_data.sbatch ${chrn}

sleep 1 # pause in between submissions

done 
