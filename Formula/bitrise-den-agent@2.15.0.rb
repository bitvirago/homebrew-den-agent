class BitriseDenAgentAT2150 < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.15.0",
        revision: "3d724928a5d075c4bee971880d6a1dfa34fbeeed"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.15.0/bitrise-den-agent-darwin-arm64.zip"
        sha256 "9e36daa6c66a1043dd91f94f4a865cf1fa13951be6e3e0285a3d10864975befd"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.15.0/bitrise-den-agent-darwin-amd64.zip"
        sha256 "788faebabc240dcc1f04d180c8184b8555587f82245a392a0a9fee69aa066ef0"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.15.0/bitrise-den-agent-linux-amd64.zip"
        sha256 "42c5f85b9516e83e6208f8c1c77b407de1355e00f681885d67632423fa8108df"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
