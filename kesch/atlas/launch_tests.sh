#!/bin/bash

exitError()
{
    echo "ERROR $1: $3" 1>&2
    echo "ERROR     LOCATION=$0" 1>&2
    echo "ERROR     LINE=$2" 1>&2
    exit $1
}

checkOutputFile()
{
logfile=$1

test -e ${logfile}
if [ $? -ne 0 ] ; then
    # abort
    exitError 4652 ${LINENO} "Output of test file not found"
fi

grep -i 'fail\|error\|[^a-zA-z]fault' ${logfile} | grep -v "100% tests passed" | grep -v "0 tests failed out of"

if [ $? -eq 0 ] ; then
    # echo output to stdout
    test -f ${logfile} || exitError 6550 ${LINENO} "batch job output file missing"
    echo "=== test.out BEGIN ==="
    cat ${logfile} | /bin/sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
    echo "=== test.out END ==="
    # abort
    exitError 4654 ${LINENO} "problem with unittests for test data detected"
else
    echo "Unittests successful (see $logfile for detailed log)"
fi
}

logfile="job.out"
rm ${logfile}
bash ./monitorjobid `sbatch submit_n4.kesch.slurm | gawk '{print $4}'` 7200

checkOutputFile ${logfile}

rm ${logfile}
bash ./monitorjobid `sbatch submit_n1.kesch.slurm | gawk '{print $4}'` 7200

checkOutputFile ${logfile}
