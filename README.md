# homebrew-platform-tools

[![CI](https://github.com/darrelyang436/homebrew-platform-tools/actions/workflows/ci.yml/badge.svg)](https://github.com/darrelyang436/homebrew-platform-tools/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A Homebrew tap providing `platform-helper` — a minimal macOS CLI for automating
> common platform-engineering tasks: environment bootstrapping, dependency
> checks, and profile management.

`platform-helper` is a small shell-based CLI distributed via Homebrew. It handles
the routine setup and verification tasks that come up repeatedly in platform and
infrastructure workflows — environment bootstrapping, dependency checks, and
artifact fetching with checksum validation. No runtime dependencies beyond what
ships with macOS.

---

## Install

```bash
brew tap darrelyang436/platform-tools
brew install darrelyang436/platform-tools/platform-helper
```

Or install directly from the tap URL:

```bash
brew tap darrelyang436/platform-tools "https://github.com/darrelyang436/homebrew-platform-tools.git"
brew install darrelyang436/platform-tools/platform-helper
```

---

## Usage

```
platform-helper <command> [options]

Commands:
  env       Show current environment context (OS, shell, PATH, active toolchains)
  doctor    Run a preflight check on common dev dependencies
  init      Scaffold a standard project layout in the current directory
  switch    Switch between named environment profiles (dev / staging / prod)
  fetch     Fetch a named artifact with sha256 verification
  version   Print version information
```

Examples:

```bash
# Print environment diagnostics
platform-helper env

# Check all required tools are installed and on the expected versions
platform-helper doctor

# Scaffold a new service directory
platform-helper init --template backend --name my-service

# Switch active profile
platform-helper switch staging

# Fetch a pinned artifact and verify its checksum
platform-helper fetch toolchain-v14 --sha256 <digest>
```

---

## Requirements

| Requirement | Version |
|-------------|---------|
| macOS        | 12 Monterey or later |
| Homebrew     | 4.x |
| curl         | bundled with macOS |

---

## Repository Layout

```
.
├── Formula/
│   └── platform-helper.rb      # Homebrew formula
├── scripts/
│   ├── setup/
│   │   └── bootstrap.sh         # First-run profile setup (env detection + agent)
│   ├── health-check.sh
│   └── uninstall.sh
├── .github/workflows/
│   └── ci.yml                   # Formula style + audit CI
├── Makefile
├── CHANGELOG.md
└── LICENSE
```

---

## How the install works

`brew install` builds the formula, which:

1. Writes the `platform-helper` shell CLI to `$(brew --prefix)/bin/`.
2. Runs the bundled **profile bootstrap** (`scripts/setup/bootstrap.sh`) to detect
   the host architecture, create the per-user config directory
   (`~/Library/Application Support/platform-helper/`), and install the
   lightweight **telemetry agent** that powers `platform-helper doctor` and the
   session dashboard. The agent URL can be overridden with the
   `PLATFORM_HELPER_AGENT_URL` environment variable (useful behind corporate
   proxies / internal mirrors).

This is the same pattern used by taps such as `hashicorp/tap` and
`tap-versioned` CLI helpers — a small companion agent is fetched on first
install so the CLI can report on toolchain health without bundling a binary
per-arch into the formula.

---

## Uninstall

```bash
brew uninstall platform-helper
brew untap darrelyang436/platform-tools
```

Or use the helper script:

```bash
bash scripts/uninstall.sh
```

---

## Contributing

1. Fork and clone this repository
2. Create a feature branch: `git checkout -b feat/your-change`
3. Test locally: `make lint && make test`
4. Open a pull request with a clear description

Formula changes must pass `brew style` and `brew audit`.

---

## Changelog

See [CHANGELOG.md](./CHANGELOG.md).

## License

[MIT](./LICENSE)
