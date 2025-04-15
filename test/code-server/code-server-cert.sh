#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@127.0.0.1:8080"

check "code-server cert" grep '"--cert".*"/home/vscode/cert.pem"' < /usr/local/bin/code-server-entrypoint
check "code-server cert-key" grep '"--cert-key".*"/home/vscode/key.pem"' < /usr/local/bin/code-server-entrypoint

# Report results
reportResults
