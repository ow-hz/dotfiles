" general settings {{{
set nocompatible
filetype plugin indent on
set fileencoding=utf-8
set fileencodings=utf-8
set scrolloff=3
set laststatus=2
let mapleader=','
syntax on
" set fileformats=unix,dos,mac
" }}}


" vim-pulg {{{
let iCanHazPlug=1
let plug_vim=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_vim)
    echo "Installing vim-plug...\n"
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let iCanHazPlug=0
endif
call plug#begin('~/.vim/pluged')
" plugins
Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular', { 'on': 'Tagbar' }
Plug 'rizzatti/dash.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
" Plug 'AutoClose'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/grep.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bronson/vim-trailing-whitespace'
" Plug 'python-mode/python-mode'
" Plug 'ivanov/vim-ipython'
" Plug 'ntpeters/vim-better-whitespace'
"" syntax check
Plug  'scrooloose/syntastic'
" Plug 'vim-scripts/CSApprox'
Plug 'yggdroot/indentLine'
Plug 'vim-scripts/bufexplorer.zip'
"" theme
Plug 'altercation/vim-colors-solarized'
"" snippets
Plug 'marcweber/vim-addon-mw-utils'| Plug 'tomtom/tlib_vim'| Plug 'garbas/vim-snipmate'
"" fonts and icons
Plug  'ryanoasis/vim-devicons'
"" marks
Plug  'kshenoy/vim-signature'
"*****************************************************************************
"" plug-vim install customized packages
"*****************************************************************************
"" Lisp Bundle
Plug 'vim-scripts/slimv.vim'
"" Salt files
" Plug 'saltstack/salt-vim'
" Plug 'stephpy/vim-yaml'
"" Python Bundle
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'unterzicht/vim-virtualenv'
"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Plug  'ternjs/tern_for_vim'
"" HTML Bundle
" Plug 'amirh/HTML-AutoCloseTag', {'for': 'html'}
" Plug 'hail2u/vim-css3-syntax', {'for': 'html'}
" Plug 'gorodinskiy/vim-coloresque', {'for': 'html'}
" Plug 'tpope/vim-haml', {'for': 'html'}
" Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'plasticboy/vim-markdown'
call plug#end()
if iCanHazPlug == 0
    echo "Installing vim plugins...\n"
    :PlugInstall
endif
" }}}


" ui settings {{{
set ruler
set number
set incsearch
set hlsearch
" hilight the cursor line
set cursorline
" highlight clear SignColumn
" color scheme
colorscheme solarized

if has("gui_running")
    set guifont=MesloLGMDZ_Nerd_Font
endif
" }}}


" customized functions {{{
function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
" }}}


" general mappings {{{
" set arrow key disabled for moving
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>
" split navagation
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
" toggle background
noremap <leader>bg :call ToggleBG()<CR>
" }}}


" specific filetype settings {{{
" python {{{
augroup filetype_python
	autocmd BufRead *.py map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>
	autocmd FileType python map <leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
	autocmd FileType python setlocal foldmethod=indent
	" tabs and space
	autocmd FileType python set expandtab
	autocmd FileType python set tabstop=4
	autocmd FileType python set softtabstop=4
	autocmd FileType python set shiftwidth=4
augroup end
" }}}

" vim {{{
augroup filetype filetype_vim
       	autocmd FileType vim setlocal foldmethod=marker
augroup end
" }}}

augroup file_js
augroup end
" }}}


" others {{{
" }}}


"=======================================================================================
" save as sudo
ca w!! w !sudo tee "%"

"=======================================================================================


" Backspace for dummies
set backspace=indent,eol,start
set linespace=0             " No extra spaces between rows
set showmatch               " Show matching brackets/parenthesis
" set ignorecase              " Case insensitive search
set wildmenu                " Show list instead of just completing

" Command <Tab> completion, list matches, then longest common part, all
set wildmode=full

" Backspace and cursor keys to wrap.
set whichwrap=b,s,h,l,<,>,[,]


" ctrlp cache dir
" let g:ctrlp_cache_dir = '~/.vim/dirs/cache/ctrlp'


" plugin settings
" NERDTree
let g:NERDTreeWinPos="left"
" let g:NERDTreeHighlightCursorline = 1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


"=======================================================================================
" Customized Mapping
"

" Buffer Move
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" Keep the current visual block selection active after changing indent.
vmap > >gv
vmap < <gv

" In insert mode, delete from the current cursor to end-of-line
inoremap <C-Del> <C-\><C-O>D

" No highlight search
nnoremap <leader><space> :noh<cr>

" Mapping for gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" Using <space> for folding toggle
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>


" Settings for Common Lisp.
" if WINDOWS()
"  " let g:slimv_swank_cmd = '!start "C:/Program Files (x86)/LispCabinet/bin/ccl/wx86cl.exe" -l "C:/Program Files (x86)/LispCabinet/site/lisp/slime/start-swank.lisp"'
" endif



" NERDTree
" let NERDTreeIgnore=['\.vim$', '\.pyc$']

" Solarized
" let g:solarized_termcolors=256



" " Jedi-vim
" let g:jedi#goto_command             = ''
" let g:jedi#goto_assignments_command = ''
" let g:jedi#rename_command           = ''
" let g:jedi#show_call_signatures     = 2
let g:jedi#popup_select_first = 0
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"


" Vim-airline
let g:airline_powerline_fonts = 1



" Syntastic
let g:syntastic_python_checkers=['python', 'flake8']
let g:syntastic_always_populate_loc_list = 1



" Bufexplorer
nnoremap <silent> <F11>   : BufExplorer<CR>
nnoremap <silent> <m-F11> : BufExplorerHorizontalSplit<CR>
nnoremap <silent> <c-F11> : BufExplorerVerticalSplit<CR>



"=======================================================================================
" Autocmd
autocmd BufWritePre * :%s/\s\+$//ge    " Delete trial spaces
autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc
" autocmd FileType javascript nnoremap <buffer><localleader>c I//<esc>
" autocmd FileType python nnoremap <buffer><localleader>c I#<esc>
" autocmd BufWrite * :sleep 2000m



"=======================================================================================
" onoremap ih :<c-u> execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>


"=======================================================================================
" key mappings
nnoremap <leader>t :Tabularize /
" nnoremap <leader>gd :YcmCompleter GoTo<CR>
" nnoremap <leader>gr :YcmCompleter GoToReferences<CR>



"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden


" *****************************************************************************
"" Customized Plugin Settings
" *****************************************************************************
" jedi-vim
let g:jedi#popup_on_dot = 1
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" don`t use popup docs
autocmd FileType python setlocal completeopt-=preview
let g:indentLine_char = '┆'
let g:sls_use_jinja_syntax = 1"}}}
