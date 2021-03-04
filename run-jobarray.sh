#!/bin/bash
#
#SBATCH --job-name=myJobarrayTest
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --time=5:00
#SBATCH --mem-1GB
#SBATCH --output=wordcounts_%A_%a.out
#SBATCH --error=wordcounts_%A_%a.err

cd / jnke2016/learn
python wordcount.py sample-$SLURM_ARRAY_TASK_ID.txt
