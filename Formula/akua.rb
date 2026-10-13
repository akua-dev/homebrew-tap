# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.0 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.0"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akua-v0.13.0-darwin-arm64.tar.gz"
      sha256 "98b3055396424235b67dc5ec7fc6a20097907a6a74eb3827e8bb5d17d5d64fe5"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akua-v0.13.0-darwin-x64.tar.gz"
      sha256 "5a27f6e3ac87aff707affe3a2ce7642ef62e0406fb2eef3f7db599a8437cd59f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akua-v0.13.0-linux-arm64.tar.gz"
      sha256 "070a66a97c8d130350ab01c37f93b2ea68f3fad9bdb497ee5e7a0f4d0ae1cfd6"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akua-v0.13.0-linux-x64.tar.gz"
      sha256 "4ea2d5091fda2c71c4815b424c7573da4f6055720e98f955fd9d36913a81408d"
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
