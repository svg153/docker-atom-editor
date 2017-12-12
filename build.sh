#!/usr/bin/env bash

source vars.sh


docker build \
    --file Dockerfile \
    --tag ${DOCKER_NAME} \
    .
