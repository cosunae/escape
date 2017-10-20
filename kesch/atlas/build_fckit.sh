module load cmake/3.1.3
module load PrgEnv-gnu
module load PrgEnv-cray
module load module load craype

ecbuild -DCMAKE_C_COMPILER=`which gcc`  -DCMAKE_CXX_COMPILER=`which g++` -DCMAKE_Fortran_COMPILER=`which ftn` -DCMAKE_EXE_LINKER_FLAGS=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/lib64/libstdc++.so -DCMAKE_CXX_FLAGS=-lpthread  -DECMWF_GIT=HTTP  -DECKIT_PATH=/scratch/cosuna/atlas_integration/builds_test/eckit ../../fckit/

make VERBOSE=1
