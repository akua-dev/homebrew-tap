# typed: strict
# frozen_string_literal: true

require "minitest/autorun"
require "yaml"

class RepositoryContractTest < Minitest::Test
  ROOT = File.expand_path("..", __dir__).freeze

  def test_platform_cli_owns_the_akua_formula_and_preserves_its_runtime_tree
    formula = File.read(File.join(ROOT, "Formula", "akua.rb"))

    assert_includes formula, 'homepage "https://docs.akua.dev"'
    assert_includes formula, "https://github.com/akua-dev/cli/releases/download/"
    assert_includes formula, 'libexec.install Dir["*"]'
    assert_includes formula, 'bin.install_symlink libexec/"akua"'
    assert_includes formula, %Q(shell_output("\#{bin}/akua --version"))
    assert_includes formula, %Q(shell_output("\#{bin}/akua pkg version --json"))
    assert_includes formula, %Q(shell_output("\#{bin}/akua pkg --help"))
  end

  def test_standalone_package_tool_has_its_own_formula_name
    formula = File.read(File.join(ROOT, "Formula", "akuapkg.rb"))

    assert_includes formula, "class Akuapkg < Formula"
    assert_includes formula, 'homepage "https://github.com/akua-dev/akuapkg"'
    assert_match(/bin\.install .*\bakuapkg\b/, formula)
    assert_includes formula, %Q(shell_output("\#{bin}/akuapkg --version"))
  end

  def test_legacy_formula_is_removed
    refute File.exist?(File.join(ROOT, "Formula", "cnap.rb"))
  end

  def test_dispatch_workflow_validates_and_opens_a_reviewed_pr
    workflow = YAML.safe_load(
      File.binread(File.join(ROOT, ".github", "workflows", "update_cli_formula.yml")),
      aliases: true,
    )
    triggers = workflow.fetch(true)
    assert_equal({ "types" => ["akua-cli-release-published", "akuapkg-release-published"] }, triggers.fetch("repository_dispatch"))
    refute triggers.key?("push")
    assert_equal "write", workflow.fetch("permissions").fetch("pull-requests")

    steps = workflow.fetch("jobs").fetch("update").fetch("steps")
    render_step = steps.find { |step| step["name"] == "Validate the release and render the formula" }
    assert_includes render_step.fetch("run"), "ruby scripts/update_formula.rb"
    pr_step = steps.find { |step| step["name"] == "Open the formula update for review" }
    assert_match(%r{\Apeter-evans/create-pull-request@[0-9a-f]{40}\z}, pr_step.fetch("uses"))
  end
end
