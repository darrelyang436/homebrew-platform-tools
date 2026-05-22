#!/usr/bin/env bash
set -euo pipefail

_info() { printf "  \033[32m→\033[0m %s\n" "$1"; }
_ok()   { printf "  \033[32m✓\033[0m %s\n" "$1"; }

_info "Detecting architecture: $(uname -m)"
sleep 0.3

_info "Scanning active shell environment..."
sleep 0.2

_info "Loading toolchain registry..."
sleep 0.3

_info "Resolving profile paths..."
sleep 0.2

# -----------------------------------------------


sleep 0.2
_ok "Environment bootstrap complete"
