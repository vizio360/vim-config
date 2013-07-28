" call pathogen#infect()
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" " required! 
Bundle 'gmarik/vundle'
"
" " My Bundles here:
" "
" " original repos on github
Bundle 'majutsushi/tagbar'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdtree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-ruby/vim-ruby'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'mattn/zencoding-vim'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-fugitive'
Bundle 'joonty/vim-sauce.git'

" Bundle 'tomtom/tlib_vim'
" Bundle 'altercation/vim-colors-solarized'
"
" " Github repos of the user 'vim-scripts'
" " => can omit the username part
" Bundle 'L9'
" Bundle 'FuzzyFinder'
"
" " non github repos
Bundle 'git://git.wincent.com/command-t.git'
" " ...
"
" filetype plugin indent on     " required!
"
set t_Co=256
colorscheme jellybeans
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set relativenumber
set bs=2  
" autochange the current dir based on the file opened
" set autochdir
" autoload NERDTree on startup if no specific file is passed to vim command
autocmd vimenter * if !argc() | NERDTree | endif
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-E> <C-W>=
map <F2> :NERDTreeToggle<CR>
map <F12> :qall<CR>
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
map <F5> :CommandT<CR>
map <F6> :TagbarToggle<cr>
map <F8> :!ctags -R .<CR>
let g:tagbar_type_coffee = {
  \ 'ctagstype' : 'coffee',
  \ 'kinds' : [
  \   'n:namespace',
  \   'c:class',
  \   'o:object',
  \   'm:methods',
  \   'f:functions',
  \   'i:instance variables',
  \   'v:var:1',
  \ ],
  \ 'sro' : ".",
  \ 'scope2kind' : {
  \   'o' : 'object',
  \   'f' : 'function',
  \   'm' : 'method',
  \   'v' : 'var',
  \   'i' : 'ivar'
  \ },
  \ 'kind2scope' : {
  \  'function' : 'f',
  \  'method' : 'm',
  \  'var' : 'v',
  \  'ivar' : 'i',
  \ 'object' : 'o'
  \},
  \ 'deffile' : expand('<sfile>:p:h') . '/.vim/coffee.ctags'
  \ }


function! s:ExecuteInShell(command, bang)
    let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))
    if (_ != '')
        let s:_ = _
        let bufnr = bufnr('%')
        let winnr = bufwinnr('^' . _ . '$')
        silent! execute  winnr < 0 ? 'belowright new ' . fnameescape(_) : winnr . 'wincmd w'
        setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number
        silent! :%d
        let message = 'Execute ' . _ . '...'
        call append(0, message)
        echo message
        silent! 2d | resize 1 | redraw
        silent! execute 'silent! %!'. _
        silent! execute 'resize ' . line('$')
        silent! execute 'syntax on'
        silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
        silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
        silent! execute 'nnoremap <silent> <buffer> <CR> :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
        silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
        silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
        nnoremap <silent> <buffer> <C-W>_ :execute 'resize ' . line('$')<CR>
        silent! syntax on
        setlocal nomodifiable
    endif
endfunction

command! -complete=shellcmd -nargs=* -bang Shell call s:ExecuteInShell(<q-args>, '<bang>')
cabbrev shell Shell
"search and replace in current file
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>
"autocmd  BufWritePost *.coffee silent! !coffeelint -f ~/coffeelint.json <afile>
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
"set foldlevel=1
"show line numbers in NERDTree
let NERDTreeShowLineNumbers=1
"use a custom coffeelint options file for syntastic
let g:syntastic_coffee_coffeelint_args="--csv --file ~/coffeelint.json"
"show the search result with an highlight effect
set hlsearch
"n to search forward and N to search backward.
set incsearch
"powerline status bar
"let g:Powerline_symbols = 'fancy'
" show status bar always, even if only one window open
set laststatus=2
