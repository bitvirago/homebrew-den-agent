class BitriseDenAgent < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.10.3",
        revision: "773b44a855cebb2a7ba40624495c502249211993"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.10.3/bitrise-den-agent-darwin-arm64.zip"
        sha256 "98583ffde7cdc1bb6ace73e196e72c337dcfa4d854d2cab087926c2f34f055d3"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.10.3/bitrise-den-agent-darwin-amd64.zip"
        sha256 "b2dacfd580fc0a921f199b6da197e4458fd18559e345bf038b1be8e7244077c6"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.10.3/bitrise-den-agent-linux-amd64.zip"
        sha256 "960a06bc68d9b34cadfa35c7c53908d722acd27752dbddbe0307a213f2707eb4"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
  