#!/bin/sh

###
### This script is for reassembling the imputed data using gtool. 
### 




#############################################################################
#### 
#### First let's download the GTOOL executable 
#### 

: <<'ENDCOMMENT'

cd /n/regal/fdoyle_lab/burook/SNP_imputation/Apps_and_programs
mkdir gtool
cd gtool
wget www.well.ox.ac.uk/~cfreeman/software/gwas/gtool_v0.7.5_x86_64.tgz
tar -zxf gtool_v0.7.5_x86_64.tgz
rm gtool_v0.7.5_x86_64.tgz

ENDCOMMENT


#######################################################################
#### 
#### Merging multiple gen files for each chromosome 
#### 



source ${scripts_dir1}/aliases_and_parameters.sh
cd ${study_data_dir}


:<<EOF


for chrn in {1..22}; do
echo reassembling chr ${chrn}

find . -type f -name 'temp_chr'${chrn}'.*[0-9]' -exec cat {} + >> Data_chr_${chrn}_imputed   

#find . -type f -name 'temp_chr'${chrn}'.*[0-9]' | wc -l

done 

EOF

# on a previous run, the FID and IID columns were swapped, 
# and we inserted the following bash code to fix it
# awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_11_corrected.phased.sample > Data_chr_11_corrected.phased.sample_swapped


for chrn in {1..22}; do

${gtool_dir}/gtool \
    -G \
    --g Data_chr_${chrn}_imputed \
    --s Data_chr_${chrn}_corrected.phased.sample \
    --ped Data_chr_${chrn}_imputed.ped \
    --map Data_chr_${chrn}_imputed.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr ${chrn}

done

:<<ENDCOMMENR1

source ../Scripts/aliases_and_parameters.sh 
cd ../Study_data

temp_gen_list=$(ls Data_chr_[1-2]*_imputed)
temp_sam_list=$(ls Data_chr_[1-2]*_corrected.phased.sample)

${gtool_dir}/gtool \
    -M \
    --g ${temp_gen_list} \
    --s ${temp_sam_list} \
    --og imputed_data2.gen \
    --os imputed_data2.sample

ENDCOMMENT1