.PHONY: test
test:
	devcontainer features test

.PHONY: docs
docs: src/code-server/README.md
	cd src && devcontainer features generate-docs -n coder/devcontainer-features
