# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.14 release manifest.
class Akuapkg < Formula
  desc "Cloud-native package build, transform, and preview toolkit"
  homepage "https://github.com/akua-dev/akua"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akuapkg-v0.13.14-aarch64-apple-darwin.tar.gz"
      sha256 "e4b6a8cee4c37a662daf52992bba0b797d5e48b663ac54c831afedf316df844d"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akuapkg-v0.13.14-x86_64-apple-darwin.tar.gz"
      sha256 "9e93d0ed957622e8942b4ffe42288a305e41dd6032cf167b6dd323a8786e6661"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akuapkg-v0.13.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4c5e7711c7ae79adf996ce970f11c6ec024f747ef58d31b714db1121b37ce697"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akuapkg-v0.13.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fba2b4b53d1357135bca85a556a12bc4be717a4fcb8920791bf3316fe08bb624"
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
