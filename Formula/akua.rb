# frozen_string_literal: true

# Generated from the verified akua-dev/cli v0.11.4 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.11.4"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.4/akua-v0.11.4-darwin-arm64.tar.gz"
      sha256 "22fa52ae4104dad65cdb37b5f04e0d176a93c65eb1e90653e900fe0e94cab500"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.4/akua-v0.11.4-darwin-x64.tar.gz"
      sha256 "62185745468e83f151224883d0417a7bdf191325fdcd11edf202ff62cd810f4c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.4/akua-v0.11.4-linux-arm64.tar.gz"
      sha256 "113c07e8c7aefa209abff33a6407c7d472746c5f84929e8f0fbdb6e11eaa9e34"
    end
    on_intel do
      url "https://github.com/akua-dev/cli/releases/download/v0.11.4/akua-v0.11.4-linux-x64.tar.gz"
      sha256 "aff6b5f2b4a9ac59ea66c71add600484043f827d2afa3cd206dd19890191a6eb"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"akua"
  end
  
  test do
    assert_match version.to_s, shell_output("#{bin}/akua --version")
    if (libexec/"node_modules/@akua-dev/native").exist?
      assert_match '"version"', shell_output("#{bin}/akua pkg version --json")
    else
      assert_match "Usage: akua", shell_output("#{bin}/akua pkg --help")
    end
  end
end
