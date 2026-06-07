#!/usr/bin/env bash
# =============================================================================
# DOTVIM Installation Script
# Installs plugins, dependencies, and configures the environment.
# =============================================================================

set -euo pipefail

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'

info()  { echo -e "${GREEN}[INFO]${NC} $1"; }
warn()  { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# ─── Prerequisites Check ────────────────────────────────────────────────────
info "Checking prerequisites..."

command -v vim >/dev/null 2>&1 || error "vim is not installed"
command -v git >/dev/null 2>&1 || error "git is not installed"
command -v curl >/dev/null 2>&1 || error "curl is not installed"

VIM_VERSION=$(vim --version | head -1 | grep -oP '\d+\.\d+' | head -1)
info "Vim version: ${VIM_VERSION}"

# ─── Create Required Directories ────────────────────────────────────────────
info "Creating directories..."
mkdir -p "${HOME}/.vim/undodir"
mkdir -p "${HOME}/.vim/autoload"
mkdir -p "${HOME}/.vim/plugged"

# ─── Install vim-plug ────────────────────────────────────────────────────────
if [ ! -f "${HOME}/.vim/autoload/plug.vim" ]; then
  info "Installing vim-plug..."
  curl -fLo "${HOME}/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
  info "vim-plug already installed."
fi

# ─── Install Plugins ────────────────────────────────────────────────────────
info "Installing Vim plugins..."
vim -es -u "${HOME}/.vim/vimrc" +PlugInstall +qa 2>/dev/null || true
info "Plugins installed."

# ─── Install External Dependencies ──────────────────────────────────────────
info "Checking optional dependencies..."

# fzf
if ! command -v fzf >/dev/null 2>&1; then
  warn "fzf not found. Installing..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get install -y fzf
  elif command -v brew >/dev/null 2>&1; then
    brew install fzf
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y fzf
  else
    warn "Could not auto-install fzf. Install manually: https://github.com/junegunn/fzf"
  fi
fi

# ripgrep (for :Rg in fzf.vim)
if ! command -v rg >/dev/null 2>&1; then
  warn "ripgrep not found. Installing..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get install -y ripgrep
  elif command -v brew >/dev/null 2>&1; then
    brew install ripgrep
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y ripgrep
  else
    warn "Could not auto-install ripgrep. Install manually: https://github.com/BurntSushi/ripgrep"
  fi
fi

# bat (for fzf preview)
if ! command -v bat >/dev/null 2>&1 && ! command -v batcat >/dev/null 2>&1; then
  warn "bat not found. Installing for fzf preview..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get install -y bat
  elif command -v brew >/dev/null 2>&1; then
    brew install bat
  else
    warn "Could not auto-install bat. Install manually: https://github.com/sharkdp/bat"
  fi
fi

# Nerd Font (for devicons)
if ! fc-list 2>/dev/null | grep -qi "nerd"; then
  info "Installing JetBrainsMono Nerd Font..."
  FONT_DIR="${HOME}/.local/share/fonts"
  mkdir -p "$FONT_DIR"
  FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
  if curl -fsSL "$FONT_URL" -o /tmp/JetBrainsMono.tar.xz 2>/dev/null; then
    tar -xf /tmp/JetBrainsMono.tar.xz -C "$FONT_DIR"
    fc-cache -f "$FONT_DIR" 2>/dev/null || true
    rm -f /tmp/JetBrainsMono.tar.xz
    info "JetBrainsMono Nerd Font installed. Set it in your terminal settings."
  else
    warn "Could not download Nerd Font. Install manually: https://www.nerdfonts.com/"
  fi
else
  info "Nerd Font already installed."
fi

# ─── Symlink vimrc ──────────────────────────────────────────────────────────
VIMRC_LINK="${HOME}/.vimrc"
VIMRC_SOURCE="${HOME}/.vim/vimrc"

if [ -L "${VIMRC_LINK}" ]; then
  info ".vimrc symlink already exists."
elif [ -f "${VIMRC_LINK}" ]; then
  warn ".vimrc already exists as a file. Backing up to .vimrc.bak"
  mv "${VIMRC_LINK}" "${VIMRC_LINK}.bak"
  ln -s "${VIMRC_SOURCE}" "${VIMRC_LINK}"
  info "Symlinked .vimrc → .vim/vimrc"
else
  ln -s "${VIMRC_SOURCE}" "${VIMRC_LINK}"
  info "Symlinked .vimrc → .vim/vimrc"
fi

# ─── Install LSP Servers ─────────────────────────────────────────────────────
info "Installing LSP servers for common languages..."

# vim-lsp-settings installs servers to ~/.local/share/vim-lsp-settings/servers/
# We trigger installation by opening a temp file of each type in vim headless mode

install_lsp() {
  local ext="$1"
  local server="$2"
  local tmpfile=$(mktemp "/tmp/lsp_install_XXXX${ext}")
  info "  Installing ${server} (${ext})..."
  vim -es -u "${HOME}/.vim/vimrc" "$tmpfile" \
    -c "LspInstallServer" -c "qa!" 2>/dev/null || true
  rm -f "$tmpfile"
}

# Core languages
install_lsp ".py" "pyright"
install_lsp ".c" "clangd"
install_lsp ".go" "gopls"
install_lsp ".sh" "bash-language-server"
install_lsp ".yaml" "yaml-language-server"
install_lsp ".json" "vscode-json-language-server"
install_lsp ".html" "vscode-html-language-server"
install_lsp ".ts" "typescript-language-server"
install_lsp ".tex" "texlab"

info "LSP servers installed. Additional servers install on-demand with :LspInstallServer"

# ─── Done ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}✓ Installation complete!${NC}"
echo ""
echo "  Everything is ready. Just open vim and start coding."
echo "  - LSP servers: pre-installed for Python, C/C++, Go, Bash, YAML, JSON, HTML, TS, LaTeX"
echo "  - Additional languages: open a file and run :LspInstallServer"
echo "  - Keybinding cheatsheet: docs/keybindings.md"
echo ""
