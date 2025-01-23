#!/bin/bash

# Build image and tag it with image name and version
docker build --no-cache . \
    --tag esteblock/soroban-preview:21.0.1-scout-audit