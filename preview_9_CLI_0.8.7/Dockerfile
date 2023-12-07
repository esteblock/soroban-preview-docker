# Based on Soroban Preview 7
# https://soroban.stellar.org/docs/reference/releases

FROM ubuntu:20.04

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
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && . ~/.bashrc \
    && nvm install 17.9.1 && nvm use 17.9.1

ENV NODE_VERSION=17.9.1
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

RUN apt update && apt install -y git

# WORKDIR /
RUN mkdir /workspace
WORKDIR /workspace
ENV IS_USING_DOCKER=true

RUN corepack enable

RUN cargo install --locked --version 0.8.7 soroban-cli