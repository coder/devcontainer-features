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

check "vscode-web log flag" grep -e '--log' /usr/local/bin/vscode-web-entrypoint

# Report results
reportResults
