cat << EOF > rms_traj.in
parm L1.parm7
trajin L?_last.pdb.2
rms fit :1-477
average avg_L1.pdb pdb
go
trajout fitted_last_8L1.nc
run

exit

EOF


cpptraj -i rms_traj.in


