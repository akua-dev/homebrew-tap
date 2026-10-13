# frozen_string_literal: true

require "rubygems/version"

module FormulaContractAssertions
  def assert_formula_release_coordinates(formula, name)
    version = formula[/^  version "([^"]+)"$/, 1]
    refute_nil version, "formula must declare its release version"
    release_version = Gem::Version.new(version.split(/[+-]/).first)
    legacy_repository = name == "akua" ? "cli" : "akuapkg"
    repository = release_version >= Gem::Version.new("0.13.0") ? "akua" : legacy_repository
    urls = formula.scan(/^      url "([^"]+)"$/).flatten
    assert_equal 4, urls.length, "formula must cover all four release targets"
    urls.each do |url|
      assert_match %r{\Ahttps://github\.com/akua-dev/#{repository}/releases/download/v#{Regexp.escape(version)}/#{name}-v#{Regexp.escape(version)}-[^/]+\.tar\.gz\z}, url
    end
    homepage = name == "akua" ? "https://docs.akua.dev" : "https://github.com/akua-dev/#{repository}"
    assert_includes formula, %Q(homepage "#{homepage}")
  end
end
