#!/bin/sh

###
### This script is for converting gen file to ped file
### 

#############################################################################   
####                                                                            
#### First let's download the GTOOL excutable                                   
####                                                                            
                                                                            
: <<ENDCOMMENT1
cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Apps_and_programs
mkdir gtool                                                                     
cd gtool                                                                        
wget www.well.ox.ac.uk/~cfreeman/software/gwas/gtool_v0.7.5_x86_64.tgz          
tar -zxf gtool_v0.7.5_x86_64.tgz                                                
rm gtool_v0.7.5_x86_64.tgz                                                      

ENDCOMMENT1



source ${scripts_dir1}/aliases_and_parameters.sh
cd ${study_data_dir}


module load plink


#:<<EOF1


# convert each chromosome into ped file
for chrn in {1..22}; do
plink \
    --gen Data_chr_${chrn}_imputed \
    --sample Data_chr_${chrn}_corrected.phased.sample \
    --oxford-single-chr ${chrn} \
    --recode \
    --hard-call-threshold 0.1 \
    --missing-code -9,NA,na \
    --out Data_chr_${chrn}_imputed_1



# If multiple variants have the same location, it will give a problem later on with clumpping.
# So let's identify and remove them.


awk '{print $4}' Data_chr_${chrn}_imputed_1.map | uniq -c | awk '$1>1' | awk '{print $2}' > loc_with_multiple_variants.txt

awk 'NR==FNR{a[$1];next} $4 in a{print $2}' loc_with_multiple_variants.txt Data_chr_${chrn}_imputed_1.map > same_loc_variants.txt

plink \
    --file Data_chr_${chrn}_imputed_1 \
    --exclude same_loc_variants.txt \
    --make-bed \
    --out Data_chr_${chrn}_imputed


done

#EOF1

# first let's create a file lists the chr files
# (exclude the first chromosome)
for chrn in {2..22}; do
echo Data_chr_${chrn}_imputed.bed Data_chr_${chrn}_imputed.bim Data_chr_${chrn}_imputed.fam >> file_list1.txt
done

plink \
    --bfile Data_chr_1_imputed \
    --merge-list file_list1.txt \
    --make-bed \
    --memory 115000 \
    --out Data_imputed

:<<EOF

plink \
    --bfile Data_chr_11_imputed \
    --bmerge Data_chr_12_imputed.bed Data_chr_12_imputed.bim Data_chr_12_imputed.fam \
    --merge-equal-pos \
    --make-bed \
    --out Data_imputed_temp

EOF


:<<ENDCOMMENT
# the following does the same with gtool, but chr values will be missing
${gtool_dir}/gtool \
    -G \
    --g imputed_data2.gen \
    --s imputed_data2.sample \
    --ped imputed_data2.ped \
    --map imputed_data2.map \
    --phenotype plink_pheno \
    --threshold 0.9

${gtool_dir}/gtool \
    -G \
    --g Data_chr_21_imputed \
    --s Data_chr_21_corrected.phased.sample \
    --ped temp_chr21 \
    --map temp_chr21 \
    --phenotype plink_pheno \
    --threshold 0.9 \
    --chr 21 \
    --snp

ENDCOMMENT
