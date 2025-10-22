# 🧪 Testing devcontainer templates

This document describes how to test devcontainer templates locally using [Pipelight](https://pipelight.dev).

## 📋 Prerequisites

1. 🐳 **Docker** - must be installed and running
2. ⚡ **Pipelight** - Fast and flexible CI/CD tool for local testing
3. 🛠️ **@devcontainers/cli** - will be installed automatically during testing

### 📦 Installing Pipelight

```bash
# 🐧 Linux / 🍎 macOS
curl -s https://pipelight.dev/install.sh | sh

# Or with cargo
cargo install pipelight

# Verify installation
pipelight --version
```

## 🚀 Local testing with Pipelight

### 🎯 Testing specific template

```bash
# Test arch-base template
pipelight run test-template -e TEMPLATE=arch-base

# Test arch-webtop template
pipelight run test-template -e TEMPLATE=arch-webtop
```

### 🧪 Testing all templates

```bash
# Test all templates sequentially
pipelight run test-all
```

### 🔄 Testing only changed templates

```bash
# Automatically detect and test changed templates
pipelight run test-changed
```

### 🧹 Cleanup artifacts

```bash
# Clean up all test artifacts and Docker containers
pipelight run cleanup
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

## 📋 Available Pipelines

### 🎯 test-template

Test a specific devcontainer template.

**Usage:**

```bash
pipelight run test-template -e TEMPLATE=arch-base
pipelight run test-template -e TEMPLATE=arch-webtop
```

**Steps:**

1. Validates template exists
2. Builds the devcontainer
3. Runs template-specific tests
4. Cleans up artifacts

### 🧪 test-all

Test all available templates sequentially.

**Usage:**

```bash
pipelight run test-all
```

**Features:**

- Tests arch-base and arch-webtop
- Continues on failure (won't stop if one fails)
- Provides summary at the end

### 🔄 test-changed

Automatically detect and test only changed templates.

**Usage:**

```bash
pipelight run test-changed
```

**Features:**

- Uses git diff to detect changes
- Tests only modified templates
- Perfect for pre-commit testing

### 🧹 cleanup

Clean up all test artifacts and Docker containers.

**Usage:**

```bash
pipelight run cleanup
```

**Cleans:**

- Test Docker containers
- Temporary directories (/tmp/arch-*)
- Pipelight cache files

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

### ⚡ Pipelight issues

```bash
# Check Pipelight version
pipelight --version

# List available pipelines
pipelight ls

# View pipeline details
pipelight inspect test-template

# Enable verbose logging
pipelight run test-template -e TEMPLATE=arch-base --log-level debug
```

### 🛠️ devcontainer CLI issues

```bash
# Check installation
npm list -g @devcontainers/cli

# Reinstall
npm uninstall -g @devcontainers/cli
npm install -g @devcontainers/cli
```

### 🧹 Manual cleanup

If automated cleanup fails:

```bash
# Stop all test containers
docker rm -f $(docker ps -a -f "label=test-container" -q)

# Remove temporary directories
rm -rf /tmp/arch-base /tmp/arch-webtop

# Run cleanup script directly
bash scripts/cleanup.sh
```

## ➕ Adding new templates

When adding new templates:

1. 📁 Create directory `src/new-template/`
2. 🧪 Add tests in `test/new-template/`
3. 🔄 Update GitHub Actions workflows:
   - Add to `test-pr.yaml` filters for automatic change detection
   - Add to `test-local.yaml` matrix
4. ⚡ Update Pipelight configuration:
   - Add template to `test-all` pipeline in `pipelight.toml`
   - Update `scripts/detect-changes.sh` to detect new template changes

## 🎯 Best Practices

### Local Development Workflow

1. **Make changes** to template files
2. **Test locally** with Pipelight:

   ```bash
   pipelight run test-changed
   ```

3. **Fix issues** if tests fail
4. **Run full test** before commit:

   ```bash
   pipelight run test-all
   ```

5. **Cleanup** after testing:

   ```bash
   pipelight run cleanup
   ```

### Quick Testing

For rapid iteration during development:

```bash
# Test only what you changed
pipelight run test-changed

# Or test specific template directly
pipelight run test-template -e TEMPLATE=arch-base
```

### CI/CD Integration

- **Local testing:** Use Pipelight for fast feedback
- **GitHub Actions:** Automatic testing on pull requests
- **Both use same scripts:** `.github/actions/smoke-test/`

## 📚 Additional Resources

- [Pipelight Documentation](https://pipelight.dev)
- [DevContainer CLI](https://github.com/devcontainers/cli)
- [GitHub Actions Workflows](.github/workflows/README.md)
