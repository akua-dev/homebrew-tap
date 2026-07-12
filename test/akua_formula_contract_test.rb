# frozen_string_literal: true

require "minitest/autorun"
require "open3"

class AkuaFormulaContractTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__).freeze
  FORMULA_PATH = File.join(ROOT, "Formula", "akua.rb").freeze
  FORMULA = File.read(FORMULA_PATH).freeze
  VERSION = "0.8.25"

  RELEASES = {
    "aarch64-apple-darwin"      => "e229f7d6d4b14b7749dcb14f2cacc4465f260c9c664a0ddc9c2f7d2025884fbf",
    "x86_64-apple-darwin"       => "6468e2b0d97f48b114bfa339c26f3d8ead339226d252fa07296bde274581a845",
    "aarch64-unknown-linux-gnu" => "3a3c6bae72764cbd85a6e4e0877a05e5def8f7aeee8563b7918099214a1a313a",
    "x86_64-unknown-linux-gnu"  => "bc57afbffe7e18aacd2146e2cd67151c56e7a3c279fe659312ff7ffb359cd03a",
  }.freeze

  def test_tracked_files_use_current_akua_ownership
    tracked, status = Open3.capture2("git", "ls-files", "-z", chdir: ROOT)
    assert status.success?, "git ls-files failed"

    forbidden = [["cnap", "-tech"].join, ["C", "NAP"].join]
    references = tracked.split("\0").each_with_object([]) do |path, matches|
      absolute_path = File.join(ROOT, path)
      next unless File.file?(absolute_path)

      contents = File.binread(absolute_path)
      matches << path if forbidden.any? { |term| contents.include?(term) }
    end

    assert_empty references, "legacy ownership references remain in: #{references.join(", ")}"
  end

  def test_formula_pins_current_akua_release_contract
    assert_includes FORMULA, "# Auto-bumped by release.yml in akua-dev/akua on every stable"
    assert_includes FORMULA, 'homepage "https://github.com/akua-dev/akua"'
    assert_equal [VERSION], FORMULA.scan(%r{/releases/download/v([^/]+)/}).flatten.uniq
    refute_match(/^\s+version /, FORMULA)

    RELEASES.each do |target, checksum|
      url = "https://github.com/akua-dev/akua/releases/download/v#{VERSION}/akua-v#{VERSION}-#{target}.tar.gz"
      assert_includes FORMULA, %Q(url "#{url}")
      assert_match(/url #{Regexp.escape(%Q("#{url}"))}\n\s+sha256 "#{checksum}"/, FORMULA)
    end
  end

  def test_formula_preserves_class_install_and_test_contract
    assert_match(/^class Akua < Formula$/, FORMULA)
    assert_includes FORMULA, 'bin.install "akua"'
    assert_includes FORMULA, 'doc.install "README.md", "SECURITY.md" if File.exist?("README.md")'
    interpolation = ["#", "{bin}"].join
    assert_includes FORMULA, %Q(assert_match(/akua/, shell_output("#{interpolation}/akua --version")))
  end
end
