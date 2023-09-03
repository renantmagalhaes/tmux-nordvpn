#!/usr/bin/env bash

print_nordvpn_ip() {
    nordvpn status | sed -n -e 's/IP: \(.*\)/\1/p'
}

print_nordvpn_ip
