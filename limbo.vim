" Sorts CSS file (http://bit.ly/znHbfG) {{{
autocmd FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
" }}}

" Link buffer being displayed with NERDTree {{{
function! ShowBufferOnNERDTree()
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) > 0
    exec 'NERDTreeFind'
  endif
endfunc
autocmd BufWinEnter * call ShowBufferOnNERDTree()
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

" Returns number of (chars|lines|blocks) selected {{{
function! VisualSelectionSize()
  if mode() == 'v'
    " Exit and re-enter visual mode, because the marks ('< and '>) have not been updated yet
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

" A few tweaks for molokai {{{
function! FixMolokai()
  if g:colors_name == 'molokai'
    " General
    hi Define guifg=#F92672
    hi Special gui=none
    hi Type gui=italic

    " Ruby highlighting
    hi rubyClass guifg=#F92672 gui=none
    hi rubyControl guifg=#F92672 gui=none
    hi rubyRailsARMethod guifg=#A6E22E
    hi rubyRailsMethod guifg=#A4E7F4
    hi link rubyRailsControllerMethod rubyRailsARMethod

    " Markdown highlighting
    hi markdownH2 guifg=pink
    hi link markdownH3 markdownH2
    hi link markdownH4 markdownH2
    hi link markdownH5 markdownH2
    hi link markdownH6 markdownH2
  endif
endfunc
" }}}
