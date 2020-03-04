# tip to run manually

https://sundowner.colorado.edu/wrfout_to_cf/overview.html

Usage:

    `ncl 'file_in="wrfout.nc"' 'file_out="wrfpost.nc"' wrfout_to_cf.ncl`
    
Files need to end with `*.nc` so that NCL recognizes them:

1. link to local dir:

    `find ../wrfout/ -iname 'wrfout*' -exec ln -s {} . \;`

2. link with nc:
    
    `for FILE in wrfout*; do ln -s "$FILE" "$FILE".nc; done`


# docker-ncl

Centos docker with NCL installed for WRF post processing

    docker pull rosatrancoso/ncl

## Usage:

    docker run -ti rosatrancoso/ncl ncl -V

### Convert wrfout to CF compliant (with diagnosis variables)

Script from http://foehn.colorado.edu/wrfout_to_cf/wrfout_to_cf.ncl

Command syntax is ncl 'file_in="wrfout.nc"' 'file_out="wrfpost.nc"' wrfout_to_cf.ncl

Usage in docker:

#### Single file:

    docker run -ti -v /mydata:/tmp rosatrancoso/ncl wrfout_to_cf.sh /tmp/wrfout.nc /tmp/wrfpost.nc"

#### Multiple files:

    docker run -ti -v /mydata:/tmp rosatrancoso/ncl wrfout_to_cf.py /tmp/wrfout_d01_20*[0-9]

## References

 - http://www.ncl.ucar.edu/Download/conda.shtml
 - http://www2.mmm.ucar.edu/wrf/OnLineTutorial/Graphics/NCL/index.html
 - http://foehn.colorado.edu/wrfout_to_cf

