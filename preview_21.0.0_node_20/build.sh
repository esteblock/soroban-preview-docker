#!/bin/bash

# Build image and tag it with image name and version
docker build . \
    --tag esteblock/soroban-preview:21.0.0_node_20