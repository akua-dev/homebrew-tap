# frozen_string_literal: true

# Auto-bumped by cli-release.yml in cnap-tech/akua on every
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/cnap-tech/akua"
  version "0.8.6"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/akua-v#{version}/akua-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "c457194cfd51c4e8400dd09b156932f9d33488cee51f96ee8520ba981ab8ea85"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/akua-v#{version}/akua-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8651822f47c1b7432cbb7f8d38ddcba88346e1caf27a1d16b1090091e29edc41"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/akua-v#{version}/akua-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b543edf2a69b06faf7bb3e803e96d08addc33a7e6e6871b966d875b98e6a8a9a"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/akua-v#{version}/akua-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7564a6643df33d61b6b54cad8446c89dfc96f01bdcced4ae1f5bc9a001556761"
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
