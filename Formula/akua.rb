# frozen_string_literal: true

# Generated from the verified akua-dev/cli v0.11.2 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.11.2"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.2/akua-v0.11.2-darwin-arm64.tar.gz"
      sha256 "232c1dab73182b88c8c7711cfadd79a66597daf18f4a284b693bc0fd0f70658f"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.2/akua-v0.11.2-darwin-x64.tar.gz"
      sha256 "971abd582a710db8a3603a8ef05bd0a0605cce0599b5957eefb58a6f2fc4b718"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.2/akua-v0.11.2-linux-arm64.tar.gz"
      sha256 "b684304a043d5227114273fdd87d77450149426fbab68b336b3633f3b1055247"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.2/akua-v0.11.2-linux-x64.tar.gz"
      sha256 "7b474e70b74dfdcee85d19c369b2b0133c1a4aa0c23c1a15383194e301bcd61e"
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
