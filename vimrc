"
" -*- General settings -*-
"
" next buffer
set nocompatible

" Minimal number of screen lines to keep above and below the cursor.
" set scrolloff=3

set encoding=utf-8
set fileencodings=utf-8,utf-16,gbk,big5,gb18030,latin1

syntax on

if !has('nvim')
endif

filetype plugin indent on

set laststatus=2

let mapleader=','

set ruler
set number
set mouse=nv
set hlsearch
set incsearch
set showmatch
set cursorline
set lazyredraw

" shorten update time of dianostic message
set updatetime=300

" always show signcolumns
" set signcolumn=yes

set backspace=indent,eol,start

" stop using arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" split direction
set splitbelow
set splitright

"==============================================================================================
"
" -*- Customzied user functions -*-
"
function! SetBackgroundMode(...)
  let s:new_bg = 'light'
  let s:mode = systemlist('defaults read -g AppleInterfaceStyle')[0]
  if $TERM_PROGRAM ==? 'Aapple_Terminal'
    if s:mode ==? 'dark'
      let s:new_bg = 'dark'
    else
      let s:new_bg = 'light'
    endif
  else
    if &background !=? s:new_bg
      let &background = s:new_bg
    endif
  endif

endfunction


function! ToggleBG()
  let s:old_bg = &background
  if s:old_bg == 'dark'
    set background=light
  else
    set background=dark
  endif
endfunction


function! QuickRun()
  exec 'w'
  if &filetype == 'python'
    exec '!time python3 %'
  endif
endfunction

"==============================================================================================
"
" -*- Plug plugins -*-
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
Plug 'junegunn/vim-easy-align'

Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" completion plugin
Plug 'davidhalter/jedi-vim'
" Plug 'zchee/deoplete-jedi'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" color theme
Plug 'NLKNguyen/papercolor-theme'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'ayu-theme/ayu-vim'
Plug 'rakr/vim-two-firewatch'
" Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'mhartington/oceanic-next'
Plug 'ajmwagar/vim-deus'
Plug 'dracula/vim'

Plug 'mattn/emmet-vim'
Plug 'scrooloose/syntastic'
" Plug 'timothycrosley/isort'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'honza/vim-snippets'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
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


"==============================================================================================
"
" -*- Color schemes -*-
"
if has('termguicolors') && !empty($COLORTERM)==1
  set termguicolors
endif

" call SetBackgroundMode()
" call timer_start(3000, "SetBackgroundMode", {"repeat": -1})

" check if supporting true color or not
if &termguicolors

  " ayu {{{
  " let ayucolor="light"  " for light version of theme
  " let ayucolor="mirage" " for mirage version of theme
  " let ayucolor="dark"   " for dark version of theme
  " colorscheme ayu
  " }}}

  " dracula {{{
  " colorscheme dracula
  " }}}

  " two-firewatch {{{
  " let g:two_firewatch_italics=1
  " let g:airline_theme='twofirewatch'
  " colorscheme two-firewatch
  " }}}

  " oceanic-next {{{
  " colorscheme OceanicNext
  " }}}

  " deus {{{
  " colorscheme deus
  " }}}

  " nord {{{
  colorscheme nord
  " }}}

else
  set background=light

  " papercolor {{{
  let g:PaperColor_Theme_Options = {
        \   'theme': {
        \     'default.dark': {
        \       'transparent_background': 0
        \     },
        \     'default.light': {
        \       'transparent_background': 0
        \     }
        \   }
        \ }
  colorscheme PaperColor
  " }}}
endif


" onehalf {{{
" colorscheme onehalflight
" colorscheme onehalfdark
" }}}


" ctrip cache folder
" let g:ctrlp_cache_dir = $HOME.'/.local/ctrlp'


" grep
" nnoremap <leader>g :execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>

" set tabstop=4
" " Setting this to a non-zero value other than tabstop will make the tab key (in insert mode) insert a combination of spaces (and possibly tabs) to simulate tab stops at this width.
" set softtabstop=4
" " The size of an "indent".
" " It's also measured in spaces, so if your code base indents with tab characters then you want shiftwidth to equal the number of tab characters times tabstop.
" " This is also used by things like the =, > and < commands.
" set shiftwidth=4
" " Enabling this will make the tab key (in insert mode) insert spaces instead of tab characters.
" " This also affects the behavior of the retab command.
" set expandtab



"==============================================================================================
"
" -*- Auto commands -*-
"
" Vimscript file settings {{{
augroup file_vimrc
  autocmd!
  autocmd BufWritePost ~/.vimrc :source ~/.vimrc
  autocmd BufRead,SourceCmd ~/.vimrc set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  " set smartindent | set cindent | set autoindent
  " remove trial spaces
  autocmd BufWritePre * :%s/\s\+$//ge
  autocmd FileType vim setlocal foldmethod=marker
augroup end
" }}}

" Python file settings {{{
augroup file_python
  autocmd!
  " autocmd FileType python set foldmethod=marker
  " expand tab to space automatically
  autocmd BufNewFile,BufRead *.py
        \ set tabstop=4 |
        \ set softtabstop=4 |
        \ set shiftwidth=4 |
        \ set expandtab |
        \ set autoindent |
  " autocmd FileType vim set smartindent | set cindent | set autoindent
  " autocmd FileType python map <leader>b oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
augroup end
" }}}


augroup filetype_html
  autocmd BufWritePre,BufRead *.html :normal gg=G
augroup end


" Javascrip file settings {{{
augroup filetype_javascript
  autocmd!
  autocmd FileType javascript set tabstop=2 softtabstop=2 shiftwidth=2
augroup end
" }}}


" Html file settings {{{
augroup filetype_html
  autocmd!
  autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup end
" }}}


"
" -*- Programming environment settings -*-
"


"
" -*- Key mappings -*-
"
" clear highlight
nnoremap <leader><space> :noh<cr>

" map esc key
inoremap <C-[> <ESC>

" list buffer
nnoremap <leader>bl :buffers<cr>

" buffer move
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" toggle background color
noremap <leader>bg :call ToggleBG()<CR>


" Keep the current visual block selection active after changing indent.
vmap > >gv
vmap < <gv


" run quickly
map <F5> :call QuickRun()<CR>


" autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" syntastic
let g:syntastic_python_checkers = ["flake8"]


" hi pythonSelf ctermfg=174 guifg=#6094DB cterm=bold gui=bold


" ==========================================================
"
"
" map <F4> :NERDTreeToggle<CR>
" map <F5> :TagbarToggle<CR>
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
"==============================================================================================
" "" Customized Plugin Settings
"==============================================================================================
" " don`t use popup docs
" " autocmd FileType python setlocal completeopt-=preview
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
" GitGutter
nnoremap ]h :GitGutterNextHunk<cr>
nnoremap [h :GitGutterPrevHunk<cr>


" " if hidden is not set, TextEdit might fail.
" set hidden

" " Some servers have issues with backup files, see #649
" set nobackup
" set nowritebackup

" " Better display for messages
" set cmdheight=2

" " You will have bad experience for diagnostic messages when it's default 4000.
" set updatetime=300

" " don't give |ins-completion-menu| messages.
" set shortmess+=c

" " always show signcolumns
" set signcolumn=yes


let g:python3_host_prog = glob('~/.pyenv/versions/neovim/bin/python')

" jedi-vim
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_select_first = 0
let g:jedi#completions_enabled = 1


" highlight pythonSelf ctermfg=174 guifg=#6094DB cterm=bold gui=bold

" autocmd FileType *     :iabbrev <buffer> iff if:<left>
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"
"


"
" Key mapping for normal and non-recursive mode
"
" nnoremap <space> za
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" prefious buffer
nnoremap <c-h> :bp<CR>
" next buffer
nnoremap <c-l> :bn<CR>


nnoremap <buffer> Q x

nnoremap <leader>g :grep -R '<cWORD>' .<cr>


" 快速添加空行, 5[<space>
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>


" Using <space> for folding toggle
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>



autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

nnoremap <leader>f :call FoldColumnToggle()<cr>
nnoremap <leader>Q :call QuickFixToggle()<cr>
nnoremap <leader>q :call CloseWindow()<cr>




function! FoldColumnToggle()
  echom &foldcolumn
endfunction


let g:quickfix_is_open = 0

function! QuickFixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction



function! CloseWindow()
  execute ':close'
endfunction



" Change terminal-mode to normal
tnoremap <ESC> <C-\><C-n>






" ==========================================================
"
" Color
"
" ==========================================================





" ==========================================================
"
" User defined commands
"
" ==========================================================
command! -nargs=* T split | terminal <args>
command! -nargs=* VT vsplit | terminal <args>



" ==========================================================
"
" Current line position
"
" ==========================================================
" zt
" zz
" zb
"
"
"
"
"

