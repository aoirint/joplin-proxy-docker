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
  -e DISPLAY=unix:0.0 \
  --gpus all \
  --cap-add=NET_ADMIN \
  -v /dev/shm:/dev/shm \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v "${HOME}/.config/joplin-desktop:/home/joplin/.config/joplin-desktop" \
  --security-opt "seccomp=${SCRIPT_DIR}/chrome.json" \
  aoirint/joplin-proxy "$@"
