#!/usr/bin/env bash
set -e

curl -fsSL https://code-server.dev/install.sh | sh

IFS=',' read -ra extensions <<<"$EXTENSIONS"
declare -p extensions

for extension in "${extensions[@]}"
do
    code-server --install-extension "$extension"
done

cat > /usr/local/bin/code-server-entrypoint \
<< EOF
#!/usr/bin/env bash
set -e

code-server --bind-addr "$HOST:$PORT" \$ARGS
EOF

chmod +x /usr/local/bin/code-server-entrypoint
