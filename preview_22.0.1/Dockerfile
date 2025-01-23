# Based on Soroban Preview 7
# https://soroban.stellar.org/docs/reference/releases

FROM ubuntu:24.04

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

# MERCURY CLI
ENV PATH="/root/.cargo/bin:$PATH"
RUN apt install -y pkg-config libssl-dev
RUN cargo install mercury-cli@0.2.1

RUN corepack enable
RUN touch .update
## THIS NEXT LINE SHOULD BE THE ONLY ONE TO CHANGE BETWEEN SOROBAN PREVIEWS
RUN rustup target add wasm32-unknown-unknown
RUN cargo install --locked stellar-cli --version 22.0.1 --features opt  
RUN echo "source <(stellar completion --shell bash)" >> ~/.bashrc