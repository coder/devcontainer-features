#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@127.0.0.1:8080"

check "code-server log-file" test -f /tmp/code-server.log
check "code-server log-file content" grep "HTTP server listening on http://127.0.0.1:8080/" < /tmp/code-server.log

# Report results
reportResults
