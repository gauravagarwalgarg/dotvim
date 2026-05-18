# 📅 Daily Usage

> The keybindings and workflows you'll reach for every single day.

---

## ⌨️ Key Bindings at a Glance

**Leader key: `<Space>`**

---

## 🗂️ File Operations

| Key | Action |
|-----|--------|
| `<leader>w` | Save file |
| `<leader>q` | Quit |
| `<leader>x` | Save and quit |
| `<leader>ev` | Edit vimrc in new tab |
| `<leader>sv` | Reload vimrc |

---

## 🔍 Finding Things

| Key | Action | Think of it as... |
|-----|--------|-------------------|
| `<C-p>` | Find files by name | "Ctrl+P" |
| `<leader>fg` | Grep across project | "Find Globally" |
| `<leader>fb` | Switch between open buffers | "Find Buffer" |
| `<leader>fh` | Recent files (history) | "Find History" |
| `<leader>fc` | Search all Vim commands | "Find Command" |
| `<leader>fl` | Search lines in current buffer | "Find Line" |
| `<leader>fm` | Jump to marks | "Find Mark" |
| `<leader>fs` | Insert snippet | "Find Snippet" |

**Inside fzf picker:**
- `Ctrl+T` → open in new tab
- `Ctrl+X` → open in horizontal split
- `Ctrl+V` → open in vertical split
- `Ctrl+/` → toggle preview

---

## 📁 File Explorer

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle NERDTree |
| `<leader>nf` | Reveal current file in tree |

**Inside NERDTree:**
| Key | Action |
|-----|--------|
| `o` | Open file / toggle folder |
| `t` | Open in new tab |
| `s` | Open in vertical split |
| `i` | Open in horizontal split |
| `m` | File menu (create, rename, delete, move) |
| `I` | Toggle hidden files |
| `R` | Refresh |
| `q` | Close tree |

---

## 🧠 Code Intelligence (LSP)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gD` | Peek definition |
| `gr` | Find all references |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover documentation |
| `<C-k>` (insert) | Signature help |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions (quick fixes) |
| `<leader>cf` | Format document |
| `<leader>cs` | Document symbols (outline) |
| `<leader>cw` | Workspace symbols |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Completion

| Key | Action |
|-----|--------|
| `<Tab>` | Next suggestion |
| `<S-Tab>` | Previous suggestion |
| `<CR>` | Accept suggestion |

---

## 🪟 Windows & Buffers

### Navigating Splits

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left split |
| `<C-j>` | Move to split below |
| `<C-k>` | Move to split above |
| `<C-l>` | Move to right split |

### Resizing Splits

| Key | Action |
|-----|--------|
| `<C-Up>` | Increase height |
| `<C-Down>` | Decrease height |
| `<C-Left>` | Decrease width |
| `<C-Right>` | Increase width |

### Buffer Navigation

| Key | Action |
|-----|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>bd` | Close buffer |

---

## ✏️ Editing

### Line Operations

| Key | Action |
|-----|--------|
| `<A-j>` | Move line down |
| `<A-k>` | Move line up |
| `<A-j>` (visual) | Move selection down |
| `<A-k>` (visual) | Move selection up |
| `<leader>d` | Duplicate line |
| `<leader>a` | Select all |

### Indentation (visual mode)

| Key | Action |
|-----|--------|
| `>` | Indent (keeps selection) |
| `<` | Outdent (keeps selection) |

### Commenting

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment on line |
| `gc` (visual) | Toggle comment on selection |
| `gcap` | Comment a paragraph |
| `gc3j` | Comment 3 lines down |

### Surround

| Key | Action |
|-----|--------|
| `cs"'` | Change `"hello"` → `'hello'` |
| `ds"` | Delete `"hello"` → `hello` |
| `ysiw"` | Surround word: `hello` → `"hello"` |
| `yss)` | Surround line with `()` |
| `S"` (visual) | Surround selection with `"` |

---

## 🔀 Git

### Fugitive

| Key | Action |
|-----|--------|
| `<leader>gs` | Git status (interactive) |
| `<leader>gc` | Git commit |
| `<leader>gp` | Git push |
| `<leader>gl` | Git log (last 20) |
| `<leader>gd` | Diff current file (split view) |
| `<leader>gb` | Git blame |

### GitGutter (hunk operations)

| Key | Action |
|-----|--------|
| `]h` | Jump to next changed hunk |
| `[h` | Jump to previous changed hunk |
| `<leader>hp` | Preview hunk diff |
| `<leader>hs` | Stage hunk |
| `<leader>hu` | Undo hunk |

---

## 🖥️ Terminal

| Key | Action |
|-----|--------|
| `<leader>t` | Toggle floating terminal |
| `<F7>` | New terminal instance |
| `<F8>` | Next terminal |
| `<Esc>` (in terminal) | Return to normal mode |

---

## 🏗️ Build & Run

| Key | Action |
|-----|--------|
| `<leader>mk` | Run `make` |
| `<leader>mb` | Run `cmake --build build` |
| `<leader>mr` | Run `make run` |

Errors populate the quickfix list:
| Key | Action |
|-----|--------|
| `:copen` | Open quickfix window |
| `:cnext` | Next error |
| `:cprev` | Previous error |

---

## 🔖 Navigation & Jumping

| Key | Action |
|-----|--------|
| `s{char}{char}` | EasyMotion: jump to any 2-char combo |
| `<leader>j` | EasyMotion: jump to line below |
| `<leader>k` | EasyMotion: jump to line above |
| `<C-o>` | Jump back (previous location) |
| `<C-i>` | Jump forward |
| `<leader>z` | Toggle fold under cursor |

---

## 🔧 Utilities

| Key | Action |
|-----|--------|
| `<leader>u` | Toggle undo tree |
| `<Esc><Esc>` | Clear search highlighting |
| `<C-\>` | Jump to tag in new tab (ctags) |
| `<leader>]` | Jump to tag in vertical split |

---

## 📋 Typical Daily Workflow

### Morning: Start a Feature

```
vim                           # Open Vim
<C-p>                         # Find the file to work on
<leader>gs                    # Check git status
gd                            # Navigate to function definition
```

### Coding: Edit → Build → Fix

```
i                             # Enter insert mode, write code
<Esc>                         # Back to normal mode
<leader>w                     # Save
<leader>mk                    # Build
:cnext                        # Jump to first error
.                             # Fix, repeat
```

### Refactoring: Rename Across Project

```
<leader>rn                    # Rename symbol (LSP handles all files)
<leader>fg                    # Grep to verify no stragglers
```

### Debugging: Trace a Bug

```
gr                            # Find all references to suspect function
gd                            # Dive into definition
K                             # Read hover docs
<C-o>                         # Jump back
<leader>t                     # Open terminal, run debugger
```

### End of Day: Commit

```
<leader>gs                    # Git status
s                             # Stage files (in fugitive window)
cc                            # Commit
<leader>gp                    # Push
```

---

## 💡 Pro Tips

1. **Use `<Tab>` / `<S-Tab>` for buffer switching** faster than `:b name`
2. **`<leader>fg` then type** ripgrep is instant even on huge codebases
3. **`]h` and `[h`** jump between git changes to review what you've done
4. **`<leader>hp`** preview a hunk before deciding to stage or undo it
5. **`gcc` in normal, `gc` in visual** commenting is always one keystroke away
6. **`gd` then `<C-o>`** peek at a definition and bounce back instantly

---

*"The best workflow is the one you don't think about. It's muscle memory."*
