" Some predefined coloring tweaks {{{
fun! ColoringTweaks()
  highlight MatchParen ctermfg=235 ctermbg=2
  highlight Search ctermfg=15 ctermbg=201
  highlight markdownError ctermbg=NONE ctermfg=red

  if !has('gui_running')
    highlight LineNr ctermbg=NONE
    highlight NonText ctermbg=NONE
    highlight Normal ctermbg=NONE
    highlight htmlEndTag ctermbg=NONE
    highlight htmlTag ctermbg=NONE
    highlight StatusLine ctermfg=7 ctermbg=233
  end
endf
" }}}

" Remove trailing spaces {{{
com! RemoveTrailingSpaces :%s/\s\+$//e | exec 'nohlsearch'
au FileType css,html,javascript,php,ruby,sql au BufWritePre * RemoveTrailingSpaces
" }}}

" Shows syntax highlighting groups for word under cursor {{{
func! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endf
nmap <leader>sg :call <SID>SynStack()<CR>
" }}}

" True fullscreen for GVim on Linux {{{
func! ToggleFullscreen()
  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endf
nmap <F11> :call ToggleFullscreen()<CR>
" }}}

" Toggles a few options for better long text editing {{{
func! TextEditorMode()
  if !exists('b:texted_mode') || b:texted_mode == 'false'
    let b:texted_mode = 'true'
    setlocal tw=0 fo= wrap lbr nolist spell spl=en,pt
    echo 'Text editor mode enabled.'
  else
    let b:texted_mode = 'false'
    setlocal tw=0 fo=tcq nowrap nolbr nolist nospell
    echo 'Text editor mode disabled.'
  endif
endf
nmap <F10> :call TextEditorMode()<CR>
" }}}

" Close all hidden buffers {{{
func! s:CloseHiddenBuffers()
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
com! CloseHiddenBuffers call s:CloseHiddenBuffers()
" }}}

" Dynamically sets wildignore list {{{
func! SetWildIgnore(ignored_strings_file)
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
endf
au VimEnter * call SetWildIgnore($HOME.'/.wildignore')
" }}}

" Function written by Steve Hall on vim@vim.org
" See :help attr-list for possible attrs to pass
func! HighlightRemoveAttr(attr)
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
  " join any lines wrapped by the highlight com output
  silent! %s/\n \+/ /
  " remove the xxx's
  silent! %s/ xxx / /
  " add highlight coms
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
endf
