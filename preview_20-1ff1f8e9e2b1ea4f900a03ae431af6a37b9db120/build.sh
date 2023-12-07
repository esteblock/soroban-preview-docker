#!/bin/bash

# Build image and tag it with image name and version
docker build . \
    --tag esteblock/soroban-preview:20-1ff1f8e9e2b1ea4f900a03ae431af6a37b9db120 \
    --force-rm \
    --rm
