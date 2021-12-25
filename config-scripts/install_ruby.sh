#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo apt update -y
sudo apt install -y ruby-full ruby-bundler build-essential apt-transport-https ca-certificates
