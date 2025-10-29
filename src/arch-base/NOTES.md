# 🐧 Arch Linux Base - Detailed Description

## 📖 Overview

The **Arch Linux Base** template provides a minimalist yet powerful development environment based on Arch Linux. This template uses pre-built images for faster container startup and consistent environments. It is ideal for developers who prefer flexibility and control over their development environment.

## 🐳 Pre-built Images

This template uses pre-built images from [arch-devcontainer-images](https://github.com/zyrakq/arch-devcontainer-images).

By default, it uses `arch-base-common` which includes:

- Common development tools (git, curl, wget, etc.)
- Zsh with Oh My Zsh
- Base development packages

### Available Image Variants

You can change the image in `.devcontainer/devcontainer.json` to use different variants:

**Base images**:

- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base:latest` - Minimal base
- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-common:latest` - With common-utils (default)

**Language-specific**:

- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-node:latest` - Node.js
- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-rust:latest` - Rust
- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-go:latest` - Go
- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-dotnet:latest` - .NET

**Docker variants**:

- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-dind:latest` - Docker-in-Docker
- `ghcr.io/zyrakq/arch-devcontainer-images/arch-base-dood:latest` - Docker-outside-of-Docker

See [full list of images](https://github.com/zyrakq/arch-devcontainer-images#available-images) for all available variants.

### Using Custom Dockerfile

If you need to customize the image further, you can switch back to using a Dockerfile:

Create a `Dockerfile` in `.devcontainer/` directory:

```dockerfile
ARG VARIANT="latest"
FROM docker.io/archlinux/archlinux:${VARIANT}

# Adjust directory permissions
RUN chmod 555 /srv/ftp && \
    chmod 755 /usr/share/polkit-1/rules.d/

# Initialize pacman keyring and upgrade system
RUN pacman-key --init && \
    pacman-key --populate archlinux && \
    pacman -Sy --needed --noconfirm --disable-download-timeout archlinux-keyring && \
    pacman -Su --noconfirm --disable-download-timeout
```

Update `.devcontainer/devcontainer.json` to use the Dockerfile:

```json
{
    "name": "${templateOption:projectName} Workspace (Archlinux)",
    "build": {
        "dockerfile": "Dockerfile",
        "context": ".",
        "args": {
            "VARIANT": "latest"
        }
    },
    // ... rest of configuration
}
```

## ⚡ Features

### 🏗️ Base System

- 🐧 **Operating System**: Arch Linux (rolling release)
- 🏛️ **Architectures**: linux/amd64, linux/arm64
- 📦 **Package Manager**: pacman + AUR via yay (optional)
- ✨ **Minimalist Approach**: only essential components

### 🛠️ Pre-installed Tools

- 🔧 **Git** - version control system
- 📥 **Curl/Wget** - download utilities
- 🔨 **Base-devel** - essential development tools
- 🔐 **SSH** - secure connection
- ✏️ **Vim/Nano** - text editors

### 🔧 Modularity through Features

The template supports Dev Container Features for extending functionality:

| Feature | Description |
|---------|-------------|
| 🛠️ `common-utils` | Additional command-line utilities |
| 🐳 `docker-in-docker` | Docker inside container |
| 🔗 `docker-outside-of-docker` | Use host Docker |
| 🐹 `go` | Go development environment |
| 🏗️ `terraform` | Infrastructure as code |
| ☁️ `aws-cli` | AWS Command Line Interface |
| 🔵 `azure-cli` | Azure Command Line Interface |
| 🌐 `gcloud-cli` | Google Cloud CLI |
| 📦 `yay` | AUR helper for Arch Linux |
| 🎨 `chaotic-aur` | Chaotic-AUR repository for pre-built AUR packages |
| 📥 `clone-repo` | Automatic repository cloning |
| 📦 `node` | Node.js development environment |
| 🦀 `rust` | Rust programming language and Cargo package manager |
| 🔷 `dotnet` | .NET development environment (via pacman) |
| 🔷 `dotnet-bin` | .NET development environment (via AUR) |

## ⚙️ Configuration Parameters

### 📝 projectName

- 🔤 **Type**: string
- 🎯 **Default**: "my-project"
- 📋 **Description**: Project name, used for container and network naming

```json
{
  "projectName": "my-awesome-project"
}
```

## 📁 Project Structure

After applying the template, the following structure is created:

```sh
.devcontainer/
├── devcontainer.json    # Main configuration
└── Dockerfile          # Arch Linux based image (if used)
```

## ➕ Adding Template to Project

To add this template to your VS Code project:

1. 📂 Open VS Code in your project folder
2. ⌨️ Press `Ctrl+Shift+P` and select "Dev Containers: Add Dev Container Configuration Files..."
3. 📋 Choose "Show All Definitions..."
4. 🔍 In the search field, enter: `ghcr.io/zyrakq/arch-devcontainer-templates/arch-base`
5. ✅ Select the desired template from the list

## 💡 Usage Examples

### 🔧 With Additional Features

```json
{
  "name": "Arch Development with Go",
  "features": {
    "ghcr.io/bartventer/arch-devcontainer-features/go:latest": {
      "version": "1.21"
    }
  }
}
```

## 🌐 Network Configuration

The template creates an isolated network for the project:

- 🏷️ **Network Name**: `${projectName}-network`
- 🔗 **Type**: bridge
- 🔒 **Isolation**: complete isolation from other projects

## 💾 Volume Management

### 📦 Recommended Volumes

```json
{
  "mounts": [
    "source=${localWorkspaceFolder},target=/workspace,type=bind",
    "source=${projectName}-home,target=/home/vscode,type=volume"
  ]
}
```

## 📦 Package Installation

### 🐧 Via pacman

```bash
# Update system
sudo pacman -Syu

# Install packages
sudo pacman -S package-name
```

### 📥 Via AUR (with yay feature)

```bash
# Install from AUR
yay -S aur-package-name
```

## 💡 Usage Recommendations

### 🎯 Perfect for

- 🔧 Systems programming
- 🐹 Go, Rust, C/C++ development
- 🚀 DevOps and automation
- 🧪 Experimenting with latest technologies
- ⚙️ Custom development environment setup

### ⚠️ Consider

- 🔄 Arch Linux is rolling release, requires regular updates
- ✨ Minimalist approach - need to install additional packages
- 🐧 Requires basic Linux knowledge

### 🔧 Post-creation setup

1. 🔄 Update system: `sudo pacman -Syu`
2. 📦 Install required packages
3. 🔧 Configure Git: `git config --global user.name "Your Name"`
4. 🔐 Set up SSH keys if needed

## 🔧 Troubleshooting

### 📦 Package Issues

```bash
# Clear pacman cache
sudo pacman -Sc

# Force refresh keys
sudo pacman-key --refresh-keys
```

## 🔧 Extending the Template

### 📝 Adding Post Scripts

```json
{
  "postCreateCommand": "bash .devcontainer/setup.sh",
  "postStartCommand": "echo 'Container started'"
}
```

## 🤝 Support and Community

- 📚 **Documentation**: [GitHub Repository](https://github.com/zyrakq/devcontainer-templates)
- 🐛 **Issues**: Report issues via GitHub Issues
- 📖 **Arch Wiki**: [Arch Linux Wiki](https://wiki.archlinux.org/)
- 🔗 **Related Templates**:
  - **[Arch Linux Base](../arch-base/NOTES.md)** - Minimalist Arch Linux environment without desktop (current)
  - **[Arch Linux Desktop](../arch-webtop/NOTES.md)** - Full desktop environment with web access
- � **Dev Containers**: [Official Documentation](https://containers.dev/)
- 🔗 **Related Projects**:
  - **Pre-built Images**:
    - [zyrakq/arch-devcontainer-images](https://github.com/zyrakq/arch-devcontainer-images) - Pre-built Arch Linux images used by this template
    - [bartventer/devcontainer-images](https://github.com/bartventer/devcontainer-images/) - Alternative pre-built images with Arch Linux support
  - **DevContainer Features**:
    - [bartventer/arch-devcontainer-features](https://github.com/bartventer/arch-devcontainer-features/) - DevContainer features for Arch Linux by bartventer
    - [zyrakq/arch-devcontainer-features](https://github.com/zyrakq/arch-devcontainer-features/) - Additional DevContainer features for Arch Linux

## 📄 License

This project is dual-licensed under:

- [Apache License 2.0](https://github.com/zyrakq/devcontainer-templates/blob/main/LICENSE-APACHE)
- [MIT License](https://github.com/zyrakq/devcontainer-templates/blob/main/LICENSE-MIT)
