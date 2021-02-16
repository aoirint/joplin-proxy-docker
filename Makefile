.PHONY: build

build:
	docker build ./docker \
	  -t aoirint/joplin-proxy \
	  --build-arg HTTP_PROXY \
		--build-arg HTTPS_PROXY \
	  --build-arg NO_PROXY
