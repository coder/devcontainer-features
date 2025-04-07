# Dev Container Features Collection

This repository contains a collection of [dev container Features](https://containers.dev/implementors/features/) that can be used to enhance your development environment. The features follow the [dev container Feature distribution specification](https://containers.dev/implementors/features-distribution/) and are hosted for free on GitHub Container Registry.

## Available Features

### `code-server`

The `code-server` feature installs [code-server](https://github.com/coder/code-server), which allows you to run VS Code in the browser.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
    "features": {
        "ghcr.io/coder/devcontainer-features/code-server:1": {
            "host": "127.0.0.1",
            "port": "8080",
            "args": "",
            "extensions": ""
        }
    }
}
```

#### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `host` | string | `127.0.0.1` | The address to bind to when starting code-server |
| `port` | string | `8080` | The port to bind to when starting code-server |
| `args` | string | `""` | Additional arguments to pass to code-server |
| `extensions` | string | `""` | Comma-separated list of VS Code extensions to install |

## Contributing

For information about contributing to this repository, including how to publish features, please see [CONTRIBUTING.md](./CONTRIBUTING.md).