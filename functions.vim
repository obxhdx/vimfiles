" Ag command (grep with Silver Searcher) {{{
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --stats\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
  command! -nargs=+ -complete=file -bar Ag silent! grep! <args> --ignore tags | cwindow | redraw!
  cabbr ag Ag
  nnoremap K :Ag <C-R><C-W><CR>
endif
" }}}

" NewRubyHashSyntax command (use the new Ruby 1.9 syntax) {{{
command! NewRubyHashSyntax :%s/\v[:']([a-z]*)'?\s\=\>/\1:/gc
" }}}

" SingleQuotes command (replaces all " with ') {{{
command! SingleQuotes :%s/\v"(<[A-Za-z?! ]{-}>)"/'\1'/gc
" }}}

" Strip trailing white spaces {{{
command! StripTrailingWhitespaces :call ExecPreservingCursorPos('%s/\s\+$//e')
autocmd FileType css,gradle,html,javascript,php,ruby,sql,vim autocmd BufWritePre <buffer> StripTrailingWhitespaces
" }}}

function! ColoringTweaks() "{{{
  hi LineNr ctermbg=NONE
  hi MatchParen ctermfg=235 ctermbg=2
  hi NonText ctermbg=NONE
  hi Normal ctermbg=NONE
  hi Search ctermfg=15 ctermbg=201
  hi StatusLine ctermfg=7 ctermbg=233
  hi htmlEndTag ctermbg=NONE
  hi htmlTag ctermbg=NONE
  hi markdownError ctermbg=NONE ctermfg=red

  if g:colors_name == 'badwolf'
    hi CursorLineNr ctermbg=235
    hi FoldColumn ctermbg=NONE guibg=NONE
    hi Folded ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
    hi SpecialKey ctermbg=NONE
  endif

  if g:colors_name == 'railscasts'
    hi LineNr ctermbg=234 guibg=#444444
  endif

  if g:colors_name == 'molokai'
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
endf
autocmd ColorScheme * call ColoringTweaks()
" }}}

function! ExecPreservingCursorPos(command) "{{{
  " Taken from http://goo.gl/DJ7xA

  " Save last search and cursor position
  let _s=@/
  let l = line('.')
  let c = col('.')

  " Do the business
  execute a:command

  " Restore previous search history and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" }}}

function! SyntaxGroupsForWordUnderCursor() "{{{
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endf
nmap <leader>sg :call SyntaxGroupsForWordUnderCursor()<CR>
" }}}

function! ToggleFullscreen() "{{{
  if !( has('unix') && has('gui_running') )
    echo 'This function only works in GVim for Linux.'
    return
  endif

  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endf

nmap <F11> :call ToggleFullscreen()<CR>
" }}}

function! TextEditorMode() "{{{
  if !exists('b:texted_mode') || b:texted_mode == 'false'
    let b:texted_mode = 'true'
    setlocal tw=0 fo= wrap lbr nolist spell spl=en,pt showtabline=0
    echo 'Text editor mode enabled.'
  else
    let b:texted_mode = 'false'
    setlocal tw=0 fo=tcq nowrap nolbr nolist nospell showtabline=1
    echo 'Text editor mode disabled.'
  endif
endf
nmap <F10> :call TextEditorMode()<CR>
" }}}

function! s:CloseHiddenBuffers() "{{{
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
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
" }}}

function! SetWildIgnore(ignored_strings_file) "{{{
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

function! HighlightRemoveAttr(attr) "{{{
  " Written by Steve Hall (http://comments.gmane.org/gmane.editors.vim/24861)
  " See :help attr-list for possible attrs to pass

  " Save selection registers
  new
  silent! put

  " Get current highlight configuration
  redir @x
  silent! highlight
  redir END
  " Open temp buffer
  new
  " Paste in
  silent! put x

  " Convert to vim syntax (from Mkcolorscheme.vim, http://vim.sourceforge.net/scripts/script.php?script_id=85)
  " Delete empty 'links' and 'cleared' lines
  silent! g/^$\| links \| cleared/d
  " Join any lines wrapped by the highlight com output
  silent! %s/\n \+/ /
  " Remove the xxx's
  silent! %s/ xxx / /
  " Add highlight coms
  silent! %s/^/highlight /
  " Protect spaces in some font names
  silent! %s/font=\(.*\)/font='\1'/

  " Substitute bold with 'NONE'
  execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
  " Yank entire buffer
  normal ggVG
  " Copy
  silent! normal "xy
  " Run
  execute @x

  " Remove temp buffer
  bwipeout!

  " Restore selection registers
  silent! normal ggVGy
  bwipeout!
endf
" }}}

function! FoldTextForIndentMethod() "{{{
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '+-- ' . printf("%9s", lines_count . ' lines') . ':'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart(line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextend . foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength)
endfunction
" }}}

function! FoldTextForMarkerMethod() "{{{
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" }}}

function! SetFoldText() "{{{
  if &foldmethod == 'indent'
    setlocal foldtext=FoldTextForIndentMethod()
  elseif &foldmethod == 'marker' || &foldmethod == 'expr'
    setlocal foldtext=FoldTextForMarkerMethod()
  endif

  if &foldmethod == 'marker'
    setlocal foldenable
  endif
endfunction
au BufEnter * call SetFoldText()
" }}}

" vim: set foldmethod=marker :
