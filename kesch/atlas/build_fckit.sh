cd builds/fckit
export BOOST_ROOT=/scratch/cosuna/software/boost_1_59_0
ecbuild -DCMAKE_C_COMPILER=`which gcc`  -DCMAKE_CXX_COMPILER=`which g++` -DCMAKE_Fortran_COMPILER=`which ftn` -DCMAKE_EXE_LINKER_FLAGS=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/lib64/libstdc++.so -DMPI_CXX_COMPILER=`which mpic++` -DMPI_Fortran_COMPILER=`which mpif90` -DCMAKE_CXX_FLAGS=-lpthread -DCMAKE_EXE_LINTER_FLAGS=-lpthread  -DECMWF_GIT=HTTP -DENABLE_CUDA=OFF -DECKIT_PATH=/scratch/cosuna/dwarf-D-advection-MPDATA/dwarf-D-advection-MPDATA/builds/eckit ../../sources/fckit/ 
