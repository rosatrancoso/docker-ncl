#!/usr/bin/python

import glob, os, sys
import subprocess

if not os.getenv("NCARG_ROOT"):
    sys.exit("NCARG_ROOT not defined in this host")

SCRIPT = os.path.join(
    os.getenv("NCARG_ROOT"), "lib/ncarg/nclscripts/wrf/wrfout_to_cf.ncl"
)

if len(sys.argv) < 2:
    print("Usage: [%s] filepattern" % sys.argv[0])
    sys.exit(-1)

# import pdb;pdb.set_trace()
# filepattern = sys.argv[1] # '/Users/rosa/gfs_mor1/wrfout_d01_2016-12-21_12*'
# files = glob.glob(filepattern)
files = sys.argv[1:]
files.sort()
print("Found %i files" % (len(files)))
print(files)
print("")

for filein in files:
    if not "wrfout_d" in filein:
        print("Skipping %s - needs to have 'wrfout_d' substring" % filein)
        continue
    print(" ======== Converting %s ========" % filein)
    fileout = filein.replace("wrfout_d", "wrfpost_d")
    file1 = filein + ".nc"
    file2 = fileout + ".nc"
    for fname in [file1, file2, fileout]:
        if os.path.isfile(fname):
            print("Unlinking %s" % fname)
            os.unlink(fname)
    os.symlink(filein, file1)
    cmd = ["ncl", "'file_in=\"%s\"'" % file1, "'file_out=\"%s\"'" % file2, SCRIPT]
    print(" ".join(cmd))
    out = subprocess.check_output(
        " ".join(cmd),
        # stderr=subprocess.STDOUT,
        shell=True,
    )
    print(out)
    if "fatal" in out:
        raise Exception("file %s was not properly converted" % filein)
