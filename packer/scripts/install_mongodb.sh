#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [ arch=amd64,arm64  ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list

apt update -y
apt install -y mongodb-org
systemctl enable mongod
systemctl start mongod
