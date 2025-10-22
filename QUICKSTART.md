# ⚡ Quick Start Guide - Pipelight Testing

Quick guide to start testing devcontainer templates locally with Pipelight.

## 🚀 Installation

### Install Pipelight

```bash
# Linux / macOS
curl -s https://pipelight.dev/install.sh | sh

# Or with cargo
cargo install pipelight
```

### Verify Installation

```bash
pipelight --version
pipelight ls
```

## 📋 Available Commands

### Test Specific Template

```bash
# Test arch-base
pipelight run test-template -e TEMPLATE=arch-base

# Test arch-webtop
pipelight run test-template -e TEMPLATE=arch-webtop
```

### Test All Templates

```bash
pipelight run test-all
```

### Test Only Changed Templates

```bash
pipelight run test-changed
```

### Cleanup

```bash
pipelight run cleanup
```

## 🎯 Common Workflows

### Quick Test During Development

```bash
# 1. Make changes to template
vim src/arch-base/.devcontainer/devcontainer.json

# 2. Test only what changed
pipelight run test-changed

# 3. Cleanup
pipelight run cleanup
```

### Full Test Before Commit

```bash
# Test everything
pipelight run test-all

# Cleanup
pipelight run cleanup
```

### Test Specific Template

```bash
# Test just one template
pipelight run test-template -e TEMPLATE=arch-base

# Cleanup
pipelight run cleanup
```

## 🔍 Troubleshooting

### Check Available Pipelines

```bash
pipelight ls
```

### View Pipeline Details

```bash
pipelight inspect test-template
```

### Enable Debug Logging

```bash
pipelight run test-template -e TEMPLATE=arch-base --log-level debug
```

### Manual Cleanup

```bash
# If automated cleanup fails
bash scripts/cleanup.sh

# Or manually
docker rm -f $(docker ps -a -f "label=test-container" -q)
rm -rf /tmp/arch-base /tmp/arch-webtop
```

## 📚 More Information

- **Full Testing Guide:** [TESTING.md](TESTING.md)
- **Pipelight Config:** [pipelight.toml](pipelight.toml)
- **Helper Scripts:** [scripts/README.md](scripts/README.md)
- **GitHub Workflows:** [.github/workflows/README.md](.github/workflows/README.md)

## 💡 Tips

1. **Use `test-changed`** for fast iteration during development
2. **Use `test-all`** before committing to ensure everything works
3. **Always cleanup** after testing to free up disk space
4. **Check logs** if tests fail - they're very detailed
5. **Docker must be running** before starting tests

## 🆘 Need Help?

- Check [TESTING.md](TESTING.md) for detailed documentation
- View pipeline configuration in [pipelight.toml](pipelight.toml)
- Inspect helper scripts in [scripts/](scripts/)
