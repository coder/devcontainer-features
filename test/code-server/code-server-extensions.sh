#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" sudo lsof -i "@0.0.0.0:8080"

extensions=$(sudo code-server --list-extensions)

check "code-server extensions [rust-lang.rust-analyzer]" grep 'rust-lang.rust-analyzer' <<<"$extensions"
check "code-server extensions [ms-python.python]"        grep 'ms-python.python'        <<<"$extensions"

# Report results
reportResults
