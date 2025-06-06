# Dev Container Templates

A collection of templates for VS Code Dev Containers, designed for quick development environment setup.

## Usage

1. Open VS Code in your project folder
2. Press `Ctrl+Shift+P` and select "Dev Containers: Add Dev Container Configuration Files..."
3. Choose "Show All Definitions..."
4. In the search field, enter this repository URL: `https://github.com/zeritiq/devcontainer-templates`
5. Select the desired template from the list

## Available Templates

### arch-base
Base template based on Arch Linux with:
- Git, SSH, and base development tools
- Configurable user and permissions (vscode user)
- Separate volumes for home directory and workspace
- Custom network isolation

## Template Parameters

When using the template, you'll be prompted to specify:
- **Project Name**: Project name (used for container and network names)

## Template Structure

```
.devcontainer/
├── devcontainer.json           # Main configuration with features
└── Dockerfile                  # Arch Linux image with required packages
```

## Setup

After creating the .devcontainer configuration:
1. Run "Dev Containers: Reopen in Container"

## License

MIT
