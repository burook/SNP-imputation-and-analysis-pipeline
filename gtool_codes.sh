#!/bin/sh

# Scripts in this file contain various tasks done with GTOOL. Including
#   - converssions between file formats (.gen to .ped and vise versa)
#   - merging datasets
#   - orienting genotpe data with strand file


module load plink
source ./aliases_and_parameters.sh
cd ${study_data_dir}


#############################################################################
#### 
#### First let's download the GTOOL excutable 
#### 

: <<'ENDCOMMENT'

cd /n/regal/fdoyle_lab/burook/GWAS_analysis/Apps_and_programs
mkdir gtool
cd gtool
wget www.well.ox.ac.uk/~cfreeman/software/gwas/gtool_v0.7.5_x86_64.tgz
tar -zxf gtool_v0.7.5_x86_64.tgz
rm gtool_v0.7.5_x86_64.tgz

ENDCOMMENT


############################################################################
#### 
#### Convering the GEN files to BED files
#### 

: <<'END1'


${gtool_dir}/gtool \
    -G \
    --g temp4444.200000 \
    --s Data_chr_4_corrected_quant-pheno.phased.sample \
    --ped ttt444.ped \
    --map ttt444.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 4





#### 
#### Merging multiple gen files
#### 

# 
# Merging can be done with the -M mode of GTOOL, here it is not necessary
# 

find . -type f -name 'temp4444.*00' -exec cat {} + >> ttt_imputed



# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_4_corrected_quant-pheno.phased.sample > temp.sample.file


${gtool_dir}/gtool \
    -G \
    --g rs717947 \
    --s temp.sample.file \
    --ped rs717947.ped \
    --map rs717947.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 4

# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' rs717947.ped  > rs717947_2.ped


plink \
    --ped rs717947_2.ped \
    --map rs717947.map \
    --make-bed \
    --out rs717947

#END1

#######################################################################
#### 
#### Merging multiple gen files --- Chromosome 4 
#### 

find . -type f -name 'temp_chr4.*00' -exec cat {} + >> Data_chr_4_imputed


# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_4_corrected_quant-pheno.phased.sample > temp.sample.file


${gtool_dir}/gtool \
    -G \
    --g Data_chr_4_imputed \
    --s temp.sample.file \
    --ped Data_chr_4_imputed.ped \
    --map Data_chr_4_imputed.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 4

# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_4_imputed.ped  > Data_chr_4_imputed_2.ped

plink \
    --ped Data_chr_4_imputed_2.ped \
    --map Data_chr_4_imputed.map \
    --make-bed \
    --out Data_chr_4_imputed

#END1

#######################################################################
#### 
#### Merging multiple gen files --- Chromosome 4 
#### 

find . -type f -name 'temp_chr6.*00' -exec cat {} + >> Data_chr_6_imputed


# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_6_corrected.phased.sample > temp.sample.file


${gtool_dir}/gtool \
    -G \
    --g Data_chr_6_imputed \
    --s temp.sample.file \
    --ped Data_chr_6_imputed.ped \
    --map Data_chr_6_imputed.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 6

# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_6_imputed.ped  > Data_chr_6_imputed_2.ped

plink \
    --ped Data_chr_6_imputed_2.ped \
    --map Data_chr_6_imputed.map \
    --make-bed \
    --out Data_chr_6_imputed

#END1

#######################################################################
#### 
#### Merging multiple gen files --- Chromosome 15 
#### 

find . -type f -name 'temp_chr15.*00' -exec cat {} + >> Data_chr_15_imputed


# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_15_corrected.phased.sample > temp.sample.file


${gtool_dir}/gtool \
    -G \
    --g Data_chr_15_imputed \
    --s temp.sample.file \
    --ped Data_chr_15_imputed.ped \
    --map Data_chr_15_imputed.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 15

# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_15_imputed.ped  > Data_chr_15_imputed_2.ped

plink \
    --ped Data_chr_15_imputed_2.ped \
    --map Data_chr_15_imputed.map \
    --make-bed \
    --out Data_chr_15_imputed

END1

#######################################################################
#### 
#### Merging multiple gen files --- Chromosome 11 
#### 

find . -type f -name 'temp_chr11.*00' -exec cat {} + >> Data_chr_11_imputed


# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_11_corrected.phased.sample > temp.sample.file


${gtool_dir}/gtool \
    -G \
    --g Data_chr_11_imputed \
    --s temp.sample.file \
    --ped Data_chr_11_imputed.ped \
    --map Data_chr_11_imputed.map \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 11

# the FID and IID columns are swapped, insert the following bash code to fix it
awk -F $'\t' ' { t = $1; $1 = $2; $2 = t; print; } ' Data_chr_11_imputed.ped  > Data_chr_11_imputed_2.ped

plink \
    --ped Data_chr_11_imputed_2.ped \
    --map Data_chr_11_imputed.map \
    --make-bed \
    --out Data_chr_11_imputed
