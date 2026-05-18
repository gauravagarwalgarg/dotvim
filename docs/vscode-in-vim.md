# 🔄 VS Code Features in Vim

> Every VS Code feature you love, replicated in Vim often faster.

---

## 📌 Quick Reference Map

| VS Code | Shortcut | Vim Equivalent | Shortcut |
|---------|----------|----------------|----------|
| Command Palette | `Ctrl+Shift+P` | FZF Commands | `<leader>fc` |
| Quick Open | `Ctrl+P` | FZF Files | `<C-p>` |
| Global Search | `Ctrl+Shift+F` | FZF Ripgrep | `<leader>fg` |
| Go to Symbol | `Ctrl+Shift+O` | LSP Document Symbols | `<leader>cs` |
| Go to Definition | `F12` | LSP Definition | `gd` |
| Peek Definition | `Alt+F12` | LSP Peek | `gD` |
| Find References | `Shift+F12` | LSP References | `gr` |
| Rename Symbol | `F2` | LSP Rename | `<leader>rn` |
| Code Actions | `Ctrl+.` | LSP Code Action | `<leader>ca` |
| Format Document | `Shift+Alt+F` | LSP Format | `<leader>cf` |
| Toggle Terminal | `` Ctrl+` `` | Floaterm | `<leader>t` |
| Toggle Sidebar | `Ctrl+B` | NERDTree | `<leader>e` |
| Next Error | `F8` | LSP Diagnostic | `]d` |
| Multi-cursor | `Ctrl+D` | vim-visual-multi | `<C-n>` |
| Move Line | `Alt+↑/↓` | Move mapping | `<A-k>/<A-j>` |
| Duplicate Line | `Ctrl+Shift+D` | Duplicate | `<leader>d` |
| Toggle Comment | `Ctrl+/` | Commentary | `gcc` |
| Fold/Unfold | `Ctrl+Shift+[/]` | Fold | `za` / `zR` |
| Git Blame | GitLens inline | Fugitive | `<leader>gb` |
| Breadcrumbs | Top bar | LSP + airline | Automatic |
| IntelliSense | Auto-popup | asyncomplete | Auto-popup |

---

## 🔍 File Finding & Navigation

### Ctrl+P Quick Open Files

VS Code's file finder is replicated by fzf.vim with superior speed:

```vim
" Find files (respects .gitignore automatically)
<C-p>         " or <leader>ff

" While in fzf:
" Ctrl+T      → open in new tab
" Ctrl+X      → open in horizontal split
" Ctrl+V      → open in vertical split
" Ctrl+/      → toggle preview window
```

### Ctrl+Shift+F Global Search

```vim
" Search across entire project with live preview
<leader>fg    " Opens Rg (ripgrep) with fzf

" Search for word under cursor
:Rg <C-r><C-w>

" Search with file type filter
:Rg pattern -t py        " Only Python files
:Rg pattern -g '*.cpp'   " Only C++ files
```

### Ctrl+G Go to Line

```vim
" Go to specific line
:42           " Jump to line 42
42G           " Same thing
42gg          " Same thing
```

### Ctrl+Shift+O Go to Symbol in File

```vim
<leader>cs    " LSP document symbols (functions, classes, etc.)
```

### Ctrl+T Go to Symbol in Workspace

```vim
<leader>cw    " LSP workspace symbols
```

---

## 🧠 IntelliSense & Code Intelligence

### Autocomplete

Asyncomplete provides VS Code-style completion:

```vim
" Completion triggers automatically as you type
" Navigate with:
<Tab>         " Next suggestion
<S-Tab>       " Previous suggestion
<CR>          " Accept suggestion
<C-e>         " Dismiss popup

" Manual trigger
<C-Space>     " Force completion popup (if mapped)
```

### Hover Documentation

```vim
K             " Show hover info (like hovering in VS Code)
              " Press K again to enter the hover window
              " Press q to close
```

### Signature Help

```vim
<C-k>         " Show function signature while typing arguments
              " (in insert mode)
```

### Diagnostics (Problems Panel)

```vim
" Navigate errors/warnings
]d            " Next diagnostic (like F8 in VS Code)
[d            " Previous diagnostic

" View all diagnostics
:LspDocumentDiagnostics    " Current file
```

Diagnostics appear:
- As signs in the gutter (●, ▲)
- As virtual text at end of line
- In the echo area when cursor is on the line
- In a floating window on hover

---

## 📁 File Explorer

### NERDTree (VS Code Explorer Sidebar)

```vim
<leader>e     " Toggle explorer
<leader>nf    " Reveal current file in explorer (like "Reveal in Explorer")

" Inside NERDTree:
o             " Open file/toggle directory
t             " Open in new tab
s             " Open in vertical split
i             " Open in horizontal split
m             " Show file menu (create, rename, delete, move)
I             " Toggle hidden files
R             " Refresh tree
q             " Close explorer
```

---

## 🖥️ Integrated Terminal

### Floaterm (VS Code Terminal Panel)

```vim
<leader>t     " Toggle floating terminal
<F7>          " New terminal instance
<F8>          " Next terminal
<Esc>         " Return to normal mode (from terminal)

" Run commands without leaving Vim
:FloatermNew python %      " Run current Python file
:FloatermNew make          " Run make
:FloatermNew lazygit       " Full TUI git client
```

---

## 🔀 Git Integration

### vim-fugitive (VS Code Source Control)

```vim
<leader>gs    " Git status (interactive staging like VS Code)
              " In status window:
              "   s = stage file
              "   u = unstage file
              "   = = toggle diff
              "   cc = commit

<leader>gd    " Diff current file (side-by-side like VS Code)
<leader>gb    " Git blame (inline annotations)
<leader>gl    " Git log

" Conflict resolution (3-way merge)
:Gdiffsplit!  " Opens 3-way split for merge conflicts
              " //2 = target (ours), //3 = merge (theirs)
:diffget //2  " Accept ours
:diffget //3  " Accept theirs
```

### vim-gitgutter (VS Code Gutter Indicators)

```vim
]h            " Jump to next changed hunk
[h            " Jump to previous changed hunk
<leader>hp    " Preview hunk changes (inline diff)
<leader>hs    " Stage hunk (like VS Code "Stage Changes")
<leader>hu    " Undo hunk (like VS Code "Revert Changes")
```

---

## ✏️ Multi-Cursor Editing

### vim-visual-multi (Ctrl+D equivalent)

```vim
<C-n>         " Select word under cursor, add cursor
<C-n>         " Select next occurrence (like Ctrl+D again)
q             " Skip current, go to next
Q             " Remove current cursor

" Select all occurrences (like Ctrl+Shift+L)
\\A           " Select all occurrences of word

" Add cursors vertically (like Ctrl+Alt+↑/↓)
<C-Down>      " Add cursor below
<C-Up>        " Add cursor above
```

**But often, Vim's native approach is faster**:

```vim
" Change all occurrences of word under cursor
*             " Highlight all occurrences
cgn           " Change next occurrence
.             " Repeat on next (dot-repeatable!)
.             " And the next...

" Or just use substitution
:%s/\<old_word\>/new_word/g
```

---

## 📐 Code Formatting

### Format Document

```vim
<leader>cf    " Format entire document via LSP
              " (like Shift+Alt+F in VS Code)

" Format selection
:'<,'>LspDocumentRangeFormat

" Auto-format on save (for C/C++ with clang-format)
" Already configured in vimrc for C/C++ files
```

### Format on Save (custom)

Add to vimrc for other languages:
```vim
autocmd BufWritePre *.py :LspDocumentFormatSync
autocmd BufWritePre *.go :LspDocumentFormatSync
```

---

## 🔖 Bookmarks & Navigation

### VS Code Bookmarks → Vim Marks

```vim
" Set bookmark (mark)
ma            " Set mark 'a' at current position

" Jump to bookmark
'a            " Jump to mark 'a'

" Global bookmarks (across files)
mA            " Set global mark 'A'
'A            " Jump to file containing mark 'A'

" Recent locations (like VS Code's Go Back/Forward)
<C-o>         " Go back (like Alt+← in VS Code)
<C-i>         " Go forward (like Alt+→ in VS Code)
```

---

## 🪟 Layout & Panels

### Split Views (VS Code Split Editor)

```vim
:vsp          " Vertical split (like Ctrl+\)
:sp           " Horizontal split
<C-w>o        " Close all other splits (focus current)
<C-w>=        " Equal size all splits
<C-w>_        " Maximize current split height
<C-w>|        " Maximize current split width
<C-w>T        " Move split to new tab
```

### Tabs (VS Code Editor Groups)

```vim
:tabnew       " New tab
gt            " Next tab (like Ctrl+PageDown)
gT            " Previous tab (like Ctrl+PageUp)
:tabclose     " Close tab
:tabonly       " Close all other tabs
```

---

## 🔧 Settings & Configuration

| VS Code | Vim |
|---------|-----|
| `settings.json` | `~/.vim/vimrc` |
| `keybindings.json` | Mappings in vimrc |
| Extensions | Plugins (vim-plug) |
| `Ctrl+,` (Settings UI) | `:e $MYVIMRC` or `<leader>ev` |
| Extension Marketplace | [VimAwesome.com](https://vimawesome.com) |

---

## 🚀 Features Vim Does Better Than VS Code

| Feature | Why Vim Wins |
|---------|-------------|
| **Startup time** | ~50ms vs ~3s. Vim is ready before VS Code finishes loading extensions. |
| **Remote editing** | SSH + Vim. No Remote-SSH extension, no latency, no port forwarding. |
| **Resource usage** | ~30MB RAM vs ~500MB+. Run 20 Vim instances for the cost of one VS Code. |
| **Composability** | `d3w` = delete 3 words. VS Code needs a mouse or multiple keystrokes. |
| **Macros** | Record any sequence, replay infinitely. VS Code macros are limited. |
| **Text manipulation** | `:g`, `:s`, registers, text objects. Vim is a text manipulation language. |
| **Stability** | No "Extension Host crashed." No "Reload Window." It just works. |
| **Customization depth** | Every single behavior is configurable. No "sorry, not supported." |
| **Terminal integration** | Vim IS the terminal. No context switch. |
| **Muscle memory** | Once learned, works everywhere: servers, containers, embedded devices. |

---

## 💡 Tips for VS Code Users Transitioning

1. **Don't try to replicate VS Code exactly.** Learn the Vim way it's often faster.
2. **Start with the basics**: `hjkl`, `w/b`, `dd`, `yy`, `p`, `/search`, `:w`, `:q`
3. **Add one new motion per week.** Don't overwhelm yourself.
4. **Use `:help {topic}`** Vim's built-in docs are exceptional.
5. **Keep a cheat sheet** for the first month. After that, muscle memory takes over.
6. **The learning curve is steep but short.** After 2 weeks, you'll be productive. After 2 months, you'll be faster than VS Code.

---

*"VS Code is a great text editor that wants to be an IDE. Vim is a great text manipulation language that happens to edit files."*
