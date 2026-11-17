# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.13 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akuapkg-v0.13.13-aarch64-apple-darwin.tar.gz"
      sha256 "a79fea08978c872e96642051c1e3c64bf2ae3cc0a35fd44cdcb248c62205936a"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akuapkg-v0.13.13-x86_64-apple-darwin.tar.gz"
      sha256 "9f97cae35ab36ab1a5213e28d2959092e955c0e6cc6266a697916a343c01db3e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akuapkg-v0.13.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73a5c983cb53e2605f59b0a66628cc17464991684513f5f788d77ebcfb478aea"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.13/akuapkg-v0.13.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "77a12968b6f67279ba7ba96e1483f77f40d5e69507f39df6921e4df926831620"
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
