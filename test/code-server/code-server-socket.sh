#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'

check "code-server socket" test -S /tmp/code-server.sock
# check "code-server socket-mode" grep '0755' <<< $(stat /tmp/code-server.sock)

# Report results
reportResults
