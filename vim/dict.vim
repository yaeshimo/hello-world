scriptencoding utf-8

let s:foo = {"name": "Bar"}

" dictionary メンバ関数のていぎ
" 暗黙で dict 識別が付けられる
function! s:foo.bar()
  echo "my name is " . self.name
  echo "my name is " . s:foo.name
    " NOTE: self で自身を参照
endfunction

call s:foo.bar()

function! s:my_bar() dict
  echo "my name is babar"
  echo "hi " . self.name
endfunction

let s:foo["bar"] = function("s:my_bar")
  " NOTE: 後から dictionary のメソッドを書き換えられる

call s:foo.bar()
