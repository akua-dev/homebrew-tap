# typed: strict
# frozen_string_literal: true

require "minitest/autorun"
require "yaml"
require "shellwords"

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

  def test_dispatch_workflow_tests_and_merges_its_exact_formula_pr
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
    pr_step = steps.find { |step| step["name"] == "Open the tested formula update" }
    assert_match(%r{\Apeter-evans/create-pull-request@[0-9a-f]{40}\z}, pr_step.fetch("uses"))
    assert_equal "formula_pr", pr_step["id"]
    assert_equal "main", pr_step.fetch("with")["base"]
    assert_equal "Formula/${{ env.FORMULA }}.rb", pr_step.fetch("with").fetch("add-paths")
    assert_equal "automation/${{ env.FORMULA }}-${{ github.event.client_payload.version }}", pr_step.fetch("with").fetch("branch")

    merge_step = steps.find { |step| step["name"] == "Merge the tested formula update" }
    refute_nil merge_step
    assert_operator steps.index(steps.find { |step| step["name"] == "Test the tap contracts" }), :<, steps.index(pr_step)
    assert_operator steps.index(pr_step), :<, steps.index(merge_step)
    assert_equal "${{ success() && steps.formula_pr.outputs.pull-request-number != '' }}", merge_step.fetch("if")
    assert_equal({
      "GH_TOKEN" => "${{ github.token }}",
      "PR_NUMBER" => "${{ steps.formula_pr.outputs.pull-request-number }}",
      "PR_HEAD_SHA" => "${{ steps.formula_pr.outputs.pull-request-head-sha }}",
    }, merge_step.fetch("env"))
    merge_commands = merge_step.fetch("run").lines.map(&:strip)
    assert_equal 2, merge_commands.length
    assert_equal '[[ "$PR_HEAD_SHA" =~ ^[0-9a-f]{40}$ ]] || exit 1', merge_commands.first
    assert_equal ["gh", "pr", "merge", "$PR_NUMBER", "--repo", "akua-dev/homebrew-tap", "--squash", "--match-head-commit", "$PR_HEAD_SHA"], Shellwords.split(merge_commands.last)
  end
end
