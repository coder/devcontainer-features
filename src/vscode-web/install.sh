#!/usr/bin/env bash
set -e

if [[ "$ACCEPTLICENSETERMS" != "true" ]]; then
    echo "ERROR: The Microsoft VS Code Server license terms (https://aka.ms/vscode-server-license) must be accepted to install this feature." >&2
    echo "Set the 'acceptLicenseTerms' option to true to accept them:" >&2
    echo '    "vscode-web": { "acceptLicenseTerms": true }' >&2
    exit 1
fi

ARCH=$(uname -m)
case "$ARCH" in
    x86_64) ARCH="x64" ;;
    aarch64 | arm64) ARCH="arm64" ;;
    *)
        echo "ERROR: unsupported architecture: $ARCH" >&2
        exit 1
        ;;
esac

INSTALL_PREFIX=/usr/local/lib/vscode-web

if [[ -n $VERSION ]]; then
    DOWNLOAD_URL=$(curl -fsSL "https://update.code.visualstudio.com/api/versions/$VERSION/server-linux-$ARCH-web/stable" \
        | grep -o '"url":"[^"]*"' | head -n 1 | cut -d '"' -f 4)

    if [[ -z $DOWNLOAD_URL ]]; then
        echo "ERROR: could not resolve a download URL for VS Code version '$VERSION'" >&2
        exit 1
    fi
else
    COMMIT=$(curl -fsSL "https://update.code.visualstudio.com/api/commits/stable/server-linux-$ARCH-web" | cut -d '"' -f 2)
    DOWNLOAD_URL="https://vscode.download.prss.microsoft.com/dbazure/download/stable/$COMMIT/vscode-server-linux-$ARCH-web.tar.gz"
fi

echo "Downloading VS Code web server from $DOWNLOAD_URL"
mkdir -p "$INSTALL_PREFIX"
curl -fsSL "$DOWNLOAD_URL" | tar -xz -C "$INSTALL_PREFIX" --strip-components 1

# The CLI inside the tarball is named code-server for historical reasons.
# Expose it as vscode-web so it cannot clash with coder/code-server.
ln -sf "$INSTALL_PREFIX/bin/code-server" /usr/local/bin/vscode-web

EXTENSION_INSTALL_ARGS=""

if [[ -n $EXTENSIONSDIR ]]; then
    EXTENSION_INSTALL_ARGS="$EXTENSION_INSTALL_ARGS --extensions-dir '$EXTENSIONSDIR'"
fi

if [[ -n $SERVERDATADIR ]]; then
    EXTENSION_INSTALL_ARGS="$EXTENSION_INSTALL_ARGS --server-data-dir '$SERVERDATADIR'"
fi

if [[ -n "$EXTENSIONS" ]]; then
    IFS=',' read -ra extensions <<<"$EXTENSIONS"

    for extension in "${extensions[@]}"
    do
        if ! su "$_REMOTE_USER" -c "vscode-web --install-extension '$extension' --force$EXTENSION_INSTALL_ARGS"; then
            echo "ERROR: Failed to install extension '$extension' as user '$_REMOTE_USER'" >&2
            exit 1
        fi
    done
fi

FLAGS=(serve-local)
FLAGS+=(--accept-server-license-terms)
FLAGS+=(--host "$HOST")
FLAGS+=(--port "$PORT")
FLAGS+=(--telemetry-level "$TELEMETRYLEVEL")

if [[ -n "$CONNECTIONTOKENFILE" ]]; then
    FLAGS+=(--connection-token-file "$CONNECTIONTOKENFILE")
else
    FLAGS+=(--without-connection-token)
fi

if [[ -n "$SOCKETPATH" ]]; then
    FLAGS+=(--socket-path "$SOCKETPATH")
fi

if [[ -n "$SERVERBASEPATH" ]]; then
    FLAGS+=(--server-base-path "$SERVERBASEPATH")
fi

if [[ -n "$SERVERDATADIR" ]]; then
    FLAGS+=(--server-data-dir "$SERVERDATADIR")
fi

if [[ -n "$USERDATADIR" ]]; then
    FLAGS+=(--user-data-dir "$USERDATADIR")
fi

if [[ -n "$EXTENSIONSDIR" ]]; then
    FLAGS+=(--extensions-dir "$EXTENSIONSDIR")
fi

if [[ -n "$DEFAULTFOLDER" ]]; then
    FLAGS+=(--default-folder "$DEFAULTFOLDER")
fi

if [[ "$DISABLEWORKSPACETRUST" == "true" ]]; then
    FLAGS+=(--disable-workspace-trust)
fi

if [[ -n "$LOGLEVEL" ]]; then
    FLAGS+=(--log "$LOGLEVEL")
fi

cat > /usr/local/bin/vscode-web-entrypoint <<EOF
#!/usr/bin/env bash
set -e

if [[ \$(whoami) != "$_REMOTE_USER" ]]; then
	exec su $_REMOTE_USER -c /usr/local/bin/vscode-web-entrypoint
fi

$(declare -p FLAGS)

/usr/local/bin/vscode-web "\${FLAGS[@]}" >"$LOGFILE" 2>&1
EOF

chmod +x /usr/local/bin/vscode-web-entrypoint
