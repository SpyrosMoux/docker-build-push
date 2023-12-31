#!/usr/bin/env bash
#
# Build and push a docker image to DockerHub
#

source "$(dirname "$0")/common.sh"

info "Executing the pipe..."

# Required parameters
ACCOUNT_NAME=${ACCOUNT_NAME:?'ACCOUNT_NAME variable missing.'}
IMAGE_NAME=${IMAGE_NAME:?'NAME variable missing.'}


# Default parameters
DEBUG=${DEBUG:="false"}
PUSH=${PUSH:="false"}
DOCKERFILE=${DOCKERFILE:="."}
DOCKER_USERNAME=${DOCKER_USERNAME:=""}
DOCKER_PASSWORD=${DOCKER_PASSWORD:=""}
IMAGE_TAG=${IMAGE_TAG:="latest"}
REGISTRY_URL=${REGISTRY_URL:="https://index.docker.io/v1/"}

run docker build -t ${ACCOUNT_NAME}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKERFILE}

if [[ "${PUSH}" == "true" ]]; then
  echo "$DOCKER_PASSWORD" | docker login ${REGISTRY_URL} -u ${DOCKER_USERNAME} --password-stdin
  run docker push ${ACCOUNT_NAME}/${IMAGE_NAME}:${IMAGE_TAG}
fi


if [[ "${status}" == "0" ]]; then
  success "Success!"
else
  fail "Error!"
fi
