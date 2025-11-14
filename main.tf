terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.8"
    }
  }
}

locals {
  required_meta_status_checks = [
    "required-meta / actionlint",
    "required-meta / validate-renovate-config / validate",
  ]

  required_status_checks = var.include_required_meta_checks ? tolist(sort(
    toset(
      concat(
        var.required_status_checks,
        local.required_meta_status_checks,
      )
    )
  )) : var.required_status_checks
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
    for_each = toset(var.is_public && !var.is_archive_prepared ? ["active"] : [])
    content {
      secret_scanning {
        status = "enabled"
      }
      secret_scanning_push_protection {
        status = "disabled"
      }
    }
  }

  lifecycle {
    ignore_changes = [
      template,
    ]
  }
}

resource "github_branch_default" "main" {
  repository = github_repository.main.name
  branch     = var.default_branch_name
}

resource "github_repository_ruleset" "default_forceless" {
  count = !var.is_archive_prepared && var.protect_default_branch ? 1 : 0

  name        = "Default Branch - No Force Push"
  repository  = github_repository.main.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  rules {
    deletion         = true
    non_fast_forward = true
  }
}

resource "github_repository_ruleset" "default_checks" {
  count = !var.is_archive_prepared && var.protect_default_branch ? 1 : 0

  name        = "Default Branch - Checks"
  repository  = github_repository.main.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~DEFAULT_BRANCH"]
      exclude = []
    }
  }

  dynamic "bypass_actors" {
    for_each = toset(var.allow_default_branch_protection_bypass ? ["active"] : [])

    content {
      # Admins have ID 5
      actor_id    = 5
      actor_type  = "RepositoryRole"
      bypass_mode = "always"
    }
  }

  rules {
    required_status_checks {
      dynamic "required_check" {
        for_each = toset(local.required_status_checks)

        content {
          # That's GitHub Actions
          integration_id = 15368
          context        = required_check.key
        }
      }
    }
  }
}

resource "github_repository_ruleset" "argocd" {
  count = !var.is_archive_prepared && var.enable_argocd_rules ? 1 : 0

  name        = "ArgoCD Branch"
  repository  = github_repository.main.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["refs/heads/release"]
      exclude = []
    }
  }

  rules {
    deletion                = true
    non_fast_forward        = true
    required_linear_history = true

    required_status_checks {
      dynamic "required_check" {
        for_each = toset(local.required_meta_status_checks)

        content {
          context = required_check.key
        }
      }
    }
  }
}

resource "github_repository_ruleset" "blocked" {
  count = !var.is_archive_prepared && length(var.blocked_branches) > 0 ? 1 : 0

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
  count           = !var.is_archive_prepared && var.enable_actions ? 1 : 0
  enabled         = true
  allowed_actions = "all"
  repository      = github_repository.main.name
}

resource "github_actions_repository_permissions" "if_disabled" {
  count      = var.is_archive_prepared || !var.enable_actions ? 1 : 0
  enabled    = false
  repository = github_repository.main.name
}
