# dotvim

> A Modern Vim Configuration IDE-grade intelligence with Vim-grade speed.

## Why Vim?

| Advantage | Detail |
|-----------|--------|
| **Speed** | Zero startup latency. No Electron. No 500MB RAM. |
| **Low Setup Cost** | One `git clone` + one script. Any Linux/macOS/WSL. |
| **Muscle Memory** | Once learned, editing speed compounds forever. |
| **Everywhere** | SSH into any server, edit instantly. No GUI required. |
| **IDE Features** | LSP, autocomplete, go-to-definition, rename, diagnostics. |
| **Customizable** | Every keystroke yours to define. No corporate decisions. |

## Where Vim Triumphs

- **Remote Development** SSH + vim = full IDE. No VS Code Remote, no latency.
- **Large Files** Open 100MB logs instantly. VS Code chokes.
- **Batch Editing** Macros + `:g/pattern/cmd` = transform thousands of lines in seconds.
- **Containers & CI** Edit config in a running container. No volume mounts.
- **Resource Usage** ~30MB RAM vs 500MB+. Runs on a Raspberry Pi.
- **Stability** No updates breaking your workflow. No telemetry.

## Quick Start

```bash
cd ~ && git clone https://github.com/GauravAgarwalGarg/dotvim.git .vim
cd ~/.vim && ./install.sh
```

Then open any source file and run `:LspInstallServer` it auto-detects the language.

## What's Included

- **LSP** Full language server support for 14+ languages
- **FZF** Ctrl+P file finder, ripgrep search, buffer switching
- **NERDTree** File explorer sidebar
- **Git** Fugitive + GitGutter (blame, diff, stage hunks)
- **Terminal** Floating terminal (floaterm)
- **Snippets** vsnip + community snippets
- **Themes** Solarized, Gruvbox, Catppuccin, Everforest
- **Formatting** clang-format (C/C++), auto on save
