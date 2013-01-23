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