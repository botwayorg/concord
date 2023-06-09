FROM alpine:latest

ENV PACKAGES "build-dependencies build-base curl curl-dev bash openssl  gcc git lld clang libsodium ffmpeg opus opus-tools autoconf automake libtool"

RUN apk update && \
	apk add --no-cache --virtual ${PACKAGES}

RUN mkdir /root/.botway

WORKDIR /usr/src/concord

COPY . .

RUN CFLAGS="-DCCORD_SIGINTCATCH -DCCORD_DEBUG_HTTP" make

RUN make voice

RUN make install
