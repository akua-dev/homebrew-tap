# frozen_string_literal: true

# Generated from the verified akua-dev/akuapkg v0.10.1 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akuapkg"
  version "0.10.1"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.1/akuapkg-v0.10.1-aarch64-apple-darwin.tar.gz"
      sha256 "351eb9638fa0dacc14375a89a4831fa20f78c8f1b1994f5bd11c3d08f487d567"
    end
    on_intel do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.1/akuapkg-v0.10.1-x86_64-apple-darwin.tar.gz"
      sha256 "b8f61ab15e14e9a6446254c0dc9fed144e0ea238a5589ca288632c94d9684034"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.1/akuapkg-v0.10.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c8eadead15a763d0f6ce4131f6389d7f03bf89bbdf403c6d1c8e57155b202bc5"
    end
    on_intel do
      url "https://github.com/akua-dev/akuapkg/releases/download/v0.10.1/akuapkg-v0.10.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2685310583b3688527033af088c4e0f7b0dfef5fbfb3ae0e81a43d2dbafb54c9"
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
