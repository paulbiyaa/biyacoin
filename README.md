# Biyacoin

A simple fungible token smart contract for the Stacks blockchain written in Clarity. It exposes SIP-010-style read-only views and a transfer entrypoint using Clarity's built-in FT primitives.

## Features
- Fungible token defined with `define-fungible-token BIYA`
- Read-only views: `get-name`, `get-symbol`, `get-decimals`, `get-balance-of`, `get-total-supply`, `get-token-uri`
- `transfer` public function, implemented via `ft-transfer?`

## Project structure
- `Clarinet.toml` — Clarinet project manifest
- `contracts/biyacoin.clar` — Token contract

## Prerequisites
- Linux x86_64
- curl and tar available in your shell

## Install Clarinet
You can install the latest Clarinet release to `~/.local/bin` with:

```bash
# Create a bin directory in your home if needed
mkdir -p "$HOME/.local/bin"

# Fetch latest release URL for Linux x86_64
a=$(curl -fsSL https://api.github.com/repos/hirosystems/clarinet/releases/latest \
  | grep browser_download_url \
  | grep -i linux \
  | grep -Ei 'x86_64|amd64' \
  | grep -E 'tar.gz|tgz' \
  | head -n1 \
  | cut -d '"' -f4)

# Download and install
curl -L "$a" -o /tmp/clarinet.tar.gz
mkdir -p /tmp/clarinet-extract
tar -xzf /tmp/clarinet.tar.gz -C /tmp/clarinet-extract
install -m 0755 "$(find /tmp/clarinet-extract -type f -name clarinet | head -n1)" "$HOME/.local/bin/clarinet"

# Ensure it’s on PATH for the current session
export PATH="$HOME/.local/bin:$PATH"

# Verify
clarinet --version
```

If you prefer, you can alternatively use Docker:

```bash
docker run --rm -it -v "$PWD":/workdir -w /workdir hirosystems/clarinet clarinet --version
```

## Usage
Run static analysis on the contract:

```bash
clarinet check
```

Open the Clarinet console to interact locally:

```bash
clarinet console
```

From the console you can call, for example:

```clarity
(contract-call? .biyacoin get-name)
(contract-call? .biyacoin get-symbol)
(contract-call? .biyacoin get-decimals)
(contract-call? .biyacoin get-total-supply)
```

## Notes
- This contract does not include mint/burn admin flows. Total supply starts at 0 and increases only if you add a mint function.
- The `get-token-uri` is a placeholder — point it to your actual metadata endpoint if desired.
