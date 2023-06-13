class BitriseDenAgent < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v.0.0.1-alpha/bitrise-den-agent.zip"
  sha256 "f54833680b26ccf4532f30b0ab3b7e322dfb1cb37cb29dfd21545919650ef9f3"
  license "MIT"

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
