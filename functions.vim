" Dynamically sets wildignore list {{{
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
" }}}

" Sorts CSS file (Taken from http://bit.ly/znHbfG) {{{
autocmd FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
" }}}

" HandleScrollbars(): Displays right hand scrollbar only when needed {{{
function! HandleScrollbars()
  if line('$') > &lines
    set guioptions+=r
  else
    set guioptions-=r
  endif
endfunc
" }}}

" <SID>SynStack(): Shows syntax highlighting groups for word under cursor {{{
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <leader>sg :call <SID>SynStack()<CR>
" }}}

" StatuslineTrailingSpaceWarning(): Returns '\s' if trailing white space is detected {{{
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
autocmd CursorHold,BufWritePost,InsertLeave * unlet! b:statusline_trailing_space_warning
" }}}

" VisualSelectionSize(): Returns number of (chars|lines|blocks) selected {{{
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
" }}}

" WordProcessingToggle(): Toggles a few options for better long text editing {{{
function! WordProcessingToggle()
  if !exists('b:wordprocessing') || b:wordprocessing == 'false'
    let b:wordprocessing = 'true'
    setlocal tw=0 fo= lbr nolist sbr= spell spl=en,pt
    echo "Word processing mode enabled."
  else
    let b:wordprocessing = 'false'
    setlocal tw=80 fo=tcq nolbr list sbr=... nospell
    echo "Word processing mode disabled."
  endif
endfunc
" }}}

" HighlightOverLength(): Toggles overlength highlighting {{{
function! HighlightOverLength()
  highlight OverLength ctermbg=52 guibg=#592929

  if !exists('b:overlength') || b:overlength == 'false'
    let b:overlength = 'true'
    match OverLength /\%>80v.\+/
    echo "Overlength highlighting enabled."
  else
    let b:overlength = 'false'
    match OverLength //
    echo "Overlength highlighting disabled."
  endif
endfunc
" }}}

" HighlightOverLength(): Toggles overlength highlighting {{{
function! ToggleFullscreen()
  if !exists('g:fullscreen') || g:fullscreen == 0
    let g:fullscreen = 1
    let mod = "add"
  else
    let g:fullscreen = 0
    let mod = "remove"
  endif
  exec 'silent !wmctrl -r :ACTIVE: -b ' . mod . ',fullscreen'
endfunc
" }}}
