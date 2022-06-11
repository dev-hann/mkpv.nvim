if exist('g:loaded_mkpv')
  finish
endif

let g:loaded_mkpv=1

let s:save_cpo = &cpo
set cpo&vim


function! open_mkpv()
  echo "hello"
endfunction

command! MKPVOpen call open_mkpv()
