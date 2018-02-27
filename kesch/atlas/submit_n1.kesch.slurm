#!/bin/bash
#SBATCH --job-name=atlas_test
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --ntasks-per-socket=1
#SBATCH --gres=gpu:1
#SBATCH --partition=debug
#SBATCH --time=00:03:00
#SBATCH --output=job.out

all=`ctest -N`
while read -r line; do
  check=`echo $line | grep "Test #" |  grep -v 'atlas_test_metadata\|atlas_test_haloexchange\|atlas_test_gather\|atlas_test_structuredcolumns'`
  if [[ -z ${check} ]]; then
    echo "Skipping ${line}"
    continue
  fi
  atest=`echo $line | sed 's/Test #.*: //g'`
  if [[ ! -z ${atest} ]]; then 
   filenames="${filenames} `find . -name $atest`"
  fi
done <<< "$all"

for test in $filenames; do
  echo "RUNNING TEST ::::::::::::::::::::: $test"
  srun $test
done

