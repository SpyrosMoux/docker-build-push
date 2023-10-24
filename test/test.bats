#!/usr/bin/env bats

setup() {
  DOCKER_IMAGE=${DOCKER_IMAGE:="test/docker-build-push"}
  DOCKER_USERNAME=${DOCKER_USERNAME:=""}
  DOCKER_PASSWORD=${DOCKER_PASSWORD:=""}

  echo "Building image..."
  docker build -t ${DOCKER_IMAGE}:test .
}

@test "Dummy test" {
    run echo "username: ${DOCKER_USERNAME}"
    run docker run \
        -e ACCOUNT_NAME="spyrosmoux" \
        -e IMAGE_NAME="ci-test" \
        -e DOCKER_USERNAME=${DOCKER_USERNAME} \
        -e DOCKER_PASSWORD=${DOCKER_PASSWORD} \
        -e DEBUG="true" \
        -v $(pwd):$(pwd) \
        -w $(pwd) \
        -v /var/run/docker.sock:/var/run/docker.sock \
        ${DOCKER_IMAGE}:test

    echo "Status: $status"
    echo "Output: $output"

    [ "$status" -eq 0 ]
}

