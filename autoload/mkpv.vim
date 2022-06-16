" Copyright (c) 2015 yoehwan
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

function! mkpv#open_mkpv(file_path)
  call mkpv#autocmd_init()
  let output = system(g:mkpv.' open '.a:file_path.' &')
endfunction

function! mkpv#close_mkpv()
  let output = system(g:mkpv.' close')
endfunction

function! mkpv#update_mkpv()
  call s:auto_save()
  " image size?
   call s:auto_scroll()
endfunction

function! mkpv#toggle_auto_scroll()
  if g:auto_scroll_mkpv == 1
    let g:auto_scroll_mkpv=0
  else
   let g:auto_scroll_mkpv=1
  endif
endfunction

function! s:auto_save()
   write
endfunction

function! s:auto_scroll()
  if g:auto_scroll_mkpv == 1
    let current_line = line(".")
    " let max_line = line("$") + 0.0
    " let position = current_line/max_line
    " let output = system(g:mkpv.' scroll '.string(position))
     let output = system(g:mkpv.' scroll '.string(current_line))
  endif
endfunction


function! mkpv#scroll_mkpv(position)
  let output = system(g:mkpv.' close '.a:position)
endfunction

function! mkpv#autocmd_init()
  execute 'augroup MKPV_AUTOCMD_INIT' . bufnr('%')
  autocmd!

  " autocmd CursorMoved,CursorMovedI <buffer> call s:auto_scroll()
  autocmd CursorHold,CursorHoldI <buffer> call mkpv#update_mkpv()
  " auto close  
  autocmd BufHidden,BufLeave,ExitPre <buffer> call mkpv#close_mkpv()
endfunction

function! mkpv#autocmd_dispose()
  execute 'autocmd! ' . 'MKPV_AUTOCMD_INIT' . bufnr('%')
endfunction
