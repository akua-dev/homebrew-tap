# frozen_string_literal: true

# Auto-bumped by release.yml in akua-dev/akua on every stable
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.8.25/akua-v0.8.25-aarch64-apple-darwin.tar.gz"
      sha256 "e229f7d6d4b14b7749dcb14f2cacc4465f260c9c664a0ddc9c2f7d2025884fbf"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.8.25/akua-v0.8.25-x86_64-apple-darwin.tar.gz"
      sha256 "6468e2b0d97f48b114bfa339c26f3d8ead339226d252fa07296bde274581a845"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.8.25/akua-v0.8.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3a3c6bae72764cbd85a6e4e0877a05e5def8f7aeee8563b7918099214a1a313a"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.8.25/akua-v0.8.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc57afbffe7e18aacd2146e2cd67151c56e7a3c279fe659312ff7ffb359cd03a"
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
