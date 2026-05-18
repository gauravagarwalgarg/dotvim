# 🧱 Core Vim Hacks

> The fundamentals that make Vim a text manipulation language, not just a text editor.

---

## 📌 Table of Contents

- [The Vim Grammar](#the-vim-grammar)
- [Motions — How You Move](#motions--how-you-move)
- [Text Objects — Surgical Precision](#text-objects--surgical-precision)
- [The Dot Command — Repeat Anything](#the-dot-command--repeat-anything)
- [Registers — 48 Clipboards](#registers--48-clipboards)
- [Marks — Teleportation Points](#marks--teleportation-points)
- [Visual Mode — Selection Done Right](#visual-mode--selection-done-right)
- [Search — Find Anything Instantly](#search--find-anything-instantly)
- [Undo & Redo — Fearless Editing](#undo--redo--fearless-editing)

---

## The Vim Grammar

Vim commands follow a grammar: **`{operator}{count}{motion/text-object}`**

```
d       3       w
│       │       │
│       │       └── motion: word
│       └────────── count: 3 times
└────────────────── operator: delete
```

Learn 10 operators × 10 motions = 100 commands. This is why Vim scales.

### Operators

| Key | Operator |
|-----|----------|
| `d` | Delete |
| `c` | Change (delete + enter insert mode) |
| `y` | Yank (copy) |
| `v` | Visual select |
| `>` | Indent right |
| `<` | Indent left |
| `=` | Auto-indent |
| `gU` | Uppercase |
| `gu` | Lowercase |
| `g~` | Toggle case |
| `gq` | Format/wrap text |

### The Rule

Every operator works with every motion and every text object. Learn them independently, combine them infinitely.

---

## Motions — How You Move

### Character-Level

| Key | Motion |
|-----|--------|
| `h` `j` `k` `l` | Left, down, up, right |
| `f{char}` | Jump **to** next `{char}` on line |
| `F{char}` | Jump **to** previous `{char}` on line |
| `t{char}` | Jump **till** (before) next `{char}` |
| `T{char}` | Jump **till** (after) previous `{char}` |
| `;` | Repeat last `f`/`F`/`t`/`T` forward |
| `,` | Repeat last `f`/`F`/`t`/`T` backward |

### Word-Level

| Key | Motion |
|-----|--------|
| `w` | Next word start |
| `W` | Next WORD start (space-delimited) |
| `b` | Previous word start |
| `B` | Previous WORD start |
| `e` | End of word |
| `E` | End of WORD |
| `ge` | End of previous word |

### Line-Level

| Key | Motion |
|-----|--------|
| `0` | Start of line |
| `^` | First non-blank character |
| `$` | End of line |
| `g_` | Last non-blank character |
| `+` | First non-blank of next line |
| `-` | First non-blank of previous line |

### Block-Level

| Key | Motion |
|-----|--------|
| `{` | Previous blank line (paragraph up) |
| `}` | Next blank line (paragraph down) |
| `%` | Matching bracket `()` `{}` `[]` |
| `[[` | Previous section/function start |
| `]]` | Next section/function start |

### File-Level

| Key | Motion |
|-----|--------|
| `gg` | First line of file |
| `G` | Last line of file |
| `42G` or `:42` | Go to line 42 |
| `H` | Top of visible screen |
| `M` | Middle of visible screen |
| `L` | Bottom of visible screen |
| `<C-d>` | Half-page down |
| `<C-u>` | Half-page up |
| `<C-f>` | Full page down |
| `<C-b>` | Full page up |

### Combining Operators + Motions

```vim
dw        " Delete to next word
d$        " Delete to end of line
d}        " Delete to next blank line
ct)       " Change till closing paren
yf;       " Yank to next semicolon (inclusive)
gUw       " Uppercase next word
>}        " Indent to next blank line
=G        " Auto-indent from here to end of file
```

---

## Text Objects — Surgical Precision

Text objects define a region of text. They come in two flavors:
- `i` = **inner** (inside the delimiters)
- `a` = **around** (includes the delimiters)

### Paired Delimiters

| Text Object | Inner (`i`) | Around (`a`) |
|-------------|-------------|--------------|
| `"` | `ci"` → change inside quotes | `ca"` → change including quotes |
| `'` | `di'` → delete inside single quotes | `da'` → delete including quotes |
| `` ` `` | `ci`` ` → change inside backticks | `ca`` ` → includes backticks |
| `(` or `)` | `ci(` → change inside parens | `ca(` → includes parens |
| `{` or `}` | `di{` → delete inside braces | `da{` → includes braces |
| `[` or `]` | `yi[` → yank inside brackets | `ya[` → includes brackets |
| `<` or `>` | `ci<` → change inside angle brackets | `ca<` → includes angles |
| `t` (tag) | `cit` → change inside HTML tag | `cat` → includes the tags |

### Word/Sentence/Paragraph

| Text Object | Meaning |
|-------------|---------|
| `iw` | Inner word |
| `aw` | A word (includes trailing space) |
| `iW` | Inner WORD (space-delimited) |
| `aW` | A WORD |
| `is` | Inner sentence |
| `as` | A sentence |
| `ip` | Inner paragraph |
| `ap` | A paragraph (includes trailing blank line) |

### Real-World Examples

```vim
" You're inside: function(arg1, arg2, arg3)
ci(                   " Delete all args, start typing new ones

" You're inside: "Hello, World!"
ci"                   " Replace string content, keep quotes

" You're inside: <div class="container">content</div>
cit                   " Replace tag content, keep tags

" You're inside a paragraph of text
dap                   " Delete entire paragraph

" You're on: const name = "value";
ciw                   " Replace just the word under cursor

" Indent inside braces
>i{                   " Indent everything inside {}

" Yank a function body
yi{                   " Copy everything inside the braces
```

---

## The Dot Command — Repeat Anything

`.` repeats your last **change**. The key insight: design your edits to be dot-repeatable.

### Pattern 1: Change + Find + Repeat

```vim
/pattern<CR>          " Find first occurrence
cgn replacement<Esc>  " Change it (cgn = change next match)
.                     " Repeat on next match
.                     " And the next
n                     " Skip one (just move, don't change)
.                     " Change this one
```

`cgn` is magical because it's a single change operation that includes the search — making `.` repeat both the find and the replace.

### Pattern 2: Append + Move + Repeat

```vim
A;<Esc>               " Append semicolon to end of line
j.                    " Next line, repeat
j.                    " And again
```

### Pattern 3: Surround + Repeat

```vim
ysiw"                 " Surround word with quotes (vim-surround)
w.                    " Move to next word, repeat
w.                    " And again
```

### What Counts as a "Change"

A change is everything from entering insert mode to leaving it, OR a single normal-mode command that modifies text:

- `dd` — one change (delete line)
- `iHello World<Esc>` — one change (insert text)
- `ciwreplacement<Esc>` — one change (change word)
- `3x` — one change (delete 3 chars)
- `>ap` — one change (indent paragraph)

### Anti-Pattern: Breaking Repeatability

```vim
" BAD: Multiple separate changes
i(<Esc>ea)<Esc>       " Two changes — dot only repeats the second

" GOOD: One atomic change
ysiw)                 " One surround operation — dot repeats it all
```

---

## Registers — 48 Clipboards

Every delete, yank, and change goes into a register. You have dozens of them.

### Named Registers (a-z)

```vim
"ayy          " Yank line into register 'a'
"bdd          " Delete line into register 'b'
"ap           " Paste from register 'a'
"bp           " Paste from register 'b'

" Uppercase = APPEND to register
"Ayy          " Append this line to register 'a'
```

### Special Registers

| Register | Contains |
|----------|----------|
| `""` | Last deleted/yanked text (default) |
| `"0` | Last yanked text (yank-only) |
| `"1`-`"9` | Delete history (1 = most recent) |
| `"_` | Black hole (delete without saving) |
| `"+` | System clipboard |
| `"*` | Selection clipboard (X11) |
| `"%` | Current filename |
| `"#` | Alternate filename |
| `".` | Last inserted text |
| `":` | Last ex command |
| `"/` | Last search pattern |
| `"=` | Expression register |

### Practical Uses

```vim
" Delete without polluting default register
"_dd          " Line gone, registers untouched

" Paste from yank register (ignores deletes)
"0p           " Always pastes what you last yanked, not deleted

" Paste in insert mode
<C-r>a        " Insert contents of register 'a'
<C-r>"        " Insert default register
<C-r>=5*42<CR> " Insert result of expression (210)
<C-r>=system('date')<CR>  " Insert shell command output

" View all registers
:registers
```

### The Yank/Delete Problem (Solved)

The classic frustration: you yank text, delete something, then paste — and get the deleted text instead.

**Solution 1**: Use `"0p` — register 0 always holds the last yank.

**Solution 2**: This config maps visual-mode paste to not overwrite:
```vim
vnoremap p "_dP   " Paste over selection without losing yanked text
```

---

## Marks — Teleportation Points

### Local Marks (a-z) — Per Buffer

```vim
ma            " Set mark 'a' at cursor
'a            " Jump to line of mark 'a'
`a            " Jump to exact column of mark 'a'
```

### Global Marks (A-Z) — Cross-File

```vim
mA            " Set global mark 'A' (remembers file + position)
'A            " Jump to file and line of mark 'A'
```

**Strategy**: Use global marks for your working set:
- `mM` — Main file you're editing
- `mT` — Test file
- `mH` — Header file
- `mC` — Config file

Jump between them instantly: `'M`, `'T`, `'H`, `'C`.

### Automatic Marks

| Mark | Position |
|------|----------|
| `` `` `` | Position before last jump |
| `'.` | Position of last edit |
| `'^` | Position where insert mode was last exited |
| `'[` `']` | Start/end of last changed or yanked text |
| `'<` `'>` | Start/end of last visual selection |

### Jump List

```vim
<C-o>         " Jump back (older position)
<C-i>         " Jump forward (newer position)
:jumps        " View jump history
```

Every `gd`, `/search`, `gg`, `G`, `'mark` adds to the jump list. `<C-o>` is your "back button."

---

## Visual Mode — Selection Done Right

### Three Flavors

| Key | Mode | Selects |
|-----|------|---------|
| `v` | Character-wise | Individual characters |
| `V` | Line-wise | Entire lines |
| `<C-v>` | Block-wise | Rectangular columns |

### Visual + Operators

```vim
" Select then operate
viw           " Select word
vip           " Select paragraph
vi{           " Select inside braces
V5j           " Select 5 lines down

" Then apply operator
d             " Delete selection
c             " Change selection
y             " Yank selection
>             " Indent selection
U             " Uppercase selection
u             " Lowercase selection
:             " Run ex command on selection
```

### Block Mode (Column Editing)

```vim
<C-v>jjjI// <Esc>    " Insert '//' at start of 4 lines (comment)
<C-v>jjjA;<Esc>      " Append ';' to end of 4 lines
<C-v>jjjd            " Delete a column
<C-v>jjjr*           " Replace column with '*'
<C-v>jjjg<C-a>       " Increment numbers: 0,0,0,0 → 1,2,3,4
```

### Reselect Last Selection

```vim
gv            " Reselect the last visual selection
```

---

## Search — Find Anything Instantly

### Basic Search

| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next match |
| `N` | Previous match |
| `*` | Search word under cursor (forward) |
| `#` | Search word under cursor (backward) |

### Search Modifiers

```vim
/\cpattern    " Case insensitive (regardless of smartcase)
/\Cpattern    " Case sensitive (force)
/\<word\>     " Whole word only (word boundaries)
/\vpattern    " Very magic (regex without escaping)
```

### Useful Search Patterns

```vim
/\v\w+\(      " Find function calls
/\vTODO|FIXME " Find all TODOs and FIXMEs
/\v^\s*$      " Find blank lines
/\v\S+\s*$    " Find trailing whitespace
/\v(.)\1+     " Find repeated characters
```

### Search and Replace

```vim
:%s/old/new/g         " Replace all in file
:%s/old/new/gc        " Replace all with confirmation
:'<,'>s/old/new/g     " Replace in visual selection
```

---

## Undo & Redo — Fearless Editing

### Basic

| Key | Action |
|-----|--------|
| `u` | Undo |
| `<C-r>` | Redo |
| `U` | Undo all changes on current line |

### Undo Tree (this config)

Vim's undo is a **tree**, not a linear stack. Every branch is preserved.

```vim
<leader>u     " Open visual undo tree (undotree plugin)
```

### Persistent Undo

This config enables persistent undo — your undo history survives Vim restarts. Close Vim, reopen the file next week, and `u` still works back to your first edit.

### Time Travel

```vim
:earlier 5m   " Revert to state 5 minutes ago
:later 5m     " Go forward 5 minutes
:earlier 10   " Go back 10 changes
```

---

## 🎯 The Core Vim Mindset

1. **Think in text objects** — Don't "move cursor, select, delete." Think `dap` (delete a paragraph).
2. **Compose, don't memorize** — `d` + `iw` = delete inner word. `c` + `i"` = change inside quotes. Same grammar, infinite combinations.
3. **Make it repeatable** — Design edits so `.` does what you want next.
4. **Use counts** — `5dd` not `dd dd dd dd dd`. `3w` not `w w w`.
5. **Stay in normal mode** — Insert mode is for inserting text. Everything else happens in normal mode.
6. **Trust the undo tree** — Be bold. Experiment. `u` always has your back.

---

*"Vim is not about typing faster. It's about thinking in text transformations."*
