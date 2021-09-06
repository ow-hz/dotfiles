"
" -*- General settings -*-
"
set nocompatible
set encoding=utf-8
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set scrolloff=1
set laststatus=2

syntax on
filetype plugin indent on

" set showcmd
" set showmode


"set shiftwidth=4 tabstop=4
" set shiftwidth=4 tabstop=8 softtabstop=12 " 1 * tab(8) + 4 *space

set autoindent


let mapleader=','

" set showmatch
set cursorline ruler number hlsearch incsearch

if !system('command -v nasm > /dev/null 2>&1')
    let g:asmsyntax = 'nasm'
endif

if has('termguicolors')
    " set termguicolors
endif


"if has('nvim') || has('gui_macvim')
"    if !has('termguicolors')
"        set termguicolors
"    endif
"endif

if has('gui_macvim')
    set pythonthreedll=~/.pyenv/versions/3.8.1/Python.framework/Versions/Current/Python
elseif has('nvim')
    let g:python3_host_prog = glob('~/.pyenv/versions/neovim/bin/python')
else
endif


" set lazyredraw

" shorten update time of dianostic message
" set updatetime=300

" always show signcolumns
" set signcolumn=yes

set backspace=indent,eol,start

" stop using arrow keys in normal mode

" split direction
set splitbelow
set splitright

"
" -*- Plugin settings -*-
"
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin("~/.vim/plugged")



Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'tpope/vim-surround'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
" Plug 'junegunn/vim-easy-align'
Plug 'ycm-core/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
" color theme
"
" Plug 'NLKNguyen/papercolor-theme'
" Plug 'arcticicestudio/nord-vim'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
" Plug 'rakr/vim-one'
"`Plug 'ayu-theme/ayu-vim'
" Plug 'rakr/vim-two-firewatch'
" Plug 'cocopon/iceberg.vim'
" Plug 'mhartington/oceanic-next'
" Plug 'ajmwagar/vim-deus'

" Plug 'mattn/emmet-vim'
" Plug 'scrooloose/syntastic'
" Plug 'timothycrosley/isort'
"
" git related
"
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'terryma/vim-multiple-cursors'
" Plug 'honza/vim-snippets'
" Plug 'godlygeek/tabular'
"
" miscellaneous
"
" Plug 'tpope/vim-repeat'
Plug 'yggdroot/indentLine'
"
" Plug 'jmcantrell/vim-virtualenv'
" " Plug 'bronson/vim-trailing-whitespace'
" " "" syntax check
" " Plug 'w0rp/ale'
" Plug 'vim-scripts/bufexplorer.zip'
call plug#end()
"
" -*- Color scheme -*-
"
" set background=dark
if &termguicolors
    "colorscheme two-firewatch
    "colorscheme nord
    "colorscheme deus
    "let ayucolor="light"
    "colorscheme ayu
    "colorscheme PaperColor
    "colorscheme one

    " colorscheme oceanicnext
    "colorscheme onehalflight
else
    " colorscheme papercolor
    " colorscheme nord
    " highlight normal guibg=none ctermbg=none
endif
"
" -*- auto commands -*-
"
augroup file_vimrc
    autocmd!
    autocmd bufread .vimrc set softtabstop=4 expandtab textwidth=100
    autocmd bufwritepre .vimrc :%s/\s\+$//ge
    autocmd bufwritepost .vimrc exec "source " . $HOME . "/.vimrc" | :AirlineRefresh
augroup end


augroup filetype_shell
    autocmd!
    autocmd filetype sh set softtabstop=4 expandtab
augroup end


augroup filetype_python
    autocmd!
    autocmd filetype python set softtabstop=4 expandtab
    autocmd filetype python map <leader>b oimport ipdb; ipdb.set_trace() # breakpoint<c-c>
    autocmd filetype python map <buffer> <f3> :wa<cr>:call runprogramme()<cr>
augroup end


augroup filetype_html
    autocmd!
    autocmd filetype html set shiftwidth=2 tabstop=2 softtabstop=2 expandtab
    autocmd bufread,bufwritepre *.html :normal! gg=g
    autocmd filetype html nnoremap <buffer> <localleader>f vatzf
augroup end


augroup filetype_javascript
    autocmd!
    autocmd filetype javascript set tabstop=2 shiftwidth=2 softtabstop=2
augroup end


augroup filetype_c
    autocmd!
augroup end

" autocmd BufEnter /home/myproj1/* setlocal tags+=/home/myproj1/tags

"
" -*- Auto commands && abbrevations -*-
"
augroup filetype_python
    autocmd!
    autocmd FileType python map <buffer> <F4> :wa<CR>:call RunProgramme()<CR>
augroup end

"
" -*- Key mappings -*-
"
noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>

noremap <up>    <nop>
noremap <down>  <nop>
noremap <left>  <nop>
noremap <right> <nop>


"noremap gcc <nop>

" clear highlight
nnoremap <leader><space> :noh<cr>

" map esc key
inoremap <C-[> <ESC>

" list buffer
nnoremap <leader>bl :buffers<cr>

" buffer navigation
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [B :bfirst<CR>
nnoremap ]B :blast<CR>

" tab navigation
nnoremap [t :tabprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [T :tabfirst<CR>
nnoremap ]T :tablast<CR>

" quickfix
" nnoremap toggle co :copen<CR>
" nnoremap [q
" nnoremap ]q

" args
" nnoremap [a
" nnoremap ]a

onoremap p i(
" onoremap b /return<cr>
" onoremap in( :<c-u>normal! f(vi(<cr>
" onoremap il( :<c-u>normal! F)vi(<cr>


" toggle background color
noremap <leader>bg :call ToggleBG()<CR>

" keep the current visual block selection
vmap > >gv
vmap < <gv

" run quickly
map <F5> :call QuickRun()<CR>

" paste from system clipboard register
nnoremap <leader>p "*p

" copy to system clipboard register
" during insert mode, use <C-r>{register}
nnoremap <leader>y "*y

" grep
" nnoremap <leader>g :execute 'grep! -R ' . shellescape(expand('<cWORD>')) . ' .'<cr>
" nnoremap <leader>g :silent execute 'grep! -R ' . shellescape(expand('<cWORD>')) . ' .'<cr>
" nnoremap <leader>g :silent execute 'grep! -R ' . shellescape(expand('<cWORD>')) . ' .'<cr>:copen<cr>
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>
" nnoremap <leader>giw
" nnoremap <leader>gi'
" nnoremap <leader>gi"

" autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" hi pythonSelf ctermfg=174 guifg=#6094DB cterm=bold gui=bold
"
" map <F4> :NERDTreeToggle<CR>
" map <F5> :TagbarToggle<CR>
"
" " save as sudo
" ca w!! w !sudo tee "%"

" inoremap <C-Del> <C-\><C-O>D

" nnoremap <space> za

nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
nnoremap <leader>< viw<esc>a><esc>bi<<esc>lel
nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>lel
nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>lel

 " adf asdfasdf-adf.asf f "asdfaf" > "asfd" "adf"

nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>

" prefious buffer
"nnoremap <c-h> :bp<CR>
" next buffer
"nnoremap <c-l> :bn<CR>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
"nnoremap <c-h> :exe "normal \<c-w>\<c-w>"

nnoremap <buffer> Q x

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

let g:quickfix_is_open = 0

"
" -*- User defined functions -*-
"
function! BuildYouCompleteMe(info)
    if a.info.status == 'installed':
        echom getcwd()
    endif
endfunction


function! RunProgramme()
endfunction


function! CloseWindow()
    execute ':close'
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


function! QuickFixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . 'wincmd w'
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction


function! s:GrepOperator(type)
    let saved_unamed_register = @@
    echom saved_unamed_register
    if a:type ==# 'v'
        execute 'normal! `<v`>y'
    elseif a:type ==# 'char'
        execute 'normal! `[v`]y'
    else
        return
    endif
    silent execute 'grep -R ' . shellescape(expand(@@)) . ' .'

    copen

    let @@ = saved_unamed_register
endfunction


function! FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction

" 2GV4$y == :2yank 1
" yyp == :.t.
" R replace mode
" yyp == :normal! yyp
" :576,588!sort -t '' -k 1
" S" surround
