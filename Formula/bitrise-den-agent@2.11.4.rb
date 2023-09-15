class BitriseDenAgentAT2114 < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.11.4",
        revision: "933a98322cf1858e138ac708c2ed3e9bd851ba75"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.11.4/bitrise-den-agent-darwin-arm64.zip"
        sha256 "0aac0aa70e17ce04ca73b5a7b82effb724990a29529b7e58b46fab079d54eb57"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.11.4/bitrise-den-agent-darwin-amd64.zip"
        sha256 "5c021727006f68055cb03659639ddfc822195045f955f256f3980bf9fb5bd219"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.11.4/bitrise-den-agent-linux-amd64.zip"
        sha256 "cbae5f39875a398cf484d03062ed1936925343c0ee3547c582d6b9b1ae17555f"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
