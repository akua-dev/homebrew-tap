# frozen_string_literal: true

# Generated from the verified akua-dev/akuapkg v0.10.0 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akuapkg"
  version "0.10.0"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.0/akuapkg-v0.10.0-aarch64-apple-darwin.tar.gz"
      sha256 "b93bd7cfc94db0db48d5c64317e343d14afbdeaa214481427277c919ce3754d7"
    end
    on_intel do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.0/akuapkg-v0.10.0-x86_64-apple-darwin.tar.gz"
      sha256 "beb12c8058857de7942af8a670ea25bec52b56120005b9ac905405998e14ff25"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.0/akuapkg-v0.10.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "123b173525218abfbd29da16f92aca7d0df3ee5220d81acd9a064acba76d0922"
    end
    on_intel do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.0/akuapkg-v0.10.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1929cd6f1579324f2633a8f342b6ef939d0c5fdb9d524840d3a4c0243010a16"
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
