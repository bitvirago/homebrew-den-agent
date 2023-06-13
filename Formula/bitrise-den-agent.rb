class BitriseDenAgent < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v.0.0.1-alpha/bitrise-den-agent.zip"
  sha256 "a7b33a2d62b62bb0d61e0dba2eaa4b7b6b6a67b38b0d4fe21210caa87998a491"
  license "MIT"

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
