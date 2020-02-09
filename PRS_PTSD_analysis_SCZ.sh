#!/bin/sh

# 04/22/2018
# This file contains analysis for total psycharray  data (n=274 samples)

##################################################################
# Calculating PRS with the various summary statistics data.
# 
# the following two line code were used to prepare pheno data for PRSice
# cut -f 2,14 phenotypes_for_psycharray_data.txt > temp.pheno.file.for.psycharray.ptsdstatus.txt
# cut -f 2,11 phenotypes_for_psycharray_data.txt > temp.pheno.file.for.psycharray.capstotcur.txt
#
# replace the 'Sub_threshold' labels (binary phenotypes for PRSice)
# sed -i -e 's/Sub_threshold/Negative/g;' temp.pheno.file.for.psycharray.ptsdstatus.txt
#
# and delete the colnames from emacs
###############

module load R
module load plink


##################################################################
# calculate principal components
do_PC_calculation="NO" # once calculating PCs, put it to "NO"


if [ ${do_PC_calculation} == "YES" ]
then

cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data

plink \
    --file AllCohorts-DNA-Blood-Emory-GWASPsychArray-20180412 \
    --maf 0.01 \
    --geno 0.05 \
    --mind 0.1 \
    --hwe 0.001 \
    --make-bed \
    --out AllCohorts_20180412_after_QC

plink \
    --bfile AllCohorts_20180412_after_QC \
    --indep-pairwise 50 10 0.2 \
    --out prune4

plink \
    --bfile AllCohorts_20180412_after_QC \
    --extract prune4.prune.in \
    --genome \
    --out ibs3

plink \
    --bfile AllCohorts_20180412_after_QC \
    --read-genome ibs3.genome \
    --cluster \
    --pca 200 \
    --out pca200

fi




####################################################
## first let's do QC filtering and partitioning data
do_QC_filtering="NO" # "YES" only the first time

if [ ${do_QC_filtering} == "YES" ]
then

cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data

# since our sample size is small, the QC is done on all samples combined
plink \
  --bfile Data_imputed \
  --maf 0.01 \
  --geno 0.1 \
  --hwe 0.001 \
  --make-bed \
  --out PsychArray_data_imputed_after_QC
fi

if [1==2]  # we do not need for this new dataset
then

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep Hispanic.txt \
  --out PsychArray_data_imputed_after_QC_Hispanic

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep Non_Hispanic_Black.txt \
  --out PsychArray_data_imputed_after_QC_Black

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep Non_Hispanic_White.txt \
  --out PsychArray_data_imputed_after_QC_White 

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --remove Non_Hispanic_Black.txt \
  --out PsychArray_data_imputed_after_QC_NOT_Black

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep cluster1.txt \
  --out PsychArray_data_imputed_after_QC_cluster1

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep cluster2.txt \
  --out PsychArray_data_imputed_after_QC_cluster2

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep cluster3.txt \
  --out PsychArray_data_imputed_after_QC_cluster3

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --keep cluster4.txt \
  --out PsychArray_data_imputed_after_QC_cluster4

plink \
  --bfile PsychArray_data_imputed_after_QC \
  --make-bed \
  --remove cluster3.txt \
  --out PsychArray_data_imputed_after_QC_cluster124

fi

#####################################
###### the following is inseted for changing figure labels
## sed -i -e 's/given score in quantiles/given score in deciles/g; s/Quantiles for Polygenic Score/Deciles for Polygenic Score/g;' /n/fdoyle_lab/burook/PRSice_v1.25/PRSice_v1.25.R


################
## with PTSD summary statistics for 


calculate_PRS_1="NO" # 'YES' if calculating PRS

if [ ${calculate_PRS_1} == "YES" ]
then

module load R
module load plink

cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Results
mkdir ptsd_tm
rm ptsd_tm/*
cd ptsd_tm
R CMD BATCH '--args plink plink 
  base /n/fdoyle_lab/burook/PRS_for_PTSD/GWAS_summary_statistics_datasets/SORTED_PTSD_EA9_ALL_study_specific_PCs12.txt
  target /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data/PsychArray_data_imputed_after_QC
  pheno.file /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data/temp.pheno.file.for.psycharray.ptsdstatus.txt
  binary.target T
  multiple.target.phenotypes F
  slower 0.05
  sinc 0.05
  supper 1
  covariates C1,C2,C3,C4,C5
  barchart.levels 0.05,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1
  quantiles T
  quant.ref 1
  num.quantiles 3
  barpalatte Blues
  bar.col.is.pval.lowcol lightblue
  bar.col.is.pval.highcol darkblue
  best.thresh.on.bar T
  figname ptsd
  wd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Results/ptsd_tm' \
  /n/fdoyle_lab/burook/PRSice_v1.25/PRSice_v1.25.R \
  ptsd.out 

fi





###############################################################################################
#############################################################################################
##############

## with SCZ summary statistics
calculate_PRS_1="YES" # 'YES' if calculating PRS

if [ ${calculate_PRS_1} == "YES" ]
then

module load R
module load plink

cd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Results
mkdir ptsd_tm
rm ptsd_tm/*
cd ptsd_tm
R CMD BATCH '--args plink plink
  base /n/fdoyle_lab/burook/PRS_for_PTSD/GWAS_summary_statistics_datasets/scz2.snp.results.txt
  target /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data/PsychArray_data_imputed_after_QC
  pheno.file /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data/temp.pheno.file.for.psycharray.ptsdstatus.txt
  binary.target T
  multiple.target.phenotypes F
  slower 0.05
  sinc 0.05
  supper 0.05
  covariates C1,C2,C3,C4,C5
  quantiles F
  quant.ref 1
  num.quantiles 5
  figname ptsd
  ggfig F
  wd /n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Results/ptsd_tm' \
  /n/fdoyle_lab/burook/PRSice_v1.25/PRSice_v1.25.R \
  ptsd.out

fi
