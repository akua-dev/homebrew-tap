# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.0 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"
  version "0.13.0"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akuapkg-v0.13.0-aarch64-apple-darwin.tar.gz"
      sha256 "56dbac06c63220b29b579b7a1150fce984fab436d0f61bfb02bcde7f46ab43b0"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akuapkg-v0.13.0-x86_64-apple-darwin.tar.gz"
      sha256 "e4ce0bdb6879a506f34117793f5bf551991cd2886e23d6370962a0e4e7ecf5a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akuapkg-v0.13.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b83e6375034113a7b165a5d2b7f6661fa7b1a9d2e42e7675472db31486575147"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.0/akuapkg-v0.13.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0e8d61ed8d937da1e5b63fbaff324d0da4b5f870ccbb5ca900e87eb3c911c68"
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
