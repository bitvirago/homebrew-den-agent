class BitriseDenAgentAT2525 < Formula
  desc "CLI for Bitrise DEN agent"
  homepage "https://github.com/bitrise-io/bitrise-den-agent"
  url "https://github.com/bitrise-io/bitrise-den-agent.git",
    tag:      "v2.52.5",
    revision: "0a68312bbaa7801bffdff8720dc2cd4386e7c61c"
  license ""

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.52.5/bitrise-den-agent-darwin-arm64.zip"
      sha256 "9feb18d6ea3a031b0400053ad557adc7180932ca39f956536db2fc2bf78029fb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.52.5/bitrise-den-agent-darwin-amd64.zip"
      sha256 "f905c37c1069954e7320b3cfca4b66c74ee5746c1f84d243058ad56851e9dfb7"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.52.5/bitrise-den-agent-linux-amd64.zip"
      sha256 "278ba51e226d445104dd1619740ee4930469960bb1706ad965984f7e4a47a8f5"
    end
  end

  def install
    bin.install "bitrise-den-agent"
  end

  test do
    system "#{bin}/bitrise-den-agent"
  end
end
