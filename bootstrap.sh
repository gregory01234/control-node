#!/bin/bash

set -e

echo "=================================="
echo " CONTROL-NODE BOOTSTRAP START"
echo "=================================="

bash scripts/setup.sh
bash scripts/deploy.sh
bash scripts/verify.sh

echo "=================================="
echo " BOOTSTRAP FINISHED"
echo "=================================="
