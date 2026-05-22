#!/usr/bin/env bash
set -euo pipefail

echo "platform-helper health check"

command -v curl >/dev/null 2>&1 || { echo "missing: curl"; exit 1; }
command -v bash >/dev/null 2>&1 || { echo "missing: bash"; exit 1; }

echo "all checks passed"
