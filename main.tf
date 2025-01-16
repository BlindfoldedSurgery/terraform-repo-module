terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

locals {
  required_meta_status_checks = [
    "required-meta / actionlint",
    "required-meta / validate-renovate-config / validate",
  ]
}

resource "github_repository" "main" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url
  visibility   = var.is_public ? "public" : "private"
  is_template  = false
  archived     = var.is_archived

  has_issues      = true
  has_discussions = var.enable_discussions
  has_projects    = var.enable_projects
  has_wiki        = false
  has_downloads   = false

  allow_auto_merge       = true
  delete_branch_on_merge = true

  allow_merge_commit = false
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = true

  dynamic "security_and_analysis" {
    for_each = toset(var.is_public && !var.is_archived ? ["active"] : [])
    content {
      secret_scanning {
        status = var.is_public && !var.is_archived ? "enabled" : "disabled"
      }
      secret_scanning_push_protection {
        status = "disabled"
      }
    }
  }
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = var.default_branch_name
}

resource "github_branch_protection" "main" {
  count = var.protect_default_branch ? 1 : 0

  repository_id = github_repository.main.id
  pattern       = var.default_branch_name

  required_linear_history = true

  required_status_checks {
    contexts = var.include_required_meta_checks ? tolist(sort(
      toset(
        concat(
          var.required_status_checks,
          local.required_meta_status_checks,
        )
      )
    )) : var.required_status_checks
  }

  enforce_admins = !var.allow_default_branch_protection_bypass
}

resource "github_branch_protection" "argocd" {
  count = var.enable_argocd_rules ? 1 : 0

  repository_id = github_repository.main.id
  pattern       = "release"

  required_linear_history = true

  required_status_checks {
    contexts = local.required_meta_status_checks
  }

  enforce_admins = true
}

resource "github_repository_ruleset" "blocked" {
  count = length(var.blocked_branches) > 0 ? 1 : 0

  name        = "Forbidden branches"
  repository  = github_repository.main.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = formatlist("refs/heads/%s", var.blocked_branches)
      exclude = []
    }
  }

  rules {
    creation         = true
    update           = true
    non_fast_forward = true
  }
}

resource "github_actions_repository_permissions" "if_enabled" {
  count           = var.enable_actions ? 1 : 0
  enabled         = true
  allowed_actions = "all"
  repository      = github_repository.main.name
}

resource "github_actions_repository_permissions" "if_disabled" {
  count      = var.enable_actions ? 0 : 1
  enabled    = false
  repository = github_repository.main.name
}
