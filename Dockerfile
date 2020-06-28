FROM ubuntu:18.04 AS build

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

FROM ubuntu:18.04
RUN apt-get -y update && \
    apt-get install -y libprotobuf10 libnl-route-3-200 && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /nsjail/nsjail /usr/bin/nsjail
RUN useradd -r -u 1000 ctf
USER ctf
ENTRYPOINT ["/usr/bin/nsjail"]
CMD ["--config", "/home/ctf/nsjail.cfg"]
