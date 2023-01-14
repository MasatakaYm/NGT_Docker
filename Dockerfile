FROM ubuntu:22.04 AS build

# Prepare command line tools
RUN apt update && apt install -y
RUN apt install wget gcc g++ cmake unzip -y
RUN apt install libblas-dev liblapack-dev -y

# Building NGT
WORKDIR /tmp
RUN cd /tmp/ && wget https://github.com/yahoojapan/NGT/archive/refs/tags/v2.0.9.zip && unzip v2.0.9.zip

WORKDIR /tmp/NGT-2.0.9/build
RUN cmake .. && make -j 4 && make install && ldconfig /usr/local/lib

ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}