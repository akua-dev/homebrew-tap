# frozen_string_literal: true

# Generated from the verified akua-dev/cli v0.11.0 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.11.0"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.0/akua-v0.11.0-darwin-arm64.tar.gz"
      sha256 "399148be54a4a51e5ce75725fe5068967af16169d38716e0c65f6483bce891e8"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.0/akua-v0.11.0-darwin-x64.tar.gz"
      sha256 "b3e1b698f3d948ae86b34d6c7bef5b679e4160af72da25db39f827e43b89c072"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.0/akua-v0.11.0-linux-arm64.tar.gz"
      sha256 "a944a47ece791f6a6b80503c084ab06fea26fe5cbae1e1cfe798a9a649071209"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.0/akua-v0.11.0-linux-x64.tar.gz"
      sha256 "0df0fde3e6df541a1a261419556a376d85e823bb9aa15a93a4ee586dd86758a4"
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
