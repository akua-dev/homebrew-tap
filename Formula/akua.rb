# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.1 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.1"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akua-v0.13.1-darwin-arm64.tar.gz"
      sha256 "4048485e00c9127fa0471d1809c51faf0e38ac6de717551ca6bbc0c8d1320e2e"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akua-v0.13.1-darwin-x64.tar.gz"
      sha256 "d0cd74ab6214e4dfaf729191572746cb25a5d179715b6c2d5f5d77367cdf0721"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akua-v0.13.1-linux-arm64.tar.gz"
      sha256 "f0cb7c08690c68986daf97fe55a0cb35f55521c1aced8b1429d920add0c92a31"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akua-v0.13.1-linux-x64.tar.gz"
      sha256 "f4839872f0df9776ac02d53760db6bc4e0b922bb06a90d698b8eb0b9fd276da7"
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
