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



function! ToggleBG()
    let s:tbg = &background
    " Inversion
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <leader>bg :call ToggleBG()<CR>



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
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'scrooloose/nerdtree'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'mattn/emmet-vim'
Bundle 'majutsushi/tagbar'
Bundle 'easymotion/vim-easymotion'
Bundle 'vim-scripts/bufexplorer.zip'
Bundle 'altercation/vim-colors-solarized'
Bundle 'snipmate'
Bundle 'AutoClose'
Bundle 'klen/python-mode'
Bundle 'unterzicht/vim-virtualenv'
Bundle 'mbbill/undotree'
Bundle 'plasticboy/vim-markdown'
Bundle 'Valloric/YouCompleteMe'
" syntax
Bundle 'scrooloose/syntastic'
" git plugins
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'
" c# plugins
" Bundle 'tpope/vim-dispatch'
" Bundle 'omniSharp/omnisharp-vim'
" Bundle 'OrangeT/vim-csharp'
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/vimshell.vim'
Bundle 'ryanoasis/vim-devicons'


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



"=======================================================================================
" Colorscheme
colorscheme solarized
set background=light

if has('gui_running')
    if has("gui_macvim")
        set guifont=Monaco\ for\ Powerline:h10
    elseif has("gui_win32")
        set guifont=Consolas:h10
    endif
else
    set guifont=Monaco\ for\ Powerline:h10
endif

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
" let g:NERDTreeHighlightCursorline = 1
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif


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

" disable arrow keys
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" Settings for Common Lisp.
if WINDOWS()
 let g:slimv_swank_cmd = '!start "C:/Program Files (x86)/LispCabinet/bin/ccl/wx86cl.exe" -l "C:/Program Files (x86)/LispCabinet/site/lisp/slime/start-swank.lisp"'
endif



" NERDTree
let NERDTreeIgnore=['\.vim$', '\.pyc$']



" Python-mode
" let g:pymode_run_bind      = '<leader>r'
let g:pymode_motion          = 0
let g:pymode_rope            = 0
let g:pymode_rope_completion = 0
let g:pymode_doc             = 0
let g:pymode_run             = 0
let g:pymode_lint            = 0
" Refactoring mapping
" let g:pymode_rope_goto_definition_bind = '<leader>d'
" let g:pymode_rope_rename_bind          = '<leader>r'
" let g:pymode_rope_rename_module_bind   = '<leader>rm'



" Solarized
" let g:solarized_termcolors=256



" " Jedi-vim
" let g:jedi#goto_command             = ''
" let g:jedi#goto_assignments_command = ''
" let g:jedi#rename_command           = ''
" let g:jedi#show_call_signatures     = 2



" Youcompleteme



" Vim-airline
let g:airline_powerline_fonts = 1



" Syntastic
let g:syntastic_python_checkers = ['flake8', 'mccabe']
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
" Vimscript file settings{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker

augroup END
"}}}



"=======================================================================================
" key mappings
nnoremap <leader>t :Tabularize /
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
