class Doppel < Formula
  desc "Isolated macOS machines for AI agents"
  homepage "https://github.com/roushou/doppel"
  url "https://github.com/roushou/doppel/releases/download/v0.2.0/doppel-0.2.0-macos-arm64.tar.gz"
  sha256 "98c838095f594215f0736e720063cd305d8845b0f225751e3a74887698a39f7f"
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
      Make a golden image for agents (downloads macOS; takes a while):
        doppel setup
    EOS
  end

  test do
    assert_match "doppel #{version}", shell_output("#{bin}/doppel --version")
  end
end
