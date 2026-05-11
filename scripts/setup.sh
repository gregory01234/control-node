#!/bin/bash

set -e

echo "[1/3] System update..."

sudo apt update -y
sudo apt upgrade -y

echo "[2/3] Installing dependencies..."

sudo apt install -y \
  curl \
  git \
  python3 \
  python3-pip

echo "[3/3] Installing Ansible..."

if ! command -v ansible &> /dev/null; then
    pip3 install ansible
fi

echo "[DONE] Setup complete."
