scriptencoding utf-8

function! MakeYouVim()
  echo getline('.')
endfunction
" :%call g:MakeYouVim()


" range 識別の指定で a:firstline, a:lastline への参照ができる
" 範囲指定して for を回せるように
function! MakeYouVim() range
  for n in range(a:firstline, a:lastline)
    echo "お前も a:first>>" . getline(n) . "<<a:last にしてやろうか!"
  endfor
endfunction
" :'<,'>call g:MakeYouVim()
