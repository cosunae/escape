#!/bin/bash
#SBATCH --job-name=atlas_test
#SBATCH --ntasks=5
#SBATCH --ntasks-per-node=5
#SBATCH --ntasks-per-socket=5
#SBATCH --gres=gpu:5
#SBATCH --partition=debug
#SBATCH --time=00:03:00
#SBATCH --output=job.out

ctest -V -R  "(atlas_test_metadata|atlas_test_haloexchange|atlas_test_gather|atlas_test_structuredcolumns)"

