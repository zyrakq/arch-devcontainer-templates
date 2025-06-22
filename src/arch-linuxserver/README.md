
# Arch Linux Desktop (LinuxServer) (arch-linuxserver)

A development container with Arch Linux desktop environment using LinuxServer.io images with web-based GUI access

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| baseImage | Base image for the container (KasmVNC, KDE, i3, MATE, or XFCE) | string | lscr.io/linuxserver/webtop:arch-kde |
| projectName | Project name (used for container and network names) | string | my-project |
| title | Title displayed in the web interface | string | Arch Linux Desktop |
| timezone | Timezone for the container (e.g., Europe/London, America/New_York) | string | Etc/UTC |

# 🖥️ Arch Linux with Web Desktop - Detailed Description

## 📖 Overview

The **Arch Linux with Web Desktop** template provides a powerful development environment with full desktop experience accessible through a web browser. Based on LinuxServer.io images, this template offers multiple desktop environments with web-based GUI access, making it perfect for remote development, GUI applications testing, and full desktop workflows.

## ⚡ Features

### 🖥️ Base Image Options
- 🎨 **5 Base Images**: KasmVNC, KDE, i3, MATE, XFCE
- 🌐 **Web Access**: Full desktop accessible via browser on port 3000
- 🔄 **Flexible Selection**: Choose the right base image for your needs
- 📱 **Cross-platform**: Works on any device with a web browser

### 🏗️ LinuxServer.io Base
- 🐧 **Operating System**: Arch Linux (rolling release)
- 🏛️ **Architectures**: linux/amd64, linux/arm64
- 👤 **User Management**: Pre-configured `abc` user with HOME=/config
- 🔐 **PUID/PGID Support**: Proper file permissions handling
- 📦 **Package Manager**: pacman with full Arch repositories

### 🛠️ Pre-installed Components
- 🔧 **Development Tools**: Git, curl, wget, base-devel
- 🖥️ **Desktop Applications**: File manager, terminal, text editor
- 🌐 **Web Interface**: KasmVNC or native desktop streaming
- 🔐 **SSH Support**: Secure remote access capabilities

### 🔧 Modularity through Features
The template supports Dev Container Features for extending functionality:

| Feature | Description | Desktop Compatibility |
|---------|-------------|----------------------|
| 🛠️ `common-utils` | Additional command-line utilities | ✅ All environments |
| 🐳 `docker-in-docker` | Docker inside container | ✅ All environments |
| 🔗 `docker-outside-of-docker` | Use host Docker | ✅ All environments |
| 🐹 `go` | Go development environment | ✅ All environments |
| 🏗️ `terraform` | Infrastructure as code | ✅ All environments |
| ☁️ `aws-cli` | AWS Command Line Interface | ✅ All environments |
| 🔵 `azure-cli` | Azure Command Line Interface | ✅ All environments |
| 🌐 `gcloud-cli` | Google Cloud CLI | ✅ All environments |
| 📦 `yay` | AUR helper for Arch Linux | ✅ All environments |
| 📥 `clone-repo` | Automatic repository cloning | ✅ All environments |
| 📦 `node` | Node.js development environment | ✅ All environments |
| 🔷 `dotnet` | .NET development environment (via pacman) | ✅ All environments |
| 🔷 `dotnet-bin` | .NET development environment (via AUR) | ✅ All environments |
| 🎨 `desktop-apps` | GUI development tools | 🖥️ Desktop environments only |

**Note**: All features work with LinuxServer.io base images. Features are configured for user `abc` with HOME directory `/config`.

## ⚙️ Configuration Parameters

### 🎨 baseImage
- 🔤 **Type**: string (enum)
- 🎯 **Default**: "lscr.io/linuxserver/webtop:arch-kde"
- 📋 **Options**:
  - `ghcr.io/linuxserver/baseimage-kasmvnc:arch` (KasmVNC)
  - `lscr.io/linuxserver/webtop:arch-kde` (KDE Desktop)
  - `lscr.io/linuxserver/webtop:arch-i3` (i3 Window Manager)
  - `lscr.io/linuxserver/webtop:arch-mate` (MATE Desktop)
  - `lscr.io/linuxserver/webtop:arch-xfce` (XFCE Desktop)
- 📝 **Description**: Base image for the container (KasmVNC, KDE, i3, MATE, or XFCE)

```json
{
  "baseImage": "lscr.io/linuxserver/webtop:arch-kde"
}
```

### 📝 projectName
- 🔤 **Type**: string
- 🎯 **Default**: "my-project"
- 📋 **Description**: Project name, used for container and network naming

```json
{
  "projectName": "my-awesome-desktop-project"
}
```

### 🏷️ title
- 🔤 **Type**: string
- 🎯 **Default**: "Arch Linux Desktop"
- 📋 **Description**: Title displayed in the web interface

```json
{
  "title": "My Development Desktop"
}
```

### 🕐 timezone
- 🔤 **Type**: string
- 🎯 **Default**: "Etc/UTC"
- 📋 **Description**: Timezone for the container

```json
{
  "timezone": "Europe/London"
}
```

## 🖥️ Base Images

| Base Image | Description | Best For | Resource Usage |
|------------|-------------|----------|----------------|
| 🎨 **baseimage-kasmvnc** | Optimized web desktop | Remote access, low bandwidth | ⚡ Low |
| 🔷 **webtop:arch-kde** | Full-featured modern desktop | Development, multimedia | 🔥 High |
| ⚡ **webtop:arch-i3** | Tiling window manager | Power users, keyboard workflows | ⚡ Low |
| 🌿 **webtop:arch-mate** | Traditional desktop | Familiar interface, stability | 📊 Medium |
| 🦌 **webtop:arch-xfce** | Lightweight desktop | Performance, simplicity | ⚡ Low |

## 📁 Project Structure

After applying the template, the following structure is created:

```
.devcontainer/
├── devcontainer.json    # Main configuration with LinuxServer settings
└── Dockerfile          # LinuxServer.io based image
```

## ➕ Adding Template to Project

To add this template to your VS Code project:

1. 📂 Open VS Code in your project folder
2. ⌨️ Press `Ctrl+Shift+P` and select "Dev Containers: Add Dev Container Configuration Files..."
3. 📋 Choose "Show All Definitions..."
4. 🔍 In the search field, enter: `ghcr.io/zyrakq/arch-devcontainer-templates/arch-linuxserver`
5. ✅ Select the desired template from the list
6. 🎨 Choose your preferred desktop environment

## 💡 Usage Examples

### 🔷 KDE Desktop with Full Development Stack
```json
{
  "baseImage": "lscr.io/linuxserver/webtop:arch-kde",
  "projectName": "kde-dev-environment",
  "title": "KDE Development Desktop",
  "timezone": "America/New_York",
  "features": {
    "ghcr.io/bartventer/arch-devcontainer-features/common-utils:1": {
      "username": "abc"
    },
    "ghcr.io/zyrakq/arch-devcontainer-features/yay:latest": {},
    "ghcr.io/devcontainers/features/docker-in-docker:latest": {},
    "ghcr.io/devcontainers/features/node:latest": {
      "version": "18"
    },
    "ghcr.io/bartventer/arch-devcontainer-features/go:latest": {
      "version": "1.21"
    }
  }
}
```

### ⚡ Lightweight i3 with Essential Tools
```json
{
  "baseImage": "lscr.io/linuxserver/webtop:arch-i3",
  "projectName": "minimal-desktop",
  "title": "i3 Tiling Desktop",
  "timezone": "Europe/Berlin",
  "features": {
    "ghcr.io/bartventer/arch-devcontainer-features/common-utils:1": {
      "username": "abc"
    },
    "ghcr.io/zyrakq/arch-devcontainer-features/yay:latest": {},
    "ghcr.io/devcontainers/features/docker-outside-of-docker:latest": {}
  }
}
```

### 🌐 Web-Optimized KasmVNC with Cloud Tools
```json
{
  "baseImage": "ghcr.io/linuxserver/baseimage-kasmvnc:arch",
  "projectName": "web-desktop",
  "title": "Remote Web Desktop",
  "timezone": "Asia/Tokyo",
  "features": {
    "ghcr.io/bartventer/arch-devcontainer-features/common-utils:1": {
      "username": "abc"
    },
    "ghcr.io/devcontainers/features/aws-cli:latest": {},
    "ghcr.io/devcontainers/features/azure-cli:latest": {},
    "ghcr.io/bartventer/arch-devcontainer-features/terraform:latest": {}
  }
}
```

### 🎨 XFCE with GUI Development Tools
```json
{
  "baseImage": "lscr.io/linuxserver/webtop:arch-xfce",
  "projectName": "gui-dev-desktop",
  "title": "XFCE GUI Development",
  "timezone": "Europe/London",
  "features": {
    "ghcr.io/bartventer/arch-devcontainer-features/common-utils:1": {
      "username": "abc"
    },
    "ghcr.io/zyrakq/arch-devcontainer-features/yay:latest": {},
    "ghcr.io/devcontainers/features/node:latest": {
      "version": "20"
    },
    "ghcr.io/bartventer/arch-devcontainer-features/dotnet:latest": {}
  }
}
```

## 🌐 Web Interface Access

### 🔗 Accessing the Desktop
1. 🚀 Start the Dev Container
2. 🌐 Open browser and navigate to `http://localhost:3000`
3. 🖱️ Use the desktop environment directly in your browser
4. 📱 Access from any device on the same network

### 🔐 Security Considerations
- 🏠 **Local Access**: Default configuration for localhost only
- 🔒 **Network Isolation**: Container runs in isolated network
- 🛡️ **No Authentication**: Suitable for development environments only
- ⚠️ **Production Warning**: Not recommended for production use without additional security

## 🌐 Network Configuration

The template creates an isolated network environment:
- 🏷️ **Network Name**: `${projectName}-network`
- 🔗 **Type**: bridge network
- 🚪 **Port Forwarding**: 3000 (web interface)
- 🔒 **Isolation**: Complete isolation from other projects
- 📡 **Auto-forward**: Browser opens automatically

## 💾 Volume Management

### 📦 LinuxServer Volume Structure
```json
{
  "mounts": [
    "source=${projectName}-workspace,target=/workspace/${projectName},type=volume",
    "source=${projectName}-home,target=/config,type=volume"
  ]
}
```

### 🏠 Volume Persistence
- 📁 **User Home**: `/config` (persistent volume `${projectName}-home`)
- 💾 **Desktop Settings**: Automatically saved in `/config/.config`
- 🔧 **Application Configs**: Preserved between restarts
- 📂 **Workspace**: `/workspace/${projectName}` (persistent volume `${projectName}-workspace`)

### 🔧 Volume Permissions
LinuxServer.io images automatically handle file permissions using PUID/PGID:
```bash
# Files are automatically owned by abc:abc (1000:1000)
# No manual permission fixes needed
```

## 📦 Package Installation

### 🐧 Via pacman
```bash
# Update system
sudo pacman -Syu

# Install packages
sudo pacman -S package-name

# Install desktop applications
sudo pacman -S code firefox gimp inkscape
```

### 📥 Via AUR (with yay feature)
```bash
# Install from AUR
yay -S aur-package-name

# Install AUR desktop applications
yay -S visual-studio-code-bin discord
```

### 🖥️ Desktop-Specific Packages
```bash
# KDE applications
sudo pacman -S kdevelop kate konsole

# XFCE applications
sudo pacman -S mousepad thunar xfce4-terminal

# i3 applications
sudo pacman -S dmenu i3status i3lock
```

## 🐧 LinuxServer Specifics

### 👤 User Configuration
- 🆔 **Username**: `abc`
- 🏠 **Home Directory**: `/config`
- 🔢 **PUID**: 1000 (configurable)
- 🔢 **PGID**: 1000 (configurable)
- 🔐 **Permissions**: Automatic file ownership handling

### 🔧 Environment Variables
```bash
PUID=1000          # User ID
PGID=1000          # Group ID
TZ=Etc/UTC         # Timezone
TITLE=Arch Linux Desktop  # Web interface title
```

### 📦 System Requirements
- 💾 **RAM**: Minimum 2GB, recommended 4GB+
- 🧠 **Shared Memory**: 1GB (--shm-size=1gb)
- 💿 **Storage**: 5GB+ for desktop environment
- 🌐 **Network**: Port 3000 available

## 💡 Usage Recommendations

### 🎯 Perfect for:
- 🖥️ **GUI Application Development**: Testing desktop applications
- 🎨 **Design Work**: Graphics and multimedia projects
- 🔬 **Research**: Academic work requiring GUI tools
- 📚 **Learning**: Linux desktop environment exploration
- 🌐 **Remote Development**: Accessing development environment from anywhere
- 🧪 **Testing**: Cross-platform GUI testing

### 🔷 Base Image Selection:
- **webtop:arch-kde**: Choose for modern development with full IDE support
- **webtop:arch-i3**: Perfect for keyboard-driven development workflows
- **webtop:arch-xfce**: Best balance of features and performance
- **webtop:arch-mate**: Ideal for traditional desktop experience
- **baseimage-kasmvnc**: Optimized for remote access and low bandwidth

### ⚠️ Consider:
- 🔄 Higher resource usage compared to CLI-only containers
- 🌐 Web interface may have slight input lag
- 📱 Mobile browser experience may be limited
- 🔒 Additional security setup needed for external access

## 🔧 Troubleshooting

### 🌐 Web Interface Issues
```bash
# Check if service is running (s6-overlay)
s6-svstat /var/run/s6/services/*

# Restart web service (container restart recommended)
docker restart container-name

# Check port availability
netstat -tlnp | grep 3000

# Check logs
tail -f /config/log/supervisord.log
```

### 🖥️ Desktop Environment Problems
```bash
# Reset desktop settings
rm -rf /config/.config/kde*  # For KDE
rm -rf /config/.config/xfce* # For XFCE

# Restart container to reload desktop
```

### 📦 Package Installation Issues
```bash
# Update system
sudo pacman -Syu

# Clear package cache
sudo pacman -Sc

# Refresh keyring
sudo pacman-key --refresh-keys
```

### 🔐 Permission Problems
```bash
# Fix ownership (run as root)
chown -R abc:abc /config
chown -R abc:abc /workspace
```

## 🔧 Extending the Template

### 📦 Installing Desktop Applications
```bash
# Install development tools
sudo pacman -S code firefox gimp inkscape

# Install multimedia tools
sudo pacman -S vlc audacity blender

# Install office suite
sudo pacman -S libreoffice-fresh
```

### 🎨 Customizing Desktop Environment
```json
{
  "postCreateCommand": "bash .devcontainer/setup-desktop.sh",
  "postStartCommand": "echo 'Desktop environment ready'"
}
```

### 🔧 Adding Development Features
```json
{
  "features": {
    "ghcr.io/zyrakq/arch-devcontainer-features/yay:latest": {},
    "ghcr.io/devcontainers/features/docker-in-docker:latest": {},
    "ghcr.io/devcontainers/features/node:latest": {
      "version": "18"
    }
  }
}
```

## 🤝 Support and Community

- 📚 **Documentation**: [GitHub Repository](https://github.com/zyrakq/devcontainer-templates)
- 🐛 **Issues**: Report issues via GitHub Issues
- 🐳 **LinuxServer.io**: [Official Documentation](https://docs.linuxserver.io/)
- 🔗 **Related Templates**:
  - **[Arch Linux Base](../arch-base/NOTES.md)** - Minimalist Arch Linux environment without desktop
  - **[Arch Linux Desktop](../arch-linuxserver/NOTES.md)** - Full desktop environment with web access (current)
- 🖥️ **Desktop Environments**:
  - [KDE](https://kde.org/) - Modern desktop environment
  - [i3](https://i3wm.org/) - Tiling window manager
  - [XFCE](https://xfce.org/) - Lightweight desktop
  - [MATE](https://mate-desktop.org/) - Traditional desktop
  - [KasmVNC](https://kasmweb.com/) - Web-based VNC
- 🐳 **Dev Containers**: [Official Documentation](https://containers.dev/)
- 🔗 **Related Projects**:
  - [LinuxServer.io Images](https://github.com/linuxserver) - Container images used as base
  - [bartventer/arch-devcontainer-features](https://github.com/bartventer/arch-devcontainer-features/) - Additional DevContainer features
  - [zyrakq/arch-devcontainer-features](https://github.com/zyrakq/arch-devcontainer-features/) - Arch-specific DevContainer features

## 📄 License

MIT License - see [LICENSE](https://github.com/zyrakq/devcontainer-templates/blob/main/LICENSE)

---

_Note: This file was auto-generated from the [devcontainer-template.json](https://github.com/zyrakq/arch-devcontainer-templates/blob/main/src/arch-linuxserver/devcontainer-template.json).  Add additional notes to a `NOTES.md`._
