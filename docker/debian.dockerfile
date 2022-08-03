FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install --no-install-recommends -y libssl-dev libcurl4-openssl-dev zlib1g-dev libsodium-dev libopus-dev cmake pkg-config g++ gcc git make && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add packages you want
# RUN apt-get install PACKAGE_NAME

WORKDIR /usr/src/concord

COPY . .

RUN CFLAGS="-DCCORD_SIGINTCATCH -DCCORD_DEBUG_HTTP" make

RUN make shared && \
	make voice

RUN make install
