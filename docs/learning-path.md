# Learning Path

A structured approach to mastering Vim from zero to full-stack development.

## Week 1: Survival

Run `vimtutor` (built-in, takes 30 minutes).

| Concept | What to learn |
|---------|---------------|
| Motions | `h j k l`, `w b e`, `0 $ ^`, `gg G` |
| Insert | `i a o I A O` six ways to enter insert mode |
| Exit | `:w` save, `:q` quit, `:wq` or `ZZ` save+quit |
| Undo | `u` undo, `Ctrl-R` redo |
| Delete | `x` char, `dd` line, `dw` word |

!!! tip "Golden Rule"
    Never use arrow keys. Force `hjkl` until it's muscle memory.

## Week 2: The Language of Vim

Vim commands follow **operator + motion** grammar:

```
d + w  = delete word
c + i" = change inside quotes
y + $  = yank to end of line
```

| Operators | `d` delete, `c` change, `y` yank, `v` visual select |
|-----------|------|
| **Motions** | `w` word, `$` end, `0` start, `}` paragraph, `f{char}` find |
| **Text Objects** | `iw` inner word, `i"` inner quotes, `a{` around braces, `ip` inner paragraph |

**The Dot Command** (`.`) repeats your last change. This is Vim's superpower.

## Week 3: Registers & Navigation

- `"ayy` yank line to register `a`
- `"ap` paste from register `a`
- `"+y` yank to system clipboard
- `:reg` view all registers
- `Ctrl-O` / `Ctrl-I` jump back/forward
- `m{a-z}` set mark, `'{a-z}` jump to mark

## Week 4: Plugins (dotvim)

| Key | Action |
|-----|--------|
| `Ctrl+P` | Find files (FZF) |
| `Space e` | File explorer (NERDTree) |
| `Space fg` | Search in files (ripgrep) |
| `Space t` | Toggle terminal |
| `Tab` / `S-Tab` | Next/previous buffer |

## Month 2: LSP & Git

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `Space rn` | Rename symbol |
| `Space ca` | Code actions |
| `Space gs` | Git status |
| `]h` / `[h` | Next/previous git hunk |

## Month 3: Power User

- **Macros**: `qa` record, `q` stop, `@a` replay, `100@a` bulk
- **Global**: `:g/TODO/d` delete all TODO lines
- **Substitute**: `:%s/old/new/gc` find and replace with confirmation
- **External**: `:%!sort` pipe buffer through shell command

## Ongoing

Read `:help` for one new command per day. After 6 months, you'll be faster than any GUI editor.
