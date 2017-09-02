#!/bin/bash

. modules.sh

CWD=${PWD}

#set -o errexit -o noclobber -o nounset -o pipefail
params="$(getopt -o b -l build --name "$0" -- "$@")"
eval set -- "$params"
only_build=false

while true
do
    case "$1" in
        -b|--build)
            only_build=true
            shift
            ;;
        --) shift ; break ;;
        *)
            echo "Not implemented: $1" >&2
            exit 1
            ;;
    esac
done

if [ ! -d builds/fckit ]; then
  mkdir builds/fckit
fi
cd builds/fckit

if [ $only_build = false ]; then
ecbuild -DCMAKE_C_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/bin/gcc  -DCMAKE_CXX_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/bin/g++ -DCMAKE_Fortran_COMPILER=/opt/cray/craype/2.4.2/bin/ftn -DMPI_CXX_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/MVAPICH2/2.2a-GCC-4.9.3-binutils-2.25/bin/mpic++ -DMPI_Fortran_COMPILER=/opt/cray/mvapich2_slurm/2.0.1.4_noslurm/CRAY/8.4/bin/mpif90 -DCMAKE_CXX_FLAGS=-lpthread -DCMAKE_EXE_LINTER_FLAGS=-lpthread  -DECMWF_GIT=HTTP -DENABLE_CUDA=OFF ../../sources/fckit/

fi

make -j3

cd ../../
if [ ! -d builds/eckit ]; then 
  mkdir builds/eckit
fi
cd builds/eckit

if [ $only_build = false ]; then

ecbuild -DCMAKE_C_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/bin/gcc  -DCMAKE_CXX_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/bin/g++ -DCMAKE_Fortran_COMPILER=/opt/cray/craype/2.4.2/bin/ftn -DMPI_CXX_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/MVAPICH2/2.2a-GCC-4.9.3-binutils-2.25/bin/mpic++ -DMPI_Fortran_COMPILER=/opt/cray/mvapich2_slurm/2.0.1.4_noslurm/CRAY/8.4/bin/mpif90 -DCMAKE_CXX_FLAGS=-lpthread -DCMAKE_EXE_LINTER_FLAGS=-lpthread  -DECMWF_GIT=HTTP -DENABLE_CUDA=OFF ../../sources/eckit

fi

make -j4

cd ../../
if [ ! -d builds/atlas ]; then
  mkdir builds/atlas
fi

cd builds/atlas

if [ $only_build = false ]; then

  ecbuild -DCMAKE_INSTALL_PREFIX=$(CWD)/install/atlas/ -DCMAKE_C_COMPILER=`which gcc`  -DCMAKE_CXX_COMPILER=`which g++` -DCMAKE_Fortran_COMPILER=`which ftn` -DMPI_CXX_COMPILER=`which mpic++` -DMPI_Fortran_COMPILER=`which mpif90` -DCMAKE_CXX_FLAGS=-lpthread -DENABLE_TESTS=OFF -DCMAKE_EXE_LINKER_FLAGS="/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/lib64/libstdc++.so -lpthread  /opt/cray/lib64/cce/libmodules64.so.1" -DECMWF_GIT=HTTP -DENABLE_GPU=OFF -DECKIT_PATH=${CWD}/builds/eckit/ -DFCKIT_PATH=${CWD}/builds/fckit ../../sources/atlas
  
  list_flags=`find . -name flags.make`
  for f in $list_flags; do
    echo "replacing $f"
    cat ../../compiler_flags.fortran > tmp_f
    cat $f | awk '{sub(/-fPIE/,""); sub(/Fortran_FLAGS =/,"Fortran_FLAGS = $(PFLAGS) $(FFLAGS) $(FOPT1)"); print}' >> tmp_f
    cp tmp_f $f
    rm tmp_f
  done
  
  list_link=`find . -name link.txt`
  for f in $list_link; do
    echo "replacing LINK $f"
    cat $f
    cat $f | awk '{sub(/-rdynamic/,""); print}' > tmp_f
    echo "out"
    cat tmp_f
    echo "post"
    cp tmp_f $f
    cat $f
    echo "RUTU $f"
  done
   
fi

make -j4

cd ../../
if [ ! -d build/dwarf-D-advection-MPDATA ]; then 
  mkdir builds/dwarf-D-advection-MPDATA
fi 
cd builds/dwarf-D-advection-MPDATA

if [ $only_build = false ]; then
  ecbuild  -DCMAKE_C_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/bin/gcc  -DCMAKE_CXX_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/bin/g++ -DCMAKE_Fortran_COMPILER=/opt/cray/craype/2.4.2/bin/ftn -DMPI_CXX_COMPILER=/apps/escha/UES/RH6.7/easybuild/software/MVAPICH2/2.2a-GCC-4.9.3-binutils-2.25/bin/mpic++ -DMPI_Fortran_COMPILER=/opt/cray/mvapich2_slurm/2.0.1.4_noslurm/CRAY/8.4/bin/mpif90 -DCMAKE_CXX_FLAGS=-lpthread -DCMAKE_EXE_LINKER_FLAGS="/apps/escha/UES/RH6.7/easybuild/software/GCC/4.9.3-binutils-2.25/lib64/libstdc++.so -lpthread  /opt/cray/lib64/cce/libmodules64.so.1" -DECMWF_GIT=HTTP -DENABLE_GPU=OFF -DECKIT_PATH=${CWD}/builds/eckit/ -DFCKIT_PATH=${CWD}/builds/fckit -DATLAS_PATH=${CWD}/builds/atlas/ ../../sources/dwarf-D-advection-MPDATA/ 

  list_flags=`find . -name flags.make`
  for f in $list_flags; do
    echo "replacing $f"
    cat ../../compiler_flags.fortran > tmp_f
    cat $f | awk '{sub(/-fPIE/,""); sub(/Fortran_FLAGS =/,"Fortran_FLAGS = $(PFLAGS) $(FFLAGS) $(FOPT1)"); print}' >> tmp_f
    cp tmp_f $f
    rm tmp_f
  done

  list_link=`find . -name link.txt`
  for f in $list_link; do
    echo "replacing LINK $f"
    cat $f
    cat $f | awk '{sub(/-rdynamic/,""); print}' > tmp_f
    echo "out"
    cat tmp_f
    echo "post"
    cp tmp_f $f
    cat $f
    echo "RUTU $f"
  done

fi

make VERBOSE=1 -j4
