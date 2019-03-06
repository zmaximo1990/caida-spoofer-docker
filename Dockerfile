FROM alpine:latest

# Install all build dependencies
RUN apk update \
    && apk add --no-cache --virtual build-dependencies \
    build-base \
    gcc \
    && apk add --no-cache \
    bash \
    && apk add --no-cache \
    protobuf \
    protobuf-dev \
    && apk add --no-cache \
    openssl \
    openssl-dev \
    && apk add --no-cache \
    qt5-qtbase \
    iputils \
    tcptraceroute \
    libpcap \
    libpcap-dev \
    whois \
    curl \
    ssmtp && \
    mkdir /spoofer

COPY ./spoofer-1.4.1.tar.gz /spoofer

COPY ./entrypoint.sh /spoofer
RUN sed -i 's/\r//' /spoofer/entrypoint.sh && \
    chmod +x /spoofer/entrypoint.sh

# Configure SSMTP to send tests results
COPY ./ssmtp.conf /etc/ssmtp

WORKDIR /spoofer

# Install CAIDA Spoofer and then cleanup
RUN tar xzvf spoofer-1.4.1.tar.gz && \
    cd spoofer-1.4.1 && \
    ./configure && \
    make && \
    make install && \
    make clean && \
    cd .. && \
    rm -rf spoofer-1.4.1 spoofer-1.4.1.tar.gz

ENTRYPOINT ["/spoofer/entrypoint.sh"]