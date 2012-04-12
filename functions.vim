" Sorts CSS file (Taken from http://bit.ly/znHbfG)
au FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort

" Displays right hand scrollbar only when needed
function! HandleScrollbars()
  if line('$') > &lines
    set guioptions+=r
  else
    set guioptions-=r
  endif
endfunc

" Shows syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" Just a key map for ease of use
nmap <leader>sg :call <SID>SynStack()<CR>

" Returns '\s' if trailing white space is detected
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '\s'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunc
" Recalculates the trailing whitespace warning when idle, and after saving
autocmd CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning

" Returns number of chars|lines|blocks selected
function! VisualSelectionSize()
  if mode() == "v"
    " Exit and re-enter visual mode, because the marks
    " ('< and '>) have not been updated yet.
    exe "normal \<ESC>gv"
    if line("'<") != line("'>")
      return (line("'>") - line("'<") + 1) . ' lines'
    else
      return (col("'>") - col("'<") + 1) . ' chars'
    endif
  elseif mode() == "V"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . ' lines'
  elseif mode() == "\<C-V>"
    exe "normal \<ESC>gv"
    return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block'
  else
    return ''
  endif
endfunc
