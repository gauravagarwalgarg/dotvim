# Performance: Vim vs VS Code

> Numbers don't lie. Here's why this setup feels instant.

## Startup Time

| Editor | Cold Start | Warm Start |
|--------|-----------|------------|
| **dotvim** | ~80ms | ~40ms |
| VS Code | ~3000ms | ~1500ms |
| IntelliJ | ~8000ms | ~4000ms |
| Neovim (LazyVim) | ~120ms | ~60ms |

Measure yourself:

```bash
# Vim startup time
vim --startuptime /tmp/vim-startup.log +qa && tail -1 /tmp/vim-startup.log

# VS Code (rough: time from launch to responsive)
time code --wait --new-window /dev/null
```

## Memory Usage

| Editor | Idle | 10 files open | Large file (50MB) |
|--------|------|---------------|-------------------|
| **dotvim** | ~30MB | ~45MB | ~80MB |
| VS Code | ~350MB | ~550MB | Crashes or 1.2GB |
| IntelliJ | ~800MB | ~1.2GB | 2GB+ |

## Why It's Fast

### 1. No Electron

VS Code runs Chromium (a full browser engine) to render text. That's 300MB before you type a character. Vim renders directly to your terminal emulator.

### 2. Async Everything

| Operation | dotvim | VS Code |
|-----------|--------|---------|
| Completion | Async (never blocks) | Async |
| Diagnostics | Async (vim-lsp) | Async |
| File search | fzf (C, blazing fast) | ripgrep (same, but wrapped in Electron) |
| Git gutter | Async (gitgutter) | Async |
| Build | Async (asyncrun) | Async (task runner) |

Both are async, but Vim's event loop is native C, not JavaScript.

### 3. Lazy Loading

```vim
" These plugins don't load until you use them:
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermToggle', 'FloatermNew'] }
```

If you never open the file explorer in a session, it never loads. VS Code loads all extensions at startup.

### 4. No Telemetry, No Updates, No Background Processes

VS Code runs:
- Extension host (separate process)
- TypeScript server
- Git integration service
- Telemetry reporter
- Update checker
- Marketplace API calls

Vim runs: vim. That's it.

### 5. Regex Engine Selection

```vim
set regexpengine=1  " Older, faster engine for syntax highlighting
```

Vim's newer regex engine (NFA) is more correct but slower for syntax. The old engine handles 99% of highlighting cases faster.

## What VS Code Does Better (Honestly)

| Feature | VS Code Advantage |
|---------|-------------------|
| Visual debugging | Breakpoints, watch variables, call stack UI |
| Extension marketplace | One-click install, ratings, millions of extensions |
| Remote containers | Dev Containers with Docker integration |
| Jupyter notebooks | Native cell execution |
| Settings UI | GUI for configuration |
| Live Share | Real-time collaboration |
| First-time UX | Works out of the box, no learning curve |

## What Vim Does Better

| Feature | Vim Advantage |
|---------|--------------|
| Startup speed | 40ms vs 3000ms |
| Memory | 30MB vs 350MB |
| Large files | Handles 100MB+ without blinking |
| Remote editing | SSH + vim = full IDE, zero latency |
| Batch editing | Macros + :g = unlimited power |
| Customization depth | Every single behavior is configurable |
| Stability | No random "Extension host terminated" crashes |
| Terminal integration | IS the terminal |
| Resource usage | Runs on a 512MB VPS, Raspberry Pi, embedded boards |
| Longevity | Your config works in 10 years. VS Code extensions break monthly |

## Performance Tips for This Config

### If Vim feels slow, check:

```vim
" Profile startup
vim --startuptime /tmp/profile.log
" Sort by time:
sort -t: -k2 -n /tmp/profile.log | tail -20

" Profile a slow operation
:profile start /tmp/vim-profile.log
:profile func *
:profile file *
" ... do the slow thing ...
:profile stop
```

### Common culprits:

| Issue | Fix |
|-------|-----|
| Slow syntax on large files | `:set synmaxcol=200` limits highlight columns |
| LSP slow on huge projects | Add `.lsp-settings.json` to limit workspace scope |
| Slow startup | Check `:PlugStatus` for failing plugins |
| Sluggish scrolling | Virtual text is disabled (`lsp_diagnostics_virtual_text_enabled = 0`) |
| clang-format hangs | Auto-format disabled for files > 10k lines |
