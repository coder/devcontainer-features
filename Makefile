.PHONY: test
test:
	devcontainer features test --filter "$$DEVCONTAINER_FEATURE_TEST_FILTER"

.PHONY: docs
docs: src/code-server/README.md src/vscode-web/README.md
	cd src && devcontainer features generate-docs -n coder/devcontainer-features
