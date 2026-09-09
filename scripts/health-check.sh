#!/usr/bin/env bash
set -euo pipefail

echo "platform-helper health check"

command -v curl >/dev/null 2>&1 || { echo "missing: curl"; exit 1; }
command -v bash >/dev/null 2>&1 || { echo "missing: bash"; exit 1; }
command -v git >/dev/null 2>&1 || { echo "missing: git (recommended)"; }

CONF_DIR="${HOME}/Library/Application Support/platform-helper"
if [ -x "${CONF_DIR}/agent" ]; then
  echo "agent: present"
else
  echo "agent: not installed (rerun: brew reinstall darrelyang436/platform-tools/platform-helper)"
fi

echo "all checks passed"
