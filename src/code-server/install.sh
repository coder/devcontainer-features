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

cat > /usr/local/bin/code-server-entrypoint \
<< EOF
#!/usr/bin/env bash
set -e

su $_REMOTE_USER -c 'code-server --bind-addr "$HOST:$PORT" "$CODE_SERVER_WORKSPACE"'
EOF

chmod +x /usr/local/bin/code-server-entrypoint
