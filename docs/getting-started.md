# Getting Started

## Prerequisites

- Vim 8.2+ (or Neovim 0.8+)
- Git, curl
- A [Nerd Font](https://www.nerdfonts.com/) for icons (recommended: JetBrainsMono Nerd Font)

## Installation

```bash
# Clone as your .vim directory
cd ~
git clone https://github.com/GauravAgarwalGarg/dotvim.git .vim

# Run the installer
cd ~/.vim
chmod +x install.sh
./install.sh
```

The installer handles:

- vim-plug (plugin manager)
- All plugins downloaded
- External tools: fzf, ripgrep, bat
- Symlinks `~/.vimrc` → `~/.vim/vimrc`
- Persistent undo directory

## First Launch

```bash
vim
```

On first open, plugins will auto-install. Wait for it to finish.

## Installing Language Servers

Open any source file and run:

```vim
:LspInstallServer
```

This auto-detects the filetype and installs the correct LSP server:

| Language | Server | Command |
|----------|--------|---------|
| C/C++ | clangd | `:LspInstallServer` in `.c`/`.cpp` |
| Python | pyright | `:LspInstallServer` in `.py` |
| Go | gopls | `:LspInstallServer` in `.go` |
| Rust | rust-analyzer | `:LspInstallServer` in `.rs` |
| JavaScript/TS | typescript-language-server | `:LspInstallServer` in `.js`/`.ts` |
| Bash | bash-language-server | `:LspInstallServer` in `.sh` |
| YAML | yaml-language-server | `:LspInstallServer` in `.yaml` |
| LaTeX | texlab | `:LspInstallServer` in `.tex` |
| HTML | vscode-html-language-server | `:LspInstallServer` in `.html` |
| JSON | vscode-json-language-server | `:LspInstallServer` in `.json` |
| Dockerfile | dockerfile-language-server | `:LspInstallServer` in `Dockerfile` |
| Terraform | terraform-ls | `:LspInstallServer` in `.tf` |
| CMake | cmake-language-server | `:LspInstallServer` in `CMakeLists.txt` |

## Updating

```bash
cd ~/.vim
git pull
vim +PlugUpdate +qa
```

## Uninstalling

```bash
rm -rf ~/.vim ~/.vimrc
```
