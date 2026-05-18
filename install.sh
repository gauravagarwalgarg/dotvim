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
if ! fc-list | grep -qi "nerd"; then
  warn "No Nerd Font detected. Icons may not render correctly."
  warn "Install one from: https://www.nerdfonts.com/font-downloads"
  warn "Recommended: FiraCode Nerd Font or JetBrainsMono Nerd Font"
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

# ─── Done ────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}✓ Installation complete!${NC}"
echo ""
echo "  Next steps:"
echo "  1. Open vim and run :LspInstallServer for your languages"
echo "  2. Install a Nerd Font for icon support"
echo "  3. Read docs/ for tips and keybinding reference"
echo ""
