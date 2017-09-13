FROM fbcotter/tf-opencv:core

MAINTAINER Fergal Cotter <fbc23@cam.ac.uk>

RUN apt-get update

# Python dependencies
RUN pip3 --no-cache-dir install \
    git+https://github.com/fbcotter/py3nvml.git@0.0.3#egg=py3nvml
