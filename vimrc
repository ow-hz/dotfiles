"==============================================================================================
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

" set cursorline
" set showmatch
set ruler
set number
set incsearch
set hlsearch

" shorten update time of dianostic message 
set updatetime=300

" always show signcolumns
" set signcolumn=yes

" set t_Co=256

set backspace=indent,eol,start

" stop using arrow keys
noremap <Up>    <NOP>
noremap <Down>  <NOP>
noremap <Left>  <NOP>
noremap <Right> <NOP>

" split position
set splitbelow
set splitright

"==============================================================================================
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

" completion plugin
Plug 'davidhalter/jedi-vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'junegunn/vim-easy-align'

Plug 'mattn/emmet-vim'
Plug 'scrooloose/syntastic'
" Plug 'timothycrosley/isort'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'honza/vim-snippets'
" Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'yggdroot/indentLine'
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
" *** Plugin settings ***
"
" color scheme
" set background=light
" colorscheme PaperColor
colorscheme onehalflight
" colorscheme onehalfdark


" ctrip cache folder
" let g:ctrlp_cache_dir = $HOME.'/.local/ctrlp'


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
" function ToggleBG()
"     let s:tbg = &background
"     if s:tbg == "dark"
"         set background=light
"     else
"         set background=dark
"     endif
" endfunction

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

" autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" syntastic
let g:syntastic_python_checkers = ["flake8"]


" hi pythonSelf ctermfg=174 guifg=#6094DB cterm=bold gui=bold




" ==========================================================
" ==========================================================
" ==========================================================
" ==========================================================
"
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

" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" " Use `[c` and `]c` to navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" " Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" " Use `:Format` to format current buffer
" command! -nargs=0 Format :call CocAction('format')

" " Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " use `:OR` for organize import of current buffer
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" inoremap <silent><expr> <c-space> coc#refresh()

" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)


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
