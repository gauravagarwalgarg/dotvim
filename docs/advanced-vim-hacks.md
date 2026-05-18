# 🧙 Advanced Vim Hacks

> Techniques that separate Vim users from Vim *wielders*. You know the grammar — now bend it.

---

## 📌 Table of Contents

- [Macros — Record Once, Replay Forever](#macros--record-once-replay-forever)
- [Global Command — Batch Operations at Scale](#global-command--batch-operations-at-scale)
- [Command-Line Sorcery](#command-line-sorcery)
- [Search & Replace — Regex Mastery](#search--replace--regex-mastery)
- [Visual Block Mode — Column Editing](#visual-block-mode--column-editing)
- [Quickfix & Location Lists](#quickfix--location-lists)
- [Scripting & Expressions](#scripting--expressions)
- [Multi-File Operations](#multi-file-operations)
- [Performance & Profiling](#performance--profiling)
- [Obscure But Lethal](#obscure-but-lethal)

---

## Macros — Record Once, Replay Forever

Macros are Vim's automation primitive. Any sequence of keystrokes, recorded and replayed.

### Basics

```vim
qq            " Start recording into register 'q'
...           " Your keystrokes
q             " Stop recording

@q            " Play macro once
@@            " Repeat last played macro
10@q          " Play 10 times
```

### Apply to Every Line

```vim
:%normal @q           " Run macro on every line in file
:'<,'>normal @q       " Run macro on visual selection
:g/pattern/normal @q  " Run macro on lines matching pattern
```

### Recursive Macros (Run Until Failure)

```vim
qqqq          " Clear register q (qqqq = record empty into q, then start fresh)
...           " Your edit
j             " Move to next line (or n for next search match)
@q            " Call itself
q             " Stop recording
@q            " Execute — runs until motion fails (end of file, no match)
```

### Edit a Macro

Macros are just text stored in registers. Edit them like text:

```vim
" Paste macro into buffer
"qp           " Paste register q

" Edit the text (it's just keystrokes as characters)
" ... make changes ...

" Yank it back
0"qy$         " Yank line back into register q

" Now @q plays your edited version
```

### Real-World Examples

**Convert CSV to SQL INSERT:**
```
name,age,city
Alice,30,NYC
Bob,25,LA
```

```vim
qq                              " Start recording
0i(')<Esc>                      " Wrap line start
f,s', '<Esc>                    " Replace first comma
f,s', '<Esc>                    " Replace second comma
A'),<Esc>                       " Close and add comma
j0q                             " Move to next line, stop
2@q                             " Apply to remaining lines
```

**Add incrementing IDs:**
```vim
:let i=1
qa
I<C-r>=i<CR>. <Esc>
:let i+=1
j0q
```

---

## Global Command — Batch Operations at Scale

`:g/{pattern}/{command}` — the most powerful ex command. Executes `{command}` on every line matching `{pattern}`.

### Deletion Patterns

```vim
:g/^$/d                   " Delete all blank lines
:g/^\s*$/d                " Delete lines that are only whitespace
:g/debug/d                " Delete lines containing 'debug'
:g/^#/d                   " Delete all comments (# style)
:v/important/d            " Delete lines NOT containing 'important' (:v = inverse)
:g/pattern/,/end/d        " Delete from pattern to 'end' (range)
```

### Movement & Reordering

```vim
:g/TODO/m$                " Move all TODOs to end of file
:g/^import/m0             " Move all imports to top
:g/^$/,/./-j              " Collapse multiple blank lines into one
```

### Execution

```vim
:g/pattern/normal @q      " Run macro on matching lines
:g/^#/normal A  // hdr    " Append text to matching lines
:g/func/normal O\         " Add blank line above each function
:g/^/normal J             " Join all lines (remove all newlines)
```

### Yanking & Collecting

```vim
:g/error/yank A           " Collect all error lines into register 'a'
                          " (uppercase A = append, so all lines accumulate)
:g/TODO/t$                " Copy (not move) all TODOs to end
```

### Sorting Within Blocks

```vim
:g/^class/+1,/^class\|^$/-1 sort    " Sort methods within each class
```

### Counting

```vim
:%s/pattern//gn           " Count occurrences (n flag = no replace, just count)
```

### Combining with Substitution

```vim
:g/^func/s/func/fn/       " Replace 'func' with 'fn' only on lines starting with 'func'
:g/test/s/\d\+/\=submatch(0)+1/g  " Increment numbers only on test lines
```

---

## Command-Line Sorcery

### Shell Integration

```vim
:r !date                          " Insert current date
:r !curl -s https://api.com/data  " Insert API response
:r !seq 1 100                     " Insert numbers 1-100
:r !ls *.c                        " Insert list of C files

" Filter buffer through external command
:%!python -m json.tool            " Pretty-print JSON
:%!sort -u                        " Sort and deduplicate entire file
:'<,'>!sort                       " Sort selection
:'<,'>!column -t                  " Align columns in selection
:%!xxd                            " Hex dump (and :%!xxd -r to reverse)

" Execute current line as shell command
:.!bash                           " Replace line with its output
:.w !bash                         " Execute line, keep original (output in :messages)
```

### Redirect & Capture

```vim
" Capture command output into a register
:redir @a | silent messages | redir END
"ap                               " Paste captured output

" Capture to a new buffer
:redir => output | silent ls | redir END
:new | put =output                " Open new buffer with output
```

### Command-Line Window

```vim
q:            " Open command history (full editing power)
q/            " Open search history
<C-f>         " Switch to command-line window from : prompt
```

In the command-line window, you can edit previous commands with full Vim motions, then press `<CR>` to execute.

### Ranges

```vim
:.,$s/old/new/g           " From current line to end
:1,5d                     " Delete lines 1-5
:.,+10s/old/new/g         " Current line + next 10
:'a,'bs/old/new/g         " Between marks a and b
:/start/,/end/d           " Between patterns
:0r !date                 " Insert at very top (line 0)
```

### Useful Ex Commands

```vim
:earlier 5m               " Revert to 5 minutes ago
:later 5m                 " Go forward 5 minutes
:changes                  " List all changes
:undolist                 " Show undo branches
:verbose set tabstop?     " Show where a setting was last set
:scriptnames              " List all loaded scripts
:messages                 " Show message history
```

---

## Search & Replace — Regex Mastery

### Very Magic Mode

Use `\v` to avoid escaping everything:

```vim
" Without \v (painful)
:%s/\(\w\+\)\s\+\(\w\+\)/\2 \1/g

" With \v (sane)
:%s/\v(\w+)\s+(\w+)/\2 \1/g
```

### Case Modifiers in Replacement

```vim
:%s/\v(\w+)/\u\1/g       " Capitalize first letter: foo → Foo
:%s/\v(\w+)/\U\1/g       " All uppercase: foo → FOO
:%s/\v(\w+)/\L\1/g       " All lowercase: FOO → foo
:%s/\v(\w)(\w+)/\u\1\L\2/g  " Title case: fOO → Foo
```

### Expression Substitution

```vim
" Increment all numbers
:%s/\v\d+/\=submatch(0)+1/g

" Replace with line number
:%s/^/\=line('.').' '/

" Replace with evaluated expression
:%s/\v(\d+)\+(\d+)/\=submatch(1)+submatch(2)/g   " 3+4 → 7

" Replace with system command output
:%s/DATE/\=strftime('%Y-%m-%d')/g
```

### Lookahead & Lookbehind

```vim
" Positive lookbehind: replace 'bar' only after 'foo'
:%s/\v(foo)@<=bar/baz/g

" Negative lookbehind: replace 'bar' only when NOT after 'foo'
:%s/\v(foo)@<!bar/baz/g

" Positive lookahead: replace 'foo' only before 'bar'
:%s/\vfoo(bar)@=/baz/g

" Negative lookahead: replace 'foo' only when NOT before 'bar'
:%s/\vfoo(bar)@!/baz/g
```

### Multi-Line Patterns

```vim
" Match across lines (\_. matches any char including newline)
:%s/\vstart\_.*end/replacement/g

" Delete empty function bodies
:%s/\v\{\n\s*\n\}/{}/g
```

---

## Visual Block Mode — Column Editing

### Insert/Append to Multiple Lines

```vim
<C-v>5jI// <Esc>         " Insert '//' at column on 6 lines
<C-v>5jA;<Esc>           " Append ';' at end of 6 lines
<C-v>5j$A;<Esc>          " Append at true end (varying lengths)
```

### Column Operations

```vim
<C-v>5jd                 " Delete a column
<C-v>5jr-                " Replace column with dashes
<C-v>5jc new<Esc>        " Change column content
```

### Number Sequences

```vim
" Start with:     " Result:
" 0               " 1
" 0               " 2
" 0               " 3
" 0               " 4

<C-v>3j           " Select the column of zeros
g<C-a>            " Increment sequentially: 1, 2, 3, 4
```

### Paste as Column

```vim
" Yank a column
<C-v>5jy

" Paste it as a column elsewhere
<C-v>p            " Replaces block with yanked block
```

---

## Quickfix & Location Lists

The quickfix list is Vim's way of handling lists of positions (compile errors, grep results, etc.).

### Populating Quickfix

```vim
:make                     " Run makeprg, errors go to quickfix
:grep pattern **/*.c      " Grep results go to quickfix
:Rg pattern               " fzf.vim sends results to quickfix (Alt+A, Enter)
:lmake                    " Same but uses location list (per-window)
```

### Navigating

```vim
:copen                    " Open quickfix window
:cclose                   " Close it
:cnext / :cprev           " Next/previous entry
:cfirst / :clast          " First/last entry
:cc 5                     " Jump to entry 5
```

### Operating on Quickfix Entries

```vim
:cdo s/old/new/g          " Substitute in every quickfix file
:cdo update               " Save all modified quickfix files
:cfdo %s/old/new/ge       " Substitute in each file (once per file)
```

### Quickfix History

```vim
:colder                   " Previous quickfix list
:cnewer                   " Next quickfix list
```

---

## Scripting & Expressions

### Expression Register

In insert mode, `<C-r>=` evaluates an expression:

```vim
<C-r>=42*2<CR>                    " Inserts: 84
<C-r>=strftime('%Y-%m-%d')<CR>    " Inserts: 2024-01-15
<C-r>=system('whoami')<CR>        " Inserts: username
<C-r>=expand('%:t')<CR>           " Inserts: current filename
<C-r>=line('.')<CR>               " Inserts: current line number
```

### Useful Functions

```vim
" In commands or mappings:
expand('%')           " Current file path
expand('%:t')         " Current filename only
expand('%:r')         " Filename without extension
expand('%:e')         " Extension only
expand('<cword>')     " Word under cursor
line('.')             " Current line number
col('.')              " Current column
getline('.')          " Current line content
```

### One-Liner Scripts

```vim
" Add line numbers to every line
:%s/^/\=printf('%3d ', line('.'))/

" Reverse all lines
:g/^/m0

" Remove duplicate lines (preserving order)
:g/^\(.*\)\n\1$/d

" Sum all numbers in file
:echo eval(join(map(getline(1,'$'), 'str2nr(v:val)'), '+'))
```

---

## Multi-File Operations

### Argument List

```vim
:args **/*.c              " Load all C files into arglist
:args `find . -name '*.py'`  " Load from shell command
:argdo %s/old/new/ge | update  " Substitute in all, save each
:argdo normal @q          " Run macro in all files
```

### Buffer List

```vim
:bufdo %s/old/new/ge      " Substitute across all open buffers
:bufdo update             " Save all modified buffers
```

### Quickfix-Driven

```vim
:Rg old_function          " Find all occurrences
" Select all results in fzf (Alt+A), then Enter
:cdo s/old_function/new_function/g  " Replace in all
:cfdo update              " Save all
```

---

## Performance & Profiling

### Startup Profiling

```bash
vim --startuptime /tmp/startup.log
sort -t: -k2 -n /tmp/startup.log | tail -20  # Slowest items
```

### Runtime Profiling

```vim
:profile start /tmp/profile.log
:profile func *
:profile file *
" ... do the slow thing ...
:profile pause
:qa
" Examine /tmp/profile.log for bottlenecks
```

### Large File Handling

```vim
" Auto-disable expensive features for large files
autocmd BufReadPre * if getfsize(expand('%')) > 1000000 |
  \ setlocal noswapfile noundofile |
  \ syntax off | filetype off | set nofoldenable | endif
```

### Faster Grep

```vim
" Use ripgrep as grep backend (already in this config)
set grepprg=rg\ --vimgrep\ --smart-case
set grepformat=%f:%l:%c:%m
```

### Lazy-Load Plugins

```vim
" Only load when command is used
Plug 'heavyplugin', { 'on': 'HeavyCommand' }

" Only load for specific filetypes
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
```

---

## Obscure But Lethal

### Digraphs (Special Characters)

```vim
" In insert mode: Ctrl+K then two chars
<C-k>->       " → (arrow)
<C-k>!=       " ≠
<C-k>>=       " ≥
<C-k>OK       " ✓
<C-k>XX       " ✗
<C-k>*2       " ★
:digraphs     " Show all available
```

### Abbreviation Tricks

```vim
" Auto-correct as you type
iabbrev teh the
iabbrev adn and

" Expand templates
iabbrev <buffer> main int main(int argc, char *argv[]) {<CR>return 0;<CR>}

" Trigger-based (type abbreviation + space)
iabbrev date@ <C-r>=strftime('%Y-%m-%d')<CR>
```

### The `norm` Command with Range

```vim
" Add prefix to lines 5-10
:5,10norm I// 

" Delete first word of every line
:%norm dw

" Surround every line in quotes
:%norm I"
:%norm A"
```

### Filename Modifiers

```vim
" In commands, % = current file. Modify with:
:echo expand('%')         " /home/user/src/main.c
:echo expand('%:t')       " main.c (tail)
:echo expand('%:r')       " /home/user/src/main (root, no extension)
:echo expand('%:e')       " c (extension)
:echo expand('%:p')       " /home/user/src/main.c (full path)
:echo expand('%:h')       " /home/user/src (head/directory)
:echo expand('%:t:r')     " main (tail then root = basename no ext)
```

### Read-Only Registers You Didn't Know About

```vim
" Insert last command
":<C-r>:

" Insert last search
/<C-r>/

" Insert current filename in command
:!wc -l %

" Insert word under cursor in command
:Rg <C-r><C-w>
```

### The `z` Commands (Screen Positioning)

```vim
zz            " Center current line on screen
zt            " Current line at top
zb            " Current line at bottom
zH            " Scroll half screen left
zL            " Scroll half screen right
```

---

## 🎯 The Advanced Mindset

1. **Macros are programs** — Think of them as tiny scripts. Debug them by pasting (`"qp`), editing, and re-recording.
2. **`:g` is your batch processor** — Any repetitive multi-line operation belongs in a `:g` command.
3. **Quickfix is your results list** — Populate it (grep, make, LSP), then operate on it (`:cdo`).
4. **Expressions are everywhere** — `<C-r>=`, `:s//.../\=`, `:%s//\=submatch()/` — Vim is a calculator too.
5. **Profile before optimizing** — Don't guess what's slow. Measure it.

---

*"I've been using Vim for about 2 years now, mostly because I can't figure out how to exit it." — Everyone's first year. Your second year? You can't figure out how to exit VS Code.*
