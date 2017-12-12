#!/usr/bin/env bash

source vars.sh

function ssh_docker() {
	local DOCKER_NAME_NOW=`docker ps | grep androtest | awk '{print $2}'`
	local SSHPORT=`docker port ${DOCKER_NAME_NOW} 22 | awk '{split($1,a,":");print a[2]}'`
	[[ ${isRunning} == "" ]] && echo "SSH port is not available" && exit 1
	[[ ${isRunning} != "" ]] && ssh root@0.0.0.0 -p "${SSHPORT}"
}


isRunning=`docker ps --filter "name=${DOCKER_NAME}" --format "table {{.Image}}" | wc -l`
[[ nOtherContainer -eq 0 ]] && echo "is not running" && exit 1

if [[ ${isRunning} -gt 0 ]]; then
	ssh_docker
fi
