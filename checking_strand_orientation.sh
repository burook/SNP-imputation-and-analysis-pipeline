#!/bin/sh


# This script is for checking the strand orientation of the genotyped SNPs with that of
# the reference panel. Usually reference panels are labelled on the forward/positive strand.
# This checking and correction can be done in multiple ways.
# (1) with plink
# (2) with Gtool
# (3) with Genome Harmonizer


source ${scripts_dir1}/aliases_and_parameters.sh
cd ${study_data_dir} 

############################################################################
##### 
# (1) with plink  
##### 

module load plink


for chrn in {1..22}
do

# convert the reference vcf data to plink bed/bim/fam format
### (a somewhat time consuming step, so we check if the file already exists and we don't recreate it if it does exist)
if [ -f "ref_phase3_${chrn}_plink_bed" ];
then
echo "ref_phase3_${chrn}_plink_bed already exists"
else
plink --vcf /n/regal/informatics_public/ref/ncbi/1000genomes/phase3/20130502/*chr${chrn}.phase3*.vcf.gz \
      --make-bed \
      --out ref_phase3_${chrn}_plink_bed
fi

# extract data for chromosome chrn
plink --file AllCohorts-DNA-Blood-Emory-GWASPsychArray-20180412 \
      --chr ${chrn} \
      --out Data_chr_${chrn}

# bmerge returns a *.missnp file that contains SNPs that it thinks are problematic
plink --bfile ref_phase3_${chrn}_plink_bed \
      --bmerge Data_chr_${chrn}.bed Data_chr_${chrn}.bim Data_chr_${chrn}.fam \
      --out Data_chr_${chrn}_merged

# now flip those SNPs the data set (A/T and C/G)
plink --bfile Data_chr_${chrn} \
      --flip Data_chr_${chrn}_merged.missnp \
      --make-bed \
      --out Data_chr_${chrn}_aligned

# check if there are still problematic SNPs
plink --bfile ref_phase3_${chrn}_plink_bed \
      --bmerge Data_chr_${chrn}_aligned.bed Data_chr_${chrn}_aligned.bim Data_chr_${chrn}_aligned.fam \
      --out Data_chr_${chrn}_merged

# there are still SNPs that plink says are problematic, we get rid of them
plink --bfile Data_chr_${chrn}_aligned \
      --exclude Data_chr_${chrn}_merged.missnp \
      --make-bed \
      --out Data_chr_${chrn}_corrected

done




#####################################################################################
### the following is only for PsychArray data
### On PsychArray data some variants are located on the same position
        

:<<COMMENT1


for chrn in {1..22}; do
plink \
    --bfile Data_chr_${chrn}_corrected \
    --recode \
    --out Data_chr_${chrn}_corrected
        


# If multiple variants have the same location, it will give a problem with phasing.  
# So let's identify and remove them.                                                                         


awk '{print $4}' Data_chr_${chrn}_corrected.map | uniq -c | awk '$1>1' | awk '{print $2}' > loc_with_multiple_variants.txt

awk 'NR==FNR{a[$1];next} $4 in a{print $2}' loc_with_multiple_variants.txt Data_chr_${chrn}_corrected.map > same_loc_variants.txt

plink \
    --file Data_chr_${chrn}_corrected \
    --exclude same_loc_variants.txt \
    --make-bed \
    --out Data_chr_${chrn}_corrected_2


done

:<<COMMENT1



