# Arch Linux Base - Detailed Description

## Overview

The **Arch Linux Base** template provides a minimalist yet powerful development environment based on Arch Linux. This template is ideal for developers who prefer flexibility and control over their development environment.

## Features

### 🏗️ Base System
- **Operating System**: Arch Linux (rolling release)
- **Architectures**: linux/amd64, linux/arm64
- **Package Manager**: pacman + AUR via yay (optional)
- **Minimalist Approach**: only essential components

### 🛠️ Pre-installed Tools
- **Git** - version control system
- **Curl/Wget** - download utilities
- **Base-devel** - essential development tools
- **SSH** - secure connection
- **Vim/Nano** - text editors

### 🔧 Modularity through Features
The template supports Dev Container Features for extending functionality:

| Feature | Description |
|---------|-------------|
| `common-utils` | Additional command-line utilities |
| `docker-in-docker` | Docker inside container |
| `docker-outside-of-docker` | Use host Docker |
| `go` | Go development environment |
| `terraform` | Infrastructure as code |
| `aws-cli` | AWS Command Line Interface |
| `azure-cli` | Azure Command Line Interface |
| `gcloud-cli` | Google Cloud CLI |
| `yay` | AUR helper for Arch Linux |
| `clone-repo` | Automatic repository cloning |

## Configuration Parameters

### projectName
- **Type**: string
- **Default**: "my-project"
- **Description**: Project name, used for container and network naming

```json
{
  "projectName": "my-awesome-project"
}
```

## Project Structure

After applying the template, the following structure is created:

```
.devcontainer/
├── devcontainer.json    # Main configuration
└── Dockerfile          # Arch Linux based image (if used)
```

## Adding Template to Project

To add this template to your VS Code project:

1. Open VS Code in your project folder
2. Press `Ctrl+Shift+P` and select "Dev Containers: Add Dev Container Configuration Files..."
3. Choose "Show All Definitions..."
4. In the search field, enter: `ghcr.io/zeritiq/arch-devcontainer-templates/arch-base`
5. Select the desired template from the list

## Usage Examples

### With Additional Features
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

## Network Configuration

The template creates an isolated network for the project:
- **Network Name**: `${projectName}-network`
- **Type**: bridge
- **Isolation**: complete isolation from other projects

## Volume Management

### Recommended Volumes
```json
{
  "mounts": [
    "source=${localWorkspaceFolder},target=/workspace,type=bind",
    "source=${projectName}-home,target=/home/vscode,type=volume"
  ]
}
```

## Package Installation

### Via pacman
```bash
# Update system
sudo pacman -Syu

# Install packages
sudo pacman -S package-name
```

### Via AUR (with yay feature)
```bash
# Install from AUR
yay -S aur-package-name
```

## Usage Recommendations

### 🎯 Perfect for:
- Systems programming
- Go, Rust, C/C++ development
- DevOps and automation
- Experimenting with latest technologies
- Custom development environment setup

### ⚠️ Consider:
- Arch Linux is rolling release, requires regular updates
- Minimalist approach - need to install additional packages
- Requires basic Linux knowledge

### 🔧 Post-creation setup:
1. Update system: `sudo pacman -Syu`
2. Install required packages
3. Configure Git: `git config --global user.name "Your Name"`
4. Set up SSH keys if needed

## Troubleshooting

### Package Issues
```bash
# Clear pacman cache
sudo pacman -Sc

# Force refresh keys
sudo pacman-key --refresh-keys
```

## Extending the Template

### Adding Post Scripts
```json
{
  "postCreateCommand": "bash .devcontainer/setup.sh",
  "postStartCommand": "echo 'Container started'"
}
```

## Support and Community

- **Documentation**: [GitHub Repository](https://github.com/zeritiq/devcontainer-templates)
- **Issues**: Report issues via GitHub Issues
- **Arch Wiki**: [Arch Linux Wiki](https://wiki.archlinux.org/)
- **Dev Containers**: [Official Documentation](https://containers.dev/)
- **Related Projects**: [bartventer/devcontainer-images](https://github.com/bartventer/devcontainer-images/) - Comprehensive collection of Dev Container images and features

## License

MIT License - see [LICENSE](https://github.com/zeritiq/devcontainer-templates/blob/main/LICENSE)
