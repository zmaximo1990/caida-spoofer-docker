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
        libpcap-dev \
        whois \
        curl \
        ssmtp

RUN mkdir /spoofer
COPY ./spoofer-1.4.1.tar.gz /spoofer

COPY ./entrypoint.sh /spoofer
RUN sed -i 's/\r//' /spoofer/entrypoint.sh
RUN chmod +x /spoofer/entrypoint.sh

COPY ./ssmtp.conf /etc/ssmtp

WORKDIR /spoofer

RUN tar xzvf spoofer-1.4.1.tar.gz && \
	cd spoofer-1.4.1 && \
	./configure && \
	make && \
	make install && \
	make clean && \
	cd .. && \
	rm -rf spoofer-1.4.1 spoofer-1.4.1.tar.gz

ENTRYPOINT ["/spoofer/entrypoint.sh"]