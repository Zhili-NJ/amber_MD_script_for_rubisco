#!/bin/bash

cat << EOF > stride.in
parm *.parm7
trajin *nc 1 last 2
trajout stride.pdb pdb multi
EOF

cpptraj -i stride.in

cat << 'EOF' > strided.pbs

#PBS -lselect=1:ncpus=1:mem=2gb
#PBS -lwalltime=3:00:00
#PBS -J 1-1000
#module load openbabel
cd /tmp/pbs.$PBS_JOBID
cp $PBS_O_WORKDIR/stride.pdb.$PBS_ARRAY_INDEX stride.pdb

for i in {1..8}; do
   for j in {1..2}; do
	sed -ie "1,/HB  KCX/s/HB /HB$j/" stride.pdb
	sed -ie "1,/HG  KCX/s/HG /HG$j/" stride.pdb
	sed -ie "1,/HD  KCX/s/HD /HD$j/" stride.pdb
	sed -ie "1,/HE  KCX/s/HE /HE$j/" stride.pdb
   done
done

source activate py37

arpeggio stride.pdb -o 4849 -s /' '/4849/
arpeggio stride.pdb -o 334 -s /' '/334/
#arpeggio stride.pdb -o 811 -s /' '/811/
#arpeggio stride.pdb -o 1288 -s /' '/1288/
#arpeggio stride.pdb -o 1765 -s /' '/1765/
#arpeggio stride.pdb -o 2242 -s /' '/2242/
#arpeggio stride.pdb -o 2719 -s /' '/2719/
#arpeggio stride.pdb -o 3196 -s /' '/3196/
#arpeggio stride.pdb -o 3673 -s /' '/3673/

rm stride.pdb
rm stride.pdbe
mkdir $PBS_O_WORKDIR/$PBS_ARRAY_INDEX/
#cp *.json $PBS_O_WORKDIR/$PBS_ARRAY_INDEX/
cp -r * $PBS_O_WORKDIR/$PBS_ARRAY_INDEX/
#rm $PBS_O_WORKDIR/stride*

EOF

qsub strided.pbs
