if exists('g:loaded_mkpv')
  finish
endif

let g:loaded_mkpv=1

let s:save_cpo = &cpo
set cpo&vim

command! MKPVOpen call mkpv#open_mkpv()
command! MKPVClose call mkpv#close_mkpv()
command! MKPVClose call mkpv#scroll_mkpv()

