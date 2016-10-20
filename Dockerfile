# Dockerfile creating Ubunt 16.04 with Tensorflow 0.11
# Also adds in some dot files
FROM ubuntu:16.04

MAINTAINER Fergal Cotter <fbc23@cam.ac.uk>

RUN apt-get update
RUN apt-get -qq update
RUN apt-get install -y curl make
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

# Core linux dependencies. Some of these taken from the Tensorflow Dockerfile
RUN apt-get -qq -y install --no-install-recommends \
    bc \
	build-essential \
    ca-certificates \
	git-core \
	libfreetype6-dev \
    libhdf5-dev \
	libpng12-dev \
    libzmq3-dev \
    pkg-config \
	python3 \
 	python3-dev \
    rsync \
    software-properties-common \
    unzip \
	wget 

RUN apt-get clean
RUN apt-get -qq install -y python3-pip
RUN pip3 install --upgrade pip

# Python dependencies
RUN pip3 --no-cache-dir install \
    dtcwt \
    hdf5storage \
    h5py \
	ipykernel \
    jupyter \
    matplotlib \
    numpy \
    scipy 

RUN python3 -m ipykernel.kernelspec

# Install TensorFlow CPU version from central repo
ENV TENSORFLOW_VERSION 0.11.0rc0
RUN pip3 --no-cache-dir install --upgrade \
	https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-${TENSORFLOW_VERSION}-cp35-cp35m-linux_x86_64.whl

# Connection to the host machine
VOLUME ["/data", "/exps"]
WORKDIR /exps

CMD ["/bin/bash", "-l"]
