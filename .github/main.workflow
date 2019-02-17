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

workflow "Code Lint (Syntax)" {
  on = "push"
  resolves = ["Lint PHP 5.2", "Lint PHP 5.6", "Lint PHP 7.3.0", "Lint JavaScript"]
}

action "Get Changed Files" {
  uses = "lots0logs/gh-action-get-changed-files@master"
  secrets = ["GITHUB_TOKEN"]
}

action "Lint PHP 5.2" {
  uses = "docker://elegantthemes/gh-action-lint-php:5.2.17"
  needs = ["Get Changed Files"]
}

action "Lint PHP 5.6" {
  uses = "docker://elegantthemes/gh-action-lint-php:5.6.39"
  needs = ["Get Changed Files"]
}

action "Lint PHP 7.3.0" {
  uses = "docker://elegantthemes/gh-action-lint-php:7.3.0"
  needs = ["Get Changed Files"]
}

action "Lint JavaScript" {
  uses = "docker://elegantthemes/gh-action-lint-js:latest"
  needs = ["Get Changed Files"]
}
