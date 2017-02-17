scriptencoding utf-8

function! s:a(str)
  echo "a:".a:str
endfunction

function! s:b(str1, str2)
  echo "b:".a:str1.a:str2
endfunction

" function('<name>') で関数リファレンス
let F = function('s:a')
call F('helloworld')

" call() 関数を使う
" call call(<ref>, [arr, arr, ...]) で引数を配列で渡した関数を呼べる
let F = function('s:b')
call call(F, ["hello", "world"])
