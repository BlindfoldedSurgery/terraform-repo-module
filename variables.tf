variable "name" {
  type     = string
  nullable = false
}

variable "description" {
  type        = string
  default     = ""
  description = "The repository description"
  nullable    = false
}

variable "homepage_url" {
  type        = string
  default     = null
  nullable    = true
  description = "The repository homepage shown in the about section"
}

variable "default_branch_name" {
  type        = string
  default     = "main"
  description = "The name of the default branch. Highly recommended to use the default here."
}

variable "protect_default_branch" {
  type        = bool
  default     = true
  description = "Whether to protected the default branch"
}

variable "allow_default_branch_protection_bypass" {
  type        = bool
  default     = true
  description = "Allow administrators to bypass the branch protection for the default branch."
}

variable "blocked_branches" {
  type        = list(string)
  default     = ["master"]
  description = "A list of branches that cannot be pushed to."
}

variable "is_public" {
  type    = bool
  default = true
}

variable "is_archived" {
  type    = bool
  default = false
}

variable "enable_actions" {
  type        = bool
  default     = true
  description = "Whether GitHub Actions is enabled"
}

variable "enable_discussions" {
  type        = bool
  default     = false
  description = "Whether GitHub discussions are enabled"
}

variable "enable_projects" {
  type        = bool
  default     = false
  description = "Whether GitHub Projects are enabled"
}

variable "required_status_checks" {
  type = list(string)
  default = [
    "lint / lint",
    "test / test",
    "build-container-image / build",
    "validate-renovate-config / validate",
  ]
  description = "The list of status checks that need to pass for PRs"
}

variable "allow_squash_merge" {
  type        = bool
  default     = false
  description = "Allow PRs to be merged by squashing the PR's commits"
}

variable "enable_argocd_rules" {
  type        = bool
  default     = false
  description = "Add branch protection for an argocd branch."
}
