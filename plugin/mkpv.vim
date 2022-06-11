if exists('g:loaded_mkpv')
  finish
endif

let g:loaded_mkpv = 1

let s:save_cpo = &cpo
set cpo&vim

let s:file_path = expand('%:p')
let s:file_ext = expand('%:e')

let g:auto_open_mkpv = get(g:,'auto_open_mkpv',0)

if exists('g:auto_open_mkpv')
   if s:file_ext == 'md'
     call mkpv#open_mkpv(s:file_path)
   endif
endif

let g:auto_scroll_mkpv = get(g:,'auto_scroll_mkpv',1)

if exists('g:auto_scroll_mkpv')
  echo  line(".") + 1
endif


command! MKPVOpen call mkpv#open_mkpv(s:file_path)
command! MKPVClose call mkpv#close_mkpv()
command! MKPVUpdate call mkpv#update_mkpv()
