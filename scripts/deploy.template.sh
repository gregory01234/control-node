#!/bin/bash

set -euo pipefail

echo "=================================="
echo " CONTROL-PLANE DEPLOY PIPELINE"
echo "=================================="

# 1. CHECK DEPENDENCIES
echo "[1/4] Checking dependencies..."

command -v ansible >/dev/null 2>&1 || {
  echo "[ERROR] Ansible not installed"
  exit 1
}

command -v kubectl >/dev/null 2>&1 || {
  echo "[ERROR] kubectl not installed"
  exit 1
}

echo "[OK] Dependencies ready"

# 2. CHECK INVENTORY
echo "[2/4] Checking inventory file..."

if [ ! -f "ansible/inventory/hosts.ini" ]; then
  echo "[ERROR] Missing inventory file"
  exit 1
fi

echo "[OK] Inventory found"

# 3. RUN ANSIBLE PIPELINE
echo "[3/4] Running Ansible bootstrap playbook..."

ansible-playbook \
  -i ansible/inventory/hosts.ini \
  ansible/playbooks/bootstrap-control-plane.yml

echo "[OK] Ansible execution completed"

# 4. POST-CHECK (pipeline validation)
echo "[4/4] Verifying cluster state..."

kubectl get nodes
kubectl get ns control-system || true
kubectl get pods -n control-system || true
kubectl get svc -n control-system || true

echo "=================================="
echo " DEPLOY PIPELINE FINISHED SUCCESSFULLY"
echo "=================================="
