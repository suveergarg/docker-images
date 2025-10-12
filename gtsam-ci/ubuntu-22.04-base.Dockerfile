ARG UBUNTU_VERSION=22.04
FROM docker.io/ubuntu:${UBUNTU_VERSION}

# Install dependencies
RUN sed -i 's|http://archive.ubuntu.com/ubuntu/|http://mirror.math.princeton.edu/pub/ubuntu/|g' /etc/apt/sources.list
RUN apt-get -y update && apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y && apt-get -y update
RUN apt-get -y install cmake \
                        build-essential \
                        pkg-config \
                        libpython3-dev \
                        python3-numpy \
                        libicu-dev \
                        ninja-build \
                        libboost-all-dev \
                        libeigen3-dev \ 
                        libmetis-dev \
                        libtbb-dev \
                        libgeographic-dev

WORKDIR /gtsam

