#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sleep 30 # waiting some time to acquire lock for apt install
apt update -y
apt install -y ruby-full ruby-bundler build-essential apt-transport-https ca-certificates
