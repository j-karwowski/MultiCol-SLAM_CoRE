FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get clean && apt-get update -y && apt-get upgrade -y

RUN apt-get install build-essential -y && \
    apt-get install cmake -y && \
    apt-get install git -y && \
    apt-get install sudo -y && \
    apt-get install wget -y && \
    apt-get install ninja-build -y && \
    apt-get install software-properties-common -y && \
    apt-get install python3 -y && \
    apt-get install python3-pip -y && \
    apt-get install -y ssh && \
    apt-get install -y gcc && \
    apt-get install -y g++ && \
    apt-get install -y gdb && \
    apt-get install -y cmake && \
    apt-get install -y rsync && \
    apt-get install -y tar && \
    apt-get install -y x11-utils && \
    apt-get install -y x11-apps && \
    apt-get install -y zip &&\
    apt-get install -y libboost-all-dev libssl-dev &&\
    apt-get clean


# OpenCV
RUN apt-get install -y cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
RUN wget https://github.com/opencv/opencv/archive/refs/tags/3.4.16.zip &&\
    unzip 3.4.16.zip &&\
    cd opencv-3.4.16 &&\
    mkdir build && cd build &&\
    cmake .. &&\
    make -j &&\
    make install &&\
    cd ../../
 
# Pangolin
RUN apt-get install -y mesa-utils && \
    apt-get install -y libgl1-mesa-glx && \
    apt-get install -y libglu1-mesa-dev && \
    apt-get install -y libglew-dev &&\
    apt-get install -y libglvnd-dev &&\
    apt-get install -y libgl1-mesa-dev &&\
    apt-get install -y libegl1-mesa-dev &&\
    apt-get install -y mesa-common-dev
RUN apt-get install -y libeigen3-dev
RUN wget https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.zip &&\
    unzip v0.6.zip &&\
    cd Pangolin-0.6 &&\
    mkdir build && cd build &&\
    cmake -DCMAKE_CXX_STANDARD=11 .. &&\
    make -j &&\
    make install &&\
    cd ../../
    
# Multi-Col SLAM
WORKDIR /
RUN git clone https://github.com/changh95/MultiCol-SLAM.git &&\
    cd MultiCol-SLAM
WORKDIR /MultiCol-SLAM
RUN sh ./build.sh

# Download Lafida dataset
WORKDIR /
RUN wget http://www2.ipf.kit.edu/~pcv2016/downloads/indoor_dynamic.zip &&\
    unzip indoor_dynamic.zip
