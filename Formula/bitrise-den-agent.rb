class BitriseDenAgent < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  url "https://github.com/tailscale/tailscale.git",
      tag:      "v2.1.23",
      revision: "184157c231882b17a5a831a7020c86efa8964abe"
  license ""

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.23/bitrise-den-agent-darwin-arm64.zip"
      sha256 "e084ffef3919da6e6728c92080a154e3d12901d4fa3e1c701c5d1383965d9cd1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.23/bitrise-den-agent-darwin-amd64.zip"
      sha256 "7df90164c5502a83948517810716ae65110df12b42d98b7f1d6cbd8ce6be6eea"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.23/bitrise-den-agent-linux-amd64.zip"
      sha256 "220f681c45fdb25e83cc995128ee6f58c27a14376543ef22109bd1e91bcc7a4b"
    end
  end

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
