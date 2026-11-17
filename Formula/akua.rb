# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.13 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.13"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akua-v0.13.13-darwin-arm64.tar.gz"
      sha256 "e46abb37c5d76632ef4ce59c7d170eaf8f2938c0fb0b6251a3a2b02caebd0f20"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akua-v0.13.13-darwin-x64.tar.gz"
      sha256 "d4c985f6cd32d11018cffbe8b3d76a9e80efdbbbb11ef08213625dd22bdfba42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akua-v0.13.13-linux-arm64.tar.gz"
      sha256 "3e77b52e999255bc49afcfc4e5f0fb95185f03c07dec7ffe3e351831c8f3ba65"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akua-v0.13.13-linux-x64.tar.gz"
      sha256 "b7006aa1f5dc7b4d5b6dc10a84789255106c1a1f7542572ad93302e6a082b509"
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
