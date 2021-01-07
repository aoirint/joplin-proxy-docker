#!/bin/bash
docker build ./docker \
  -t aoirint/joplin-proxy \
  --build-arg HTTP_PROXY \
  --build-arg HTTPS_PROXY
