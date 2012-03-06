" Sort CSS file (Stack Overflow => http://bit.ly/znHbfG)
au FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <leader>sg :call <SID>SynStack()<CR>

" Dynamically sets wildignore list
let filename = '.wildignore'
if filereadable(filename)
  let igstring = ''
  for oline in readfile(filename)
    let line = substitute(oline, '\s|\n|\r', '', "g")
    if line =~ '^#' | con | endif
    if line == '' | con  | endif
    if line =~ '^!' | con  | endif
    if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
    let igstring .= "," . line
  endfor
  let execstring = "set wildignore=".substitute(igstring, '^,', '', "g")
  execute execstring
endif

" Return '\s' if trailing white space is detected
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

" Recalculate the trailing whitespace warning when idle, and after saving
au CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning

" Return number of chars|lines|blocks selected
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
