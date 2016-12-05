"=======================================================================================
" Not compatible with vi.
set nocompatible
" Set the character encoding used inside Vim.
" set encoding=utf-8
" Used for opening existed file.
" Set leader key.
" Use plugin.
filetype plugin indent on


" general settings
"
" ui settings
" plugins settings

" customized functions

" customized general mappings
" split navagation
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>

" set arrow keys disabled
noremap <c-k> <c-w>k
noremap <c-j> <c-w>j
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l

" filetype settings
autocmd FileType python map <leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
augroup file_python
augroup end

augroup file_js
augroup end
"
" others

"*****************************************************************************
"" vim-plug
"*****************************************************************************
let iCanHazPlug=1

let plug_vim=expand('~/.vim/autoload/plug.vim')

if !filereadable(plug_vim)
    echo "Installing vim-plug..."
    echo ""
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let iCanHazPlug=0
endif
call plug#begin('~/.vim/pluged')



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



" if WINDOWS()
"     " Set runtime path for Windows.
"     set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
"     "Fix menu display for Windows.
"     source $VIMRUNTIME/delmenu.vim
"     source $VIMRUNTIME/menu.vim
"     language messages en_US.UTF-8
" endif




"*****************************************************************************
"" plug-vim install essential packages
"*****************************************************************************
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

" Plug 'ivanov/vim-ipython'

" Plug 'ntpeters/vim-better-whitespace'
"

if has('nvim')
    "" auto-completion
    " Plug 'Shougo/deoplete.nvim'
else
    "" auto-completion
    Plug 'Shougo/neocomplete.vim'
    "" shell
    Plug 'Shougo/vimshell.vim'

    function! BuildVimProc(info)
        if a:info.status == 'installed' || a:info.force
            if WINDOWS()
                ! tools\\update-dll-mingw
            endif
        endif
    endfunction
    Plug 'Shougo/vimproc.vim', { 'do': function('BuildVimProc')}
endif

"" syntax check
Plug  'scrooloose/syntastic'

" Plug 'vim-scripts/CSApprox'
"
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
"
"" Lisp Bundle
Plug 'vim-scripts/slimv.vim'

"" Salt files
" Plug 'saltstack/salt-vim'
" Plug 'stephpy/vim-yaml'

"" Python Bundle
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'hdima/python-syntax', {'for': 'python'}
Plug 'unterzicht/vim-virtualenv'

"" Javascript Bundle
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
" Plug  'ternjs/tern_for_vim'

"" .Net Bundle
" Plug 'tpope/vim-dispatch' | Plug 'OmniSharp/Omnisharp-vim', {'for': 'cs'}
" Plug 'OrangeT/vim-csharp', { 'for': 'cs' }

"" HTML Bundle
" Plug 'amirh/HTML-AutoCloseTag', {'for': 'html'}
" Plug 'hail2u/vim-css3-syntax', {'for': 'html'}
" Plug 'gorodinskiy/vim-coloresque', {'for': 'html'}
" Plug 'tpope/vim-haml', {'for': 'html'}
" Plug 'chrisgillis/vim-bootstrap3-snippets'
Plug 'mattn/emmet-vim'

Plug 'mbbill/undotree'
Plug 'plasticboy/vim-markdown'
" function! BuildYCM(info)
"     if a:info.status == 'installed' || a:info.force
"         !./install.py
"     endif
" endfunction

call plug#end()


if iCanHazPlug == 0
    echo "Installing vim plugins..."
    echo ""
    :PlugInstall
endif


"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
" set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

"" Map leader to ,
let mapleader=','


set fileformats=unix,dos,mac


"*****************************************************************************
"" Visual Settings
"*****************************************************************************"
syntax on
set ruler
set number

"" Color Scheme
colorscheme solarized
" set background=light

if has('gui_running')
    if has("gui_macvim")
        "set guifont=Monaco\ for\ Powerline:h11
    elseif has("gui_win32")
        "set guifont=Consolas:h10
    endif
endif

highlight clear SignColumn

"" Highlight the current line
set cursorline

"" Keep cursor 3 lines away from screen border
set scrolloff=3

"" Always show status bar
set laststatus=2

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



"=======================================================================================
" save as sudo
ca w!! w !sudo tee "%"

"=======================================================================================


" Tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set incsearch               " Incremental search
set hlsearch                " Highlighted search results


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
    "set directory=~/.vim/dirs/tmp
    " Make backup files
    "set backup
    "set backupdir=~/.vim/dirs/backups
    "set undofile
    "set undodir=~/.vim/dirs/undos

    " Create needed directories
    "if !isdirectory(&backupdir)
    "    call mkdir(&backupdir, "p")
    "endif
    "if !isdirectory(&directory)
    "    call mkdir(&directory, "p")
    "endif
    "if !isdirectory(&undodir)
    "    call mkdir(&undodir, "p")
    "endif
" }

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


" Settings for Common Lisp.
if WINDOWS()
 " let g:slimv_swank_cmd = '!start "C:/Program Files (x86)/LispCabinet/bin/ccl/wx86cl.exe" -l "C:/Program Files (x86)/LispCabinet/site/lisp/slime/start-swank.lisp"'
endif



" NERDTree
" let NERDTreeIgnore=['\.vim$', '\.pyc$']



" Python-mode
" let g:pymode_run_bind      = '<leader>r'
" let g:pymode_motion          = 0
" let g:pymode_rope            = 0
" let g:pymode_rope_completion = 0
" let g:pymode_doc             = 0
" let g:pymode_run             = 0
" let g:pymode_lint            = 0
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
" Vimscript file settings{{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker

augroup END
"}}}



"=======================================================================================
" key mappings
nnoremap <leader>t :Tabularize /
" nnoremap <leader>gd :YcmCompleter GoTo<CR>
" nnoremap <leader>gr :YcmCompleter GoToReferences<CR>

au BufRead *.py map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>


"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden


"*****************************************************************************
"" Customized Plugin Settings
"*****************************************************************************
"" jedi-vim
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


let g:sls_use_jinja_syntax = 1


