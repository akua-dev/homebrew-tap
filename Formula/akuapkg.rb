# frozen_string_literal: true

# Generated from the verified akua-dev/akuapkg v0.9.6 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akuapkg"
  version "0.9.6"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.9.6/akuapkg-v0.9.6-aarch64-apple-darwin.tar.gz"
      sha256 "32d37fe1c7ac0a2c65bfa8d5c1b8e8c08a6d7c332e59ec166a79f5c037bbd110"
    end
    on_intel do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.9.6/akuapkg-v0.9.6-x86_64-apple-darwin.tar.gz"
      sha256 "5ad76b7ba1d684f78f12035bbc2e2829399fd1cffa89f5dc35ae0955c024cb8d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.9.6/akuapkg-v0.9.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0660956a20f64b4c305c59932475914728e0b7ca4ea6070a66defb39c6fe142"
    end
    on_intel do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.9.6/akuapkg-v0.9.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ec198953af885058a0c90426de9b32d6d8c68379b29ddc7afc3b454b7ef0517"
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
