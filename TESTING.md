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

```bash
act pull_request
```

## 🏗️ Testing structure

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
