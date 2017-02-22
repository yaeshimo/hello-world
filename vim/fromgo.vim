
" from mattn.kaoriya.net
" http://mattn.kaoriya.net/software/vim/20160129114716.htm

function! Callback(handle, msg)
  echo a:msg
endfunction
let handle = ch_open("localhost:8080", {"mode": "json" , "callback": "Callback"})
echo ch_sendexpr(handle, "GET", {"callback": "Callback"})
" go run ../go/tovim.go
