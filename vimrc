" Environment {

    " Basics {
        set nocompatible
        set encoding=utf-8,gbk
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

    " Vim path on Windows {
        if WINDOWS()
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME
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

    " Unix platforms {
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

    " }

    " Windows platforms {
    " }

    " Let Vundle manage Vundle
    Bundle 'gmarik/vundle'
" }

" Bundle management for Vundle {

    " Bundle repos {
        " Vim UI {
            Bundle 'altercation/vim-colors-solarized'

            Bundle 'bling/vim-airline'
            let g:airline_powerline_fonts=1
            let g:airline#extensions#tabline#enabled=1
        " }

        " Files search and management for Vim {
            Bundle 'scrooloose/nerdtree'

            " Code and files fuzzy finder
            Bundle 'kien/ctrlp.vim'
            let g:ctrlp_cache_dir = $HOME.'/.vim/cache/ctrlp'
        " }

        " Motion for Vim {
            Bundle 'Lokaltog/vim-easymotion'
        " }

        " Completion for Vim {
            Bundle 'valloric/YouCompleteMe'
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
        set guifont=Source\ Code\ Pro for\ Powerline
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

" Key mapping {

" }
