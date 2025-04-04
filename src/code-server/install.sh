#!/bin/sh
set -e

curl -fsSL https://code-server.dev/install.sh | sh

cat > /usr/local/bin/code-server-entrypoint \
<< EOF
#!/bin/sh
set -e

code-server --bind-addr "$HOST:$PORT" \$ARGS
EOF

chmod +x /usr/local/bin/code-server-entrypoint
