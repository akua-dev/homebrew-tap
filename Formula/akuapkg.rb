# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.1 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"
  version "0.13.1"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akuapkg-v0.13.1-aarch64-apple-darwin.tar.gz"
      sha256 "26a30d918f26c2423f23dd92ed78e152a83449abee89a1fbfbe5f28bd04ce182"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akuapkg-v0.13.1-x86_64-apple-darwin.tar.gz"
      sha256 "999ae9ade55c8dd782d1a737e4b6978f00f80547682c19099df83b2f80f0ff88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akuapkg-v0.13.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7a914ed56c42670cb4ba4913e87163732afde81fd0877cf6c690a3b00901b622"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.1/akuapkg-v0.13.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7ae1be93e70d9014d241d7906cc1927d9e28c81f864e28bca274cf95fe2df117"
    end
  end

  def install
    bin.install "akuapkg"
  end
  
  test do
    assert_match version.to_s, shell_output("#{bin}/akuapkg --version")
    system "#{bin}/akuapkg", "init", "smoke"
    cd "smoke" do
      system "#{bin}/akuapkg", "render"
      assert_predicate Pathname("deploy"), :directory?
      refute_empty Dir["deploy/**/*"]
    end
  end
end
