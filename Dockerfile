FROM ubuntu AS osmp_model_builder
MAINTAINER bjoern.bahn@dlr.de

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y cmake build-essential git libprotobuf-dev protobuf-compiler && rm -rf /var/lib/apt/lists/*

COPY . model
RUN mkdir -p /model/examples/build
WORKDIR /model/examples/build

RUN cmake ..
RUN cmake --build . -j 4

