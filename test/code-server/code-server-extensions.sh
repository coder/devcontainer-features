#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@0.0.0.0:8080"

# Verify extensions are installed under the remoteUser's home, not root's.
# See: https://github.com/coder/devcontainer-features/issues/18
extensions_dir=/home/vscode/.local/share/code-server/extensions

check "rust-analyzer installed under remoteUser" ls "$extensions_dir"/rust-lang.rust-analyzer-*
check "python installed under remoteUser"        ls "$extensions_dir"/ms-python.python-*
check "extensions not installed under root"      test ! -d /root/.local/share/code-server/extensions

# Report results
reportResults
