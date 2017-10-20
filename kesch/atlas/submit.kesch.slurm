#!/bin/bash
#SBATCH --job-name=atlas_test
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --output=atlas_test.log
#SBATCH --partition=debug
#SBATCH --time=00:15:00
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=1

echo $LD_LIBRARY_PATH

srun ./src/tests/array/atlas_test_array
srun ./src/tests/array/atlas_test_vector_kernel
srun ./src/tests/array/atlas_test_array_kernel
srun ./src/tests/grid/atlas_test_field
srun ./src/tests/grid/atlas_test_grid_ptr
srun ./src/tests/grid/atlas_test_grids
srun ./src/tests/grid/atlas_test_rotation
srun ./src/tests/grid/atlas_test_state
