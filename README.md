# joplin-proxy-docker

- Joplin: https://joplinapp.org/
- Joplin Repository: https://github.com/laurent22/joplin


## How to run
Download `run_*.sh` and follow instructions below.

### macOS
1. Run `xhost + localhost`.
2. Execute `run_macos.sh`.

### Ubuntu
1. Run `xhost + local:joplin`.
2. execute `run_ubuntu.sh`.


## Font Config
Use "Noto Mono" as monospace font in editor: https://www.google.com/get/noto/#mono-mono


## Source of chrome.json
chrome.json: https://github.com/jessfraz/dotfiles/blob/d4d29613a2493805aad2c9ad1aa33005c5140688/etc/docker/seccomp/chrome.json

https://github.com/jessfraz/dockerfiles/blob/6e1142c2078ba65f306b518137313fa00114db0c/chrome/stable/Dockerfile

## Libraries
- go-transproxy: https://github.com/wadahiro/go-transproxy
