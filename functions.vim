" Sorts CSS file (Taken from http://bit.ly/znHbfG) {{{
autocmd FileType css command! SortCSSBraceContents :g#\({\n\)\@<=#.,/}/sort
" }}}

" Remove trailing spaces {{{
autocmd BufWritePre *.css,*.html,*.js,*.php,*.rb,*.sql RemoveTrailingSpaces
command! RemoveTrailingSpaces :%s/\s\+$//e | set nohlsearch
" }}}

" Dynamically sets wildignore list {{{
function! SetWildIgnore(ignored_strings_file)
  if filereadable(a:ignored_strings_file)
    let igstring = ''
    for oline in readfile(a:ignored_strings_file)
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
endfunc

autocmd VimEnter * call SetWildIgnore('.wildignore')
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
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <leader>sg :call <SID>SynStack()<CR>
" }}}

" Returns '\s' if trailing white space is detected {{{
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

" Returns number of (chars|lines|blocks) selected {{{
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

" Toggles a few options for better long text editing {{{
function! WordProcessingToggle()
  if !exists('b:wordprocessing') || b:wordprocessing == 'false'
    let b:wordprocessing = 'true'
    setlocal tw=0 fo= wrap lbr nolist spell spl=en,pt
    echo "Word processing mode enabled."
  else
    let b:wordprocessing = 'false'
    setlocal tw=0 fo=tcq nowrap nolbr nolist nospell
    echo "Word processing mode disabled."
  endif
endfunc
" }}}

" Toggles overlength highlighting {{{
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

" Toggles fullscreen mode {{{
function! ToggleFullscreen()
  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endfunc
" }}}

" Do not show invisible chars when editing files with no ft {{{
function! HandleUnprintableChars()
  if strlen(&ft) == 0
    set nolist
  else
    set list
  endif
endfunc
" autocmd BufRead,BufWritePost,VimEnter * call HandleUnprintableChars()
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

" Confirm quit when more than 1 buffer is open {{{
function! ConfirmQuit(save_before_quit)
  let confirmed = 1

  if !empty(bufname('%')) && (exists("t:NERDTreeBufName") && !(match(bufname('%'), t:NERDTreeBufName) > -1))
    let open_buffers = CountListedBuffers()

    if open_buffers > 1
      let confirmed = confirm("There are " . open_buffers . " buffers open.\nDo you really want to quit?", "&Yes\n&No")
    endif
  endif

  if confirmed == 1
    if a:save_before_quit == 1
      exec "w"
    endif

    exec "quit"
  endif
endfunc

cnoremap <silent> q<CR> call ConfirmQuit(0)<CR>
cnoremap <silent> x<CR> call ConfirmQuit(0)<CR>
cnoremap <silent> wq<CR> call ConfirmQuit(1)<CR>
" }}}

" Close all hidden buffers {{{
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i + 1))
  endfor

  for num in range(1, bufnr("$") + 1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec "bdelete ".num
    endif
  endfor
endfunc

command! CloseHiddenBuffers call s:CloseHiddenBuffers()
" }}}

" Link buffer being displayed with NERDTree {{{
function! ShowBufferOnNERDTree()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) > 0
    exec "NERDTreeFind"
  endif
endfunc

autocmd BufWinEnter * call ShowBufferOnNERDTree()
" }}}

" {{{
" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction

command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')

cnoremap bd Bclose
cnoremap bd! Bclose!
" }}}
