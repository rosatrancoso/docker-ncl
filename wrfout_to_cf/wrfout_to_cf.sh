#!/bin/bash
SCRIPT=$NCARG_ROOT/lib/ncarg/nclscripts/wrf/wrfout_to_cf.ncl

if (( $# < 2 )); then
    echo "Usage: $0 filein fileout"
    exit
fi

filein=$1
fileout=$2

CMD="ncl 'file_in=\"$filein\"' 'file_out=\"$fileout\"' $SCRIPT"
echo $CMD
eval $CMD
