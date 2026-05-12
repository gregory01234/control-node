#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/gregory01234/control-node.git"
REPO_DIR="control-node"

echo "=== INSTALL (NODE ONLY) ==="

if [ -d "$REPO_DIR" ]; then
  cd "$REPO_DIR"
  git pull --ff-only
else
  git clone "$REPO_URL"
  cd "$REPO_DIR"
fi

echo "[OK] Repo ready"
echo "NODE (Ollama / masternode) nie jest tu uruchamiany"
