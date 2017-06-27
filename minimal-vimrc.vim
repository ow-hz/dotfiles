" 不兼容vi
set nocompatible


" 设置插件和缩进
filetype plugin indent on
" 设置语法高亮
syntax on

" 拷贝上一行的缩进格式
set autoindent
" 对已经存在的tab用空格替换，此时默认softtabstop=8
set expandtab
" 制表符长度为4个空格
set softtabstop=4
" 以4个空格缩进
set shiftwidth=4
" todo indents to next multiple of 'shitwidth'
set shiftround

" todo Make backspace as you expected
set backspace=indent,eol,start
" Switch between
set hidden
