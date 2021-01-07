#!/bin/bash

set -eu

SCRIPT_DIR=$(dirname $(realpath $0))

docker run --rm -it \
  -e HTTP_PROXY \
  -e HTTPS_PROXY \
  -e NO_PROXY \
  -e "HOST_UID=$(id -u)" \
  -e "HOST_GID=$(id -g)" \
  -v "$PWD/docker/docker-entrypoint.sh:/docker-entrypoint.sh" \
  -e DISPLAY=host.docker.internal:0 \
  --cap-add=NET_ADMIN \
  -v /dev/shm:/dev/shm \
  -v "${HOME}/.config/joplin-desktop:/home/joplin/.config/joplin-desktop" \
  --security-opt "seccomp=${SCRIPT_DIR}/chrome.json" \
  aoirint/joplin-proxy "$@"
