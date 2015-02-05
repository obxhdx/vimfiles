" Ag command (grep with Silver Searcher) {{{
set grepprg=ag\ --nogroup\ --nocolor\ --stats\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
command! -nargs=+ -complete=file -bar Ag silent! grep! <args> --ignore tags | cwindow | redraw!
cabbr ag Ag
" }}}

" Grep with motions (http://goo.gl/iB5nFs) {{{
function! s:AckMotion(type) abort
  let reg_save = @@

  call s:CopyMotionForType(a:type)

  execute "normal! :Ag " . shellescape(@@) . "\<cr>"

  let @@ = reg_save
endfunction

function! s:CopyMotionForType(type)
  if a:type ==# 'v'
    silent execute "normal! `<" . a:type . "`>y"
  elseif a:type ==# 'char'
    silent execute "normal! `[v`]y"
  endif
endfunction

nnoremap <silent> <Leader>g :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> <Leader>g :<C-U>call <SID>AckMotion(visualmode())<CR>
" }}}

" NewRubyHashSyntax command (use the new Ruby 1.9 syntax) {{{
command! -range=% NewRubyHashSyntax :<line1>,<line2>s/\v[:']([a-z_]*)'?\s\=\>/\1:/gc
" }}}

" SingleQuotes command (replaces all " with ') {{{
command! -range=% SingleQuotes :<line1>,<line2>s/\v"(<[A-Za-z?! ]{-}>)"/'\1'/gc
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
  hi Search ctermfg=255 ctermbg=198
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

function! s:DidYouMean() "{{{
  let matching_files = split(glob(expand('%').'*', 1), '\n')
  if empty(matching_files)
    return
  endif

  let shown_items = ['Did you mean:']
  for i in range(1, len(matching_files))
    call add(shown_items, i.'. '.matching_files[i-1])
  endfor

  let chosen_number = inputlist(shown_items)
  if chosen_number >= 1 && chosen_number <= len(matching_files)
    let empty_buffer_nr = bufnr("%")
    execute ':edit ' . matching_files[chosen_number-1]
    execute ':silent bdelete ' . empty_buffer_nr
    filetype detect
  endif
endfunction

autocmd BufNewFile * call s:DidYouMean()
"}}}

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
    setlocal fo+=a wrap lbr nolist spell spl=en,pt showtabline=0
    echo 'Text editor mode enabled.'
  else
    let b:texted_mode = 'false'
    setlocal fo-=a nowrap nolbr nolist nospell showtabline=1
    echo 'Text editor mode disabled.'
  endif
endf
nmap <F10> :call TextEditorMode()<CR>
" }}}

function! CloseHiddenBuffers() "{{{
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
command! CloseHiddenBuffers call CloseHiddenBuffers()
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

function! s:HighlightWordUnderCursor() "{{{
  if get(g:, 'wuc_disabled') == 1
    return
  endif

  let s:word = expand('<cword>')
  let s:word = substitute(s:word, '[^[:alnum:]_-]', '', 'g')
  if len(s:word) > 1
    execute 'match WordUnderCursor /\v<'.s:word.'>/'
  endif
endfunction

highlight WordUnderCursor ctermbg=236 ctermfg=magenta

autocmd FileType * set updatetime=300
autocmd FileType * autocmd CursorHold * call s:HighlightWordUnderCursor()

command! ToggleWordUnderCursor let g:wuc_disabled = !get(g:, 'wuc_disabled')
"}}}

function! HighlightSearchMatches(use_cword) "{{{
  if get(g:, 'clear_search_warning') == 1
    let v:warningmsg = ''
    let g:clear_search_warning = 0
  endif

  if (v:warningmsg =~ 'search hit .*, continuing at .*')
    let g:clear_search_warning = 1
  else
    echo '/'.@/
  endif

  if a:use_cword == 1
    let @/ = '\<'.expand('<cword>').'\>'
  endif
  call clearmatches()
  call matchadd('Search', '\c'.@/, 11)
  call matchadd('IncSearch', '\c\%#'.@/, 11)
  call histadd('/', @/)
  call search_pulse#Pulse()
endfunction

nnoremap <silent> gd gdzv:call HighlightSearchMatches(0)<CR>
nnoremap <silent> gD gDzv:call HighlightSearchMatches(0)<CR>
nnoremap <silent> * *:call HighlightSearchMatches(0)<CR>
nnoremap <silent> # #:call HighlightSearchMatches(0)<CR>
nnoremap <silent> n zvn:call HighlightSearchMatches(0)<CR>
nnoremap <silent> N zvN:call HighlightSearchMatches(0)<CR>
nnoremap <silent> / zn:exec('cnoremap <'.'CR> <'.'CR>:exec("cunmap <"."CR>")<'.'CR>:call HighlightSearchMatches(0)<'.'CR>')<CR>/
nnoremap <silent> ? zn:exec('cnoremap <'.'CR> <'.'CR>:exec("cunmap <"."CR>")<'.'CR>:call HighlightSearchMatches(0)<'.'CR>')<CR>?
nnoremap <silent> <Leader>* :call HighlightSearchMatches(1)<CR>
"}}}

function! s:ClearSearchMatches() "{{{
  if get(g:, 'freeze_search_matches') == 0
    call clearmatches()
    set nohlsearch
  endif
endfunction

autocmd! CursorMoved * call s:ClearSearchMatches()
command! FreezeSearchMatches let g:freeze_search_matches = 1
command! UnfreezeSearchMatches let g:freeze_search_matches = 0
"}}}

function! s:SearchSelectedText(cmd_type) "{{{
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmd_type.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap <silent> * :<C-u>call <SID>SearchSelectedText('/')<CR>/<C-R>=@/<CR><CR>:call HighlightSearchMatches(0)<CR>
xnoremap <silent> # :<C-u>call <SID>SearchSelectedText('?')<CR>?<C-R>=@/<CR><CR>:call HighlightSearchMatches(0)<CR>
xnoremap <silent> <Leader>* :<C-u>call <SID>SearchSelectedText('/')<CR>:call HighlightSearchMatches(0)<CR>
"}}}

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
