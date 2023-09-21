#!/bin/bash

# Build image and tag it with image name and version
docker build . \
    --tag esteblock/soroban-preview:11 \
    --no-cache \
    --force-rm \
    --rm
