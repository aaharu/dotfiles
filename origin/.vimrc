set nocompatible

set expandtab
"set noexpandtab

set encoding=utf-8
set fileencoding=utf-8
set fileformats=unix
set backspace=2

set nobackup
set autoread

set showmatch
set showmode
set showcmd
set laststatus=2
set cursorline
set number
set ruler
set hidden
set wildmenu

set tabstop=4
set shiftwidth=4
set softtabstop=4
set cindent
set autoindent
set smartindent

set ignorecase
set smartcase
set hlsearch

set foldmethod=manual
set list
set listchars=tab:>\ ,extends:<,trail:-

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
au BufRead,BufNewFile *.ts  set filetype=typescript

noremap <c-a> <Home>
inoremap <c-a> <Home>
noremap <c-e> <End>
inoremap <c-e> <End>
noremap <c-d> <Del>
inoremap <c-d> <Del>
noremap <c-b> <Left>
inoremap <c-b> <Left>
noremap <c-f> <Right>
inoremap <c-f> <Right>
noremap <c-p> <Up>
inoremap <c-p> <Up>
noremap <c-n> <Down>
inoremap <c-n> <Down>

if has('syntax') && &t_Co > 2
    if stridx($TERM, "256") >= 0
        set t_Co=256
    endif

    syntax enable
endif
set background=dark
colorscheme darkblue

if has('vim_starting')
    set nocompatible               " Be iMproved
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

filetype indent plugin on

NeoBundleCheck
