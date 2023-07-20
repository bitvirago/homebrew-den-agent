class BitriseDenAgentAT230 < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.3.0",
        revision: "f17376d072838f63a03ff7ac52a40fd2e4fa5c26"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.3.0/bitrise-den-agent-darwin-arm64.zip"
        sha256 "8cbff54eda36946806a00c08ed872f48e0b4b205afcaa521ebcd143f2b0664c4"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.3.0/bitrise-den-agent-darwin-amd64.zip"
        sha256 "7f456299c1f1dadad732d8d93368eebdd7a3091b8354c875de2387c7788ce80b"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.3.0/bitrise-den-agent-linux-amd64.zip"
        sha256 "7b346f34e85d7f2cb9a5e479c071d9bbb4d9ec034c3ce37ebbeaf0f6a38192a6"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
  