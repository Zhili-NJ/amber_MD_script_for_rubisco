#!/rds/general/user/zc719/home/miniconda3/bin/python
import sys
import subprocess
def write_submit(prefix, REP, RUN):
    if RUN == 1:
        RST = "equi_1.ncrst"
    else:
        RST = f"{prefix}_rep{REP:02}-{RUN-1:02}.rst"
    filename = f"{prefix}_rep{REP:02}-{RUN:02}"
    with open(f"production{REP:02}-{RUN:02}.sh", "w") as output:
        output.write("#PBS -lselect=1:ncpus=4:mem=24gb:ngpus=1:gpu_type=RTX6000\n")
        output.write("#PBS -lwalltime=24:00:0\n")
        output.write("module load cuda/9.0\n\n")
        output.write(f"prefix={prefix}\nREP={REP:02}\nRUN={RUN:02}\nRST={RST}\n\n")
        output.write("cd /tmp/pbs.$PBS_JOBID\n\n")
        output.write("cp $PBS_O_WORKDIR/production.in .\ncp $PBS_O_WORKDIR/${RST} .\ncp $PBS_O_WORKDIR/${prefix}_HMR.parm7 .\n")
        output.write(f"/rds/general/user/igould/home/pmemd.cuda_SPFP -O -i production.in -o {filename}.out -c {RST} -p {prefix}_HMR.parm7 -ref {RST} -r {filename}.rst -x {filename}.nc -inf {filename}_info\n\n")
        output.write(f"cp {filename}* $PBS_O_WORKDIR\n")
        output.write("cd $PBS_O_WORKDIR\n\n")
        output.write(f"/rds/general/user/zc719/home/miniconda3/bin/python $PBS_O_WORKDIR/next_job.py {prefix} {REP} {RUN}\n\n")
    return f"production{REP:02}-{RUN:02}.sh"

if __name__ == "__main__":
    prefix = sys.argv[1]
    REP = int(sys.argv[2])
    RUN = int(sys.argv[3]) + 1
    if len(sys.argv) == 5 and sys.argv[4] == "init":
        scriptname = write_submit(prefix, REP, 1)
        subprocess.run(["qsub", "-N", "_".join([prefix, str(REP), str(RUN)]), scriptname])
    elif RUN <= 20:
        scriptname = write_submit(prefix, REP, RUN)
        subprocess.run(["qsub", "-N", "_".join([prefix, str(REP), str(RUN)]), scriptname])
