# frozen_string_literal: true

# Auto-bumped by release.yml in cnap-tech/akua on every stable
# tag push. Manual edits get overwritten.
class Akua < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/cnap-tech/akua"
  version "0.8.21"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "65796b9f45244cfd33cc342b08d35e0db071ca337eb09e8414b3438bb0a74f3b"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "8b43912af9bb5f287f2ec48d9a5ace71749cb458fed47c6a4b534520200e1983"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "92829e5824f225bcca1a2147f6e0d06c11d074ee395c07afb99323334fe5550c"
    end
    on_intel do
      url "https://github.com/cnap-tech/akua/releases/download/v#{version}/akua-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "97cfad7d541501acb17738a398b3bb476c5be8679632e95a7c32eaa6de1fa063"
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
