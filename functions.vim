" Remove trailing spaces {{{
command! RemoveTrailingSpaces :%s/\s\+$//e | exec 'nohlsearch'
au BufWritePre *.css,*.html,*.js,*.php,*.rb,*.ru,*.sql RemoveTrailingSpaces
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

" Toggles a few options for better long text editing {{{
function! s:WordProcessingToggle()
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
command! WordProcessingToggle call s:WordProcessingToggle()
" }}}

" Close all hidden buffers {{{
function! s:CloseHiddenBuffers()
  let open_buffers = []

  for i in range(tabpagenr('$'))
    call extend(open_buffers, tabpagebuflist(i+1))
  endfor

  for num in range(1, bufnr('$')+1)
    if buflisted(num) && index(open_buffers, num) == -1
      exec 'bdelete '.num
    endif
  endfor
endfunc
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
" }}}

" Toggles overlength highlighting {{{
highlight ColorColumn ctermfg=9
highlight OverLength ctermbg=9 ctermfg=9 ctermbg=none

function! s:OverlengthToggle()
  if !exists('b:overlength') || b:overlength == 'false'
    call OverlengthToggle(1)
    echo 'Overlength highlighting enabled.'
  else
    call OverlengthToggle(0)
    echo 'Overlength highlighting disabled.'
  endif
endfunc
command! OverlengthToggle call s:OverlengthToggle()

function! OverlengthToggle(enable)
  if (a:enable)
    let b:overlength = 'true'
    set colorcolumn=80
    match OverLength /\%>80v.\+/
  else
    let b:overlength = 'false'
    set colorcolumn=
    match OverLength //
  endif
endfunc
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
  else
    echo "Can't open file " . a:ignored_strings_file
  endif
endfunc
au VimEnter * call SetWildIgnore($HOME.'/.wildignore')
" }}}
