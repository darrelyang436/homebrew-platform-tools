# homebrew-platform-tools

> A Homebrew tap providing `platform-helper` — a minimal macOS CLI for automating common platform engineering tasks.

[![CI](https://github.com/attacker-demo/homebrew-platform-tools/actions/workflows/ci.yml/badge.svg)](https://github.com/attacker-demo/homebrew-platform-tools/actions/workflows/ci.yml)

---

## What is this?

`platform-helper` is a small shell-based CLI distributed via Homebrew. It handles routine setup and verification tasks that come up repeatedly in platform and infrastructure workflows — environment bootstrapping, dependency checks, and artifact fetching with checksum validation.

No runtime dependencies beyond what ships with macOS.

---

## Install

```bash
brew tap demo/platform-tools "https://github.com/attacker-demo/homebrew-platform-tools.git"
brew install demo/platform-tools/platform-helper
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
```

---

## Requirements

| Requirement | Version |
|-------------|---------|
| macOS | 12 Monterey or later |
| Homebrew | 4.x |
| curl | bundled with macOS |

---

## Repository Layout

```
.
├── Formula/
│   └── platform-helper.rb
├── scripts/
│   ├── setup/
│   │   └── bootstrap.sh
│   ├── health-check.sh
│   └── uninstall.sh
└── .github/
    └── workflows/
        └── ci.yml
```

---

## Uninstall

```bash
brew uninstall platform-helper
brew untap demo/platform-tools
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

---

## License

[MIT](./LICENSE)
