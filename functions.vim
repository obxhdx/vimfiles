" Ag command (grep with Silver Searcher) {{{
set grepprg=ag\ --nogroup\ --nocolor\ --stats\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
command! -nargs=+ -complete=file -bar Ag silent! grep! <args> --ignore tags | cwindow | redraw!
cabbr ag Ag
" }}}

" NewRubyHashSyntax command (use the new Ruby 1.9 syntax) {{{
command! -range=% NewRubyHashSyntax :<line1>,<line2>s/\v(:|'|")?([[:alnum:]_]{-})('|")?\s\=\>/\2:/gc
" }}}

" SingleQuotes command (replaces all " with ') {{{
command! -range=% SingleQuotes :<line1>,<line2>s/\v"(<[[:alnum:][:punct:][:blank:]]{-}>)?"/'\1'/gc
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
  hi ErrorMsg ctermbg=NONE

  if g:colors_name == 'badwolf'
    hi CursorLineNr ctermbg=235
    hi FoldColumn ctermbg=NONE guibg=NONE
    hi Folded ctermbg=NONE guibg=NONE
    hi SignColumn ctermbg=NONE guibg=NONE
    hi SpecialKey ctermbg=NONE
    hi VertSplit ctermfg=236 ctermbg=NONE guibg=NONE
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

  autocmd FileType ruby syntax match Error '\<binding.pry\>'
endf
autocmd ColorScheme * call ColoringTweaks()
" }}}

function! DistractionFreeMode() "{{{
  if get(b:, 'distraction_free_on') == 0
    setlocal nonu
    setlocal nocursorline
    setlocal laststatus=0
    let b:wuc_disabled = 1
    call s:ClearAllSearchMatches()
    silent! call lightline#disable()
    silent! !tmux set -q status off
    silent! Limelight
  else
    setlocal nu
    setlocal cursorline
    setlocal laststatus=2
    let b:wuc_disabled = 0
    call s:ClearAllSearchMatches()
    silent! call lightline#enable()
    silent! !tmux set -q status on
    silent! Limelight!
  endif

  let b:distraction_free_on = !get(b:, 'distraction_free_on')
endfunction
command! DistractionFreeMode :call DistractionFreeMode()
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
    setlocal wrap lbr nolist spell spl=en,pt showtabline=0
    echo 'Text editor mode enabled.'
  else
    let b:texted_mode = 'false'
    setlocal nowrap nolbr nolist nospell showtabline=1
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
  silent! call s:ClearMatchList(w:wuc_match_ids)

  if get(b:, 'wuc_disabled') == 1
    return
  endif

  let s:match_groups = map(copy(getmatches()), 'v:val["group"]')
  if !empty(filter(s:match_groups, 'v:val == "ObliqueCurrentMatch"'))
    return
  endif

  if !exists('w:wuc_match_ids')
    let w:wuc_match_ids = []
  endif

  let s:word = expand('<cword>')
  let s:word = substitute(s:word, '[^[:alnum:]_-]', '', 'g')
  if len(s:word) > 1
    call add(w:wuc_match_ids, matchadd('WordUnderCursor', '\<'.s:word.'\>', 0))
  endif
endfunction

highlight WordUnderCursor ctermbg=236 ctermfg=magenta

autocmd FileType * autocmd CursorHold * call s:HighlightWordUnderCursor()
autocmd BufRead * if expand('%:t') =~ 'NERD' | let b:wuc_disabled = 1 | endif

command! ToggleWordUnderCursor let b:wuc_disabled = !get(b:, 'wuc_disabled')
"}}}

function! s:ClearAllSearchMatches() "{{{
  if get(g:, 'freeze_search_matches') == 0
    silent! call s:ClearMatchList(w:wuc_match_ids)
  endif
endfunction

function! s:ClearMatchList(list)
  if type(a:list) == type([])
    while !empty(a:list)
      call matchdelete(remove(a:list, -1))
    endwhile
  endif
endfunction

autocmd! CursorMoved * call s:ClearAllSearchMatches()
command! FreezeSearchMatches let g:oblique#clear_highlight = 0 | set hlsearch
command! UnfreezeSearchMatches let g:oblique#clear_highlight = 1 | call clearmatches() | set nohlsearch
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

function! ZoomWindow() "{{{
  if get(g:, 'window_zommed_in') == 0
    call feedkeys("\<C-W>_\<C-W>|")
  else
    call feedkeys("\<C-W>=")
  endif

  let g:window_zommed_in = !get(g:, 'window_zommed_in')
endfunction

nnoremap <C-W>z :call ZoomWindow()<CR>
"}}}

" Prevent vp from replacing paste buffer {{{
" From http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction

function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction

vmap <silent> <expr> p <sid>Repl()
"}}}

" Act on text objects with custom functions {{{1
" Adapted from unimpaired.vim by Tim Pope
" Source: http://vim.wikia.com/wiki/Act_on_text_objects_with_custom_functions

function! s:DoAction(algorithm,type) "{{{2
  " backup settings that we will change
  let sel_save = &selection
  let cb_save = &clipboard
  " make selection and clipboard work the way we need
  set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
  " backup the unnamed register, which we will be yanking into
  let reg_save = @@
  " yank the relevant text, and also set the visual selection (which will be reused if the text
  " needs to be replaced)
  if a:type =~ '^\d\+$'
    " if type is a number, then select that many lines
    silent exe 'normal! V'.a:type.'$y'
  elseif a:type =~ '^.$'
    " if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then reselect the visual region
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    " line-based text motion
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    " block-based text motion
    silent exe "normal! `[\<C-V>`]y"
  else
    " char-based text motion
    silent exe "normal! `[v`]y"
  endif
  " call the user-defined function, passing it the contents of the unnamed register
  let repl = s:{a:algorithm}(@@)
  " if the function returned a value, then replace the text
  if type(repl) == 1
    " put the replacement text into the unnamed register, and also set it to be a
    " characterwise, linewise, or blockwise selection, based upon the selection type of the
    " yank we did above
    call setreg('@', repl, getregtype('@'))
    " relect the visual region and paste
    normal! gvp
  endif
  " restore saved settings and register value
  let @@ = reg_save
  let &selection = sel_save
  let &clipboard = cb_save
endfunction
"}}}2

function! s:ActionOpfunc(type) "{{{2
  return s:DoAction(s:encode_algorithm, a:type)
endfunction
"}}}2

function! s:ActionSetup(algorithm) "{{{2
  let s:encode_algorithm = a:algorithm
  let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_') . 'ActionOpfunc'
endfunction
"}}}2

function! MapAction(algorithm, key) "{{{2
  execute 'nnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call <SID>ActionSetup("'.a:algorithm.'")<CR>g@'
  execute 'xnoremap <silent> <Plug>actions'    .a:algorithm.' :<C-U>call <SID>DoAction("'.a:algorithm.'",visualmode())<CR>'
  execute 'nnoremap <silent> <Plug>actionsLine'.a:algorithm.' :<C-U>call <SID>DoAction("'.a:algorithm.'",v:count1)<CR>'
  execute 'nmap '.a:key.' <Plug>actions'.a:algorithm
  execute 'xmap '.a:key.' <Plug>actions'.a:algorithm
  execute 'nmap '.a:key.a:key[strlen(a:key)-1].' <Plug>actionsLine'.a:algorithm
endfunction
"}}}2

call MapAction('SendTextToREPL', '<leader>t') " {{{2
function! s:SendTextToREPL(str)
  execute 'SlimuxREPLSendSelection'
endfunction
"}}}2

call MapAction('AckWithMotions', '<leader>g') " {{{2
function! s:AckWithMotions(str)
  try
    execute 'Ag ' . shellescape(a:str, 1)
  catch
    redraw!
    echohl WarningMsg | echo 'AckWithMotions does not play well with line breaks' | echohl None
  endtry
endfunction
"}}}2
"}}}1

" Send keystrokes to REPL using Slimux {{{
function! SendKeysToREPL()
  let l:keys = ""
  if getchar(1)
    let l:keys = nr2char(getchar())
  endif
  call SlimuxSendKeys(l:keys)
  call feedkeys("\<Esc>")
  return ""
endfunction

imap <C-y><Esc> <Nop> | imap <C-y> <C-r>=SendKeysToREPL()<cr>
nnoremap <Leader>k :call feedkeys("i\<C-y>")<CR>
"}}}

" vim: set foldmethod=marker :
