# frozen_string_literal: true

# Generated from the verified akua-dev/cli v0.12.1 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.12.1"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.1/akua-v0.12.1-darwin-arm64.tar.gz"
      sha256 "fda5a6f714c742c2e679cea60e4c9965353605935e2b64e537ca272ed5c76800"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.1/akua-v0.12.1-darwin-x64.tar.gz"
      sha256 "9a8d9729fe9d14134673b3f6b2a5d5fd5c3ef43bb72d1a3a734b812454680996"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.1/akua-v0.12.1-linux-arm64.tar.gz"
      sha256 "4020a8347485d3942d522189f46c519f23f7a45505ddc256240286313b062390"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.1/akua-v0.12.1-linux-x64.tar.gz"
      sha256 "73fdece3dc0a33879cce1bbf226ad13523f9afb4faa42b43b3a1a277cd2501e7"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"akua"
  end
  
  test do
    assert_match version.to_s, shell_output("#{bin}/akua --version")
    if (libexec/"node_modules/@akua-dev/native").exist?
      assert_match '"version"', shell_output("#{bin}/akua pkg version --json")
    else
      assert_match "Usage: akua", shell_output("#{bin}/akua pkg --help")
    end
  end
end
