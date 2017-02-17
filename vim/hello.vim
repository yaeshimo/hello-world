scriptencoding utf-8

" comment


" :source %


" 関数を呼ぶときは
" :call <func name>()

" 関数定義
function Foo()
  echo "foo"
endfunction

" 同名関数の上書き
function! Foo()
  "call Foo()
    " NOTE: echo "HI!" が無限に続く
  echo "HI!"
endfunction

function! Bar()
  echo "ref func"
endfunc

" types
  " 数値
    let foo = 1
  " 文字列
    let foo = "bar"
  " 関数リファレンス
    "let Foo = function("Bar")
      " NOTE: source すると最初の関数定義とコンクリフトする
      "     : 関数リファレンスは大文字で始まらないといけない
    let Foo2 = function("Bar")
      " NOTE: :call Foo2() == :call Bar()
  " リスト(list)
    let foo = ["foo", "bar"]
  " 辞書(Dictionary)
    let foo = {"bar": "bar"}
  " 浮動小数点
    let foo = 3.14

" 文字列
" NOTE: :help eval
  echo "hello " . "world"
    " NOTE: 文字列の連結は . を使う
  echo "hello world"[1:3]
    " NOTE: スライスできる

" try catch finally
function! Foo()
  try
    adlfkj
    echo "foo"
  catch
  endtry
endfunction

function! Bar()
  call Foo()
  echo "bar"
endfunction

call Bar()

