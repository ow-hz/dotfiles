"
" *** General settings ***
"
set nocompatible

set encoding=utf-8
" set fileencodings=utf-8,utf-16,gbk,big5,gb18030,latin1

syntax on

filetype plugin indent on

set laststatus=2

let mapleader=','

" set guifont=Menlo:h10

" set cursorline
" set showmatch
set ruler
set number
set incsearch
set hlsearch

set t_Co=256

set backspace=indent,eol,start

" stop using arrow keys
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" split position
set splitbelow
set splitright


"
" *** Plugins ***
"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/grep.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install() }}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/vim-easy-align'

Plug 'mattn/emmet-vim'
" Plug 'Valloric/YouCompleteMe'
" Plug 'google/yapf'
Plug 'SirVer/ultisnips'
Plug 'scrooloose/syntastic'
Plug 'timothycrosley/isort'

" Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'
" Plug 'honza/vim-snippets'
" Plug 'godlygeek/tabular'
" Plug 'tpope/vim-repeat'
" Plug 'yggdroot/indentLine'
" Plug 'terryma/vim-multiple-cursors'
"
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'jmcantrell/vim-virtualenv'
" " Plug 'bronson/vim-trailing-whitespace'
" " "" syntax check
" " Plug 'w0rp/ale'
" Plug 'vim-scripts/bufexplorer.zip'

call plug#end()


"
" *** Plugin settings ***
"
" color scheme
set background=light
colorscheme PaperColor


" grep
" nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>


"
" *** Auto commands ***
"
augroup file_vimrc 
  autocmd!
  " autocmd! BufNewFile,BufRead ~/.vimrc set shiftwidth=2
  " reload vim
  autocmd BufWritePost ~/.vimrc nested :source ~/.vimrc
  " set tabstop=2
  " set softtabstop=2
  " set shiftwidth=2
  " remove trial spaces
  " autocmd BufWritePre * :%s/\s\+$//ge
augroup end

augroup filetype_python
  autocmd!
  " autocmd FileType python set foldmethod=marker
  " expand tab to space automatically
  autocmd FileType python set softtabstop=4
  autocmd FileType python set tabstop=8
  autocmd FileType python set expandtab
  autocmd FileType python set shiftwidth=4
  " autocmd FileType vim set smartindent | set cindent | set autoindent
  autocmd FileType python map <leader>b oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
augroup end


"
" *** Programming environment settings ***
"


"
" *** Key mappings ***
"
" clear highlight
nnoremap <leader><space> :noh<cr>

" map esc key
inoremap <C-[> <ESC>

" buffer move
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" toggle background color
noremap <leader>bg :call ToggleBG()<CR>
function ToggleBG()
    let s:tbg = &background
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction

" Keep the current visual block selection active after changing indent.
vmap > >gv
vmap < <gv

" move current line downward
nnoremap - ddp

" run quickly
map <F5> :call QuickRun()<CR>

function! QuickRun()
  exec "w"
  if &filetype == "python"
    exec "!time python3 %"
  endif
endfunction

autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" syntastic
let g:syntastic_python_checkers = ["flake8"]




hi pythonSelf ctermfg=174 guifg=#6094DB cterm=bold gui=bold




" ==========================================================
" ==========================================================
" ==========================================================
" ==========================================================
"
"
" " show completion list
" set wildmenu wildmode=full
" " Command <Tab> completion, list matches, then longest common part, all
" set wildmode=full
" " Backspace and cursor keys to wrap.
" " set whichwrap=b,s,h,l,<,>,[,]
"
"
"
" set t_Co=256
" " Essential Plug
" " "*****************************************************************************
" " "" plug-vim install customized packages
" " "*****************************************************************************
" call plug#end()
" " if iCanHazPlug == 0
" "     echo "Installing vim plugins...\n"
" "     :PlugInstall
" " endif
"
"
" " ==============================================
" " General autocmd
" " ==============================================
" " Vim file settings ------------------------ {{{
" augroup filetype_vim
"     autocmd!
"     autocmd FileType vim set foldmethod=marker
"     " expand tab to space automatically
"     autocmd FileType vim set expandtab
"     " one tab uses 4 space
"     autocmd FileType vim set tabstop=4
"     autocmd FileType vim set softtabstop=4
"     autocmd FileType vim set shiftwidth=4
"     " autocmd FileType vim set smartindent | set cindent | set autoindent
" augroup end
" " {{{
"
"
" " set arrow key disabled for moving
" " split navagation
" noremap <c-k> <c-w>k
" noremap <c-j> <c-w>j
" noremap <c-h> <c-w>h
" noremap <c-l> <c-w>l
" " toggle background
"
" map <F4> :NERDTreeToggle<CR>
" map <F5> :TagbarToggle<CR>
"
"
"
"
"
"
"
" "=======================================================================================
" " save as sudo
" ca w!! w !sudo tee "%"
"
" "=======================================================================================
"
"
"
"
" " plugin settings
" " NERDTree
" let g:NERDTreeWinPos="left"
" " let g:NERDTreeHighlightCursorline = 1
"
"
" "=======================================================================================
" " Customized Mapping
" "
"
" " Keep the current visual block selection active after changing indent.
"
" " In insert mode, delete from the current cursor to end-of-line
" inoremap <C-Del> <C-\><C-O>D
"
"
	" " Mapping for gitgutter
	" nmap ]h <Plug>GitGutterNextHunk
" nmap [h <Plug>GitGutterPrevHunk
"
" " Using <space> for folding toggle
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"
"
"
"
"
" " NERDTree
" " let NERDTreeIgnore=['\.vim$', '\.pyc$']
"
" " Solarized
" " let g:solarized_termcolors=256
"
"
"
" " " ale {
" " " filetype off
" " let &runtimepath.=',~/.vim/pluged/ale'
" " let g:ale_linters = {
" " \   'javascript': ['eslint'],
" " \   'python': ['flake8'],
" " \}
" " filetype plugin on
" let g:ale_sign_column_always = 1
" let g:ale_sign_error = '•'
" let g:ale_sign_warning = '•'
" " highlight clear ALEErrorSign
" " highlight clear ALEWarningSign
" " let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" " }
"
"
" " Bufexplorer {
" nnoremap <silent> <F2>   : BufExplorer<CR>
" " nnoremap <silent> <m-F2> : BufExplorerHorizontalSplit<CR>
" " nnoremap <silent> <c-F2> : BufExplorerVerticalSplit<CR>
" " }
"
"
"
" "=======================================================================================
" " onoremap ih :<c-u> execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<CR>
"
"
" "=======================================================================================
"
"
" " *****************************************************************************
" "" Customized Plugin Settings
" " *****************************************************************************
" " don`t use popup docs
" " autocmd FileType python setlocal completeopt-=preview
" let g:indentLine_char = '┆'
" " let g:sls_use_jinja_syntax = 1"}}}
"
"
" let g:virtualenv_directory = '~/.local/virtualenvs'
"
" let g:NERDTreeIgnore=['.*.pyc', '__pycache__/']
" " let g:ycm_python_binary_path = 'python'
" filetype plugin indent on
" " let g:ycm_server_python_interpreter = '~/.local/pyenv/shims/python'
"
" " xmap ga <Plug>(EasyAlign)
" " nmap ga <Plug>(EasyAlign)
"
"
" augroup python_file
"     autocmd!
"     autocmd BufRead *.py map <buffer> <F3> :wa<CR>:call RunProgramme()<CR>
"
"     " autocmd FileType py setlocal foldmethod=indent
"     " tabs and space
"     autocmd FileType py set smartindent | set cindent | set autoindent
" augroup end
"
"
"
"
" " nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
"
" " autocmd BufWrite * :echom "Writing buffer!"
"
"
"
" " ==============================================
" " Plugin settings
" " ==============================================
" "
" " Mappings
" "
" " GitGutter
" " previous hunk
" " nnoremap <leader>gph :GitGutterPrevHunk<cr>
" " next hunk
" " nnoremap <leader>gph :GitGutterNextHunk<cr>
