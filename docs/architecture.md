# 🏗️ Architecture & Design

> How this config is structured, what each plugin does, and why it was chosen.

---

## Design Philosophy

1. **IDE intelligence, terminal speed** LSP for code smarts, fzf for navigation, zero mouse dependency.
2. **Composable, not monolithic** Each plugin does one thing well. Swap any piece without breaking the rest.
3. **Zero-config where possible** `vim-lsp-settings` auto-installs language servers. Open a file, it just works.
4. **Vim-native patterns** Plugins enhance Vim's grammar, they don't replace it. No "VS Code in a terminal" nonsense.
5. **Performance-conscious** Async everything. No blocking operations. Startup under 100ms.

---

## Plugin Stack

```
┌─────────────────────────────────────────────────────────────┐
│                        COMPLETION                            │
│  asyncomplete.vim ← asyncomplete-lsp ← vim-lsp-settings    │
├─────────────────────────────────────────────────────────────┤
│                     LANGUAGE SERVER                          │
│  vim-lsp → clangd, pyright, gopls, rust-analyzer, etc.      │
├─────────────────────────────────────────────────────────────┤
│                      NAVIGATION                             │
│  fzf.vim │ NERDTree │ EasyMotion │ tmux-navigator           │
├─────────────────────────────────────────────────────────────┤
│                         GIT                                  │
│  vim-fugitive │ vim-gitgutter                                │
├─────────────────────────────────────────────────────────────┤
│                       EDITING                                │
│  surround │ commentary │ auto-pairs │ visual-multi           │
├─────────────────────────────────────────────────────────────┤
│                      UTILITIES                               │
│  undotree │ asyncrun │ floaterm │ dispatch                   │
├─────────────────────────────────────────────────────────────┤
│                         UI                                   │
│  airline │ gruvbox │ indentLine │ devicons                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Plugin Breakdown

### Completion & LSP

| Plugin | Role | Why This One |
|--------|------|--------------|
| `vim-lsp` | Language Server Protocol client | Pure VimScript, no Python/Node dependency, async |
| `vim-lsp-settings` | Auto-install/configure language servers | One command `:LspInstallServer`, zero manual config |
| `asyncomplete.vim` | Completion engine | Lightweight, async, no external dependencies |
| `asyncomplete-lsp.vim` | Bridge LSP → completion | Feeds LSP results into asyncomplete |

**Why not YouCompleteMe?** YCM requires compiled components, Python, and manual per-language setup. vim-lsp + asyncomplete achieves the same result with zero compilation and auto-detection.

**Why not CoC.nvim?** CoC pulls in Node.js and npm. This config stays pure no runtime dependencies beyond Vim itself.

### Navigation

| Plugin | Role | VS Code Equivalent |
|--------|------|--------------------|
| `fzf` + `fzf.vim` | Fuzzy finder for everything | Ctrl+P, Ctrl+Shift+F, Ctrl+Shift+O |
| `NERDTree` | File explorer sidebar | Explorer panel |
| `vim-easymotion` | Jump to any visible character | (Vim-only superpower) |
| `vim-tmux-navigator` | Seamless split navigation with tmux | |

### Git

| Plugin | Role | VS Code Equivalent |
|--------|------|--------------------|
| `vim-fugitive` | Full git client inside Vim | Source Control panel |
| `vim-gitgutter` | Gutter signs + hunk operations | GitLens gutter |

### Editing

| Plugin | Role | Example |
|--------|------|---------|
| `vim-surround` | Add/change/delete surroundings | `cs"'` changes `"hello"` → `'hello'` |
| `vim-commentary` | Toggle comments | `gcc` comments a line, `gc` in visual |
| `auto-pairs` | Auto-close brackets/quotes | Type `(` → get `()` with cursor inside |
| `vim-visual-multi` | Multiple cursors | `<C-n>` to select next occurrence |
| `vim-repeat` | Make plugin actions dot-repeatable | `.` repeats surround/commentary actions |

### Utilities

| Plugin | Role |
|--------|------|
| `undotree` | Visual undo history (branching, persistent across sessions) |
| `asyncrun.vim` | Run shell commands async, output to quickfix |
| `vim-floaterm` | Floating terminal windows |
| `vim-dispatch` | Async build dispatch |

### UI & Aesthetics

| Plugin | Role |
|--------|------|
| `vim-airline` | Statusline with git branch, filetype, encoding |
| `gruvbox` | Default colorscheme (warm, readable) |
| `catppuccin` | Alternative (pastel, modern) |
| `everforest` | Alternative (soft green) |
| `indentLine` | Visual indent guides |
| `vim-highlightedyank` | Flash yanked text briefly |
| `vim-devicons` | File type icons in NERDTree |
| `vim-polyglot` | Syntax highlighting for 100+ languages |

---

## Configuration Structure

```
~/.vim/
├── vimrc                 # Main configuration (single file, well-sectioned)
├── autoload/
│   └── plug.vim          # vim-plug (auto-bootstraps on first run)
├── colors/
│   └── newproggie.vim    # Legacy colorscheme (preserved)
├── indent/
│   └── cmake-indent.vim  # CMake indentation rules
├── undodir/              # Persistent undo files (gitignored)
├── plugged/              # Installed plugins (gitignored)
└── docs/                 # Documentation
```

### Why a Single vimrc?

Many configs split into `plugins.vim`, `mappings.vim`, `settings.vim`, etc. This config keeps everything in one file because:

1. **Grep-ability** One file to search, one file to understand.
2. **Sections are clear** Each block is demarcated with ASCII headers.
3. **No load-order bugs** Everything is in one place, top to bottom.
4. **Easy to share** Copy one file, done.

---

## Key Design Decisions

### Leader Key: Space

Space is the largest key on the keyboard, reachable by both thumbs, and does nothing useful in normal mode by default. It's the natural leader.

### Hybrid Line Numbers

```vim
set number relativenumber
```

Absolute number on the current line (for `:42` jumps), relative numbers everywhere else (for `5j`, `3k` motions). Best of both worlds.

### Persistent Undo

```vim
set undofile
set undodir=~/.vim/undodir
```

Undo history survives Vim restarts. Combined with Undotree, you get a visual timeline of every change ever made to a file better than git for micro-changes.

### No Swap Files

```vim
set noswapfile nobackup nowritebackup
```

Git handles versioning. Swap files are noise that cause "file already open" annoyances in multi-terminal workflows.

### System Clipboard

```vim
set clipboard=unnamedplus
```

Yank in Vim, paste anywhere. Copy anywhere, put in Vim. No more `"+y` gymnastics.

### Async Everything

- Completion: async (asyncomplete)
- Builds: async (asyncrun)
- Linting: async (vim-lsp)
- Git signs: async (gitgutter)

Nothing blocks the editor. Ever.

---

## Colorschemes

| Scheme | Vibe | Switch Command |
|--------|------|----------------|
| gruvbox (default) | Warm, retro, easy on eyes | `:colorscheme gruvbox` |
| catppuccin | Pastel, modern | `:colorscheme catppuccin_mocha` |
| everforest | Soft green, nature | `:colorscheme everforest` |
| newproggie | Original dark (legacy) | `:colorscheme newproggie` |

To change default, edit the `colorscheme` line in vimrc.

---

## Supported Languages (via LSP)

| Language | Server | Install |
|----------|--------|---------|
| C/C++ | clangd | `:LspInstallServer` |
| Python | pyright | `:LspInstallServer` |
| Go | gopls | `:LspInstallServer` |
| Rust | rust-analyzer | `:LspInstallServer` |
| TypeScript/JS | typescript-language-server | `:LspInstallServer` |
| Bash | bash-language-server | `:LspInstallServer` |
| YAML | yaml-language-server | `:LspInstallServer` |
| Docker | dockerfile-language-server | `:LspInstallServer` |
| Terraform | terraform-ls | `:LspInstallServer` |
| CMake | cmake-language-server | `:LspInstallServer` |
| Lua | lua-language-server | `:LspInstallServer` |
| JSON | vscode-json-languageserver | `:LspInstallServer` |

All servers are auto-detected by filetype. Just open a file and run the command once.

---

*"Complexity is the enemy of reliability. This config is complex enough to be powerful, simple enough to be understood."*
