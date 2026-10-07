# frozen_string_literal: true

# Generated from the verified akua-dev/cli v0.11.3 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.11.3"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.3/akua-v0.11.3-darwin-arm64.tar.gz"
      sha256 "e8c867df99d61db1e2ced34d0ebbe5613674c6d9fe3bbc73e4cd24947a110bb6"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.3/akua-v0.11.3-darwin-x64.tar.gz"
      sha256 "f57aac22628bcc405e92c50e91da79bf380fabcd9df97ba4c2f1d8f186a524a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.3/akua-v0.11.3-linux-arm64.tar.gz"
      sha256 "064b2a0db398d412eaccf1ac669a9b664092d1d12d696e211dd73767dec9b9ea"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.3/akua-v0.11.3-linux-x64.tar.gz"
      sha256 "f7f85b9ddc6b8b90314d98658d99423f4aeb6414a7f4f730622aa82287402b67"
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
