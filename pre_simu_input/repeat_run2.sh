#!/bin/bash
#this version script of running hpc GPU pbs job
#take the space of the $EPHEMERAL,rather than the share gpu space with others.
#otherwise it will run out space on the disk.

i=$1

if [ $i == 1 ]
then
   inputrst=equi_1.ncrst
else 
   inputrst=$((i-1)).rst7
fi

if [ $i -le 20 ]
then

   cat << EOF > production$i.pbs
#PBS -lselect=1:ncpus=4:mem=24gb:ngpus=1:gpu_type=RTX6000
#PBS -lwalltime=24:00:0

cd \$PBS_O_WORKDIR

module load cuda/9.0

RUN=$i

/rds/general/user/igould/home/pmemd.cuda_SPFP -O -i production.in -o $i.out -c $inputrst -p *_HMR.parm7 -ref $inputrst -r $i.rst7 -x $i.nc -inf $i.inf

./repeat_run.sh $((i+1)) 

EOF

cd /rds/general/user/zc719/ephemeral/1rubp_new/1rubp_rep01         #not sure necessary anymore, not sure whereami
qsub production$i.pbs

fi 

