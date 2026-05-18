# 🎨 Themes & Appearance

> How to select, switch, and customize the look of your Vim.

---

## Quick Switch

Open your vimrc (`<leader>ev`) and change one line:

```vim
let g:dotvim_theme = 'solarized8'
```

Save and reload (`:source $MYVIMRC` or `<leader>sv`).

---

## Available Themes

| Theme | Value | Vibe |
|-------|-------|------|
| **Solarized** (default) | `'solarized8'` | The classic blue-tinted dark theme. Precision-engineered contrast. |
| **Gruvbox** | `'gruvbox'` | Warm, retro, earthy tones. Easy on the eyes for long sessions. |
| **Catppuccin Mocha** | `'catppuccin_mocha'` | Pastel, modern, soft. Popular in the Neovim community. |
| **Everforest** | `'everforest'` | Soft green, nature-inspired. Low contrast, high comfort. |
| **NewProggie** | `'newproggie'` | The original theme from this repo. Minimal, dark, no frills. |

---

## How It Works

The theme system uses a single variable `g:dotvim_theme` that controls:

1. **Colorscheme** — which color palette loads
2. **Airline theme** — statusbar automatically matches
3. **Plugin-specific settings** — contrast levels, highlight groups, etc.

```vim
" In vimrc — this is all you need to change:
let g:dotvim_theme = 'solarized8'

" The rest is handled automatically:
" - colorscheme loads
" - airline theme matches
" - transparency applies (if enabled)
```

---

## Transparency

Terminal transparency is **on by default**. Your terminal's background (wallpaper, blur, opacity) shows through Vim.

### Disable Transparency (Use Solid Background)

```vim
let g:dotvim_transparent = 0
```

### Enable Transparency (Default)

```vim
let g:dotvim_transparent = 1
```

When transparent, these highlight groups have their background cleared:
- `Normal`, `NonText`, `LineNr`, `SignColumn`, `EndOfBuffer`, `Folded`, `CursorLineNr`

> **Note**: Transparency depends on your terminal emulator supporting it (most modern ones do: Alacritty, Kitty, WezTerm, Windows Terminal, iTerm2).

---

## Light Mode

Some themes support light backgrounds. To switch:

```vim
set background=light
```

Works well with:
- `solarized8` — the iconic solarized light palette
- `gruvbox` — warm light variant
- `everforest` — soft green light

Add this line **before** the `colorscheme` loads (or just put it near the top of your vimrc).

---

## Try a Theme Without Committing

Switch temporarily in a running session:

```vim
:colorscheme gruvbox
:colorscheme solarized8
:colorscheme catppuccin_mocha
:colorscheme everforest
:colorscheme newproggie
```

This lasts until you close Vim. To make it permanent, update `g:dotvim_theme` in vimrc.

---

## Preview All Installed Themes

```vim
" Cycle through all available colorschemes
:colorscheme <Tab>
```

Press `<Tab>` repeatedly to cycle through options. Press `<Enter>` to apply.

---

## Adding Your Own Theme

1. Install via vim-plug — add to the plugins section in vimrc:

```vim
Plug 'folke/tokyonight.nvim'    " Example: Tokyo Night
```

2. Run `:PlugInstall`

3. Set it:

```vim
let g:dotvim_theme = 'tokyonight'
```

4. (Optional) Add airline matching in the theme selection block:

```vim
elseif g:dotvim_theme ==# 'tokyonight'
  let g:airline_theme = 'tokyonight'
```

---

## Recommended Terminal + Theme Pairings

| Terminal | Theme | Why |
|----------|-------|-----|
| Alacritty + transparency | `solarized8` | Clean blue tones with wallpaper bleed |
| Kitty (opaque) | `gruvbox` | Warm and cozy, no transparency needed |
| Windows Terminal + acrylic | `catppuccin_mocha` | Pastels pop against frosted glass |
| tmux + minimal | `everforest` | Low contrast, easy on eyes in splits |
| Any terminal, SSH session | `newproggie` | Minimal, works in 256-color mode |

---

## Font Recommendations

Themes look best with a proper Nerd Font (required for devicons):

| Font | Style |
|------|-------|
| **JetBrains Mono Nerd** | Clean, modern, great ligatures |
| **FiraCode Nerd** | Popular, excellent ligatures |
| **Hack Nerd** | Classic monospace, no ligatures |
| **Iosevka Nerd** | Narrow, fits more columns |
| **CaskaydiaCove Nerd** | Microsoft's Cascadia Code + Nerd glyphs |

Install from: https://www.nerdfonts.com/font-downloads

---

*"A good theme is one you forget is there. It should serve the code, not compete with it."*
