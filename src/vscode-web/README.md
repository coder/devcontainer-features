
# vscode-web (vscode-web)

VS Code in the browser (Microsoft's official [VS Code web server](https://code.visualstudio.com/docs/remote/vscode-server), with access to the Microsoft Marketplace)

## Example Usage

```json
"features": {
    "ghcr.io/coder/devcontainer-features/vscode-web:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| acceptLicenseTerms | REQUIRED: set to true to accept the Microsoft VS Code Server license terms (https://aka.ms/vscode-server-license). The feature fails to install when the terms are not accepted. | boolean | false |
| connectionTokenFile | Path to a file containing the connection token used for authentication. When empty, the server starts without a connection token (intended to be used behind an authenticating reverse proxy such as Coder). | string | - |
| defaultFolder | The folder to open by default when no folder is specified in the URL. Can also be passed per-request via the '?folder=' query parameter. | string | - |
| disableWorkspaceTrust | Disable Workspace Trust feature. This only affects the current session. | boolean | false |
| extensions | Comma-separated list of VS Code extensions to install from the Microsoft Marketplace. Format: 'publisher.extension[@version]' (e.g., 'ms-python.python,ms-python.vscode-pylance'). | string | - |
| extensionsDir | Path where extensions are installed. Defaults to a directory under the server data dir. | string | - |
| host | The address to bind to for the VS Code web server. Use '0.0.0.0' to listen on all interfaces. | string | 127.0.0.1 |
| logFile | Path to a file to send stdout and stderr logs to from the VS Code web server. | string | /tmp/vscode-web.log |
| logLevel | Log level of the VS Code web server. One of 'trace', 'debug', 'info', 'warn', 'error', 'critical', 'off'. Defaults to the server's built-in default ('info'). | string | - |
| port | The port to bind to for the VS Code web server. | string | 13338 |
| serverBasePath | Path under which the server is served (e.g. when running behind a path-routing reverse proxy). | string | - |
| serverDataDir | Directory where the server stores its data. Defaults to '~/.vscode-server'. | string | - |
| socketPath | Path to a socket to listen on instead of host:port. | string | - |
| telemetryLevel | Telemetry level of the VS Code web server. | string | off |
| userDataDir | Directory where user data (settings, state) is kept. Defaults to a directory under the server data dir. | string | - |
| version | The version of VS Code to install (e.g. '1.101.0'). If empty, installs the latest stable version. | string | - |
| appOpenIn | The way to open the app in Coder. Defaults to 'slim-window'. | string | slim-window |
| appShare | The sharing level to use for the app in Coder. Defaults to 'owner'. | string | owner |
| appGroup | The group to use for the app in Coder. Defaults to 'Web Editors'. | string | Web Editors |

## vscode-web vs code-server

This feature installs Microsoft's official VS Code web server (the same
`vscode-server-linux-*-web` build used by `code serve-web`), not
[coder/code-server](https://github.com/coder/code-server). The main practical
difference is the extension marketplace: the official server uses the
Microsoft Marketplace, so Microsoft-exclusive extensions such as Pylance and
GitHub Copilot can be installed. If you do not need those, consider the
[code-server feature](../code-server) instead.

## License

Installing this feature requires explicitly accepting the
[Microsoft VS Code Server license](https://aka.ms/vscode-server-license),
which limits usage to your own development purposes. Set the
`acceptLicenseTerms` option to `true`; installation fails otherwise:

```json
"features": {
    "ghcr.io/coder/devcontainer-features/vscode-web:1": {
        "acceptLicenseTerms": true
    }
}
```

The server is then started with `--accept-server-license-terms`.

## Extensions

Extensions must be listed in this feature's `extensions` option. The
`customizations.vscode.extensions` property of `devcontainer.json` is consumed
by VS Code clients (e.g. the Dev Containers extension), not by the standalone
web server, so extensions listed only there will not show up in VS Code Web.

## Authentication

By default the server binds to `127.0.0.1` and starts without a connection
token. This assumes an authenticating reverse proxy (such as Coder) in front
of it. If you expose the port directly, set `connectionTokenFile` to require a
token.

## Opening a folder

Use the `defaultFolder` option to control which folder opens by default, or
append `?folder=/path/to/folder` to the URL.

## Coder integration

When used inside a [Coder workspace with dev container support](https://coder.com/docs/admin/templates/extending-templates/devcontainers),
the feature registers a `vscode-web` app on the workspace dashboard via
`customizations.coder.apps`. Its health check probes the `/version` endpoint
(the standalone web server exposes no `/healthz`). The `app*` options
only affect this Coder app metadata, not the server itself.


---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
