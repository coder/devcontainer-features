
# code-server (code-server)

VS Code in the browser

## Example Usage

```json
"features": {
    "ghcr.io/coder/devcontainer-features/code-server:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| auth | The type of authentication to use. When 'password' is selected, code-server will auto-generate a password. 'none' disables authentication entirely. | string | password |
| extensions | Comma-separated list of VS Code extensions to install. Format: 'publisher.extension[@version]' (e.g., 'ms-python.python,ms-azuretools.vscode-docker'). | string | - |
| host | The address to bind to for the code-server. Use '0.0.0.0' to listen on all interfaces. | string | 127.0.0.1 |
| port | The port to bind to for the code-server. | string | 8080 |
| version | The version of code-server to install. If empty, installs the latest version. | string | - |
| workspace | Path to the workspace or folder to open on startup. Can be a directory or a .code-workspace file. | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
