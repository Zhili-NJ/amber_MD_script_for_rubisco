cat << EOF > strip_traj.in
parm *strip.parm7
trajin *strip.nc -1
strip !:1-477 parmout L1.parm7
outtraj L1_last.pdb pdb multi
go
unstrip
strip !:478-954
outtraj L2_last.pdb pdb multi 
go
unstrip
strip !:955-1431
outtraj L3_last.pdb pdb multi
go
unstrip
strip !:1432-1908
outtraj L4_last.pdb pdb multi
go
unstrip
strip !:1909-2385
outtraj L5_last.pdb pdb multi
go
unstrip
strip !:2386-2862
outtraj L6_last.pdb pdb multi
go
unstrip
strip !:2863-3339
outtraj L7_last.pdb pdb multi
go
unstrip
strip !:3340-3816
outtraj L8_last.pdb pdb multi
go
exit

EOF


cpptraj -i strip_traj.in

rm *.pdb.1

