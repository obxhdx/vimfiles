" Sorts CSS file (Taken from http://bit.ly/znHbfG) {{{
au FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
" }}}

" Remove trailing spaces {{{
command! RemoveTrailingSpaces :%s/\s\+$//e | exec 'nohlsearch'
au BufWritePre *.css,*.html,*.js,*.php,*.rb,*.sql RemoveTrailingSpaces
" }}}

" Dynamically sets wildignore list {{{
function! SetWildIgnore(ignored_strings_file)
  if filereadable(a:ignored_strings_file)
    let igstring = ''
    for oline in readfile(a:ignored_strings_file)
      let line = substitute(oline, '\s|\n|\r', '', 'g')
      if line =~ '^#' | con | endif
      if line == '' | con  | endif
      if line =~ '^!' | con  | endif
      if line =~ '/$' | let igstring .= ',' . line . '*' | con | endif
      let igstring .= ',' . line
    endfor
    let execstring = 'set wildignore='.substitute(igstring, '^,', '', 'g')
    execute execstring
  endif
endfunc

au VimEnter * call SetWildIgnore('.wildignore')
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

" Shows syntax highlighting groups for word under cursor {{{
function! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <leader>sg :call <SID>SynStack()<CR>
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

" Toggles a few options for better long text editing {{{
function! WordProcessingToggle()
  if !exists('b:wordprocessing') || b:wordprocessing == 'false'
    let b:wordprocessing = 'true'
    setlocal tw=0 fo= wrap lbr nolist spell spl=en,pt
    echo 'Word processing mode enabled.'
  else
    let b:wordprocessing = 'false'
    setlocal tw=0 fo=tcq nowrap nolbr nolist nospell
    echo 'Word processing mode disabled.'
  endif
endfunc
" }}}

" Toggles overlength highlighting {{{
highlight ColorColumn ctermfg=9
highlight OverLength ctermbg=9 ctermfg=9 ctermbg=none

function! HighlightOverLength()
  if !exists('b:overlength') || b:overlength == 'false'
    call EnableOverlengthHighlighting()
    echo 'Overlength highlighting enabled.'
  else
    call DisableOverlengthHighlighting()
    echo 'Overlength highlighting disabled.'
  endif
endfunc

function! EnableOverlengthHighlighting()
  let b:overlength = 'true'
  set colorcolumn=80
  match OverLength /\%>80v.\+/
endfunc

function! DisableOverlengthHighlighting()
  let b:overlength = 'false'
  set colorcolumn=
  match OverLength //
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

" Close all hidden buffers {{{
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr('$') + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec 'bdelete '.num
    endif
  endfor
endfunc

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
" }}}

" Link buffer being displayed with NERDTree {{{
function! ShowBufferOnNERDTree()
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) > 0
    exec 'NERDTreeFind'
  endif
endfunc

au BufWinEnter * call ShowBufferOnNERDTree()
" }}}
