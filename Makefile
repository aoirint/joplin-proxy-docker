.PHONY: build

SCRIPT_DIR = $(shell dirname "$(realpath "$(firstword "$(MAKEFILE_LIST)")")")
IMAGE_TAG  = dev-alpine

HOST_UID   = $(shell id -u)
HOST_GID   = $(shell id -g)

build:
	docker build "$(SCRIPT_DIR)/docker" \
	  -t aoirint/joplin-proxy:$(IMAGE_TAG) \
	  --build-arg HTTP_PROXY \
		--build-arg HTTPS_PROXY \
	  --build-arg NO_PROXY

run-ubuntu:
	docker run --rm -it \
	  -e HTTP_PROXY \
	  -e HTTPS_PROXY \
	  -e NO_PROXY \
	  -e "HOST_UID=$(HOST_UID)" \
	  -e "HOST_GID=$(HOST_GID)" \
	  -e DISPLAY=unix:0.0 \
	  --gpus all \
	  --cap-add=NET_ADMIN \
	  -v /dev/shm:/dev/shm \
	  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
	  -v "$(HOME)/.config/joplin-desktop:/home/node/.config/joplin-desktop" \
	  --security-opt "seccomp=$(SCRIPT_DIR)/chrome.json" \
	  aoirint/joplin-proxy:$(IMAGE_TAG)
