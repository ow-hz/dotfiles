" Environment {

    " Basics settings {
        set nocompatible
        set encoding=utf-8
        set fileencodings=utf-8,gbk
        set listchars=tab:>-,trail:-
        set list
        let mapleader=","
    " }

    " Identify platforms {
        silent function! OSX()
            return has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('macunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return (has('win16') || has('win32') || has('win64'))
        endfunction
    " }

    " Vim basic settings on Windows {
        if WINDOWS()
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
            source $VIMRUNTIME/delmenu.vim
            source $VIMRUNTIME/menu.vim
            language messages en_US.UTF-8
        endif
    " }

    " Allow to toggle background {
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
    " }

    " Automatically detect file types
    filetype plugin on
    filetype indent on
" }

" Vundle installation {

    " Setting up Vundle - the Vim plug-in bundle
    let iCanHazVundle=1
    if !filereadable(vundle_readme)
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif

    filetype off

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    " Let Vundle manage Vundle
    Bundle 'gmarik/vundle'
" }

" Bundle management for Vundle {

    " Pymode
    Bundle 'klen/python-mode'
    let g:pymode_rope=0

    " Bundle repos {
        " Vim UI {
            Bundle 'altercation/vim-colors-solarized'

            Bundle 'bling/vim-airline'
            let g:airline_powerline_fonts=1
        " }

        " Files search and management for Vim {
            Bundle 'scrooloose/nerdtree'

            " Code and files fuzzy finder
            Bundle 'kien/ctrlp.vim'
            let g:ctrlp_cache_dir = $HOME.'/.vim/cache/ctrlp'
        " }

        " Motion for Vim {
            Bundle 'Lokaltog/vim-easymotion'
            " Multiple-cursors
            Bundle 'terryma/vim-multiple-cursors'
        " }

        " Completion for Vim {
            Bundle 'valloric/YouCompleteMe'
        " }

        " Vim-fugitive {
            Bundle 'tpope/vim-fugitive'
        " }

        " Vim-gitgutter
        Bundle 'airblade/vim-gitgutter'

        " Extension to ctrlp, to have a command palette like sublime text 2
        Bundle 'fisadev/vim-ctrlp-cmdpalette'

        " Syntax check {
            Bundle 'scrooloose/syntastic'
        " }

        " Show a diff via Vim sign column
        Bundle 'mhinz/vim-signify'

        " Debug for Vim {
            Bundle 'jaredly/vim-debug'
        " }

        " Vim-virtualenv
        Bundle 'jmcantrell/vim-virtualenv'
        let g:virtualenv_stl_format='[%n]'
    " }

    " Install plug-ins the first time Vim runs {
        if iCanHazVundle == 0
            echo "Installing Bundles, please ignore key map error messages"
            echo ""
            :BundleInstall
        endif
    " }
" }

" Vim UI {

    colorscheme solarized       " Set color scheme
    if has('gui_running')
    endif
    set background=light
    highlight clear SignColumn
    set cursorline              " Highlight the current line
    set laststatus=2            " Always show status bar
    set spell                   " Set spell checking on

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
    set wildmode=list:longest,full

    " Backspace and cursor keys wrap
    set whichwrap=b,s,h,l,<,>,[,]
" }

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

" Key map {
    noremap <Up>    <NOP>
    noremap <Down>  <NOP>
    noremap <Left>  <NOP>
    noremap <Right> <NOP>

    " Keep the current visual block selection active after changing indent
    vmap > >gv
    vmap < <gv

    " In insert mode, delete from the current cursor to end-of-line
    inoremap <C-Del> <C-\><C-O>D

    " Highlight text on the screen matching that under the cursor: Press Ctrl-k to start; each subsequent Ctrl-l matches one more character.
    map <C-k> mx
    map <C-l> lmy"zy`x/<C-r>z<CR>`y

    nnoremap / /\v
    vnoremap / /\v
    nnoremap <leader><space> :noh<cr>

    " Customized key for programming {
    " }
" }

" Auto command {

    autocmd BufWritePre * :%s/\s\+$//ge    " Delete trial spaces
" }
