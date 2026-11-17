# frozen_string_literal: true

# Generated from the verified akua-dev/akua v0.13.14 release manifest.
class Akua < Formula
  desc "CLI for building, deploying, and operating applications with Akua"
  homepage "https://docs.akua.dev"
  version "0.13.14"

  on_macos do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akua-v0.13.14-darwin-arm64.tar.gz"
      sha256 "3abc9fcd5b372adf8144099bf0caf9dd633778d344a00cae4ce3cceebc91a4b3"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akua-v0.13.14-darwin-x64.tar.gz"
      sha256 "0714637c14768bc9a06757ba7ed842ee84ba65ff3220a7368371d3c42b5422ab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akua-v0.13.14-linux-arm64.tar.gz"
      sha256 "b60d8520a349379a997873f6e6ca2a1976211fd552d0ff04848921d8e3db75d3"
    end
    on_intel do
      url "https://github.com/akua-dev/akua/releases/download/v0.13.14/akua-v0.13.14-linux-x64.tar.gz"
      sha256 "d2bb17a79561a181cafdf4bf1db8e5c6a12347435d6bb3e13a74d3d40bd7b8b0"
    end
  end

  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"akua"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/akua --version")
    assert_match '"version"', shell_output("#{bin}/akua pkg version --json")
  end
end
