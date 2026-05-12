#!/bin/bash
set -euo pipefail

REPO_URL="https://github.com/gregory01234/control-node.git"
REPO_DIR="control-node"

echo "=== INSTALL (CLEAN CLONE MODE) ==="

# 🔴 zawsze zaczynamy od czystego stanu
if [ -d "$REPO_DIR" ]; then
  echo "[INFO] Removing old repo..."
  rm -rf "$REPO_DIR"
fi

echo "[INFO] Cloning full repository..."
git clone "$REPO_URL" "$REPO_DIR"

cd "$REPO_DIR"

echo "[OK] Repo fully cloned at: $(pwd)"

# 🔵 opcjonalnie: tylko informacja, NIE uruchamiamy nic
echo "[INFO] Available scripts:"
ls -ლა scripts 2>/dev/null || echo "No scripts directory found"

echo "=== INSTALL COMPLETE ==="
