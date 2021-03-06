# joplin-proxy-docker

Run Joplin Desktop App behind HTTP Proxy.

- Joplin: https://joplinapp.org/
- Joplin Repository: https://github.com/laurent22/joplin


## How to run
1. Download `run_*.sh`, `chrome.json` from [aoirint/joplin-proxy-docker](https://github.com/aoirint/joplin-proxy-docker) into a directory.
2. Set `HTTP_PROXY`, `HTTPS_PROXY`, `NO_PROXY` env vars.
`NO_PROXY` is also IMPORTANT!
(ex. `export NO_PROXY=192.168.0.0/16,172.16.0.0/16`)

### Ubuntu
1. Execute `run_ubuntu.sh`.

### macOS / xQuartz (GUI is slow)
1. Run `xhost + localhost`.
2. Execute `run_macos.sh`.


## Font Config
Use "Noto Mono" as monospace font in editor: https://www.google.com/get/noto/#mono-mono


## Source of chrome.json
- https://github.com/jessfraz/dotfiles/blob/d4d29613a2493805aad2c9ad1aa33005c5140688/etc/docker/seccomp/chrome.json
- https://github.com/jessfraz/dockerfiles/blob/6e1142c2078ba65f306b518137313fa00114db0c/chrome/stable/Dockerfile

## Libraries
- go-transproxy: https://github.com/wadahiro/go-transproxy
