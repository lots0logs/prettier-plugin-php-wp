workflow "Housekeeping" {
  on = "push"
  resolves = ["Branch Cleanup"]
}

action "Branch Cleanup" {
  uses = "jessfraz/branch-cleanup-action@master"
  secrets = ["GITHUB_TOKEN"]
}

workflow "Slash Commands" {
  on = "issue_comment"
  resolves = ["/rebase"]
}

action "/rebase" {
  uses = "docker://cirrusactions/rebase:latest"
  secrets = ["GITHUB_TOKEN"]
}

workflow "Code Lint" {
  on = "push"
  resolves = ["Print env"]
}

action "Get Changed Files" {
  uses = "lots0logs/gh-action-get-changed-files@master"
  secrets = ["GITHUB_TOKEN"]
}

action "Print env" {
  uses = "actions/bin/sh@master"
  needs = ["Get Changed Files"]
  args = "env"
}
