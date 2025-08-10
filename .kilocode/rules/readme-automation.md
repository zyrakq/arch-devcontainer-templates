# Readme Automation

## Brief overview

Rules for automatic README file generation in DevContainer templates project. README files are created automatically from NOTES.md files through GitHub Actions workflow.

## Template documentation

- Each template must have a `/src/<template>/NOTES.md` file with complete documentation
- NOTES.md contains description, configuration examples, options and usage instructions
- File must be written in English using Markdown formatting
- Include emojis for improved readability (📝, 🚀, ✅, 🔧, etc.)

## Manual README creation prohibition

- DO NOT create README.md files in `/src/<template>/` directories
- README files are generated automatically when `.github/workflows/release.yaml` executes
- Automatic generation is based on `/src/<template>/NOTES.md` content
- Manual README creation may lead to conflicts during automatic generation

## Automation workflow

- GitHub Actions workflow `release.yaml` handles README file generation
- Process runs automatically on release or manually triggered
- NOTES.md content is transformed into corresponding README.md
- Links and formatting are automatically updated for GitHub

## NOTES.md structure

- Start with "## 📖 Overview" section
- Include sections: Features, Configuration Parameters, Project Structure, Usage Examples
- Add sections: Adding Template to Project, Network Configuration, Volume Management, Package Installation
- Add Usage Recommendations, Troubleshooting, Extending the Template sections as needed
- Use consistent formatting and structure across templates
