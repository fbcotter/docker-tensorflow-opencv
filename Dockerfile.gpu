## Dockerfile to build opencv from sources with CUDA support
## Based on Josip Janzic file and Thomas Herbin's work

# FROM nvidia/cuda:9.0-devel
FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER Fergal Cotter <fbc23@cam.ac.uk>

###########################
### TENSORFLOW INSTALL  ###
###########################

ARG https_proxy
ARG http_proxy

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    yasm \
    pkg-config \
    curl 

RUN apt-get install -y \
    libswscale-dev libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev \
    libjasper-dev libavformat-dev libpq-dev libxine2-dev libglew-dev \
    libtiff5-dev zlib1g-dev libjpeg-dev libpng12-dev libjasper-dev \
    libavcodec-dev libavformat-dev libavutil-dev libpostproc-dev \
	libswscale-dev libeigen3-dev libtbb-dev libgtk2.0-dev 
    # libcudnn7=7.1.4.18-1+cuda9.0 

RUN apt-get install -y \
    python3-dev \
    python3-numpy \
    python3-pip 

## Cleanup
RUN rm -rf /var/lib/apt/lists/*

# Python dependencies
RUN pip3 --no-cache-dir install \
    numpy \
    hdf5storage \
    h5py \
    scipy \
    py3nvml

# Install tensorflow
RUN pip3 --no-cache-dir install tensorflow-gpu==1.8.0

# Set the library path to use cuda and cupti
ENV LD_LIBRARY_PATH /usr/local/cuda/extras/CUPTI/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH

########################
###  OPENCV INSTALL  ###
########################

ARG OPENCV_VERSION=3.4.1
# ARG OPENCV_INSTALL_PATH=/usr/local

## Create install directory
## Force success as the only reason for a fail is if it exist

# RUN mkdir -p $OPENCV_INSTALL_PATH; exit 0

WORKDIR /

## Single command to reduce image size
## Build opencv
RUN wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip \
    && unzip $OPENCV_VERSION.zip \
    && mkdir /opencv-$OPENCV_VERSION/cmake_binary \
    && cd /opencv-$OPENCV_VERSION/cmake_binary \
    && cmake -DBUILD_TIFF=ON \
       -DBUILD_opencv_java=OFF \
       -DBUILD_SHARED_LIBS=OFF \
       -DWITH_CUDA=ON \
       # -DENABLE_FAST_MATH=1 \
       # -DCUDA_FAST_MATH=1 \
       -DWITH_CUBLAS=1 \
       -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-9.0 \
       ##
       ## Should compile for most card
       ## 3.5 binary code for devices with compute capability 3.5 and 3.7,
       ## 5.0 binary code for devices with compute capability 5.0 and 5.2,
       ## 6.0 binary code for devices with compute capability 6.0 and 6.1,
       -DCUDA_ARCH_BIN='3.0 3.5 5.0 6.0 6.2' \
       -DCUDA_ARCH_PTX="" \
       ##
       ## AVX in dispatch because not all machines have it
       -DCPU_DISPATCH=AVX,AVX2 \
       -DENABLE_PRECOMPILED_HEADERS=OFF \
       -DWITH_OPENGL=OFF \
       -DWITH_OPENCL=OFF \
       -DWITH_QT=OFF \
       -DWITH_IPP=ON \
       -DWITH_TBB=ON \
       -DFORCE_VTK=ON \
       -DWITH_EIGEN=ON \
       -DWITH_V4L=ON \
       -DWITH_XINE=ON \
       -DWITH_GDAL=ON \
       -DWITH_1394=OFF \
       -DWITH_FFMPEG=OFF \
       -DBUILD_PROTOBUF=OFF \
       -DBUILD_TESTS=OFF \
       -DBUILD_PERF_TESTS=OFF \
       -DCMAKE_BUILD_TYPE=RELEASE \
       # -DCMAKE_INSTALL_PREFIX=$OPENCV_INSTALL_PATH \
    .. \
    ##
    ## Add variable to enable make to use all cores
    && export NUMPROC=$(nproc --all) \
    && make -j$NUMPROC install \
    ## Remove following lines if you need to move openCv
    && rm /$OPENCV_VERSION.zip \
    && rm -r /opencv-$OPENCV_VERSION

## Compress the openCV files so you can extract them from the docker easily 
# RUN tar cvzf opencv-$OPENCV_VERSION.tar.gz --directory=$OPENCV_INSTALL_PATH .
WORKDIR /home
