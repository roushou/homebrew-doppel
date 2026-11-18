class Doppel < Formula
  desc "Isolated macOS machines for AI agents"
  homepage "https://github.com/roushou/doppel"
  url "https://github.com/roushou/doppel/releases/download/v0.1.0/doppel-0.1.0-macos-arm64.tar.gz"
  sha256 "81e90d8c9fd30430578f9f3bc3203a1b98432dfd27ca7f05ad972a535566458b"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on arch: :arm64
  depends_on :macos

  def install
    # Together, so doppel finds the VMM and the guest agent beside it.
    libexec.install "doppel", "doppel-vmm", "doppel-agent.zip", "doppel-agent.build-id", "doppel-agent.csreq"
    bin.install_symlink libexec/"doppel"
  end

  def caveats
    <<~EOS
      Start the daemon at login, then check what's missing:
        doppel daemon install
        doppel doctor
    EOS
  end

  test do
    assert_match "doppel #{version}", shell_output("#{bin}/doppel --version")
  end
end
