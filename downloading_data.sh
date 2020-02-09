#!/bin/sh

###
### these are various scripts for downloading and preparing reference panel 
### and other genomic data required for imputation pipeline
###

source ${scripts_dir1}/aliases_and_parameters.sh
cd ${impute_dir1}/Reference_data

#### 
#### 1. 1000 Genome Project Data (unphased)
#### 
# The 1000 Genome Project data is saved in the following places on Odyssey.
# Phase 1: 
# /n/regal/informatics_public/ref/ncbi/1000genomes/phase1/20110521/
# Phase 3: 
# /n/regal/informatics_public/ref/ncbi/1000genomes/phase3/20130502/

#######################################################################
#### This is an unphased reference data. Phased reference datasets are
#### also available. The following is one from impute2.
#### Phased data not only speed up imputation but also increases accuracy. 
#### So, let's use phased reference genome.
#######################################################################



#### 
#### 2. Phased reference panel from impute2
####

cd ${impute_dir1}/Reference_data

echo Downloading 1000GP Phase3 data
wget https://mathgen.stats.ox.ac.uk/impute/1000GP_Phase3.tgz
echo Uncompressing the data
tar -zxf 1000GP_Phase3.tgz
echo Removing the original compressed data
rm 1000GP_Phase3.tgz

echo Downloading 1000GP Phase1 data
wget https://mathgen.stats.ox.ac.uk/impute/ALL.integrated_phase1_SHAPEIT_16-06-14.nosing.tgz
echo Uncompressing the data
tar -zxf ALL.integrated_phase1_SHAPEIT_16-06-14.nosing.tgz
echo Removing the downloaded compressed data
rm ALL.integrated_phase1_SHAPEIT_16-06-14.nosing.tgz



#### 
#### 3. Genetic map data
#### 

cd ${impute_dir1}/Reference_data

echo Genetic map data for build 36
wget http://hapmap.ncbi.nlm.nih.gov/downloads/recombination/2008-03_rel22_B36/rates/genetic_map_chr4_b36.txt

echo Genetic map data for build 37
wget http://www.shapeit.fr/files/genetic_map_b37.tar.gz
tar -zxf genetic_map_b37.tar.gz
rm genetic_map_b37.tar.gz


