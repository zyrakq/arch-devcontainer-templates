# Dev Container Templates

A collection of templates for VS Code Dev Containers, designed for quick development environment setup.

## Usage

1. Open VS Code in your project folder
2. Press `Ctrl+Shift+P` and select "Dev Containers: Add Dev Container Configuration Files..."
3. Choose "Show All Definitions..."
4. In the search field, enter: `ghcr.io/zeritiq/arch-devcontainer-templates/arch-base`
5. Select the desired template from the list

## Available Templates

### arch-base
Base template based on Arch Linux with:
- Minimal Arch Linux base image
- DevContainer features for modular functionality
- Separate volumes for home directory and workspace
- Custom network isolation

## Available Features

| Feature | Repository |
|---------|------------|
| common-utils | `ghcr.io/bartventer/arch-devcontainer-features/common-utils` |
| aws-cli | `ghcr.io/bartventer/arch-devcontainer-features/aws-cli` |
| azure-cli | `ghcr.io/bartventer/arch-devcontainer-features/azure-cli` |
| gcloud-cli | `ghcr.io/bartventer/arch-devcontainer-features/gcloud-cli` |
| go | `ghcr.io/bartventer/arch-devcontainer-features/go` |
| terraform | `ghcr.io/bartventer/arch-devcontainer-features/terraform` |
| docker-in-docker | `ghcr.io/bartventer/arch-devcontainer-features/docker-in-docker` |
| docker-outside-of-docker | `ghcr.io/bartventer/arch-devcontainer-features/docker-outside-of-docker` |
| yay | `ghcr.io/zeritiq/arch-devcontainer-features/yay` |
| clone-repo | `ghcr.io/zeritiq/arch-devcontainer-features/clone-repo` |

## Template Parameters

When using the template, you'll be prompted to specify:
- **Project Name**: Project name (used for container and network names)

## Template Structure

```
.devcontainer/
├── devcontainer.json           # Main configuration with features
└── Dockerfile                  # Arch Linux image with required packages
```

## Local Testing

For developers working on these templates, you can test changes locally using [Act](https://github.com/nektos/act):

```bash
# Test pull request workflow locally
act pull_request
```

This allows you to validate template builds and tests before pushing changes to the repository.

## Setup

After creating the .devcontainer configuration:
1. Run "Dev Containers: Reopen in Container"

## Related Projects

This project was inspired by and borrows concepts from:
- [bartventer/devcontainer-images](https://github.com/bartventer/devcontainer-images/) - Comprehensive collection of Dev Container images and features

## License

MIT
