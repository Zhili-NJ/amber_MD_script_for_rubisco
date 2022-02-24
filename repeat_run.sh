#!/bin/bash
#prerequisite: change  working address manunally, 
#bash: chmod 755 repeat_run.sh
#bash: ./repeat_run.sh 1
#Imperial College London Research Computing Service

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
module load cuda/9.0

RUN=$i

cd /tmp/pbs.\$PBS_JOBID

cp \$PBS_O_WORKDIR/production.in .
cp \$PBS_O_WORKDIR/$inputrst .
cp \$PBS_O_WORKDIR/*_HMR.parm7 .
/rds/general/user/igould/home/pmemd.cuda_SPFP -O -i production.in -o $i.out -c $inputrst -p *_HMR.parm7 -ref $inputrst -r $i.rst7 -x $i.nc -inf $i.inf

cp $i* \$PBS_O_WORKDIR
cp *rst7 \$PBS_O_WORKDIR
cd \$PBS_O_WORKDIR

./gamd_run.sh $((i+1)) 

EOF

cd /rds/general/user/zc719/ephemeral/1rubp_repeats/1rubp_4_rep04
qsub production$i.pbs

fi 

