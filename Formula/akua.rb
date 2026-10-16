# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.2 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.2"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akua-v0.13.2-darwin-arm64.tar.gz"
      sha256 "3a1cce19d2d1ef339571715d1d07e906087307c36c907e5bbe55568b2ccd5ea8"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akua-v0.13.2-darwin-x64.tar.gz"
      sha256 "a59cf4fa01a7a0c92bb5b5d21ba7d631ac9e7db7763969f4af9121b002d1eb87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akua-v0.13.2-linux-arm64.tar.gz"
      sha256 "c5467c5a03660099ade1c086471abe267ce755c4234fcc533f6de445eca90e4f"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akua-v0.13.2-linux-x64.tar.gz"
      sha256 "c7efb922e2933d0e6bf5204e2eb25dda9efb89f2ad56ad5b4fc31a6029b9fae2"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"akua"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/akua --version")
    assert_match '"version"', shell_output("#{bin}/akua pkg version --json")
  end
end
