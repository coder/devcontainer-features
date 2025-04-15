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

FLAGS=()
FLAGS+=(--auth "$AUTH")
FLAGS+=(--bind-addr "$HOST:$PORT")

if [[ "$DISABLEFILEDOWNLOADS" == "true" ]]; then
    FLAGS+=(--disable-file-downloads)
fi

if [[ "$DISABLEFILEUPLOADS" == "true" ]]; then
    FLAGS+=(--disable-file-uploads)
fi

if [[ "$DISABLEGETTINGSTARTEDOVERRIDE" == "true" ]]; then
    FLAGS+=(--disable-getting-started-override)
fi

if [[ "$DISABLEPROXY" == "true" ]]; then
    FLAGS+=(--disable-proxy)
fi

if [[ "$DISABLETELEMETRY" == "true" ]]; then
    FLAGS+=(--disable-telemetry)
fi

if [[ "$DISABLEUPDATECHECK" == "true" ]]; then
    FLAGS+=(--disable-update-check)
fi

if [[ "$DISABLEWORKSPACETRUST" == "true" ]]; then
    FLAGS+=(--disable-workspace-trust)
fi

if [[ -n "$CERT" ]]; then
    FLAGS+=(--cert "$CERT")
fi

if [[ -n "$CERTHOST" ]]; then
    FLAGS+=(--cert-host "$CERTHOST")
fi

if [[ -n "$CERTKEY" ]]; then
    FLAGS+=(--cert-key "$CERTKEY")
fi

if [[ -n "$SOCKET" ]]; then
    FLAGS+=(--socket "$SOCKET")
fi

if [[ -n "$SOCKETMODE" ]]; then
    FLAGS+=(--socket-mode "$SOCKETMODE")
fi

cat > /usr/local/bin/code-server-entrypoint <<EOF
#!/usr/bin/env bash
set -e

$(declare -p FLAGS)

CMD="code-server \${FLAGS[@]} \"$CODE_SERVER_WORKSPACE\""

su $_REMOTE_USER -c "\$CMD"
EOF

chmod +x /usr/local/bin/code-server-entrypoint
