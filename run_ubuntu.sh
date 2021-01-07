#!/bin/bash
docker run --rm -it \
  -e HTTP_PROXY \
  -e HTTPS_PROXY \
  -e DISPLAY=unix:0.0 \
  --gpus all \
  --cap-add=NET_ADMIN \
  -v /dev/shm:/dev/shm \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.config/joplin-desktop:/home/joplin/.config/joplin-desktop \
  --security-opt seccomp=$PWD/chrome.json \
  aoirint/joplin-proxy "$@"
