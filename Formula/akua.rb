# frozen_string_literal: true

# Auto-bumped by release.yml in cnap-tech/akua on every stable
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/cnap-tech/akua"
  version "0.8.18"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "818d9e72296c30211b36ccd2d8421b582743db765590842ed91d001f952d3c02"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "659b54f6a7aef7d6ffca6040f7dc4ba4ea457e3a8795001cc84d4707f8a23873"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d40830d32f5196c70171550cbeab894a27f6fa1b2e4401f0ee608e208c74cbc6"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3615577caac9506c4a94495773d1c5c05c0ea20eb0332030caf46b5f5a357c23"
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
