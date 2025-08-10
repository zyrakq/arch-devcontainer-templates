# 🐳 Dev Container Templates

A collection of templates for VS Code Dev Containers, designed for quick development environment setup.

## 🚀 Usage

1. 📂 Open VS Code in your project folder
2. ⌨️ Press `Ctrl+Shift+P` and select "Dev Containers: Add Dev Container Configuration Files..."
3. 📋 Choose "Show All Definitions..."
4. 🔍 In the search field, enter: `ghcr.io/zyrakq/arch-devcontainer-templates/arch-base` or `ghcr.io/zyrakq/arch-devcontainer-templates/arch-linuxserver`
5. ✅ Select the desired template from the list

## 📦 Available Templates

### 🏗️ arch-base

Base template based on Arch Linux with:

- 🐧 Minimal Arch Linux base image
- 🔧 DevContainer features for modular functionality
- 💾 Separate volumes for home directory and workspace
- 🔒 Custom network isolation

### 🖥️ arch-linuxserver

Desktop template based on LinuxServer.io images with:

- 🌐 Web-based GUI access via browser (port 3000)
- 🖥️ 5 desktop environments: KDE, i3, MATE, XFCE, or terminal-only (kasmvnc)
- 🐧 Arch Linux base with LinuxServer.io optimizations
- 👤 User `abc` with HOME at `/config`
- 🔧 PUID/PGID support for proper file permissions

## ⚡ Available Features

| Feature | Repository |
|---------|------------|
| 🛠️ common-utils | `ghcr.io/bartventer/arch-devcontainer-features/common-utils` |
| ☁️ aws-cli | `ghcr.io/bartventer/arch-devcontainer-features/aws-cli` |
| 🔵 azure-cli | `ghcr.io/bartventer/arch-devcontainer-features/azure-cli` |
| 🌐 gcloud-cli | `ghcr.io/bartventer/arch-devcontainer-features/gcloud-cli` |
| 🐹 go | `ghcr.io/bartventer/arch-devcontainer-features/go` |
| 🏗️ terraform | `ghcr.io/bartventer/arch-devcontainer-features/terraform` |
| 🐳 docker-in-docker | `ghcr.io/bartventer/arch-devcontainer-features/docker-in-docker` |
| 🔗 docker-outside-of-docker | `ghcr.io/bartventer/arch-devcontainer-features/docker-outside-of-docker` |
| 📦 yay | `ghcr.io/zyrakq/arch-devcontainer-features/yay` |
| 📥 clone-repo | `ghcr.io/zyrakq/arch-devcontainer-features/clone-repo` |
| 📦 node | `ghcr.io/zyrakq/arch-devcontainer-features/node` |
| 🦀 rust | `ghcr.io/zyrakq/arch-devcontainer-features/rust` |
| 🔷 dotnet | `ghcr.io/zyrakq/arch-devcontainer-features/dotnet` |
| 🔷 dotnet-bin | `ghcr.io/zyrakq/arch-devcontainer-features/dotnet-bin` |

## ⚙️ Template Parameters

When using the template, you'll be prompted to specify:

### arch-base

- 📝 **Project Name**: Project name (used for container and network names)

### arch-linuxserver

- 🎨 **Desktop Environment**: Choose from kasmvnc, kde, i3, mate, or xfce
- 📝 **Project Name**: Project name (used for container and network names)
- 🏷️ **Title**: Title displayed in the web interface
- 🕐 **Timezone**: Timezone for the container (e.g., Europe/London, America/New_York)

## 📁 Template Structure

```sh
.devcontainer/
├── devcontainer.json           # Main configuration with features
└── Dockerfile                  # Arch Linux image with required packages
```

## 🧪 Local Testing

For developers working on these templates, you can test changes locally using [Act](https://github.com/nektos/act).

### ⚡ Quick Testing

```bash
# Test all templates (via pull request workflow)
act pull_request
```

### 🔍 Detailed Testing

For comprehensive testing instructions, troubleshooting, and advanced usage, see [TESTING.md](TESTING.md).

This allows you to validate template builds and tests before pushing changes to the repository.

## 🔧 Setup

After creating the .devcontainer configuration:

1. 🔄 Run "Dev Containers: Reopen in Container"

## 🔗 Related Projects

This project was inspired by and borrows concepts from:

- [bartventer/devcontainer-images](https://github.com/bartventer/devcontainer-images/) - Comprehensive collection of Dev Container images and features
- [bartventer/arch-devcontainer-features](https://github.com/bartventer/arch-devcontainer-features/) - DevContainer features for Arch Linux by bartventer
- [zyrakq/arch-devcontainer-features](https://github.com/zyrakq/arch-devcontainer-features/) - Additional DevContainer features for Arch Linux

## 📄 License

This project is dual-licensed under:

- [Apache License 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)
