# frozen_string_literal: true

# Generated from the verified akua-dev/cli v0.12.0 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.12.0"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.0/akua-v0.12.0-darwin-arm64.tar.gz"
      sha256 "c64ff8c9fe0d2d03f89eb8301376c44dffe13b70a1e74c92fb7ac9000befcac8"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.0/akua-v0.12.0-darwin-x64.tar.gz"
      sha256 "67a81a1f928d95f6790d0bcb9dfccddc4e409cccd612c859533c43785833aa6d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.0/akua-v0.12.0-linux-arm64.tar.gz"
      sha256 "70662709a0776f5acb1e9082c097e244a0124ec8401de094a5e1cc795bc88a57"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.12.0/akua-v0.12.0-linux-x64.tar.gz"
      sha256 "f7582a46f4eb10098348c7e7e5c7b0b96bbb2148c787c02094b704c459e37890"
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
