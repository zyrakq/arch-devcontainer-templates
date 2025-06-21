# GitHub Actions Workflows

This project contains several workflows for testing devcontainer templates:

## 📁 Workflow Files

### [`test-pr.yaml`](test-pr.yaml) - Testing Changes in PRs
- **Purpose:** Automatic testing of only changed templates
- **Trigger:** Pull requests
- **Features:** 
  - Uses `dorny/paths-filter` to detect changes
  - Tests only changed templates (optimization)
  - Doesn't work without git changes

### [`test-local.yaml`](test-local.yaml) - Local Testing
- **Purpose:** Flexible testing for development
- **Trigger:** Manual dispatch with parameters
- **Features:**
  - Can test specific template or all templates
  - Optimized for use with `act`
  - Supports `template` input parameter

## 🚀 Usage with act

```bash
# Test changes (original workflow)
act pull_request

# Test all templates
act workflow_dispatch -W .github/workflows/test-local.yaml

# Test specific template
act workflow_dispatch -W .github/workflows/test-local.yaml --input template=arch-base
```

## 🔧 Adding New Templates

When adding a new template, update the matrices in:
- [`test-local.yaml`](test-local.yaml) - line with `templates:`
- [`test-pr.yaml`](test-pr.yaml) - `filters:` section for change detection

## 🏗️ Testing Architecture

All workflows use the common smoke-test action: [`.github/actions/smoke-test/`](../actions/smoke-test/)

This action performs:
1. **Build** ([`build.sh`](../actions/smoke-test/build.sh)) - copying and configuring template
2. **Test** ([`test.sh`](../actions/smoke-test/test.sh)) - running devcontainer and tests