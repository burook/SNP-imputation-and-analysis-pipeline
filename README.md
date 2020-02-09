# SNP-imputation-and-analysis-pipeline
SNP imputation and analysis pipeline

These are a set of Bash scripts for imputation and analysis of GWAS data. 


## Scripts

Scripts of the imputation pipeline are run in the following order.


Script    |	Description 
:----------|---------------- 
`1.aliases_and_parameters.sh` | First various parameters and variables need to be set. Modify this first. 
`2.downloading_data.sh` | Download reference genomes required for imputation. 
`3.checking_strand_orientation.sh` | Strand orientation of the target data is checked with the reference genome (usually labelled on the forward strand). 
`4.phase_study_data.sh` <br/>  `--> phase_study_data.sbatch` | Submit jobs for phasing each chromosome. 
`5.impute2_sbatch_submission.sh` <br/>  `--> impute2_sbatch_submission.sbatch` | Imputation is done for each chromosome in parallel. 
`6.reassembling_imputed_genome.sh` | Reassemble the imputed data using gtool. 
`7.convert_gen_to_ped.sh` | Convert gen files to ped files. 

---

## Note

The batch codes are prepared for SLURM job scheduler. If the cluster uses another job scheduler, the headers need to be modified accordingly. For example, for three schedulers I had used, the headers can be modified as follows.


LSF (eg. Partners cluster, Erisone) | SGE (eg. Broad cluster) | SLURM (eg. Harvard FAS cluster, Odyssey) | Notes
------------------------------------|-------------------------|------------------------------------------|-------
-M | -l h_vmem=, -l s_vmem= | --mem | Memory size limit
-n | -pe | -n, --ntasks | Number of CPU (number of tasks)
-W | -l h_rt | -t, --time | Wall clock time
-cwd | -wd | -D, --workdir | Set working directory
-J | -N | -J, --job-name | Job name
-u | -M | --mail-user | Email address
-B | -m b | –mail-type=BEGIN | Email when job begins
-N | -m e | –mail-type=END | Email when job ends
-e | -e | -e, --error | stderr file
-o | -o | -o, --output | stdout file
bsub < scriptFile | qsub | sbatch scriptFile (no need for ‘<’) | Submitting a job
#bsub | #$ | #SBATCH | 


Monitoring and controlling jobs


LSF | SGE | SLURM | Notes
----|-----|-------|------
bhist | qacct | sacct | Finished jobs history
bjobs | qstat | squeue | List pending, running and suspended jobs
bkill <jobID> | qdel <jobID> | scancel <jobID> | Delete job







