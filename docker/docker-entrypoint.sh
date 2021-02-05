#!/bin/ash

set -u

# For Docker Desktop, changing owner id of many files is very slow and unnecessary.
# So disable this with USE_CONTAINER_UID=1
# For Linux Docker, USE_CONTAINER_UID=0 in order to use the same user id as the host user id.
if [[ "${USE_CONTAINER_UID:-0}" == "0" ]]; then
  usermod -u "${HOST_UID}" node
  groupmod -g "${HOST_GID}" node
fi

set -eu

ash -c "transproxy -disable-iptables -dns-over-https-enabled" &

# iptables -t nat -I OUTPUT -p tcp --dport 53 -j REDIRECT --to-ports 3131
# iptables -t nat -I OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 3131
iptables -t nat -I OUTPUT -p tcp --dport 80 -j REDIRECT --to-ports 3129
iptables -t nat -I OUTPUT -p tcp --dport 443 -j REDIRECT --to-ports 3130

su-exec node "$@"
