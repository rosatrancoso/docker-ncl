# docker-ncl

This docker has ncl installed from conda and includes 
- the script to convert WRF native ouput to netCDF CF compliant: [wrfout_to_cf.ncl](https://sundowner.colorado.edu/wrfout_to_cf/wrfout_to_cf.ncl)
- `wrfout_to_cf.sh`: bash wrapper to convert single file
-  `wrfout_to_cf.py`: python wrapper to convert multiple files

## Usage

Wrfout files need to end with `*.nc` so that NCL recognizes them. 

```
ncl 'file_in="wrfout.nc"' 'file_out="wrfpost.nc"' wrfout_to_cf.ncl
```
