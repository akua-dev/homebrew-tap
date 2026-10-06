# typed: strict
# frozen_string_literal: true

require "json"
require "minitest/autorun"
require "open3"
require "tmpdir"

class UpdateFormulaTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__).freeze
  SCRIPT = File.join(ROOT, "scripts", "update_formula.rb").freeze
  FIXTURE = File.join(ROOT, "test", "fixtures", "cli-homebrew-v1.2.3.json").freeze
  VERSION = "1.2.3"
  TAG = "v#{VERSION}".freeze
  RELEASE_URL = "https://github.com/akua-dev/cli/releases/tag/#{TAG}".freeze
  MANIFEST_URL = "https://github.com/akua-dev/cli/releases/download/#{TAG}/akua-v#{VERSION}-homebrew.json".freeze

  def test_renders_a_libexec_formula_for_the_verified_release_manifest
    Dir.mktmpdir("tap-formula-") do |directory|
      output = File.join(directory, "akua.rb")
      stdout, stderr, status = run_generator(output: output)

      assert status.success?, "generator failed: #{stdout}#{stderr}"
      syntax_out, syntax_err, syntax_status = Open3.capture3("ruby", "-c", output)
      assert syntax_status.success?, "invalid formula: #{syntax_out}#{syntax_err}"
      formula = File.read(output)
      assert_includes formula, "class Akua < Formula"
      assert_includes formula, %Q(version "#{VERSION}")
      assert_includes formula, 'url "https://github.com/akua-dev/cli/releases/download/v1.2.3/akua-v1.2.3-darwin-arm64.tar.gz"'
      assert_includes formula, 'sha256 "1111111111111111111111111111111111111111111111111111111111111111"'
      assert_includes formula, 'libexec.install Dir["*"]'
      assert_includes formula, 'bin.install_symlink libexec/"akua"'
      assert_includes formula, %Q(shell_output("\#{bin}/akua --version"))
      assert_includes formula, '(libexec/"node_modules/@akua-dev/native").exist?'
      assert_includes formula, %Q(shell_output("\#{bin}/akua pkg version --json"))
      assert_includes formula, %Q(shell_output("\#{bin}/akua pkg --help"))
    end
  end

  def test_rejects_an_asset_url_outside_the_verified_release
    Dir.mktmpdir("tap-formula-") do |directory|
      manifest = JSON.parse(File.read(FIXTURE))
      manifest.fetch("platforms").fetch("linux_intel")["url"] = "https://example.com/cli.tar.gz"
      malicious = File.join(directory, "manifest.json")
      File.write(malicious, JSON.pretty_generate(manifest))

      _stdout, stderr, status = run_generator(output: File.join(directory, "akua.rb"), manifest: malicious)

      refute status.success?
      assert_includes stderr, "linux_intel.url"
    end
  end

  def test_rejects_dispatch_metadata_that_does_not_match_the_manifest
    Dir.mktmpdir("tap-formula-") do |directory|
      _stdout, stderr, status = run_generator(
        output: File.join(directory, "akua.rb"),
        tag:    "v9.9.9",
      )

      refute status.success?
      assert_includes stderr, "tag must equal v#{VERSION}"
    end
  end

  def test_renders_the_standalone_package_formula_from_its_verified_release
    Dir.mktmpdir("tap-package-formula-") do |directory|
      output = File.join(directory, "akuapkg.rb")
      stdout, stderr, status = Open3.capture3(
        "ruby", SCRIPT,
        "--formula", "akuapkg", "--version", VERSION, "--tag", TAG,
        "--release-url", "https://github.com/akua-dev/akuapkg/releases/tag/#{TAG}",
        "--manifest-url", "https://github.com/akua-dev/akuapkg/releases/download/#{TAG}/akuapkg-v#{VERSION}-homebrew.json",
        "--manifest", File.join(ROOT, "test/fixtures/package-homebrew-v1.2.3.json"),
        "--output", output, chdir: ROOT
      )
      assert status.success?, "generator failed: #{stdout}#{stderr}"
      syntax_out, syntax_err, syntax_status = Open3.capture3("ruby", "-c", output)
      assert syntax_status.success?, "invalid formula: #{syntax_out}#{syntax_err}"
      formula = File.read(output)
      assert_includes formula, "class Akuapkg < Formula"
      assert_includes formula, 'bin.install "akuapkg"'
      assert_includes formula, "akuapkg-v1.2.3-aarch64-apple-darwin.tar.gz"
      assert_includes formula, '"init", "smoke"'
      assert_includes formula, '/akuapkg", "render"'
      refute_includes formula, "node_modules"
    end
  end

  def test_rejects_a_package_manifest_routed_as_the_platform_formula
    Dir.mktmpdir("tap-wrong-formula-") do |directory|
      _stdout, stderr, status = run_generator(
        output: File.join(directory, "akua.rb"),
        manifest: File.join(ROOT, "test/fixtures/package-homebrew-v1.2.3.json")
      )
      refute status.success?
      assert_includes stderr, "manifest.formula"
    end
  end

  def test_rejects_a_package_archive_from_another_repository
    Dir.mktmpdir("tap-package-repository-") do |directory|
      manifest = JSON.parse(File.read(File.join(ROOT, "test/fixtures/package-homebrew-v1.2.3.json")))
      manifest.fetch("platforms").fetch("macos_arm")["url"].sub!("/akuapkg/", "/cli/")
      input = File.join(directory, "manifest.json")
      output = File.join(directory, "akuapkg.rb")
      File.write(input, JSON.generate(manifest))
      _stdout, stderr, status = run_generator(output: output, manifest: input, formula: "akuapkg")
      refute status.success?
      assert_includes stderr, "macos_arm.url"
      refute File.exist?(output)
    end
  end

  private

  def run_generator(output:, manifest: FIXTURE, tag: TAG, formula: "akua")
    repository = formula == "akuapkg" ? "akuapkg" : "cli"
    Open3.capture3(
      "ruby",
      SCRIPT,
      "--formula", formula,
      "--version", VERSION,
      "--tag", tag,
      "--release-url", "https://github.com/akua-dev/#{repository}/releases/tag/#{TAG}",
      "--manifest-url", "https://github.com/akua-dev/#{repository}/releases/download/#{TAG}/#{formula}-v#{VERSION}-homebrew.json",
      "--manifest", manifest,
      "--output", output,
      chdir: ROOT
    )
  end
end
