class BitriseDenAgent < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.5-alpha/bitrise-den-agent-darwin-arm64.zip"
      sha256 "efa19e324e5902b7a2b9c489823ed6bdddbe9168c1a2815f8cf1849c1b4a0de0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.5-alpha/bitrise-den-agent-darwin-amd64.zip"
      sha256 "410ac10497651b2555d7e09941409f3b8f8469abe957e898f9ace42141d54540"
    end
  end

  on_linux do
    url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.5-alpha/bitrise-den-agent-linux-amd64.zip"
    sha256 "72fe8137e9f6b4b1ce45a74053af2f6daff0abab1d06e694b943027e473fcdaa"
  end

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
