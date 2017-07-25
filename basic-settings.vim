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
