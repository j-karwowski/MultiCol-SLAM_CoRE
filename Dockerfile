FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update -y && apt-get upgrade -y

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    sudo \
    wget \
    ninja-build \
    software-properties-common \
    python3 \
    python3-pip \
    ssh \
    gcc \
    g++ \
    gdb \
    cmake \
    rsync \
    tar \
    x11-utils \
    x11-apps \
    zip \
    libboost-all-dev libssl-dev

# OpenCV
RUN apt-get install -y \
    cmake \
    git \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev
RUN wget https://github.com/opencv/opencv/archive/refs/tags/3.4.16.zip &&\
    unzip 3.4.16.zip &&\
    cd opencv-3.4.16 &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make -j2 &&\
    make install &&\
    cd ../../
 
# Pangolin
RUN apt-get install -y \
    mesa-utils \
    libgl1-mesa-glx \
    libglu1-mesa-dev \
    libglew-dev \
    libglvnd-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev \ 
    mesa-common-dev
RUN apt-get install -y libeigen3-dev
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.zip &&\
    unzip v0.6.zip &&\
    cd Pangolin-0.6 &&\
    mkdir build && cd build &&\
    cmake -DCMAKE_CXX_STANDARD=11 .. &&\
    make -j2 &&\
    make install &&\
    cd ../../

# Multi-Col SLAM
WORKDIR /
RUN git clone https://github.com/j-karwowski/MultiCol-SLAM_CoRE -b core/devel MultiCol-SLAM &&\
    cd MultiCol-SLAM
WORKDIR /MultiCol-SLAM
RUN sh ./build.sh

# Download Lafida dataset
WORKDIR /
RUN wget http://www2.ipf.kit.edu/~pcv2016/downloads/indoor_dynamic.zip &&\
    unzip indoor_dynamic.zip
