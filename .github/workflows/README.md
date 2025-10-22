# GitHub Actions Workflows

This project uses GitHub Actions for CI/CD in the cloud and Pipelight for local testing.

## 📁 Workflow Files

### [`test-pr.yaml`](test-pr.yaml) - Testing Changes in PRs

- **Purpose:** Automatic testing of only changed templates
- **Trigger:** Pull requests
- **Features:**
  - Uses `dorny/paths-filter` to detect changes
  - Tests only changed templates (optimization)
  - Runs automatically on pull requests

### [`test-local.yaml`](test-local.yaml) - Manual Testing

- **Purpose:** Flexible testing for development
- **Trigger:** Manual dispatch with parameters
- **Features:**
  - Can test specific template or all templates
  - Supports `template` input parameter
  - Useful for testing in GitHub Actions environment

### [`release.yaml`](release.yaml) - Release & Documentation

- **Purpose:** Publish templates and generate documentation
- **Trigger:** Manual dispatch (master branch only)
- **Features:**
  - Publishes templates to GitHub Container Registry
  - Generates README.md from NOTES.md
  - Creates PR with documentation updates

## 🚀 Local Testing with Pipelight

For local development and testing, use Pipelight instead of GitHub Actions:

```bash
# Test specific template
pipelight run test-template -e TEMPLATE=arch-base

# Test all templates
pipelight run test-all

# Test only changed templates
pipelight run test-changed

# Cleanup artifacts
pipelight run cleanup
```

See [TESTING.md](../../TESTING.md) for detailed Pipelight usage.

## 🔧 Adding New Templates

When adding a new template, update:

### GitHub Actions

- [`test-local.yaml`](test-local.yaml) - add to `templates:` matrix
- [`test-pr.yaml`](test-pr.yaml) - add to `filters:` section for change detection

### Pipelight

- [`pipelight.toml`](../../pipelight.toml) - add to `test-all` pipeline
- [`scripts/detect-changes.sh`](../../scripts/detect-changes.sh) - add detection logic

## 🏗️ Testing Architecture

### Shared Components

Both GitHub Actions and Pipelight use the same testing infrastructure:

**Smoke Test Action:** [`.github/actions/smoke-test/`](../actions/smoke-test/)

This action performs:

1. **Build** ([`build.sh`](../actions/smoke-test/build.sh)) - copying and configuring template
2. **Test** ([`test.sh`](../actions/smoke-test/test.sh)) - running devcontainer and tests

**Template Tests:** [`test/`](../../test/)

- [`test/arch-base/test.sh`](../../test/arch-base/test.sh) - arch-base specific tests
- [`test/arch-webtop/test.sh`](../../test/arch-webtop/test.sh) - arch-webtop specific tests
- [`test/test-utils/test-utils.sh`](../../test/test-utils/test-utils.sh) - common utilities

### Testing Flow

```
┌─────────────────┐
│  Developer      │
└────────┬────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌────────┐ ┌──────────────┐
│Pipelight│ │GitHub Actions│
│ (Local)│ │   (Cloud)    │
└────┬───┘ └──────┬───────┘
     │            │
     └─────┬──────┘
           ▼
    ┌──────────────┐
    │ Smoke Test   │
    │   Scripts    │
    └──────┬───────┘
           ▼
    ┌──────────────┐
    │Template Tests│
    └──────────────┘
```

## 📚 Documentation

- **Local Testing:** See [TESTING.md](../../TESTING.md) for Pipelight usage
- **Pipelight Config:** See [pipelight.toml](../../pipelight.toml) for pipeline definitions
- **Scripts:** See [scripts/](../../scripts/) for helper scripts
