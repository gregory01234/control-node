#!/bin/bash

set -e

echo "[DEPLOY] Running Ansible bootstrap..."

ansible-playbook \
  -i ansible/inventory/hosts.ini \
  ansible-playbook ansible/site.yml

echo "[DEPLOY] Finished."
