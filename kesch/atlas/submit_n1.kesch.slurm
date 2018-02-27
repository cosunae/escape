#!/bin/bash
#SBATCH --job-name=atlas_test
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-socket=1
#SBATCH --gres=gpu:1
#SBATCH --partition=debug
#SBATCH --time=00:03:00
#SBATCH --output=job.out

ctest -V -E  "(atlas_test_metadata|atlas_test_haloexchange|atlas_test_gather|atlas_test_structuredcolumns)"

