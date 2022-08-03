FROM alpine:latest

ENV PACKAGES "build-dependencies build-base curl curl-dev bash openssl openssl-dev libressl-dev gcc git lld clang libsodium ffmpeg opus opus-tools autoconf automake libtool"

RUN apk update && \
	apk add --no-cache --virtual ${PACKAGES}

# Add packages you want
# RUN apk add PACKAGE_NAME

WORKDIR /usr/src/concord

COPY . .

RUN CFLAGS="-DCCORD_SIGINTCATCH -DCCORD_DEBUG_HTTP" make

RUN make install
