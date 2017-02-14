syntax enable
set nocompatible
set wildmenu
set hidden

silent! call pathogen#infect()

set viminfo='100,\"1000,:100,%,n~/.vim/info
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

set noautoindent
set cindent
set history=500
set ruler
set showcmd
set colorcolumn=100
set matchtime=0

set cursorline
set scrolloff=5

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

autocmd Filetype php set noexpandtab

" Automatically strip trailing whitespace from lines when saving Python or C files.
autocmd BufWritePre * if &filetype == 'python' | exe 'normal m`' | %s/\s\+$//e | exe 'normal ``' | endif
autocmd BufWritePre * if &filetype == 'c' | exe 'normal m`' | %s/\s\+$//e | exe 'normal ``' | endif

" Make tabs and trailing whitespace visible
set list
set encoding=utf-8
set lcs=tab:»·  "show tabs
set lcs+=trail:· "show trailing spaces

let python_highlight_all = 1
autocmd! Syntax python source ~/.vim/syntax/python.vim
autocmd Syntax python source ~/.vim/indent/python.vim

set number
set relativenumber

set showtabline=1
nnoremap <F5> :bp<CR>
nnoremap <F6> :bn<CR>
nnoremap <F8> :TagbarToggle<CR>

set incsearch
set hlsearch

" Hide the search highlight in insert mode:
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

let mapleader=','
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<CR>
nmap <leader>ew :edit %%
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>s :set spell!<CR>
nnoremap <leader>n :set hlsearch!<CR>
nnoremap <leader>v :set paste!<CR>

set spelllang=en_us

try
    colo grb256
catch
    colo default
endtry

let g:miniBufExplBuffersNeeded = 1
let g:syntastic_enable_signs = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_java_javac_config_file_enabled = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

set virtualedit=all
set mouse=n

set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000
