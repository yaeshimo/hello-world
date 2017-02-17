scriptencoding utf-8


" abort でエラ-が発生したら即関数を抜ける
" abort {{{
function! Foo() abort
  asldfkj
  echo "foo"
endfunction

function! Bar()
  call Foo()
  echo "bar"
endfunction

call Bar()
" }}}

" abort try {{{
function! Foo() abort
  adlfkj
  echo "foo"
endfunction

function! Bar()
  try
    call Foo()
    echo "bar"
  catch
    echo "Failure"
  endtry
endfunction

call Bar()
" }}}
