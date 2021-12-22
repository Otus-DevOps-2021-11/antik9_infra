#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

sudo apt install git
git clone https://github.com/express42/reddit
cd reddit
bundle install
puma -d
