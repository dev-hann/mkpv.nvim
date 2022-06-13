if exists('g:loaded_mkpv')
  finish
endif

let g:loaded_mkpv = 1

let s:save_cpo = &cpo
set cpo&vim

let s:file_ext = expand('%:e')
let s:src_path=stdpath('data').'/plugged/mkpv.nvim'
let g:mkpv = s:src_path.'/app/mkpv'

let g:auto_open_mkpv = get(g:,'auto_open_mkpv',0)
let g:auto_scroll_mkpv = get(g:,'auto_scroll_mkpv',1)



function! s:file_path()
  let temp_path=expand('%:p')
  if !isdirectory(temp_path)
    return temp_path
  endif
  let buffer_name=bufname()
  return temp_path.buffer_name
endfunction


if exists('g:auto_open_mkpv')
   " if bufname() == 'md'
     " call mkpv#open_mkpv(file_path())
     " call mkpv#open_mkpv(s:tmp_name)
   " endif
endif

command! MKPVOpen call mkpv#open_mkpv(s:file_path())
command! MKPVClose call mkpv#close_mkpv()
command! MKPVUpdate call mkpv#update_mkpv()
command! MKPVToggleAutoScroll call mkpv#toggle_auto_scroll()
