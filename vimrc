" =============================================================================
" `DOTVIM`: A Modern Vim Configuration
" Author: Gaurav Agarwal
" Philosophy: IDE-grade intelligence with Vim-grade speed.
" =============================================================================

" ─── BOOTSTRAP ───────────────────────────────────────────────────────────────
" Auto-install vim-plug if not present
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ─── PLUGINS ─────────────────────────────────────────────────────────────────
call plug#begin('~/.vim/plugged')

" --- Completion & LSP (the brain) ---
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" --- Fuzzy Finding (Ctrl+P on steroids) ---
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- File Explorer (lazy: opens on demand) ---
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'ryanoasis/vim-devicons'

" --- Git Integration ---
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" --- Editing Superpowers ---
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'

" --- Syntax & Language Support ---
Plug 'sheerun/vim-polyglot'
Plug 'rhysd/vim-clang-format'
Plug 'andymass/vim-matlab'

" --- UI & Aesthetics ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'gruvbox-community/gruvbox'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'sainnhe/everforest'
Plug 'lifepillar/vim-solarized8'
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'

" --- Navigation & Motion ---
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

" --- Snippets ---
Plug 'honza/vim-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" --- Utilities (lazy-loaded) ---
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'tpope/vim-dispatch'
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-floaterm', { 'on': ['FloatermToggle', 'FloatermNew', 'FloatermNext'] }

call plug#end()

" ─── GENERAL SETTINGS ────────────────────────────────────────────────────────
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set hidden                      " Allow switching buffers without saving
set updatetime=250              " Faster CursorHold events (gitgutter, LSP)
set timeoutlen=500              " Mapping timeout
set ttimeoutlen=10              " Key code timeout (snappy escape)
set mouse=a                     " Mouse support in all modes
set clipboard=unnamedplus       " System clipboard integration
set signcolumn=yes              " Always show sign column (no layout shift)
set scrolloff=8                 " Keep 8 lines visible above/below cursor
set sidescrolloff=8             " Keep 8 columns visible left/right
set shortmess+=c                " Don't pass messages to completion menu
set completeopt=menuone,noinsert,noselect  " Better completion behavior
set belloff=all                 " Silence all bells

" ─── APPEARANCE ──────────────────────────────────────────────────────────────
syntax enable
set termguicolors               " True color support
set background=dark

" Theme selection change this one line to switch themes:
"   solarized8, gruvbox, catppuccin_mocha, everforest, newproggie
let g:dotvim_theme = get(g:, 'dotvim_theme', 'solarized8')

if g:dotvim_theme ==# 'gruvbox'
  let g:gruvbox_contrast_dark = 'medium'
  let g:gruvbox_invert_selection = 0
elseif g:dotvim_theme ==# 'everforest'
  let g:everforest_background = 'medium'
elseif g:dotvim_theme ==# 'solarized8'
  let g:solarized_extra_hi_groups = 1
endif

silent! execute 'colorscheme ' . g:dotvim_theme

" Terminal transparency let your terminal background bleed through.
" Set to 0 to disable (use colorscheme's own background).
let g:dotvim_transparent = get(g:, 'dotvim_transparent', 1)

if g:dotvim_transparent
  highlight Normal      guibg=NONE ctermbg=NONE
  highlight NonText     guibg=NONE ctermbg=NONE
  highlight LineNr      guibg=NONE ctermbg=NONE
  highlight SignColumn  guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight Folded      guibg=NONE ctermbg=NONE
  highlight CursorLineNr guibg=NONE ctermbg=NONE
endif

set number                      " Absolute line numbers
set cursorline                  " Highlight current line
set showmatch                   " Highlight matching brackets
set laststatus=2                " Always show statusline
set noshowmode                  " Airline handles mode display
set cmdheight=1                 " Command line height

" Color column at 125 characters
set colorcolumn=125

" Whitespace visualization
set listchars=extends:»,precedes:«,tab:→\ ,trail:·,nbsp:␣
set list

" ─── INDENTATION ─────────────────────────────────────────────────────────────
set tabstop=4                   " Tab width
set shiftwidth=4                " Indent width
set softtabstop=4               " Soft tab width
set expandtab                   " Spaces over tabs
set smartindent                 " Smart auto-indentation
set autoindent                  " Maintain indent level
filetype plugin indent on

" Per-filetype overrides
augroup FileTypeSettings
  autocmd!
  autocmd FileType c,cpp,cuda,h,hpp     setlocal tabstop=2 shiftwidth=2 cindent
  autocmd FileType cmake                setlocal tabstop=2 shiftwidth=2
  autocmd FileType xml,html,json,yaml   setlocal tabstop=2 shiftwidth=2
  autocmd FileType python               setlocal tabstop=4 shiftwidth=4
  autocmd FileType go                   setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType matlab               setlocal tabstop=4 shiftwidth=4 noexpandtab
  autocmd FileType make                 setlocal noexpandtab
  autocmd FileType markdown             setlocal wrap linebreak
augroup END

" ─── SEARCH ──────────────────────────────────────────────────────────────────
set hlsearch                    " Highlight search results
set incsearch                   " Incremental search
set ignorecase                  " Case insensitive by default
set smartcase                   " Case sensitive if uppercase present

" Center search results vertically
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear search highlighting
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" ─── SPLITS & WINDOWS ────────────────────────────────────────────────────────
set splitright                  " New vertical splits to the right
set splitbelow                  " New horizontal splits below

" Navigate splits with Ctrl+hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Resize splits with arrow keys
nnoremap <silent> <C-Up>    :resize +3<CR>
nnoremap <silent> <C-Down>  :resize -3<CR>
nnoremap <silent> <C-Left>  :vertical resize -3<CR>
nnoremap <silent> <C-Right> :vertical resize +3<CR>

" ─── KEY MAPPINGS ────────────────────────────────────────────────────────────
" Leader key
let mapleader = " "
let maplocalleader = ","

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Edit and source vimrc
nnoremap <leader>ev :tabnew $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Buffer navigation (like VS Code tabs)
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Move lines up/down (like Alt+Up/Down in VS Code)
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Duplicate line (like Ctrl+Shift+D in VS Code)
nnoremap <leader>d :t.<CR>

" Select all
nnoremap <leader>a ggVG

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv

" Center cursor after page jumps
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz

" Yank to end of line (consistent with D and C)
nnoremap Y y$

" Don't overwrite register on paste in visual mode
vnoremap p "_dP

" Quick terminal (like VS Code integrated terminal)
nnoremap <leader>t :FloatermToggle<CR>
tnoremap <Esc> <C-\><C-n>

" ─── FZF (Ctrl+P, Ctrl+Shift+F equivalents) ─────────────────────────────────
nnoremap <C-p>      :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fs :Snippets<CR>

let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.80 } }
let g:fzf_preview_window = ['right,50%', 'ctrl-/']

" ─── NERDTREE (File Explorer like VS Code sidebar) ───────────────────────────
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', '\.pyc$', '__pycache__', 'node_modules']
let g:NERDTreeWinSize = 35

" Close vim if NERDTree is the only window remaining
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 &&
  \ exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" ─── LSP CONFIGURATION ──────────────────────────────────────────────────────
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  " Go to definition (like F12 in VS Code)
  nmap <buffer> gd <plug>(lsp-definition)
  " Peek definition (like Alt+F12 in VS Code)
  nmap <buffer> gD <plug>(lsp-peek-definition)
  " Go to declaration
  nmap <buffer> gC <plug>(lsp-declaration)
  " Find references (like Shift+F12 in VS Code)
  nmap <buffer> gr <plug>(lsp-references)
  " Find implementations
  nmap <buffer> gi <plug>(lsp-implementation)
  " Type definition
  nmap <buffer> gt <plug>(lsp-type-definition)
  " Rename symbol (like F2 in VS Code)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  " Code actions (like Ctrl+. in VS Code)
  nmap <buffer> <leader>ca <plug>(lsp-code-action)
  " Hover documentation (like hovering in VS Code)
  nmap <buffer> K <plug>(lsp-hover)
  " Signature help
  imap <buffer> <C-k> <plug>(lsp-signature-help)
  " Diagnostics navigation (like F8 in VS Code)
  nmap <buffer> [d <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]d <plug>(lsp-next-diagnostic)
  " Format document (like Shift+Alt+F in VS Code)
  nmap <buffer> <leader>cf <plug>(lsp-document-format)
  " Document symbols (like Ctrl+Shift+O in VS Code)
  nmap <buffer> <leader>cs <plug>(lsp-document-symbol)
  " Workspace symbols (like Ctrl+T in VS Code)
  nmap <buffer> <leader>cw <plug>(lsp-workspace-symbol)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" LSP settings
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 1
let g:lsp_diagnostics_virtual_text_enabled = 0  " Disabled: slows scrolling on large files
let g:lsp_document_highlight_enabled = 1
let g:lsp_fold_enabled = 0
let g:lsp_semantic_enabled = 1
let g:lsp_inlay_hints_enabled = 1

" Supported language servers (auto-installed via :LspInstallServer):
"   C/C++      → clangd
"   Python     → pyright / pylsp
"   Go         → gopls
"   Rust       → rust-analyzer
"   JavaScript → typescript-language-server
"   HTML/CSS   → vscode-html-language-server / vscode-css-language-server
"   Bash       → bash-language-server
"   YAML       → yaml-language-server
"   JSON       → vscode-json-language-server
"   LaTeX      → texlab
"   Dockerfile → dockerfile-language-server
"   Terraform  → terraform-ls
"   CMake      → cmake-language-server

" ─── ASYNCOMPLETE ────────────────────────────────────────────────────────────
" Tab completion (like VS Code Tab to accept)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? asyncomplete#close_popup() : "\<CR>"

" ─── GIT (like VS Code Source Control) ───────────────────────────────────────
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git log --oneline -20<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gb :Git blame<CR>

" GitGutter
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▁'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▎'
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)

" ─── AIRLINE ─────────────────────────────────────────────────────────────────
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled = 1
" Airline theme follows colorscheme
if g:dotvim_theme ==# 'solarized8'
  let g:airline_theme = 'solarized'
elseif g:dotvim_theme ==# 'gruvbox'
  let g:airline_theme = 'gruvbox'
elseif g:dotvim_theme ==# 'everforest'
  let g:airline_theme = 'everforest'
else
  let g:airline_theme = 'dark'
endif

" ─── CLANG-FORMAT ────────────────────────────────────────────────────────────
" Auto-format only on files < 10000 lines (large files are slow)
let g:clang_format#auto_format = 0
let g:clang_format#detect_style_file = 1
augroup ClangFormatOnSave
  autocmd!
  autocmd BufWritePre *.c,*.cpp,*.h,*.hpp
    \ if line('$') < 10000 | ClangFormat | endif
augroup END

" ─── UNDOTREE ────────────────────────────────────────────────────────────────
nnoremap <leader>u :UndotreeToggle<CR>

" Persistent undo (survives vim restarts)
if has('persistent_undo')
  let target_path = expand('~/.vim/undodir')
  if !isdirectory(target_path)
    call mkdir(target_path, 'p', 0700)
  endif
  let &undodir = target_path
  set undofile
endif

" ─── FLOATERM (Integrated Terminal) ──────────────────────────────────────────
let g:floaterm_width = 0.85
let g:floaterm_height = 0.80
let g:floaterm_title = ' Terminal ($1/$2) '
let g:floaterm_borderchars = '─│─│╭╮╯╰'
nnoremap <F7> :FloatermNew<CR>
nnoremap <F8> :FloatermNext<CR>
tnoremap <F7> <C-\><C-n>:FloatermNew<CR>
tnoremap <F8> <C-\><C-n>:FloatermNext<CR>

" ─── EASYMOTION ──────────────────────────────────────────────────────────────
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-s2)
nmap <leader>j <Plug>(easymotion-j)
nmap <leader>k <Plug>(easymotion-k)

" ─── INDENTLINE ──────────────────────────────────────────────────────────────
let g:indentLine_char = '│'
let g:indentLine_first_char = '│'
let g:indentLine_showFirstIndentLevel = 1

" ─── HIGHLIGHTED YANK ────────────────────────────────────────────────────────
let g:highlightedyank_highlight_duration = 250

" ─── ASYNCRUN (Build & Run) ──────────────────────────────────────────────────
nnoremap <leader>mk :AsyncRun make<CR>
nnoremap <leader>mb :AsyncRun cmake --build build<CR>
nnoremap <leader>mr :AsyncRun make run<CR>
let g:asyncrun_open = 10  " Open quickfix window with 10 lines

" ─── WILDMENU & FILE IGNORES ────────────────────────────────────────────────
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*.obj,*~,*.pyc,*.pyo
set wildignore+=*.git/*,*.hg/*,*.svn/*
set wildignore+=*.pdf,*.ipynb
set wildignore+=*/__pycache__/*,*/node_modules/*
set wildignore+=*.so,*.dll,*.exe
set wildignore+=*/build/*,*/dist/*,*/target/*

" ─── FOLDING ─────────────────────────────────────────────────────────────────
set foldmethod=indent
set foldlevelstart=99           " Start with all folds open
set nofoldenable                " Don't fold by default
nnoremap <leader>z za           " Toggle fold under cursor

" ─── BACKUP & SWAP ───────────────────────────────────────────────────────────
set nobackup
set nowritebackup
set noswapfile                  " Git handles versioning; swap files are noise

" ─── CTAGS ───────────────────────────────────────────────────────────────────
" Jump to tag in new tab
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Jump to tag in vertical split
map <leader>] :vsp<CR>:exec("tag ".expand("<cword>"))<CR>

" ─── FILETYPES ───────────────────────────────────────────────────────────────
augroup filetypedetect
  autocmd!
  au BufRead,BufNewFile *.launch setfiletype xml
  au BufRead,BufNewFile *.dts,*.dtsi setfiletype dts
  au BufRead,BufNewFile *.bb,*.bbappend,*.bbclass setfiletype bitbake
  au BufRead,BufNewFile Dockerfile* setfiletype dockerfile
  au BufRead,BufNewFile Jenkinsfile setfiletype groovy
  au BufRead,BufNewFile *.tf,*.tfvars setfiletype terraform
  au BufRead,BufNewFile *.m setfiletype matlab
  au BufRead,BufNewFile *.astro setfiletype astro
  au BufRead,BufNewFile *.tsx setfiletype typescriptreact
  au BufRead,BufNewFile *.jsx setfiletype javascriptreact
  au BufRead,BufNewFile *.toml setfiletype toml
  au BufRead,BufNewFile *.conf setfiletype conf
  au BufRead,BufNewFile *.service,*.timer,*.socket setfiletype systemd
  au BufRead,BufNewFile Vagrantfile setfiletype ruby
  au BufRead,BufNewFile Makefile* setlocal noexpandtab
  au BufRead,BufNewFile *.proto setfiletype proto
augroup END

" ─── ABBREVIATIONS ───────────────────────────────────────────────────────────
iabbrev @@ gauravagarwalgarg@gmail.com
iabbrev teh the
iabbrev adn and

" ─── PERFORMANCE ─────────────────────────────────────────────────────────────
set lazyredraw                  " Don't redraw during macros
set ttyfast                     " Faster terminal connection
set regexpengine=1              " Older regex engine (faster for syntax)
