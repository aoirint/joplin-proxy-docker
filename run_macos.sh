#!/bin/bash
docker run --rm -it \
  -e HTTP_PROXY \
  -e HTTPS_PROXY \
  -e DISPLAY=host.docker.internal:0 \
  --cap-add=NET_ADMIN \
  -v /dev/shm:/dev/shm \
  -v $HOME/.config/joplin-desktop:/home/joplin/.config/joplin-desktop \
  --security-opt seccomp=$PWD/chrome.json \
  aoirint/joplin-proxy "$@"
