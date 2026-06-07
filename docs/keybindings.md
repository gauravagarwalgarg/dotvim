# Keybindings Reference

Leader key: `Space`

## File Operations

| Key | Action |
|-----|--------|
| `Space w` | Save |
| `Space q` | Quit |
| `Space x` | Save and quit |

## Navigation

| Key | Action |
|-----|--------|
| `Ctrl+P` | Find files (FZF) |
| `Space ff` | Find files |
| `Space fg` | Grep in files (ripgrep) |
| `Space fb` | Switch buffer |
| `Space fh` | Recent files |
| `Space fl` | Search in current file |
| `Tab` | Next buffer |
| `S-Tab` | Previous buffer |
| `Space bd` | Close buffer |

## File Explorer

| Key | Action |
|-----|--------|
| `Space e` | Toggle NERDTree |
| `Space nf` | Find current file in tree |

## LSP (Language Server)

| Key | Action | VS Code Equivalent |
|-----|--------|-------------------|
| `gd` | Go to definition | F12 |
| `gD` | Peek definition | Alt+F12 |
| `gr` | Find references | Shift+F12 |
| `gi` | Go to implementation | |
| `gt` | Type definition | |
| `K` | Hover documentation | Mouse hover |
| `Space rn` | Rename symbol | F2 |
| `Space ca` | Code actions | Ctrl+. |
| `Space cf` | Format document | Shift+Alt+F |
| `Space cs` | Document symbols | Ctrl+Shift+O |
| `[d` / `]d` | Previous/next diagnostic | F8 |
| `Ctrl+K` (insert) | Signature help | |

## Git

| Key | Action |
|-----|--------|
| `Space gs` | Git status |
| `Space gc` | Git commit |
| `Space gp` | Git push |
| `Space gl` | Git log |
| `Space gd` | Git diff split |
| `Space gb` | Git blame |
| `]h` / `[h` | Next/previous hunk |
| `Space hp` | Preview hunk |
| `Space hs` | Stage hunk |
| `Space hu` | Undo hunk |

## Editing

| Key | Action |
|-----|--------|
| `A-j` / `A-k` | Move line down/up |
| `Space d` | Duplicate line |
| `Space a` | Select all |
| `gc` (visual) | Toggle comment |
| `s{char}{char}` | EasyMotion jump |
| `Space u` | Undo tree |

## Terminal

| Key | Action |
|-----|--------|
| `Space t` | Toggle floating terminal |
| `F7` | New terminal |
| `F8` | Next terminal |
| `Esc` (in terminal) | Exit terminal mode |

## Build

| Key | Action |
|-----|--------|
| `Space mk` | Make |
| `Space mb` | CMake build |
| `Space mr` | Make run |
