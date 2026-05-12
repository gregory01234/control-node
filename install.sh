#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/gregory01234/control-node.git"
REPO_DIR="$(basename "$REPO_URL" .git)"

echo "=== START: CONTROL NODE BOOTSTRAP ==="

# 1. Clone or update repo
if [ -d "$REPO_DIR" ]; then
  echo "[INFO] Repo already exists → updating"
  cd "$REPO_DIR"
  git pull --ff-only
else
  echo "[INFO] Cloning repo"
  git clone "$REPO_URL"
  cd "$REPO_DIR"
fi

echo "[INFO] Working directory: $(pwd)"

# 2. Clean and safe listing (no alias issues, no weird encoding)
echo "[INFO] Repository contents:"
/bin/ls -la

# 3. Detect Ansible directory safely
ANSIBLE_DIR=""

if [ -d "ansible" ]; then
  ANSIBLE_DIR="ansible"
elif [ -d "ansible/playbooks" ]; then
  ANSIBLE_DIR="ansible"
elif [ -d "playbooks" ]; then
  ANSIBLE_DIR="playbooks"
fi

if [ -z "$ANSIBLE_DIR" ]; then
  echo "❌ ERROR: Cannot find ansible or playbooks directory"
  echo "Available directories:"
  find . -maxdepth 2 -type d
  exit 1
fi

cd "$ANSIBLE_DIR"

echo "[SUCCESS] Entered directory: $(pwd)"

# 4. Check ansible installation
if command -v ansible >/dev/null 2>&1; then
  echo "[INFO] Ansible installed:"
  ansible --version | head -n 1
else
  echo "⚠️ Ansible not found (installation should have handled it earlier)"
fi

echo "=== BOOTSTRAP COMPLETE ==="
