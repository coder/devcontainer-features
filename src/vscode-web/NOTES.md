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
