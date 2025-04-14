#!/usr/bin/env bash
set -e

CODE_SERVER_INSTALL_ARGS=""

if [[ -n $VERSION ]]; then
	CODE_SERVER_INSTALL_ARGS="$CODE_SERVER_INSTALL_ARGS --version=\"$VERSION\""
fi

curl -fsSL https://code-server.dev/install.sh | sh -s -- $CODE_SERVER_INSTALL_ARGS

IFS=',' read -ra extensions <<<"$EXTENSIONS"
declare -p extensions

for extension in "${extensions[@]}"
do
    code-server --install-extension "$extension"
done

CODE_SERVER_WORKSPACE="$_REMOTE_USER_HOME"

if [[ -n $WORKSPACE ]]; then
    CODE_SERVER_WORKSPACE="$WORKSPACE"
fi

DISABLE_FLAGS=()

if [[ "$DISABLEFILEDOWNLOADS" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-file-downloads)
fi

if [[ "$DISABLEFILEUPLOADS" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-file-uploads)
fi

if [[ "$DISABLEGETTINGSTARTEDOVERRIDE" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-getting-started-override)
fi

if [[ "$DISABLEPROXY" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-proxy)
fi

if [[ "$DISABLETELEMETRY" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-telemetry)
fi

if [[ "$DISABLEUPDATECHECK" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-update-check)
fi

if [[ "$DISABLEWORKSPACETRUST" == "true" ]]; then
    DISABLE_FLAGS+=(--disable-workspace-trust)
fi

cat > /usr/local/bin/code-server-entrypoint \
<< EOF
#!/usr/bin/env bash
set -e

$(declare -p DISABLE_FLAGS)

su $_REMOTE_USER -c 'code-server --auth "$AUTH" --bind-addr "$HOST:$PORT" "\${DISABLE_FLAGS[@]}" "$CODE_SERVER_WORKSPACE"'
EOF

chmod +x /usr/local/bin/code-server-entrypoint
