# 🖥️ dotvim

> A modern, IDE-grade Vim configuration. All the intelligence of VS Code, all the speed of Vim.

## 🚀 Installation

```bash
# Clone as your .vim directory
cd ~
git clone https://github.com/GauravAgarwalGarg/dotvim.git .vim

# Run the installer
cd ~/.vim
chmod +x install.sh
./install.sh
```

The installer handles everything:
- vim-plug (plugin manager)
- All plugins
- External dependencies (fzf, ripgrep, bat)
- Symlinks `~/.vimrc` → `~/.vim/vimrc`
- Persistent undo directory

## 📦 Requirements

- Vim 8.2+
- Git, curl
- A [Nerd Font](https://www.nerdfonts.com/) for icons

## 🔧 Post-Install: LSP

Open any source file and run:

```vim
:LspInstallServer
```

Auto-detects filetype and installs the right language server (clangd, pyright, gopls, rust-analyzer, etc.)

## 🔄 Updating

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qa
```

## 📚 Documentation

| Guide | Description |
|-------|-------------|
| [Architecture & Design](docs/architecture.md) | Plugin stack, design decisions, configuration philosophy |
| [Themes & Appearance](docs/themes.md) | How to select, switch, and customize themes and transparency |
| [Daily Usage](docs/daily-usage.md) | Keybindings, workflows, and the commands you'll use every day |
| [Core Vim Hacks](docs/core-vim-hacks.md) | Registers, text objects, the dot command, motions — Vim fundamentals |
| [Advanced Vim Hacks](docs/advanced-vim-hacks.md) | Macros, global commands, regex mastery, performance tricks |
| [VS Code Features in Vim](docs/vscode-in-vim.md) | Complete mapping of VS Code features to Vim equivalents |
| [Embedded Development](docs/embedded-workflow.md) | C/C++ with clangd, cross-compilation, GDB, serial monitors |

---

*"Give me six hours to chop down a tree and I will spend the first four sharpening the axe."*
