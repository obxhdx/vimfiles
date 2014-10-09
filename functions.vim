" Some predefined coloring tweaks {{{
function! ColoringTweaks()
  hi MatchParen ctermfg=235 ctermbg=2
  hi Search ctermfg=15 ctermbg=201
  hi markdownError ctermbg=NONE ctermfg=red

  if !has('gui_running')
    hi LineNr ctermbg=NONE
    hi NonText ctermbg=NONE
    hi Normal ctermbg=NONE
    hi htmlEndTag ctermbg=NONE
    hi htmlTag ctermbg=NONE
    hi StatusLine ctermfg=7 ctermbg=233
  end

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
" }}}

" Use the new Ruby 1.9 syntax {{{
command! NewRubyHashSyntax :%s/\v[:']([a-z]*)'?\s\=\>/\1:/gc
" }}}

" Replace " with ' {{{
command! SingleQuotes :%s/\v"(<[A-Za-z?! ]{-}>)"/'\1'/gc
" }}}

" Remove trailing spaces {{{
autocmd FileType css,gradle,html,javascript,php,ruby,sql,vim autocmd BufWritePre * call Preserve('%s/\s\+$//e')
" }}}

" Preserve cursor state when performing commands like regex replaces (http://goo.gl/DJ7xA)
function! Preserve(command)
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

" Shows syntax highlighting groups for word under cursor {{{
function! <SID>SynStack()
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endf
nmap <leader>sg :call <SID>SynStack()<CR>
" }}}

" True fullscreen for GVim on Linux {{{
function! ToggleFullscreen()
  if executable('wmctrl')
    exec 'silent !wmctrl -r :ACTIVE: -b toggle,fullscreen'
  else
    echo 'You must install wmctrl in order to use GVim fullscreen toggling.'
  endif
endf
nmap <F11> :call ToggleFullscreen()<CR>
" }}}

" Toggles a few options for better long text editing {{{
function! TextEditorMode()
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
endf
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
endf
au VimEnter * call SetWildIgnore($HOME.'/.wildignore')
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

" Displays right hand scrollbar only when needed (GVim) {{{
function! HandleScrollbars()
  if line('$') > &lines
    set guioptions+=r
  else
    set guioptions-=r
  endif
endfunc
" }}}
