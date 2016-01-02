"=======================================================================================
" Not compatible with vi.
set nocompatible
" Set the character encoding used inside Vim.
set encoding=utf-8
" Used for opening existed file.
set fileencodings=utf-8,gbk
" Set leader key.
let mapleader=","
" Use plugin.
filetype plugin indent on
" Always show status bar.
set laststatus=2



"=======================================================================================
" Identify platforms.
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction



" function! ToggleBG()
"     let s:tbg = &background
"     " Inversion
"     if s:tbg == "dark"
"         set background=light
"     else
"         set background=dark
"     endif
" endfunction
" noremap <leader>bg :call ToggleBG()<CR>



if WINDOWS()
    " Set runtime path for Windows.
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
    "Fix menu display for Windows.
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages en_US.UTF-8
endif



"=======================================================================================
" Setting up Vundle - the Vim plug-in bundle
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let iCanHazVundle=0
endif

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'rizzatti/dash.vim'
Bundle 'davidhalter/jedi-vim'
if OSX() || LINUX()
    " Bundle 'Valloric/YouCompleteMe'
endif
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'bling/vim-airline'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'mattn/emmet-vim'
Bundle 'majutsushi/tagbar'
Bundle 'easymotion/vim-easymotion'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'snipmate'
Bundle 'AutoClose'
" syntax
Bundle 'scrooloose/syntastic'
" git plugins
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'
" c# plugins
Bundle 'tpope/vim-dispatch'
Bundle 'omniSharp/omnisharp-vim'
Bundle 'OrangeT/vim-csharp'

if iCanHazVundle == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif



"=======================================================================================
" save as sudo
ca w!! w !sudo tee "%"

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3

" Set color scheme.
colorscheme Tomorrow

if has('gui_running')
    if has("gui_gtk2")
        set guifont=Inconsolata\ 11
    elseif has("gui_macvim")
        set guifont=Monaco\ for\ Powerline:h11
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    else
        set guifont=Monaco\ for\ Powerline\ Regular:h11
    endif
else
    set guifont=Monaco\ for\ Powerline:h11
endif
set background=light
highlight clear SignColumn
set cursorline              " Highlight the current line

" Tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set incsearch               " Incremental search
set hlsearch                " Highlighted search results

syntax on                   " Syntax highlight on

set number                  " Show line numbers

" Backspace for dummies
set backspace=indent,eol,start
set linespace=0             " No extra spaces between rows
set showmatch               " Show matching brackets/parenthesis
set ignorecase              " Case insensitive search
set wildmenu                " Show list instead of just completing

" Command <Tab> completion, list matches, then longest common part, all
set wildmode=full

" Backspace and cursor keys to wrap.
set whichwrap=b,s,h,l,<,>,[,]

" Storage setting {

    " Better backup, swap and redo storage
    set directory=~/.vim/dirs/tmp
    " Make backup files
    set backup
    set backupdir=~/.vim/dirs/backups
    set undofile
    set undodir=~/.vim/dirs/undos
    set viminfo+=n~/.vim/dirs/viminfo

    " Create needed directories
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
" }

" ctrlp cache dir
let g:ctrlp_cache_dir = '~/.vim/dirs/cache/ctrlp'


" plugin settings
" NERDTree
let g:NERDTreeWinPos="right"



"=======================================================================================
" Customized Mapping
"
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

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

noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l



" Auto commands
autocmd BufWritePre * :%s/\s\+$//ge    " Delete trial spaces

" Settings for Common Lisp.
if WINDOWS()
 let g:slimv_swank_cmd = '!start "C:/Program Files (x86)/LispCabinet/bin/ccl/wx86cl.exe" -l "C:/Program Files (x86)/LispCabinet/site/lisp/slime/start-swank.lisp"'
endif

" Tabularize
nnoremap <leader>t : Tabularize /



" NERDTree
let NERDTreeIgnore=['\.vim$', '\.pyc$']



" Vim-airline
let g:airline_powerline_fonts = 1



" Bufexplorer
nnoremap <silent> <F11> :BufExplorer<CR>
nnoremap <silent> <m-F11> :BufExplorerHorizontalSplit<CR>
nnoremap <silent> <c-F11> :BufExplorerVerticalSplit<CR>



"=======================================================================================
autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc
