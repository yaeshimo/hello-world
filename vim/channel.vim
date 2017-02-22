
function! Callback(handle, msg)
  echo a:msg
endfunction
let handle = ch_open("localhost:5000", {"mode": "raw"})
" godoc -http="5000:"
call ch_sendraw(handle, "GET / HTTP/1.0\r\n\r\n", {"callback": "Callback"})
" うごいた-!
