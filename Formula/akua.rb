# frozen_string_literal: true

# Auto-bumped by release.yml in cnap-tech/akua on every stable
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/cnap-tech/akua"
  version "0.8.11"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "3d2c7c37602dfdf0cb5f4d98dbf1aac28968c5a3534afa7f8d22fcf890dd7866"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "20d5fb814454332a9f1c25c915a49f5d0e1405ba37475de0a9a826ed4449f537"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "78cdf3a7a86a5de211670c483255ec33ccaa737ed14bf278c619bad58b6f7311"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5a446c7ff409af9c05e9c6d68a61019b7d1fbf49a4992f8caeb8b1a0af177db7"
    end
  end

  def install
    bin.install "akua"
    doc.install "README.md", "SECURITY.md" if File.exist?("README.md")
  end

  test do
    assert_match(/akua/, shell_output("#{bin}/akua --version"))
  end
end
