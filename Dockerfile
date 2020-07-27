FROM ubuntu:20.04 AS build

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get install -y \
    autoconf \
    bison \
    flex \
    gcc \
    g++ \
    git \
    libprotobuf-dev \
    libnl-route-3-dev \
    libtool \
    make \
    pkg-config \
    protobuf-compiler
RUN git clone https://github.com/google/nsjail.git /nsjail && cd /nsjail && make

FROM ubuntu:20.04
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libprotobuf17 libnl-route-3-200 python3 sudo libc6:i386 libncurses5:i386 libstdc++6:i386 && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /nsjail/nsjail /usr/bin/nsjail
RUN useradd -r -u 1000 ctf
