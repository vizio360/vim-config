call pathogen#infect()
syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab
set number
set bs=2  
" autochange the current dir based on the file opened
" set autochdir
autocmd vimenter * if !argc() | NERDTree | endif
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_
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

