"Install plugins if required.
call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf'
Plug 'kana/vim-operator-user'
Plug 'preservim/NERDTree'
Plug 'rhysd/vim-clang-format'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'valloric/youcompleteme'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

"Spaces are easier to type then colons.
nnoremap <space> :

"Easily edit and source the vimrc file.
nnoremap <leader>ev :tabnew $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Add abbreviations.
iabbrev @@ mgubbi1@jhu.edu

"Line numbers are always helpful.
set nu

"Reduce tab width to 4.
set tabstop=4

"Clearly demarcate whitespace characters (courtesy of praveenv253).
set listchars=extends:»,precedes:«,tab:·\ ,trail:◀
set list

"Enable filetype detection, loading the plugin for the filetype, and the
"correct indentation style for the filetype.
filetype plugin indent on

"Configure clang indentation to format on saving.
let g:clang_format#auto_format=1
let g:clang_format#detect_style_file=1

"Indent files on saving.
autocmd BufWritePre,BufRead *.html :normal gg=G
"autocmd BufWritePre,BufRead *.xml %!xmllint --format -
autocmd FileType c,cc,cpp,h,hpp setlocal tabstop=2 shiftwidth=2 expandtab autoindent cindent smarttab
autocmd FileType xml setlocal tabstop=2 shiftwidth=2 expandtab autoindent smarttab

"Configure airline and other visual aspects to your tastes.
colo newproggie
let g:airline_theme='newproggie'

"For exceeding 80 characters in a line"
if exists('+colorcolumn')
	set colorcolumn=81
else
	au BufWinEnter * let w:m2=matchadd('ColorColumn', '\%>81v.\+', -1)
endif

"Fold all lines of the same or higher indent level...
set foldmethod=indent
"... but not unless asked to do so.
set nofoldenable

"Searches are easier when highlighted and intelligently case insensitive...
set hlsearch incsearch ignorecase smartcase

"... and vertically centered.
nnoremap n nzz
nnoremap N Nzz

"New windows are better off to the right and below existing windows...
set splitright splitbelow

"... and shifting between windows should be easier than it is by default.
nnoremap <C-Left>  <C-w><Left>
nnoremap <C-Right> <C-w><Right>
nnoremap <C-Up>    <C-w><Up>
nnoremap <C-Down>  <C-w><Down>

"Toggling paste mode comes in handy every now and then.
set pastetoggle=<F2>

"Certain filetypes must be treated as others unless previously specified
"otherwise.
augroup filetypedetect
	au BufRead,BufNewFile *.launch setfiletype xml
augroup END

"Certain filetypes are not meant to be opened in Vim.
set wildignore=*.o,*~,*.pyc,*.git,*.pdf

"Adding ctags related shortcuts"
map <C-\> :tab split<Enter>:exec("tag ".expand("<cword>"))<Enter>
map <C-]> :vsp <Enter>:exec("tag ".expand("<cword>"))<Enter>
