FROM continuumio/miniconda3
RUN conda install -c conda-forge -y ncl
ADD wrfout_to_cf /tmp/wrfout_to_cf


ENV CONDA_PREFIX="/opt/conda" NCARG_ROOT="/opt/conda"

RUN cd /tmp/wrfout_to_cf &&\
    #wget  http://foehn.colorado.edu/wrfout_to_cf/wrfout_to_cf.ncl &&\
    cp wrfout_to_cf.ncl $CONDA_PREFIX/lib/ncarg/nclscripts/wrf/ &&\
    cp wrfout_to_cf.sh /usr/local/bin/ &&\
    cp wrfout_to_cf.py /usr/local/bin/ &&\
    chmod +x /usr/local/bin/wrfout_to_cf.sh &&\
    chmod +x /usr/local/bin/wrfout_to_cf.py
