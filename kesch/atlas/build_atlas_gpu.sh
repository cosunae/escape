cd builds/atlas_gpu
GT_ROOT=`pwd`/../../
export BOOST_ROOT=/scratch/cosuna/software/boost_1_59_0
ecbuild -DCMAKE_C_COMPILER=gcc  -DCMAKE_CXX_COMPILER=g++ -DCMAKE_Fortran_COMPILER=ftn -DCUDA_NVCC_FLAGS="--std=c++11" -DCMAKE_CXX_FLAGS=-lpthread -DCMAKE_EXE_LINTER_FLAGS=-lpthread  -DECMWF_GIT=HTTP -DENABLE_GPU=ON -DECKIT_PATH=/scratch/cosuna/atlas_integration/builds/eckit/ -DFCKIT_PATH=/scratch/cosuna/atlas_integration/builds/fckit -DGRIDTOOLS_STORAGE_PATH=/scratch/cosuna/atlas_integration/tools/gridtools/  ../../atlas 
