# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.2 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akuapkg-v0.13.2-aarch64-apple-darwin.tar.gz"
      sha256 "4bece6ab249ff0ccd794378c636b4fcdaad5cb6d146e97a3f7abe5ed13a6c80d"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akuapkg-v0.13.2-x86_64-apple-darwin.tar.gz"
      sha256 "881b1afe790b4313920cd160e42a80c1942886ca4781e797272ef881710c040a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akuapkg-v0.13.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2397a8ad18a877212e9dcf7245b68ec7776b4ebaa83f7a08e0e469a62a94b1a3"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.2/akuapkg-v0.13.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c19d4c38de4fb5f6f5aeb243ac5007ecf43d986249e67452a3e49fd77c513bbe"
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
