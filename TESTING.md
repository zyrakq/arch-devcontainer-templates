# 🧪 Testing devcontainer templates

This document describes how to test devcontainer templates locally using [act](https://github.com/nektos/act).

## 📋 Prerequisites

1. 🐳 **Docker** - must be installed and running
2. 🎭 **act** - GitHub Actions runner for local testing
3. 🛠️ **@devcontainers/cli** - will be installed automatically during testing

### 📦 Installing act

```bash
# 🍎 macOS (with Homebrew)
brew install act

# 🐧 Linux (with curl)
curl https://raw.githubusercontent.com/nektos/act/master/install.sh | sudo bash

# 🪟 Windows (with Chocolatey)
choco install act-cli
```

## 🚀 Local testing

### 🔄 Testing changed templates (original workflow)

```bash
act pull_request
```

### 🧪 Testing all templates (new workflow)

```bash
# Test all templates
act workflow_dispatch -W .github/workflows/test-local.yaml
```

### 🎯 Testing specific template

```bash
# Test specific template
act workflow_dispatch -W .github/workflows/test-local.yaml --input template=arch-webtop
```

### 🛠️ Manual testing

```bash
# Direct smoke-test execution for arch-base
./.github/actions/smoke-test/build.sh arch-base
./.github/actions/smoke-test/test.sh arch-base

# Direct smoke-test execution for arch-webtop
./.github/actions/smoke-test/build.sh arch-webtop
./.github/actions/smoke-test/test.sh arch-webtop
```

## 📋 Workflow Types

### 🔄 test-pr.yaml (Original)

- **Trigger:** Pull requests
- **Logic:** Tests only changed templates
- **Optimization:** Fast execution, resource saving
- **Issue:** Doesn't work without git changes

### 🎯 test-local.yaml (Local Testing)

- **Trigger:** Manual dispatch with parameters
- **Logic:** Flexible testing (single template or all)
- **Usage:** Local development and debugging
- **Commands:**
  - All: `act workflow_dispatch -W .github/workflows/test-local.yaml`
  - Single: `act workflow_dispatch -W .github/workflows/test-local.yaml --input template=arch-base`
  - LinuxServer: `act workflow_dispatch -W .github/workflows/test-local.yaml --input template=arch-webtop`

## �️ Testing structure

### 💨 Smoke tests

Smoke tests perform:

1. 🔨 **Template build** - copying and configuring files
2. 🐳 **Devcontainer creation** - building Docker image
3. ✅ **Test execution** - running tests inside the container

### 🔍 Local tests

The `test/arch-base/test.sh` file contains detailed tests:

- 🐧 Base system check (Arch Linux)
- 📦 Installed packages testing
- 🔧 Git verification
- 🌐 Network connectivity testing
- 📁 File system verification
- 🔧 Environment variables testing

The `test/arch-webtop/test.sh` file contains LinuxServer-specific tests:

- 🖥️ Desktop environment verification
- 🌐 Web interface accessibility (port 3000)
- 👤 LinuxServer user configuration (`abc` user)
- 🔧 PUID/PGID environment variables
- 📁 Volume mount verification (`/config`, `/workspace`)
- 🎨 Desktop environment specific checks

## 🔧 Troubleshooting

### 🐳 Docker issues

```bash
# Check Docker status
docker --version
docker ps

# Clear Docker cache
docker system prune -f
```

### 🎭 act issues

```bash
# Check act version
act --version

# Clear act cache
rm -rf ~/.cache/act
```

### 🛠️ devcontainer CLI issues

```bash
# Check installation
npm list -g @devcontainers/cli

# Reinstall
npm uninstall -g @devcontainers/cli
npm install -g @devcontainers/cli
```

## ➕ Adding new templates

When adding new templates:

1. 📁 Create directory `src/new-template/`
2. 🧪 Add tests in `test/new-template/`
3. 🔄 Update main workflow `test-pr.yaml` for automatic change detection
