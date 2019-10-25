# ------------------------------------------------------------------------------
# Cargo Build Stage
# ------------------------------------------------------------------------------

FROM rust:latest as cargo-build

ARG OPENSSL_VERSION=1.0.2s

RUN apt-get update

RUN apt-get install sudo musl-dev musl-tools libssl-dev openssl ca-certificates git libc6-dev gcc -y

RUN rustup target add x86_64-unknown-linux-musl

ENV PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig/

RUN echo "Building OpenSSL" && \
    ls /usr/include/linux && \
    sudo mkdir -p /usr/local/musl/include && \
    sudo ln -s /usr/include/linux /usr/local/musl/include/linux && \
    sudo ln -s /usr/include/x86_64-linux-gnu/asm /usr/local/musl/include/asm && \
    sudo ln -s /usr/include/asm-generic /usr/local/musl/include/asm-generic && \
    cd /tmp && \
    curl -LO "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz" && \
    tar xvzf "openssl-$OPENSSL_VERSION.tar.gz" && cd "openssl-$OPENSSL_VERSION" && \
    env CC=musl-gcc ./Configure no-shared no-zlib -fPIC --prefix=/usr/local/musl -DOPENSSL_NO_SECURE_MEMORY linux-x86_64 && \
    env C_INCLUDE_PATH=/usr/local/musl/include/ make depend && \
    env C_INCLUDE_PATH=/usr/local/musl/include/ make && \
    sudo make install && \
    sudo rm /usr/local/musl/include/linux /usr/local/musl/include/asm /usr/local/musl/include/asm-generic && \
    rm -r /tmp/*

ENV OPENSSL_DIR=/usr/local/musl/ssl \
    PKG_CONFIG_PATH=/usr/local/musl/lib/pkgconfig \
    OPENSSL_LIB_DIR=/usr/local/musl/lib \
    OPENSSL_INCLUDE_DIR=/usr/local/musl/include

WORKDIR /usr/src/kiamexample
COPY . .
RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl


# ------------------------------------------------------------------------------
# App
# ------------------------------------------------------------------------------

FROM alpine:latest

RUN apk add tzdata
RUN apk update && apk upgrade

COPY --from=cargo-build /usr/src/kiamexample/target/x86_64-unknown-linux-musl/release/rust-kiam_upload_to_s3 /opt/kiamexample/app

ENV RUST_BACKTRACE=1

CMD ["/opt/kiamexample/app"]