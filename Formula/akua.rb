# frozen_string_literal: true

# Auto-bumped by release.yml in cnap-tech/akua on every stable
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/cnap-tech/akua"
  version "0.8.10"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f79ace21790965433df8bcb3d65c5d3f40b9a48e0d4ae2c704ba271fb339f5b3"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "f24974cda157f1a9b9a7ce4d5e7d268f0fd092340208e00ea613cf05021702ef"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ec4e7e72481c4ec787919a7f9f9f48fbfae119b01bd37ac6c532ca0dc5ef1f81"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5371ea6008961921f20725c633d61a972d034653a2d557faaa851c395ea2b1e6"
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
