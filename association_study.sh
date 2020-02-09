#!/bin/sh

# The ped/map file we have listed PTSD status as the phenotype
# (the sixth column entry). 
# First, replace the categorical phenotype (PTSD status) with a 
# quantitative phenotype (CAPS score)
# 
# Then, the actual association analysis is performed. 


input_gwas_data=Data_chr_4_corrected_quant-pheno
data_wd1=/n/regal/fdoyle_lab/burook/GWAS_analysis/Study_data
do_QC_filtering="NO" # assign "YES" if want to do the QC prefiltering

module load plink


cd ${data_wd1}

##############################################################
### Quality control filtering

if [ ${do_QC_filtering} == "YES" ]
then
    plink \
	--bfile ${input_gwas_data} \
	--maf 0.01 \
	--geno 0.05 \
	--mind 0.05 \
	--hwe 0.001 \
	--make-bed \
	--out ${output_gwas_data}
fi


###############################################################
### First we do analysis on the whole chromosome


plink \
    --file Biomarker_GWAS_147sids \
    --make-bed \
    --out temp111
 
plink \
    --bfile temp111 \
    --recode \
    --pheno pheno_data.txt \
    --pheno-name CAPSTOT_cur \
    --make-bed \
    --out Biomarker_GWAS_147sids_quant-pheno

plink \
    --bfile Biomarker_GWAS_147sids_quant-pheno \
    --indep-pairwise 50 10 0.2 \
    --out prune2

plink \
    --bfile Biomarker_GWAS_147sids_quant-pheno \
    --extract prune2.prune.in \
    --genome \
    --out ibs2

plink \
    --bfile Biomarker_GWAS_147sids_quant-pheno \
    --read-genome ibs2.genome \
    --cluster \
    --mds-plot 3 \
    --out mds1
#    --ppc 0.001 \
#    --cc \

: <<'ENDCOMMENT'


plink \
    --bfile Biomarker_GWAS_147sids_quant-pheno \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc2


###############################################################
### Analysis on just chromosome 4



# the following line is not necessary, 
# exclude it and rewrite the subsequent codes
plink \
    --bfile Data_chr_4_corrected \
    --no-pheno \
    --make-bed \
    --out Data_chr_4_corrected_no-pheno 

plink \
    --bfile Data_chr_4_corrected_no-pheno \
    --recode \
    --pheno pheno_data.txt \
    --pheno-name CAPSTOT_cur \
    --make-bed \
    --out Data_chr_4_corrected_quant-pheno

plink \
    --bfile Data_chr_4_corrected_quant-pheno \
    --indep-pairwise 50 10 0.2 \
    --out prune1

plink \
    --bfile Data_chr_4_corrected_quant-pheno \
    --extract prune1.prune.in \
    --genome \
    --out ibs1

plink \
    --bfile Data_chr_4_corrected_quant-pheno \
    --read-genome ibs1.genome \
    --cluster \
    --mds-plot 3 \
    --out mds1
#    --ppc 0.001 \
#    --cc \

plink \
    --bfile Data_chr_4_corrected_quant-pheno \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc1

# ENDCOMMENT


###############################################################
### Analysis on the the imputed data 5Mb around the top SNP



plink \
    --bfile rs717947 \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc4


#ENDCOMMENT

###############################################################
### Analysis on the the imputed chromosome 4

plink \
    --bfile Data_chr_4_imputed \
    --recode \
    --pheno pheno_data.txt \
    --pheno-name CAPSTOT_cur \
    --make-bed \
    --out Data_chr_4_imputed_quant-pheno

plink \
    --bfile Data_chr_4_imputed_quant-pheno \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc5

#ENDCOMMENT

###############################################################
### Analysis on the the imputed chromosome 6

plink \
    --bfile Data_chr_6_imputed \
    --recode \
    --pheno pheno_data.txt \
    --pheno-name CAPSTOT_cur \
    --make-bed \
    --out Data_chr_6_imputed_quant-pheno

plink \
    --bfile Data_chr_6_imputed_quant-pheno \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc6

#ENDCOMMENT

###############################################################
### Analysis on the the imputed chromosome 15

plink \
    --bfile Data_chr_15_imputed \
    --recode \
    --pheno pheno_data.txt \
    --pheno-name CAPSTOT_cur \
    --make-bed \
    --out Data_chr_15_imputed_quant-pheno

plink \
    --bfile Data_chr_15_imputed_quant-pheno \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc15

ENDCOMMENT

###############################################################
### Analysis on the imputed chromosome 11

plink \
    --bfile Data_chr_11_imputed \
    --maf 0.01 \
    --geno 0.05 \
    --mind 0.05 \
    --hwe 0.001 \
    --make-bed \
    --out Data_chr_11_imputed_after_QC

plink \
    --bfile Data_chr_11_imputed_after_QC \
    --recode \
    --pheno pheno_data.txt \
    --pheno-name CAPSTOT_cur \
    --make-bed \
    --out Data_chr_11_imputed_quant-pheno

plink \
    --bfile Data_chr_11_imputed_quant-pheno \
    --linear sex\
    --covar mds1.mds \
    --covar-name C1,C2,C3 \
    --out assoc_chr_11

