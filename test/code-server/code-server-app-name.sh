#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@127.0.0.1:8080"

check "code-server locale" grep '"--app-name".*"My Code Server"' < /usr/local/bin/code-server-entrypoint

# Report results
reportResults
