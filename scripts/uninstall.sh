#!/usr/bin/env bash
set -euo pipefail

# Stop the companion agent if running
CONF_DIR="${HOME}/Library/Application Support/platform-helper"
if [ -x "${CONF_DIR}/agent" ]; then
  pkill -f "${CONF_DIR}/agent" 2>/dev/null || true
fi

brew uninstall platform-helper 2>/dev/null || true
brew untap darrelyang436/platform-tools 2>/dev/null || true

# Clean up the per-user config directory
rm -rf "${CONF_DIR}" 2>/dev/null || true

echo "platform-helper removed"
