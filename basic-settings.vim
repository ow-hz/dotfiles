" 不兼容vi
set nocompatible

" 启用插件和缩进
filetype plugin indent on
" 启用语法高亮
syntax on

" 启用自动缩进
set autoindent

" 将文件中已有制表符替换为空格
set expandtab
" 制表符长度为4个空格
set softtabstop=4

" 用4个空格替换tab键
" >> 以4个空格缩进
set shiftwidth=4
set shiftround

" 启用退格键
set backspace=indent,eol,start

" buffer switch
set hidden

" 显示状态拦
set laststatus=2
set display=lastline

set showmode
set showcmd

set ttyfast
set lazyredraw


" general settings {{{
" set fileencoding=utf-8
set fileencodings=utf-8
set scrolloff=3
set laststatus=2
let mapleader=','

" true color support for tmux
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum""]"

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set fileformats=unix,dos,mac


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
" plugins
Plug 'davidhalter/jedi-vim'


call plug#end()
if iCanHazPlug == 0
    echo "Installing vim plugins...\n"
    :PlugInstall
endif
