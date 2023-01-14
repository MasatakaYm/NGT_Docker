FROM ubuntu:22.04 AS build

ARG NUM_PARALLEL_BUILD=1

ARG NGT_VERSION=2.0.9
ENV NGT_SRC_URL=https://github.com/yahoojapan/NGT/archive/refs/tags/v${NGT_VERSION}.zip

# Prepare command line tools
RUN apt update && apt install -y
RUN apt install wget unzip gcc g++ cmake libblas-dev liblapack-dev -y

# Building NGT
WORKDIR /opt
RUN wget   ${NGT_SRC_URL} && \
    unzip v${NGT_VERSION}.zip && \
    rm    v${NGT_VERSION}.zip

WORKDIR /opt/NGT-${NGT_VERSION}/build
RUN cmake .. && make -j ${NUM_PARALLEL_BUILD} && make install && \
    ldconfig /usr/local/lib

ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}