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

FROM clover/base

WORKDIR /
COPY --from=build /build/image /

VOLUME ["/var/lib/memcachedb"]

CMD ["memcachedb", "-u", "root", "-H", "/var/lib/memcachedb", "-f", "default.db", "-v", "-r"]

EXPOSE 21201
