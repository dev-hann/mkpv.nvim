if exists('g:loaded_mkpv')
  finish
endif

let g:loaded_mkpv = 1

let s:save_cpo = &cpo
set cpo&vim

let s:file_path = expand('%:p')
let s:file_ext = expand('%:e')
let s:src_path=stdpath('data').'/plugged/mkpv.nvim'
let g:mkpv = s:src_path.'/app/mkpv'
let g:auto_open_mkpv = get(g:,'auto_open_mkpv',0)

if exists('g:auto_open_mkpv')
   if s:file_ext == 'md'
     call mkpv#autocmd_init()
     " call mkpv#open_mkpv(s:file_path)
     " call mkpv#open_mkpv(s:tmp_name)
   endif
endif

" let g:auto_scroll_mkpv = get(g:,'auto_scroll_mkpv',1)
"
" if exists('g:auto_scroll_mkpv')
"   echo  line(".") + 1
" endif


command! MKPVOpen call mkpv#open_mkpv(s:tmp_name)
command! MKPVClose call mkpv#close_mkpv()
command! MKPVUpdate call mkpv#update_mkpv()
