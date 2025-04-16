
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
| appName | The name to use in branding. Will be shown in titlebar and welcome message. | string | - |
| auth | The type of authentication to use. When 'password' is selected, code-server will auto-generate a password. 'none' disables authentication entirely. | string | password |
| cert | Path to certificate. A self signed certificate is generated if none is provided. | string | - |
| certHost | Hostname to use when generating a self signed certificate. | string | - |
| certKey | Path to certificate key when using non-generated cert. | string | - |
| disableFileDownloads | Disable file downloads from Code. When enabled, users will not be able to download files from the editor. | boolean | false |
| disableFileUploads | Disable file uploads to Code. When enabled, users will not be able to upload files to the editor. | boolean | false |
| disableGettingStartedOverride | Disable the coder/coder override in the Help: Getting Started page. | boolean | false |
| disableProxy | Disable domain and path proxy routes. | boolean | false |
| disableTelemetry | Disable telemetry reporting. | boolean | false |
| disableUpdateCheck | Disable update check. Without this flag, code-server checks every 6 hours against the latest GitHub release and notifies once a week when updates are available. | boolean | false |
| disableWorkspaceTrust | Disable Workspace Trust feature. This only affects the current session. | boolean | false |
| enableProposedAPI | Comma-separated list of VS Code extension IDs to enable proposed API features for. | string | - |
| extensions | Comma-separated list of VS Code extensions to install. Format: 'publisher.extension[@version]' (e.g., 'ms-python.python,ms-azuretools.vscode-docker'). | string | - |
| host | The address to bind to for the code-server. Use '0.0.0.0' to listen on all interfaces. | string | 127.0.0.1 |
| locale | Set VS Code display language and language shown on the login page. Format should be an IETF language tag (e.g., 'en', 'fr', 'zh-CN'). | string | - |
| logFile | Path to a file to send stdout and stderr logs to from code-server. | string | /tmp/code-server.log |
| port | The port to bind to for the code-server. | string | 8080 |
| socket | Path to a socket. When specified, host and port will be ignored. | string | - |
| socketMode | File mode of the socket when using the socket option. | string | - |
| trustedOrigins | Comma-separated list of trusted-origins to disable origin check for. Useful if not able to access reverse proxy configuration. | string | - |
| verbose | Enable verbose logging. | boolean | false |
| version | The version of code-server to install. If empty, installs the latest version. | string | - |
| welcomeText | Text to show on login page. | string | - |
| workspace | Path to the workspace or folder to open on startup. Can be a directory or a .code-workspace file. | string | - |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
