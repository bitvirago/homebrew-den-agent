class BitriseDenAgent < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v.0.0.1-alpha/bitrise-den-agent.tar.gz"
  sha256 "ef97d3a987df69209f696d1271502650ad31876b3d9fb8d206d1081f9ab3d69c"
  license "MIT"

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
