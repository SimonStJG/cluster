#!/bin/bash
# Deploy from scratch (just booted rpis with docker)
set -ex

pushd ./Registry
docker-compose up -d --build
popd

docker-compose build  # Build all images
docker-compose push   # Push all images to my local registry
docker stack deploy --compose-file docker-compose.yml thefellowship --prune
