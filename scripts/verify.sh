#!/bin/bash

set -e

echo "[VERIFY] Cluster state:"

kubectl get nodes
kubectl get ns control-system || true
kubectl get pods -n control-system || true
kubectl get svc -n control-system || true

echo "[VERIFY] Running Python deep check..."

python3 scripts_py/verify_cluster.py
