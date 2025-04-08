#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@0.0.0.0:8080"

version=$(code-server --version)
check "code-server is correct version" grep '4.98.0\>' <<<"$version"

# Report results
reportResults
