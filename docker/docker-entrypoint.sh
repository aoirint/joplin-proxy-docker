#!/bin/bash

bash -c "transproxy -disable-iptables -dns-over-https-enabled" &

# iptables -t nat -I OUTPUT -p tcp --dport 53 -j REDIRECT --to-ports 3131
# iptables -t nat -I OUTPUT -p udp --dport 53 -j REDIRECT --to-ports 3131
iptables -t nat -I OUTPUT -p tcp --dport 80 -j REDIRECT --to-ports 3129
iptables -t nat -I OUTPUT -p tcp --dport 443 -j REDIRECT --to-ports 3130

gosu joplin "$@"
