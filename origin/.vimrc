set nocompatible

set expandtab
"set noexpandtab

set encoding=utf-8
set fileencodings=utf-8,euc-jp,sjis
set fileformats=unix
set backspace=2

set nobackup
set autoread

set showmatch
set showmode
set showcmd
set laststatus=2
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

set list
set listchars=tab:>\ ,extends:<,trail:-

set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}%=%l,%c%V%8P

let g:netrw_liststyle=3
let g:netrw_list_hide='CVS,\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv=1
let g:netrw_alto=1

au BufRead,BufNewFile *.ts set filetype=typescript
au BufRead,BufNewFile *.cc set filetype=cpp
au BufRead,BufNewFile *.cpp set filetype=cpp

autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType c,cc,cpp setlocal omnifunc=ccomplete#Complete

set complete+=k
set completeopt=menuone,preview

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
imap <Nul> <c-x><c-k>

if has('cscope')
    set nocsverb
    if filereadable('cscope.out')
        cs add cscope.out
    endif
    set csverb
endif

if has('syntax') && &t_Co > 2
    if stridx($TERM, "256") >= 0
        set t_Co=256
    endif

    syntax enable
endif

if v:version >= 704
    if &compatible
        set nocompatible
    endif
    set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim/

    call dein#begin(expand('~/.vim/dein/'))

    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('Shougo/unite.vim', {'build': 'make', 'depends': ['vimproc.vim']})
    call dein#add('ujihisa/unite-colorscheme', {'depends': ['unite.vim']})
    if has('lua')
        call dein#add('Shougo/neocomplete.vim')
    else
        call dein#add('Shougo/neocomplcache.vim')
    endif
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tfnico/vim-gradle')
    call dein#add('scrooloose/nerdtree')
    call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
    call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})

    call dein#end()

    filetype indent plugin on

    if dein#check_install()
        call dein#install()
    endif

    nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
    nnoremap <silent><C-t> :NERDTreeToggle<CR>
    if executable('pt')
        let g:unite_source_grep_command = 'pt'
        let g:unite_source_grep_default_opts = '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt = ''
        let g:unite_source_grep_encoding = 'utf-8'
    endif
elseif v:version >= 702
    if &compatible
        set nocompatible
    endif
    set runtimepath^=~/.vim/bundle/neobundle.vim/

    call neobundle#begin(expand('~/.vim/bundle/'))

    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
    NeoBundle 'editorconfig/editorconfig-vim'

    call neobundle#end()

    filetype indent plugin on

    NeoBundleCheck
endif

set background=dark
colorscheme darkblue
"colorscheme koehler
