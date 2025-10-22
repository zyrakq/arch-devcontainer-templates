# 🛠️ Helper Scripts

This directory contains helper scripts used by Pipelight pipelines for testing devcontainer templates.

## 📋 Scripts Overview

### [`detect-changes.sh`](detect-changes.sh)

Detects which templates have been modified based on git diff.

**Usage:**

```bash
bash scripts/detect-changes.sh
```

**Output:**

- Writes list of changed templates to `/tmp/pipelight-templates-to-test`
- Prints detected changes to stdout with colored output

**Detection Logic:**

- Checks `src/arch-base/` for arch-base changes
- Checks `src/arch-webtop/` for arch-webtop changes
- Checks `test/arch-base/` for arch-base test changes
- Checks `test/arch-webtop/` for arch-webtop test changes

**Used by:**

- `pipelight run test-changed` pipeline

---

### [`test-changed.sh`](test-changed.sh)

Tests templates that were detected as changed by `detect-changes.sh`.

**Usage:**

```bash
bash scripts/test-changed.sh
```

**Prerequisites:**

- Must run `detect-changes.sh` first
- Requires `/tmp/pipelight-templates-to-test` file

**Features:**

- Tests each changed template sequentially
- Continues on failure (tests all templates even if one fails)
- Provides detailed summary at the end
- Automatic cleanup after each template test

**Used by:**

- `pipelight run test-changed` pipeline

---

### [`cleanup.sh`](cleanup.sh)

Cleans up all test artifacts and Docker containers.

**Usage:**

```bash
bash scripts/cleanup.sh
```

**Cleanup Actions:**

1. Stops and removes Docker containers with `test-container` label
2. Removes temporary directories (`/tmp/arch-base`, `/tmp/arch-webtop`)
3. Removes Pipelight temporary files
4. Prunes unused Docker images with `test-container` label

**Safe to run:**

- Can be run at any time
- Handles missing files/containers gracefully
- Provides colored output for each step

**Used by:**

- `pipelight run cleanup` pipeline
- Automatically after each test in other pipelines

---

## 🎨 Output Colors

All scripts use colored output for better readability:

- 🔵 **Blue** - Informational messages
- 🟢 **Green** - Success messages
- 🟡 **Yellow** - Warnings
- 🔴 **Red** - Errors

## 🔧 Integration with Pipelight

These scripts are called by Pipelight pipelines defined in [`pipelight.toml`](../pipelight.toml):

```toml
# Example: test-changed pipeline
[[pipelines]]
name = "test-changed"
  [[pipelines.steps]]
  name = "detect-changes"
  commands = ["bash scripts/detect-changes.sh"]
  
  [[pipelines.steps]]
  name = "test-changed-templates"
  commands = ["bash scripts/test-changed.sh"]
```

## 📝 Adding New Scripts

When adding new helper scripts:

1. Create the script in this directory
2. Make it executable: `chmod +x scripts/your-script.sh`
3. Add colored output using the color variables
4. Document it in this README
5. Update [`pipelight.toml`](../pipelight.toml) if needed

### Color Variables Template

```bash
#!/bin/bash
# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Info message${NC}"
echo -e "${GREEN}Success message${NC}"
echo -e "${YELLOW}Warning message${NC}"
echo -e "${RED}Error message${NC}"
```

## 🔗 Related Documentation

- [TESTING.md](../TESTING.md) - Complete testing guide
- [pipelight.toml](../pipelight.toml) - Pipelight configuration
- [.github/workflows/README.md](../.github/workflows/README.md) - GitHub Actions workflows
