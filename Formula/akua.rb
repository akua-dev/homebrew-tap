# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.15 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.15"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akua-v0.13.15-darwin-arm64.tar.gz"
      sha256 "35034ba551726346dd8a2b2da10d03a8ae3c42abbd98cbb1e757990a0549d63d"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akua-v0.13.15-darwin-x64.tar.gz"
      sha256 "44068ae300929a27e129a5208fe9e649fc369386f2a51d925ec3dbc3920efd26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akua-v0.13.15-linux-arm64.tar.gz"
      sha256 "1f4e1779f38893204915d81cde3c846d8077bfae8cb4ecdc21abe24ad400275b"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akua-v0.13.15-linux-x64.tar.gz"
      sha256 "33c4502dcc6e1fda01f0443dd5f011b3ff62eba280653c6bcc51b0310ebaf124"
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
