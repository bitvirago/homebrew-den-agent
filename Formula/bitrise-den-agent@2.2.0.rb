class BitriseDenAgentAT220 < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.2.0",
        revision: "7eebb6de9b2c379b1817ab2a900a8e5334d4a3e6"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.2.0/bitrise-den-agent-darwin-arm64.zip"
        sha256 "7ba06390cb11f95561d38981d43a22db46bef2f973f7af993841ec3872f436fc"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.2.0/bitrise-den-agent-darwin-amd64.zip"
        sha256 "85f497987b1e60110474bc34b6cdf9016255827bf179bdf3f701ec5941648bbb"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.2.0/bitrise-den-agent-linux-amd64.zip"
        sha256 "b3a3b57781fa35ced89b8b93eb94c2d3c6a6c6a1d768f88a57aa39679abc29b7"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
  