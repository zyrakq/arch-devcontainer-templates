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
- YAY AUR helper for additional packages
- Configurable user and permissions (vscode user)
- Container initialization scripts
- Separate volumes for home directory and workspace

## Template Parameters

When using the template, you'll be prompted to specify:
- **Project Name**: Project name (used for container and network names)
- **Repository URL**: Git repository URL for cloning (optional)
- **Forward Port**: Port to forward to host (default 8080)

## Template Structure

```
.devcontainer/
├── devcontainer.json           # Main configuration
└── docker/
    ├── docker-compose.yml      # Docker Compose configuration
    ├── Dockerfile              # Arch Linux image with required packages
    ├── .env                    # Environment variables (ready to use)
    ├── .env.example            # Environment variables reference
    └── scripts/
        ├── setup_container.sh  # Container initialization script
        └── clone-repo.sh       # Repository cloning script
```

## Setup

After creating the .devcontainer configuration:
1. Review and adjust `.env` file if needed (`.env.example` serves as reference)
2. Edit scripts in the `scripts/` folder if needed
3. Run "Dev Containers: Reopen in Container"

## License

MIT
