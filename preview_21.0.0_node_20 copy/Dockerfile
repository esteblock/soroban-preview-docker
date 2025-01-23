# Based on Soroban Preview 7
# https://soroban.stellar.org/docs/reference/releases

FROM ubuntu:20.04

RUN mkdir -p /etc/systemd/system/docker.service.d
RUN echo -e "[Service]\nExecStart=\nExecStart=/usr/bin/dockerd --storage-driver=overlay2" > /etc/systemd/system/docker.service.d/override.conf


RUN apt update
RUN apt install -y nano
RUN apt install -y curl

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust_install.sh
RUN sh rust_install.sh -y
RUN echo $PATH
ENV PATH="$PATH:/root/.cargo/bin"
RUN rustup target add wasm32-unknown-unknown

RUN apt install -y build-essential

RUN apt install -y jq
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . ~/.bashrc \
    && nvm install 20.18.0 && nvm use 20.18.0

ENV NODE_VERSION=20.18.0
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN apt update && apt install -y git

# WORKDIR /
RUN mkdir /workspace
WORKDIR /workspace
ENV IS_USING_DOCKER=true

#Forcing to only use the rust version installed when building the image
RUN rustc_version=$(rustc --version | cut -d' ' -f2) && \
    rustup override set $rustc_version

RUN corepack enable
RUN touch .update
## THIS NEXT LINE SHOULD BE THE ONLY ONE TO CHANGE BETWEEN SOROBAN PREVIEWS
RUN cargo install --locked --version 21.0.0 stellar-cli
RUN rustup target add wasm32-unknown-unknown

# Install scout-audit
# Set environment variables required to install pkg-config in an non interactive way
ENV DEBIAN_FRONTEND=noninteractive
RUN apt install -y pkg-config
RUN apt install -y libssl-dev
RUN rustup toolchain install nightly-2023-12-16
RUN rustup default nightly-2023-12-16
RUN rustup component add rust-src --toolchain nightly-2023-12-16
RUN cargo install cargo-dylint dylint-link
RUN cargo install cargo-scout-audit
