# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.12 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akuapkg-v0.13.12-aarch64-apple-darwin.tar.gz"
      sha256 "e2e346ab6046e3b8c8228098bb4b2f4c50a93a4b5ff8234b59ac7e22d93effad"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akuapkg-v0.13.12-x86_64-apple-darwin.tar.gz"
      sha256 "2fe5cf0500f76bf5925e883771572eefe87d2f69bf2cc2e51de5cb04022eb35a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akuapkg-v0.13.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "922e256ec9c2df1d699c1d96b9d50e8f65bba60ce654c6c72785d99d1d4f44ed"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.12/akuapkg-v0.13.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "79e45aae5f3fce8a2c4b52c2399bf120a8cb976bb1cefa3a7ce183bec77803ac"
    end
  end

  def install
    bin.install "akuapkg"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/akuapkg --version")
    system bin/"akuapkg", "init", "smoke"
    cd "smoke" do
      system bin/"akuapkg", "render"
      assert_predicate Pathname("deploy"), :directory?
      refute_empty Dir["deploy/**/*"]
    end
  end
end
