#!/bin/bash
set -e
APP_DIR=${1:-$HOME}

sleep 30
sudo apt-get install -y nginx

sudo mv /tmp/nginx.conf /etc/nginx/nginx.conf

sudo systemctl start nginx
sudo systemctl enable enable
