# frozen_string_literal: true

# Auto-bumped by release.yml in cnap-tech/akua on every stable
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/cnap-tech/akua"
  version "0.8.23"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "d9e9f8c910e89fa9effb6ca13aa5af43307aab1ea2cd79935ecee27c53f32a7e"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "4e1c3287612de76cbf025b0b583aa62687cfc8ec696527b4b521f80e16e22d26"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "59f48105a34566e67cf99940167065167b29f28fe56db4879bebd2d17d329bfb"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dd6d35166de5a206c9e011da54da1c2460f5cf1e6fb9443ed3a9e0b6625ee542"
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
