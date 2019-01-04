FROM alpine:latest

# Install all build dependencies
RUN apk update \
    && apk add --virtual build-dependencies \
        build-base \
        gcc \
    && apk add \
        bash \
    && apk add \
        protobuf \
        protobuf-dev \
    && apk add \
        openssl \
        openssl-dev \
    && apk add \
        qt5-qtbase \
        iputils \
        tcptraceroute \
        libpcap \
        libpcap-dev

RUN mkdir /spoofer
COPY ./spoofer-1.4.1.tar.gz /spoofer

WORKDIR /spoofer

RUN tar xzvf spoofer-1.4.1.tar.gz && \
	cd spoofer-1.4.1 && \
	./configure && \
	make && \
	make install && \
	make clean && \
	cd .. && \
	rm -rf spoofer-1.4.1 spoofer-1.4.1.tar.gz

ENTRYPOINT ["spoofer-prober", "-v", "-s1", "-r1", "--no-tls"]
