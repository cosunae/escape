export BOOST_ROOT=/scratch/cosuna/software/boost_1_59_0
module load cmake/3.1.3
module load PrgEnv-gnu
module load PrgEnv-cray
module load craype

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/lib64/cce/:/opt/cray/lib64/

ecbuild -DCMAKE_C_COMPILER=gcc  -DENABLE_FORTRAN=OFF -DCMAKE_CXX_COMPILER=g++ -DCMAKE_Fortran_COMPILER=ftn -DCUDA_NVCC_FLAGS="--std=c++11" -DCMAKE_CXX_FLAGS=-lpthread  -DECMWF_GIT=HTTP -DENABLE_GPU=ON -DECKIT_PATH=/scratch/cosuna/atlas_integration/builds_test/eckit/ -DFCKIT_PATH=/scratch/cosuna/atlas_integration/builds_test/fckit -DGRIDTOOLS_STORAGE_PATH=/scratch/cosuna/atlas_integration/tools/gridtools/  ../../atlas 

make -j8 VERBOSE=1
