#!/bin/bash
set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "code-server version" code-server --version
check "code-server running" pgrep -f 'code-server/lib/node.*/code-server'
check "code-server listening" lsof -i "@127.0.0.1:8080"

# Check for all three flags we enabled in this scenario
check "code-server disable-file-downloads" grep $'\'code-server.* --disable-file-downloads .*' < /usr/local/bin/code-server-entrypoint
check "code-server disable-file-uploads" grep $'\'code-server.* --disable-file-uploads .*' < /usr/local/bin/code-server-entrypoint
check "code-server disable-getting-started-override" grep $'\'code-server.* --disable-getting-started-override .*' < /usr/local/bin/code-server-entrypoint
check "code-server disable-proxy" grep $'\'code-server.* --disable-proxy .*' < /usr/local/bin/code-server-entrypoint
check "code-server disable-telemetry" grep $'\'code-server.* --disable-telemetry .*' < /usr/local/bin/code-server-entrypoint
check "code-server disable-update-check" grep $'\'code-server.* --disable-update-check .*' < /usr/local/bin/code-server-entrypoint
check "code-server disable-workspace-trust" grep $'\'code-server.* --disable-workspace-trust .*' < /usr/local/bin/code-server-entrypoint

# Report results
reportResults
