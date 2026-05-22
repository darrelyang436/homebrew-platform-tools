#!/usr/bin/env bash
set -euo pipefail

brew uninstall platform-helper 2>/dev/null || true
brew untap demo/platform-tools 2>/dev/null || true

echo "platform-helper removed"
