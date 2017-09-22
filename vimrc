" general settings {{{
set nocompatible
filetype plugin indent on
" set fileencoding=utf-8
set fileencodings=utf-8
set scrolloff=3
set laststatus=2
let mapleader=','

" true color support for tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum""]"

syntax on

" vim-pulg {{{
let iCanHazPlug=1
let plug_vim=expand('~/.vim/autoload/plug.vim')
if !filereadable(plug_vim)
    echo "Installing vim-plug...\n"
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let iCanHazPlug=0
endif
call plug#begin('~/.vim/pluged')
call plug#begin()
"" plugins
Plug 'davidhalter/jedi-vim'
Plug 'tpope/vim-repeat'
" color theme
Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jmcantrell/vim-virtualenv'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'rizzatti/dash.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/grep.vim'
Plug 'bronson/vim-trailing-whitespace'
" "" syntax check
Plug 'vim-syntastic/syntastic'
Plug 'yggdroot/indentLine'
Plug 'vim-scripts/bufexplorer.zip'
Plug 'mattn/emmet-vim'
" "*****************************************************************************
" "" plug-vim install customized packages
" "*****************************************************************************
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
" colorscheme solarized
" set background=light
colorscheme onedark

if has("gui_running")
    set guifont=MesloLGSDZ_Nerd_Font
    " set pythondll=~/.local/.pyenv/versions/2.7.11/Python.framework/Versions/2.7/Python
    " set pythondll = /Users/owen/.local/pyenv/versions/3.6.1/Python.framework/python
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

map <F4> :NERDTreeToggle<CR>
map <F5> :TagbarToggle<CR>

" }}}


" specific filetype settings {{{
" python {{{
function! RunProgramme()
    " if g:virtualenv_loaded == 1
    "     silent !clear
    "     !python %
    " else
    " endif
    silent !clear
    " !/usr/bin/env python3 %
    !python %
endfunction

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


" plugin settings
" NERDTree
let g:NERDTreeWinPos="left"
" let g:NERDTreeHighlightCursorline = 1


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



" Jedi-vim
let g:jedi#show_call_signatures     = 2
let g:jedi#popup_select_first       = 0
let g:jedi#goto_definitions_command = "<leader>jd"
let g:jedi#goto_command             = "<leader>jg"
let g:jedi#goto_assignments_command = "<leader>ja"
let g:jedi#documentation_command    = "<leader>jk"
let g:jedi#usages_command           = "<leader>ju"
let g:jedi#rename_command           = "<leader>jr"
let g:jedi#popup_on_dot = 0

" Vim-airline
" let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache=1

" {
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_yaml_checkers = ['yamllint']

" }


" " ale {
" " filetype off
" let &runtimepath.=',~/.vim/pluged/ale'
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'python': ['flake8'],
" \}
" filetype plugin on
let g:ale_sign_column_always = 1
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
" highlight clear ALEErrorSign
" highlight clear ALEWarningSign
" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" }


" Bufexplorer {
nnoremap <silent> <F2>   : BufExplorer<CR>
" nnoremap <silent> <m-F2> : BufExplorerHorizontalSplit<CR>
" nnoremap <silent> <c-F2> : BufExplorerVerticalSplit<CR>
" }



"=======================================================================================
" Autocmd
autocmd BufWritePre * :%s/\s\+$//ge    " Delete trial spaces
autocmd! BufWritePost ~/.vimrc nested :source ~/.vimrc


"=======================================================================================
" onoremap ih :<c-u> execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>


"=======================================================================================


" *****************************************************************************
"" Customized Plugin Settings
" *****************************************************************************
" don`t use popup docs
" autocmd FileType python setlocal completeopt-=preview
let g:indentLine_char = '┆'
" let g:sls_use_jinja_syntax = 1"}}}
"

let g:virtualenv_directory = '~/.local/virtualenvs'

let g:NERDTreeIgnore=['.*.pyc', '__pycache__/']
" let g:ycm_python_binary_path = 'python'
filetype plugin indent on
" let g:ycm_server_python_interpreter = '~/.local/pyenv/shims/python'

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

augroup js_json_html_file
    autocmd!
    autocmd FileType js,json,html set tabstop=2
    autocmd FileType js,json,html set softtabstop=2
    autocmd FileType js,json,html set shiftwidth=2
augroup END

augroup python_file
    autocmd!
    autocmd BufRead *.py map <buffer> <F3> :wa<CR>:call RunProgramme()<CR>

	autocmd FileType python map <leader>b oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
	" autocmd FileType py setlocal foldmethod=indent
	" tabs and space
	autocmd FileType py set expandtab
	autocmd FileType py set tabstop=4
	autocmd FileType py set softtabstop=4
	autocmd FileType py set shiftwidth=4
	autocmd FileType py set smartindent | set cindent | set autoindent
augroup end
