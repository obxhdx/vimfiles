" Align command (format text in columns) {{{
command! -nargs=1 -range=% Align :execute "<line1>,<line2>!sed 's/" . <f-args> . "/@". <f-args> . "/g' | column -s@ -t"
"}}}

" StripTrailingWhitespaces command {{{
command! StripTrailingWhitespaces :call <SID>ExecPreservingCursorPos('%s/\s\+$//e')
" }}}

fun! s:CloseHiddenBuffers() "{{{
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i+1))
  endfor

  for num in range(1, bufnr('$')+1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec 'bdelete '.num
    endif
  endfor
endf
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
" }}}

fun! s:ExecPreservingCursorPos(command) "{{{
  " Taken from http://goo.gl/DJ7xA

  " Save last search and cursor position
  let _s=@/
  let l = line('.')
  let c = col('.')

  " Do the business
  execute a:command

  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endf
" }}}

fun! s:GitAnnotate() "{{{
  " save cursor position
  let l:current_line = line('.')

  " create annotate buffer
  execute 'vnew | 0read !git annotate '.expand('%')." | awk '{print $1,$2,$3}' | sed -E 's/\\( ?//g'"
  " adjust buffer width to longest line
  execute 'vertical resize '.max(map(getline(1,'$'), 'len(v:val)'))
  " delete last line
  execute 'normal Gddgg'

  " configure annotate buffer
  setlocal bufhidden=hide buftype=nofile nobuflisted nonumber noswapfile nomodifiable statusline=git-annotate
  silent! file git-annotate

  " lock cursor and scroll
  windo setlocal cursorbind scrollbind
  windo execute 'normal '.l:current_line.'Gzz'
  wincmd h

  " unlock when annotate buffer closes
  autocmd BufHidden git-annotate windo set nocursorbind noscrollbind
endf
autocmd BufEnter git-annotate DimInactiveOff
command! GitAnnotate :call s:GitAnnotate()
"}}}

fun! s:SyntaxGroupsForWordUnderCursor() "{{{
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endf
nmap <leader>sg :call <SID>SyntaxGroupsForWordUnderCursor()<CR>
" }}}

" vim: set foldmethod=marker :
