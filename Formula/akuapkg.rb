# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.15 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akuapkg-v0.13.15-aarch64-apple-darwin.tar.gz"
      sha256 "775fe72a4572c0eeb542d0410765e6e9572c0bd1f98792e0cdee567257dc8731"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akuapkg-v0.13.15-x86_64-apple-darwin.tar.gz"
      sha256 "504ad82d6c62e84844a4894f88f3e032f978cb954394d776d793e2d275a75d48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akuapkg-v0.13.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "63b2cdd3a3222e46e623a57aeb3fb3136b651f38c214ba945364f5443933e9a3"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.15/akuapkg-v0.13.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6cd6a9c3c63e16cf2715702679892ed58a918c3e6e1fea22753b68a2b830069"
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
