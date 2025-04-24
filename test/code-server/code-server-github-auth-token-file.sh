#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@127.0.0.1:8080"

cat /tmp/code-server.log
check "code-server github-auth-token-file" grep $'export GITHUB_TOKEN="$(cat \'/tmp/code-server-github-auth-token\')"' < /usr/local/bin/code-server-entrypoint

# Report results
reportResults
