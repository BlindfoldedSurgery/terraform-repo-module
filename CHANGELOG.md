## v11.1.0 (2025-11-19)

### Feat

- **deps**: update dependency terraform to v1.14.0

## v11.0.0 (2025-11-14)

### Feat

- set restrictive workflow permissions


- update minimum GitHub provider version to 6.8

## v10.1.1 (2025-10-17)

### Fix

- add integration ID to required status checks

## v10.1.0 (2025-10-11)

### Feat

- migrate to rulesets

## v10.0.1 (2025-10-11)

### Fix

- properly set actions status

## v10.0.0 (2025-10-11)

### Feat

- add is_archive_prepared variable

## v9.4.1 (2025-10-03)

### Fix

- ignore repository template

## v9.4.0 (2025-09-05)

### Feat

- **deps**: update dependency terraform to v1.13.1

## v9.3.0 (2025-05-16)

### Feat

- **deps**: update dependency terraform to v1.12.0

## v9.2.0 (2025-02-27)

### Feat

- **deps**: update dependency terraform to v1.11.0

## v9.1.3 (2025-01-16)

### Fix

- put secret scanning in a dynamic block

## v9.1.2 (2025-01-15)

### Fix

- explicitly disable push protection

## v9.1.1 (2025-01-15)

### Fix

- Don't enable secret scanning on archived projects

## v9.1.0 (2025-01-15)

### Feat

- enable secret scanning on public repositories

## v9.0.2 (2025-01-07)

### Fix

- Only require meta status checks for release branch

## v9.0.1 (2025-01-07)

### Fix

- Only require deploy job for release branch

## v9.0.0 (2025-01-07)

### BREAKING CHANGE

- projects should follow best practices and provide
dual-arch container images. Thus, the build-container-image job is no
longer required, instead the dual arch build jobs should be followed
by an artificial "post-build-container-images" job.

## v8.0.3 (2024-12-13)

### Fix

- Revert actionlint requirement

## v8.0.2 (2024-12-13)

### Fix

- Require actionlint status check

## v8.0.1 (2024-12-08)

### Fix

- Remove validate-renovate-config from default status checks

## v8.0.0 (2024-12-06)

### Feat

- Add actions-meta required workflow

## v7.4.0 (2024-12-04)

### Feat

- **deps**: update dependency terraform to v1.10.1

## v7.3.3 (2024-10-06)

### Fix

- **deps**: update dependency pre-commit to v4

## v7.3.2 (2024-09-15)

### Fix

- Allow all GitHub 6.x.x versions

## v7.3.1 (2024-09-15)

### Fix

- loosen GitHub provider constraints

## v7.3.0 (2024-09-15)

### Feat

- **deps**: update terraform github to ~> 6.3.0

## v7.2.0 (2024-06-28)

### Feat

- Enable Argo CD branch protection by default

## v7.1.1 (2024-04-13)

### Fix

- change argocd release branch name

## v7.1.0 (2024-04-05)

### Feat

- Add option to add argocd branch rules

## v7.0.0 (2024-04-02)

### Fix

- Disable Poetry package-mode


- Add note about github upgrade

## v6.0.0 (2024-01-19)

### BREAKING CHANGE

- This update disables the option to merge PRs by
squashing. Can be overriden using the new `allow_squash_merge` variable.


- Disable squash-and-merge by default

## v5.0.0 (2023-11-10)

### BREAKING CHANGE

- This adds a new required status check to the default
list. Add the following job to your projects to include this job:
```yaml
validate-renovate-config:
  uses: BlindfoldedSurgery/renovate-config/.github/workflows/validate.yml@main
```

## v4.3.0 (2023-10-28)

### Feat

- Tooling upgrades

## v4.2.0 (2023-10-28)

### Feat

- Add option to prevent admins from bypassing default branch protection

## v4.1.3 (2023-10-28)

### Fix

- Actually enforce blocked branches in ruleset

## v4.1.2 (2023-10-28)

### Fix

- Fully qualify branch names with refs/heads/ prefix

## v4.1.1 (2023-10-28)

### Fix

- Don't try to create rules without conditions

## v4.1.0 (2023-10-28)

### Feat

- Realize branch blocking using a ruleset

## v4.0.1 (2023-10-21)

### Fix

- Fix default status check names

## v4.0.0 (2023-10-21)

### BREAKING CHANGE

- If you use the default status checks, the affected
repo should be updated to use the BlindfoldedSurgery reusable workflows.

## v3.0.0 (2023-10-21)

### BREAKING CHANGE

- Major tags like v2 will no longer be updated. Starting
with v3.0.0, no major tag is available anymore. Please use exact version
tags.

## v2.0.0 (2023-10-21)

### BREAKING CHANGE

- If you're still using the create_default_branch
variable, you must remove it. Removing it should not have an effect for
you.

### Feat

- Remove option to create default branch

## v1.1.0 (2023-10-19)

### Feat

- Add ssh URL as output

## v1.0.0 (2023-10-19)

### Feat

- introduce commitizen
