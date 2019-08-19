FROM clover/base AS base

RUN groupadd \
        --gid 50 \
        --system \
        memcachedb \
 && useradd \
        --home-dir /var/lib/memcachedb \
        --no-create-home \
        --system \
        --shell /bin/false \
        --uid 50 \
        --gid 50 \
        memcachedb

FROM library/ubuntu:bionic AS build

ENV LANG C.UTF-8
RUN export DEBIAN_FRONTEND=noninteractive \
 && apt-get update \
 && apt-get install -y \
        software-properties-common \
        apt-utils

RUN mkdir -p /build/image
WORKDIR /build
RUN apt-get download \
    memcachedb \
    libevent-2.1-6
RUN for file in *.deb; do dpkg-deb -x ${file} image/; done

WORKDIR /build/image
RUN rm -rf \
        etc \
        usr/share

COPY --from=base /etc/group /etc/gshadow /etc/passwd /etc/shadow etc/
COPY init/ etc/init/


FROM clover/base

WORKDIR /
COPY --from=build /build/image /

VOLUME [${MEMCACHEDB_DB_HOME:-/var/lib/memcached}]

EXPOSE ${MEMCACHED_TCP_PORT:-21201}/tcp ${MEMCACHED_UDP_PORT:-21201}/udp
