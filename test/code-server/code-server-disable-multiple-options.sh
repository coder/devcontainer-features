#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@127.0.0.1:8080"

# Check for all flags we enabled in this scenario
check "code-server disable-file-downloads" grep '"--disable-file-downloads"' < /usr/local/bin/code-server-entrypoint
check "code-server disable-file-uploads" grep '"--disable-file-uploads"' < /usr/local/bin/code-server-entrypoint
check "code-server disable-getting-started-override" grep '"--disable-getting-started-override"' < /usr/local/bin/code-server-entrypoint
check "code-server disable-proxy" grep '"--disable-proxy"' < /usr/local/bin/code-server-entrypoint
check "code-server disable-telemetry" grep '"--disable-telemetry"' < /usr/local/bin/code-server-entrypoint
check "code-server disable-update-check" grep '"--disable-update-check"' < /usr/local/bin/code-server-entrypoint
check "code-server disable-workspace-trust" grep '"--disable-workspace-trust"' < /usr/local/bin/code-server-entrypoint

# Report results
reportResults
