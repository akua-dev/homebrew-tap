# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.12 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.12"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akua-v0.13.12-darwin-arm64.tar.gz"
      sha256 "b50798e96c97e8a7420c4161b1206c1d73fc72d6f9d82fa41fa136a2601e03ab"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akua-v0.13.12-darwin-x64.tar.gz"
      sha256 "18c3983af3722cede642aee3c3a6537b7fccbfe90725f777e16a115f0a14fa9d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akua-v0.13.12-linux-arm64.tar.gz"
      sha256 "a587763d64fe0e514fec11765710f3f663e33e409d564be95b2f364e11b48a07"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akua-v0.13.12-linux-x64.tar.gz"
      sha256 "4e66cf6b5a21941ba86fdbadbc031d7592ae42105c44274ed54e9d0af383ec7b"
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
