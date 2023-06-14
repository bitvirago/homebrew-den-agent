class BitriseDenAgentAT215 < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.5-alpha/bitrise-den-agent-darwin-arm64.zip"
      sha256 "f54833680b26ccf4532f30b0ab3b7e322dfb1cb37cb29dfd21545919650ef9f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.5-alpha/bitrise-den-agent-darwin-amd64.zip"
      sha256 "ae594544497c8d681e206fcecacddedd0a352b7a03aaf12b77a05e202254eb9d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.5-alpha/bitrise-den-agent-linux-amd64.zip"
      sha256 "04a11108b1e3cbe156f1196efc3fe7a6f62e3d466b3c316aed5f350b716b6c58"
    end
  end

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
