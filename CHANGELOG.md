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
