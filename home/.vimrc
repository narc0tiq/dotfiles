syntax on
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

map q :q
map <C-Up> <C-W>k
map <C-Down> <C-W>j

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

set relativenumber

set showtabline=2
nmap <F5> <Esc>:tabp<CR>
nmap <F6> <Esc>:tabn<CR>

set incsearch
set hlsearch
nnoremap <C-l> :nohlsearch<CR><C-l>

" Hide the search highlight in insert mode:
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

let mapleader=','
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

nmap <silent> <leader>s :set spell!<cr>
set spelllang=en_us

try
    colo grb256
catch
    colo default
endtry
