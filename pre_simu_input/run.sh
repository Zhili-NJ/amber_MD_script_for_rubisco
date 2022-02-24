export CUDA_VISIBLE_DEVICES="GPU_NUMBER"
/usr/local/amber/bin/pmemd.cuda_SPFP -O -i min_1.in -o min_1.out -c NAME.rst7 -p NAME.parm7 -r min_1.ncrst -ref NAME.rst7 -inf min_1.inf
/usr/local/amber/bin/pmemd.cuda_SPFP -O -i min_2.in -o min_2.out -c min_1.ncrst -p NAME.parm7 -r min_2.ncrst -inf min_2.inf
/usr/local/amber/bin/pmemd.cuda_SPFP -O -i Heat_1.in -o Heat_1.out -c min_2.ncrst -p NAME.parm7 -r Heat_1.ncrst -ref min_2.ncrst -inf Heat_1.inf
/usr/local/amber/bin/pmemd.cuda_SPFP -O -i Heat_2.in -o Heat_2.out -c Heat_1.ncrst -p NAME.parm7 -r Heat_2.ncrst -ref Heat_1.ncrst -inf Heat_2.inf
/usr/local/amber/bin/pmemd.cuda_SPFP -O -i equi_1.in -o equi_1.out -c Heat_2.ncrst -p NAME_HMR.parm7 -r equi_1.ncrst -inf equi_1inf
