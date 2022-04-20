#!/bin/bash
#use directory name to distinguish the running systems
#usage: chmod 755 repeat_gpu.sh
#CUDA_VISIBLE_DEVICES="0" need to be specifie
#nohup ./repeat_gpu.sh 1 &

i=$1

if [ $i == 1 ]
then
   inputrst=equi_1.ncrst
else 
   inputrst=$((i-1)).rst7
fi

if [ $i -le 20 ]
then

   cat << EOF > production$i.sh
export CUDA_VISIBLE_DEVICES="0"
RUN=$i

/usr/local/amber/bin/pmemd.cuda_SPFP -O -i production.in -o $i.out -c $inputrst -p *_HMR.parm7 -ref $inputrst -r $i.rst7 -x $i.nc -inf $i.inf

./repeat_gpu.sh $((i+1)) 

EOF

chmod 755 production$i.sh
./production$i.sh

fi 

