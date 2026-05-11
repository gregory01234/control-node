#!/bin/bash

set -e

echo "[DEPLOY] Running Ansible bootstrap..."

ansible-playbook \
  -i ansible/inventory/hosts.ini \
  ansible/playbooks/bootstrap-control-plane.yml

echo "[DEPLOY] Finished."
