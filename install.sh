#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/gregory01234/control-node.git"
REPO_DIR="control-node"
BRANCH="bootstrap"

echo "=== INSTALL (BOOTSTRAP BRANCH) ==="

rm -rf "$REPO_DIR"

git clone --branch "$BRANCH" "$REPO_URL" "$REPO_DIR"

cd "$REPO_DIR"

echo "[OK] Repo cloned from branch: $BRANCH"
echo "[INFO] Scripts:"
ls -la scripts
