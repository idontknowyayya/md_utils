#!/bin/bash
#PBS -N resubmit
#PBS -l walltime=5:00
#PBS -l nodes=1:ppn=1,pmem=1g
#PBS -A hbmayes_fluxod
#PBS -q fluxod
#PBS -V
#PBS -j oe
set -u
set -e
cd ~
# This submits this job file again, but makes sure
# that it waits in the queue for at least 10 minutes
if [ -d "$PBS_O_WORKDIR" ] ; then
    cd $PBS_O_WORKDIR
fi
files=
basename=

for file in ${files[@]}
do
    if [ -f ${file}.log ]
    then
        echo "${file}.log exists"
    else
        qsub -a $(date -d '10 minutes' "+%H%M") ${basename}_resubmit.pbs
        exit 1
    fi
done
qsub -a $(date -d '10 minutes' "+%H%M") ${basename}_analysis.pbs