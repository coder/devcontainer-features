# Contributing to DanielleMaywood's Dev Container Features

This guide contains information about how to contribute to this collection of dev container Features maintained by DanielleMaywood.

## Current Features

This repository currently contains the following features:

- `code-server` - Adds VS Code in the browser functionality to your dev container

## Adding a New Feature

To add a new feature to this collection:

1. Create a new folder under the `src` directory with the name of your feature
2. Add a `devcontainer-feature.json` file describing your feature and its options
3. Create an `install.sh` script that installs the feature
4. Optionally add a `README.md` with additional documentation

### Feature Structure

Each feature should follow this structure:

```
src/
└── your-feature-name/
    ├── devcontainer-feature.json  # Feature metadata and options
    ├── install.sh                 # Installation script
    └── README.md                  # (Optional) Feature-specific documentation
```

### devcontainer-feature.json Example

```json
{
    "name": "Your Feature Name",
    "id": "your-feature-name",
    "version": "1.0.0",
    "description": "Brief description of your feature",
    "options": {
        "optionId": {
            "type": "string",
            "default": "default value",
            "description": "Description of this option"
        }
    },
    "entrypoint": "/usr/local/bin/your-feature-entrypoint",
    "dependsOn": {
        "ghcr.io/devcontainers/features/common-utils:2": {}
    }
}
```

## Testing Your Feature

Before submitting a PR, test your feature using the Dev Container CLI:

```bash
# From the repository root
devcontainer features test -f your-feature-name
```

You can also test all features:

```bash
devcontainer features test
```

## Versioning Guidelines

Follow semantic versioning for all features:

- Increment the **major** version when making incompatible changes
- Increment the **minor** version when adding functionality in a backward-compatible manner
- Increment the **patch** version when making backward-compatible bug fixes

Update the version in your feature's `devcontainer-feature.json` file.

## Publishing Process

Features in this repository are automatically published to GitHub Container Registry (GHCR) via GitHub Actions when changes are merged to the main branch.

The published features will be available at:
```
ghcr.io/DanielleMaywood/devcontainer-features/feature-id:version
```

For example, the current code-server feature is referenced as:
```
ghcr.io/DanielleMaywood/devcontainer-features/code-server:1
```

### Making Features Public

After a feature is published to GHCR, make it public by:

1. Navigate to the package settings in GHCR:
   ```
   https://github.com/users/DanielleMaywood/packages/container/devcontainer-features%2Fcode-server/settings
   ```
2. Change the visibility setting to "Public"

## Pull Request Process

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Code Style Guidelines

- Use shellcheck to validate your shell scripts
- Include comments explaining complex operations
- Follow the style of existing features for consistency

## Getting Help

If you have questions about contributing to this repository, please open an issue or reach out to DanielleMaywood directly.
