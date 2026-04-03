#!/usr/bin/env bash
# install.sh — Install slides-it
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/slides-it/slides-it/main/install.sh | bash
#
# What this does:
#   1. Detects your platform and architecture
#   2. Checks that Node.js is installed (installs via fnm if not — required for web search)
#   3. Installs open-websearch globally (npm install -g)
#   4. Checks that opencode is installed (installs it if not)
#   5. Downloads the matching slides-it binary from the latest GitHub Release
#   6. Installs it to ~/.local/bin/slides-it

set -euo pipefail

REPO="mengdigao1988/slides-it"
INSTALL_DIR="${HOME}/.local/bin"

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

info()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
ok()    { printf '\033[1;32m ✓\033[0m %s\n' "$*"; }
warn()  { printf '\033[1;33mWARN\033[0m %s\n' "$*" >&2; }
die()   { printf '\033[1;31mERROR\033[0m %s\n' "$*" >&2; exit 1; }

need() {
    command -v "$1" >/dev/null 2>&1 || die "$1 is required but not found. Please install it first."
}

# ---------------------------------------------------------------------------
# 1. Detect platform
# ---------------------------------------------------------------------------

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Darwin)
        case "$ARCH" in
            arm64)  ARTIFACT="slides-it-macos-arm64" ;;
            x86_64) ARTIFACT="slides-it-macos-x86_64" ;;
            *)      die "Unsupported macOS architecture: $ARCH" ;;
        esac
        ;;
    Linux)
        case "$ARCH" in
            x86_64) ARTIFACT="slides-it-linux-x86_64" ;;
            *)      die "Unsupported Linux architecture: $ARCH (only x86_64 is supported)" ;;
        esac
        ;;
    *)
        die "Unsupported operating system: $OS"
        ;;
esac

info "Platform: $OS $ARCH → $ARTIFACT"

# ---------------------------------------------------------------------------
# 2. Check for required tools
# ---------------------------------------------------------------------------

need curl

# ---------------------------------------------------------------------------
# 3. Check / install Node.js (required for web search)
# ---------------------------------------------------------------------------

if command -v node >/dev/null 2>&1; then
    ok "Node.js is already installed ($(node --version 2>/dev/null || echo 'version unknown'))"
else
    info "Node.js not found — installing via fnm (required for web search)..."
    curl -fsSL https://fnm.vercel.app/install | bash
    export PATH="${HOME}/.local/share/fnm:${PATH}"
    eval "$(fnm env 2>/dev/null || true)"
    fnm install --lts
    if command -v node >/dev/null 2>&1; then
        ok "Node.js installed via fnm ($(node --version 2>/dev/null))"
    else
        warn "Node.js installation may not be on PATH yet. Web search requires Node.js."
        warn "Install manually: https://nodejs.org/"
    fi
fi

# Ensure fnm-managed Node.js is on PATH for the rest of this script
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env 2>/dev/null || true)"
fi

# ---------------------------------------------------------------------------
# 4. Install open-websearch (web search engine for AI)
# ---------------------------------------------------------------------------

if command -v open-websearch >/dev/null 2>&1; then
    ok "open-websearch is already installed"
else
    if command -v npm >/dev/null 2>&1; then
        info "Installing open-websearch globally..."
        npm install -g open-websearch
        if command -v open-websearch >/dev/null 2>&1; then
            ok "open-websearch installed"
        else
            warn "open-websearch installed but may not be on PATH yet."
        fi
    else
        warn "npm not available — skipping open-websearch install. Web search will be unavailable."
    fi
fi

# ---------------------------------------------------------------------------
# 5. Check / install opencode
# ---------------------------------------------------------------------------

if command -v opencode >/dev/null 2>&1; then
    ok "opencode is already installed ($(opencode --version 2>/dev/null | head -1 || echo 'version unknown'))"
else
    info "opencode not found — installing..."
    curl -fsSL https://opencode.ai/install | bash
    # Re-source PATH in case the installer added ~/.local/bin etc.
    export PATH="${HOME}/.local/bin:${PATH}"
    if command -v opencode >/dev/null 2>&1; then
        ok "opencode installed"
    else
        warn "opencode may not be on PATH yet. You may need to restart your shell."
    fi
fi

# ---------------------------------------------------------------------------
# 6. Resolve latest release tag from GitHub API
# ---------------------------------------------------------------------------

info "Fetching latest slides-it release..."

LATEST_TAG="$(
    curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
    | grep '"tag_name"' \
    | head -1 \
    | sed 's/.*"tag_name": *"\([^"]*\)".*/\1/'
)"

if [ -z "$LATEST_TAG" ]; then
    die "Could not determine latest release tag. Check https://github.com/${REPO}/releases"
fi

ok "Latest release: $LATEST_TAG"

DOWNLOAD_URL="https://github.com/${REPO}/releases/download/${LATEST_TAG}/${ARTIFACT}"

# ---------------------------------------------------------------------------
# 7. Download binary
# ---------------------------------------------------------------------------

info "Downloading ${ARTIFACT}..."

TMP_FILE="$(mktemp)"
# shellcheck disable=SC2064
trap "rm -f '${TMP_FILE}'" EXIT

if ! curl -fsSL --progress-bar -o "$TMP_FILE" "$DOWNLOAD_URL"; then
    die "Download failed: $DOWNLOAD_URL"
fi

# ---------------------------------------------------------------------------
# 8. Install to ~/.local/bin
# ---------------------------------------------------------------------------

mkdir -p "$INSTALL_DIR"
DEST="${INSTALL_DIR}/slides-it"
mv "$TMP_FILE" "$DEST"
chmod +x "$DEST"

ok "Installed: $DEST"

# ---------------------------------------------------------------------------
# 9. Done
# ---------------------------------------------------------------------------

echo ""
printf '\033[1;32mslides-it %s installed successfully!\033[0m\n' "$LATEST_TAG"
echo ""
echo "  To make all tools permanently available in your shell, add these to your shell config:"
echo ""
echo '    # slides-it + opencode'
echo '    export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"'
echo ""
echo '    # fnm (Node.js version manager, required for web search)'
echo '    eval "$(fnm env 2>/dev/null || true)"'
echo ""
echo "  Quick setup (zsh):"
echo ""
echo '    echo '"'"'export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"'"'"' >> ~/.zshrc'
echo '    echo '"'"'eval "$(fnm env 2>/dev/null || true)"'"'"' >> ~/.zshrc'
echo '    source ~/.zshrc'
echo ""
echo "  Then get started:"
echo "    slides-it            # launch the web UI"
echo "    slides-it --help     # show all commands"
echo "    slides-it --version  # show version"
echo ""
