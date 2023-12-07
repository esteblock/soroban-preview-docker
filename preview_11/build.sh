#!/bin/bash

# Build image and tag it with image name and version
docker build . \
    --tag esteblock/soroban-preview:20.0.0-rc4 \
    --no-cache \
    --force-rm \
    --rm
