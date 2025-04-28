#!/usr/bin/env bash
set -e

CODE_SERVER_INSTALL_ARGS=""

if [[ -n $VERSION ]]; then
	CODE_SERVER_INSTALL_ARGS="$CODE_SERVER_INSTALL_ARGS --version=\"$VERSION\""
fi

curl -fsSL https://code-server.dev/install.sh | sh -s -- $CODE_SERVER_INSTALL_ARGS

IFS=',' read -ra extensions <<<"$EXTENSIONS"

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

if [[ -n "$LOCALE" ]]; then
    FLAGS+=(--locale "$LOCALE")
fi

if [[ -n "$APPNAME" ]]; then
	FLAGS+=(--app-name "$APPNAME")
fi

if [[ -n "$WELCOMETEXT" ]]; then
    FLAGS+=(--welcome-text "$WELCOMETEXT")
fi

if [[ "$VERBOSE" == "true" ]]; then
    FLAGS+=(--verbose)
fi

IFS=',' read -ra trusted_origins <<<"$TRUSTEDORIGINS"

for trusted_origin in "${trusted_origins[@]}"; do
    FLAGS+=(--trusted-origins "$trusted_origin")
done

IFS=',' read -ra proposed_api_extensions <<<"$ENABLEPROPOSEDAPI"

for extension in "${proposed_api_extensions[@]}"; do
    FLAGS+=(--enable-proposed-api "$extension")
done

if [[ "$PROXYDOMAIN" ]]; then
    FLAGS+=(--proxy-domain "$PROXYDOMAIN")
fi

if [[ "$ABSPROXYBASEPATH" ]]; then
    FLAGS+=(--abs-proxy-base-path "$ABSPROXYBASEPATH")
fi

cat > /usr/local/bin/code-server-entrypoint <<EOF
#!/usr/bin/env bash
set -e

if [[ \$(whoami) != "$_REMOTE_USER" ]]; then
	exec su $_REMOTE_USER -c /usr/local/bin/code-server-entrypoint
fi

$(declare -p FLAGS)

if [[ -f "$PASSWORDFILE" ]]; then
	export PASSWORD="\$(<"$PASSWORDFILE")"
fi

if [[ -f "$HASHEDPASSWORDFILE" ]]; then
	export HASHED_PASSWORD="\$(<"$HASHEDPASSWORDFILE")"
fi

if [[ -f "$GITHUBAUTHTOKENFILE" ]]; then
    export GITHUB_TOKEN="\$(<"$GITHUBAUTHTOKENFILE")"
fi

code-server "\${FLAGS[@]}" "$CODE_SERVER_WORKSPACE" >"$LOGFILE" 2>&1
EOF

chmod +x /usr/local/bin/code-server-entrypoint
