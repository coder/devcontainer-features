#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

wait_for_server() {
    for _ in $(seq 30); do
        if curl -fsS "http://127.0.0.1:$1/version" >/dev/null 2>&1; then
            return 0
        fi
        sleep 1
    done
    return 1
}

# Feature-specific tests
check "vscode-web version" vscode-web --version
check "vscode-web running" pgrep -f 'vscode-web/out/server-main.js'
check "vscode-web responding" wait_for_server 13338

# Verify extensions are installed under the remoteUser's home, not root's.
# See: https://github.com/coder/devcontainer-features/issues/18
extensions_dir=/home/vscode/.vscode-server/extensions

check "even-better-toml installed under remoteUser" ls "$extensions_dir"/tamasfe.even-better-toml-*
check "vscode-yaml installed under remoteUser"      ls "$extensions_dir"/redhat.vscode-yaml-*
check "extensions not installed under root"         test ! -d /root/.vscode-server/extensions

# Report results
reportResults
