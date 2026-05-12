#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/gregory01234/control-node.git"
REPO_DIR="$(basename "$REPO_URL" .git)"

echo "=== START: CONTROL NODE BOOTSTRAP ==="

# 1. Clone repo if missing
if [ ! -d "$REPO_DIR" ]; then
  echo "[INFO] Cloning repo..."
  git clone "$REPO_URL"
else
  echo "[INFO] Repo already exists, pulling latest changes..."
  cd "$REPO_DIR"
  git pull
  cd ..
fi

cd "$REPO_DIR"

echo "[INFO] Current directory: $(pwd)"
echo "[INFO] Listing contents:"
ls -ლა

# 2. Detect ansible directory (more robust than hardcoding path)
if [ -d "ansible" ]; then
  cd ansible
elif [ -d "ansible/playbooks" ]; then
  cd ansible
elif [ -d "playbooks" ]; then
  cd playbooks
  echo "[WARN] Using fallback playbooks directory"
else
  echo "❌ ERROR: Cannot find ansible directory"
  echo "Available structure:"
  find . -maxdepth 3 -type d
  exit 1
fi

echo "[SUCCESS] Entered Ansible directory: $(pwd)"

# 3. Basic validation
if ! command -v ansible >/dev/null 2>&1; then
  echo "[INFO] Ansible installed correctly"
else
  echo "[INFO] Ansible version:"
  ansible --version | head -n 1
fi

echo "=== BOOTSTRAP COMPLETE ==="
