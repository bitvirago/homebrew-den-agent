class BitriseDenAgentAT2125 < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.1.25",
        revision: "2f7651c91a227e3c9e160076c2862dbae373b922"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.25/bitrise-den-agent-darwin-arm64.zip"
        sha256 "83ac4766e9c2011a513348e25cac6f9d951ba9ab2624ff21690a3f1c8c6102d8"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.25/bitrise-den-agent-darwin-amd64.zip"
        sha256 "c2aeb573695d84549567d3fcc27527281cb24f6d9be7f8ae00ac8a9e1ba30446"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.25/bitrise-den-agent-linux-amd64.zip"
        sha256 "7b5dcdb528c5245e6498e09eedfd467c7c1716ff87b0c748e7425d9947f126b4"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
  