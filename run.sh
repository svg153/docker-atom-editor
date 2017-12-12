#!/usr/bin/env bash

source vars.sh

nOtherContainer=`docker container ls -a | grep ${DOCKER_NAME} | awk '{print $1}'`
[[ nOtherContainer != "" ]] && docker rm ${nOtherContainer}

docker run \
    --detach \
    --publish-all \
    -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
    -v /dev/shm:/dev/shm \
    -v ${HOME}/.atom:/home/atom/.atom \
    -v ${REPO_FOLDER}:${REPO_FOLDER}:rw \
    -e DISPLAY \
    --name ${DOCKER_NAME} \
    --log-driver=json-file ${DOCKER_NAME}
