class BitriseDenAgent < Formula
    desc "CLI for Bitrise DEN agent"
    homepage "https://github.com/bitrise-io/bitrise-den-agent"
    url "https://github.com/bitrise-io/bitrise-den-agent.git",
        tag:      "v2.1.26",
        revision: "cd06d52db23912228593129f892c23f06bdcdc4d"
    license ""
  
    on_macos do
      if Hardware::CPU.arm?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.26/bitrise-den-agent-darwin-arm64.zip"
        sha256 "3571a679645acdfedb4655dc1ead7e7952b258c914c38b4eb34a4990ca87cd1b"
      end
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.26/bitrise-den-agent-darwin-amd64.zip"
        sha256 "925b39900a4675109e32635da510a06a7f8c5ad0760db8faca8df8d7a44ab578"
      end
    end
  
    on_linux do
      if Hardware::CPU.intel?
        url "https://github.com/bitrise-io/bitrise-den-agent/releases/download/v2.1.26/bitrise-den-agent-linux-amd64.zip"
        sha256 "2ac2afc85648f0dd59bf2fc622a20079f3edac537a7a4379dda778d9325b30e2"
      end
    end
  
    def install
      bin.install "bitrise-den-agent"
    end
  
    test do
      system "#{bin}/bitrise-den-agent"
    end
  end
  