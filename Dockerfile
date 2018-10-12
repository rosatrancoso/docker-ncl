FROM centos:centos7
MAINTAINER Rosa Trancoso <rosatrancoso@gmail.com>

RUN yum -y install epel-release &&\
    yum -y update &&\
    yum -y install vim wget bzip2 libXrender libXext libSM csh sudo \
                   xterm sudo &&\
    yum clean all

ENV CONDA_PREFIX="/usr/local/conda"

# install conda
RUN cd /tmp &&\
    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh &&\
    sh Miniconda2-latest-Linux-x86_64.sh -b -f -p $CONDA_PREFIX

ENV PATH $CONDA_PREFIX/bin:$PATH

# install ncl from conda
RUN conda create -n ncl_stable -c conda-forge ncl -y
ENV PATH $CONDA_PREFIX/envs/ncl_stable/bin:$PATH
RUN echo "source activate ncl_stable" >> /etc/.bashrc

# install wrfout_to_cf
COPY wrfout_to_cf.ncl /tmp/wrfout_to_cf.ncl
COPY wrfout_to_cf.sh /tmp/wrfout_to_cf.sh
COPY wrfout_to_cf.py /tmp/wrfout_to_cf.py

RUN cd /tmp &&\
    #wget  http://foehn.colorado.edu/wrfout_to_cf/wrfout_to_cf.ncl &&\
    mv wrfout_to_cf.ncl $CONDA_PREFIX/envs/ncl_stable/lib/ncarg/nclscripts/wrf/ &&\
    mv wrfout_to_cf.sh /usr/local/bin/ &&\
    mv wrfout_to_cf.py /usr/local/bin/ &&\
    chmod +x /usr/local/bin/wrfout_to_cf.sh &&\
    chmod +x /usr/local/bin/wrfout_to_cf.py

# add user with sudo
ARG uid
ARG user

RUN echo "Adding user $user with uid $uid" &&\
    adduser -u $uid $user &&\
    echo "$user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$user && \
    chmod 0440 /etc/sudoers.d/$user

USER $user


# ENTRYPOINT "/bin/bash"
WORKDIR /work
