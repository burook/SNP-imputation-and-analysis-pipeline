#!/bin/sh


### 
### variable definitions:
### This variables need to be modified first.
### 




### 
### file location information
### 

# chromosome number we are working on if analysis is to be done on a single chromosome
#chrn=11

# location of the imputation working directory
export impute_dir1=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274

# location of the raw study data
export study_data_dir=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Study_data

# location of various scripts
export scripts_dir1=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Scripts

# genetic map data for build37 is located in the following folder
export genetic_map_data_chrn=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Reference_data/genetic_map_b37/genetic_map_chr${chrn}_combined_b37.txt

# location of prephased refernce panel
export phase3_chrn_haps=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Reference_data/1000GP_Phase3/1000GP_Phase3_chr${chrn}.hap.gz
export phase3_chrn_legend=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Reference_data/1000GP_Phase3/1000GP_Phase3_chr${chrn}.legend.gz
export genetic_map_data_chrn=${impute_dir1}/Reference_data/genetic_map_b37/genetic_map_chr${chrn}_combined_b37.txt

# location of the shapeit binary
export shapeit_dir=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Apps_and_programs/shapeit/bin

# location of the impute2 binary
export impute2_dir=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Apps_and_programs/impute2/impute_v2.3.2_x86_64_static

# location of the gtool executable
export gtool_dir=/n/fdoyle_lab/burook/SNP_imputation_PsychArray_total_274/Apps_and_programs/gtool






