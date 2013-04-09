" Sorts CSS file (Taken from http://bit.ly/znHbfG) {{{
au FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
" }}}

" Displays right hand scrollbar only when needed {{{
function! HandleScrollbars()
  if line('$') > &lines
    set guioptions+=r
  else
    set guioptions-=r
  endif
endfunc
" }}}

" Returns '\s' if trailing white space is detected {{{
function! StatuslineTrailingSpaceWarning()
  if !exists('b:statusline_trailing_space_warning')
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '\s'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunc

au CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning
" }}}

" Returns number of (chars|lines|blocks) selected {{{
function! VisualSelectionSize()
  if mode() == 'v'
    " Exit and re-enter visual mode, because the marks
    " ('< and '>) have not been updated yet.
    exe "normal \<ESC>gv"
    if line(''<') != line("'>")
      return (line("'>") - line("'<") + 1) . ' lines'
    else
      return (col("'>") - col("'<") + 1) . ' chars'
    endif
  elseif mode() == 'V'
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . ' lines'
  elseif mode() == "\<C-V>"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block'
  else
    return ''
  endif
endfunc
" }}}

" Toggles fullscreen mode {{{
function! ToggleFullscreen()
  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endfunc

nmap <silent> <F11> :call ToggleFullscreen()<CR>
" }}}

" Do not show invisible chars when editing files with no ft {{{
function! HandleUnprintableChars()
  if strlen(&ft) == 0
    set nolist
  else
    set list
  endif
endfunc
" au BufRead,BufWritePost,VimEnter * call HandleUnprintableChars()
" }}}

" Return number of open buffers {{{
function! CountListedBuffers()
  let cnt = 0
  for num in range(1, bufnr('$'))
    if buflisted(num) && !empty(bufname(num))
      let cnt += 1
    endif
  endfor
  return cnt
endfunc
" }}}

" Link buffer being displayed with NERDTree {{{
function! ShowBufferOnNERDTree()
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) > 0
    exec 'NERDTreeFind'
  endif
endfunc
au BufWinEnter * call ShowBufferOnNERDTree()
" }}}
