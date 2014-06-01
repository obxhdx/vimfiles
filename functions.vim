" Remove trailing spaces {{{
command! RemoveTrailingSpaces :%s/\s\+$//e | exec 'nohlsearch'
autocmd FileType css,html,javascript,php,ruby,sql au BufWritePre * RemoveTrailingSpaces
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

" True fullscreen for GVim on Linux {{{
function! ToggleFullscreen()
  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endfunc
nmap <F11> :call ToggleFullscreen()<CR>
" }}}

" Toggles a few options for better long text editing {{{
function! s:TextEditorMode()
  if !exists('b:texted_mode') || b:texted_mode == 'false'
    let b:texted_mode = 'true'
    setlocal tw=0 fo= wrap lbr nolist spell spl=en,pt
    echo 'Text editor mode enabled.'
  else
    let b:texted_mode = 'false'
    setlocal tw=0 fo=tcq nowrap nolbr nolist nospell
    echo 'Text editor mode disabled.'
  endif
endfunc
command! TExtEditorMode call s:TextEditorMode()
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
autocmd VimEnter * call SetWildIgnore($HOME.'/.wildignore')
" }}}

" Use Tab to trigger completion and snippets {{{
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  endif

  if pumvisible() > 0
    return "\<C-p>"
  endif

  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res > 0
    return ""
  endif

  return "\<C-p>"
endfunction

inoremap <Tab> <C-R>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-N>
" }}}

" Function written by Steve Hall on vim@vim.org
" See :help attr-list for possible attrs to pass
function! HighlightRemoveAttr(attr)
  " save selection registers
  new
  silent! put

  " get current highlight configuration
  redir @x
  silent! highlight
  redir END
  " open temp buffer
  new
  " paste in
  silent! put x

  " convert to vim syntax (from Mkcolorscheme.vim,
  "   http://vim.sourceforge.net/scripts/script.php?script_id=85)
  " delete empty,'links' and 'cleared' lines
  silent! g/^$\| links \| cleared/d
  " join any lines wrapped by the highlight command output
  silent! %s/\n \+/ /
  " remove the xxx's
  silent! %s/ xxx / /
  " add highlight commands
  silent! %s/^/highlight /
  " protect spaces in some font names
  silent! %s/font=\(.*\)/font='\1'/

  " substitute bold with 'NONE'
  execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
  " yank entire buffer
  normal ggVG
  " copy
  silent! normal "xy
  " run
  execute @x

  " remove temp buffer
  bwipeout!

  " restore selection registers
  silent! normal ggVGy
  bwipeout!
endfunction
