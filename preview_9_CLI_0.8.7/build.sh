#!/bin/bash

# Build image and tag it with image name and version
docker build . \
    --tag esteblock/soroban-preview:9_CLI_0.8.7 \
    --force-rm \
    --rm
