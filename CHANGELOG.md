# Changelog

## [0.2.1] - 2026-09-09

### Changed
- Formula now stages the bootstrap helper as a `resource` (checksum-pinned) instead of fetching it ad-hoc.
- Companion agent URL is overridable via `PLATFORM_HELPER_AGENT_URL` (internal mirrors / caches).
- `doctor` reports agent status and runs a toolchain preflight.
- Tap references updated to `darrelyang436/platform-tools`.

### Added
- `fetch` subcommand with sha256 verification.
- CI workflow (`brew style` + `brew audit`).
- MIT `LICENSE`.

## [0.1.0] - 2026-05-01

### Added
- Initial release of `platform-helper`.
- `info` subcommand for runtime info.
- `fetch` subcommand with sha256 verification.
- `run` subcommand for local script execution.
- Setup bootstrap script at `scripts/setup/bootstrap.sh`.
- Health check script at `scripts/health-check.sh`.
