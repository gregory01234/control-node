#!/bin/bash

set -e

echo "=== START: CONTROL NODE BOOTSTRAP ==="

# =========================
# 1. UPDATE SYSTEM
# =========================
sudo apt update && sudo apt upgrade -y

# =========================
# 2. INSTALL DEPENDENCIES
# =========================
sudo apt install -y ansible git

# =========================
# 3. CLONE REPOSITORY
# =========================
REPO_URL="https://github.com/TWOJ_LOGIN/ai-control-node.git"

if [ -d "ai-control-node" ]; then
    echo "Repo already exists, pulling updates..."
    cd ai-control-node && git pull
    cd ..
else
    git clone $REPO_URL
fi

# =========================
# 4. RUN ANSIBLE PLAYBOOK
# =========================
cd ai-control-node/ansible

echo "Running Ansible playbook: site.yml"

ansible-playbook site.yml

echo "=== DONE: SYSTEM BOOTSTRAP COMPLETE ==="
