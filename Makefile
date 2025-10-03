.PHONY: check prune changelog-status changelog-prepare changelog-release changelog-help

# === Local Utility Scripts ===
check:
	zsh scripts/cleanup_local_branches_preview.sh

prune:
	zsh scripts/cleanup_local_branches.sh

# === Version & Release Management ===
changelog-status:
	@zsh scripts/changelog.sh status

changelog-prepare:
	@zsh scripts/changelog.sh prepare $(VERSION)

changelog-release:
	@zsh scripts/changelog.sh release $(VERSION)

changelog-help:
	@zsh scripts/changelog.sh quick-help
