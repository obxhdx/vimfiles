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
command! -range=% SingleQuotes :<line1>,<line2>s/\v"(.{-})?"/'\1'/gc
" }}}

" StripTrailingWhitespaces command {{{
command! StripTrailingWhitespaces :call <SID>ExecPreservingCursorPos('%s/\s\+$//e')
autocmd FileType css,gradle,html,javascript,php,ruby,sql,vim autocmd BufWritePre <buffer> StripTrailingWhitespaces
" }}}

" Tabify command (format text in columns) {{{
command! -nargs=1 -range=% Tabify :execute "<line1>,<line2>!sed 's/" . <f-args> . "/@". <f-args> . "/g' | column -s@ -t"
"}}}

fun! Ag(text) "{{{
  let escaped_text = substitute(substitute(a:text, '\n$', '', ''), '\([][)(}{]\)', '\\\1', 'g')

  if escaped_text =~ '\n'
    echohl ErrorMsg | echo 'Multiline search is not supported by Ag' | echohl None
    return
  endif

  execute 'Ag ' . shellescape(escaped_text, 1)
endf
" }}}

fun! CloseHiddenBuffers() "{{{
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

fun! HighlightRemoveAttr(attr) "{{{
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

fun! RestoreRegisterAfterPaste() " {{{
  " From http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity
  let @" = s:restore_reg
  return ''
endf

fun! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegisterAfterPaste()\<cr>"
endf

vmap <silent> <expr> p <SID>Repl()
"}}}

fun! s:ColoringTweaks() "{{{
  set background=dark
  hi Normal ctermbg=NONE

  hi MatchParen ctermfg=196 ctermbg=234
  hi Pmenu ctermfg=236 ctermbg=218

  if g:colors_name == 'iceberg'
    hi! link Folded Comment
    hi! link jpropertiesIdentifier Statement
    hi MatchParen ctermfg=203 ctermbg=234
    hi VertSplit ctermbg=NONE ctermfg=235 term=none cterm=none
    hi Visual ctermbg=239
    hi markdownH2 ctermfg=green
    hi IncSearch ctermbg=203 ctermfg=232 cterm=none term=none
    hi StatusLine ctermbg=236 cterm=none
  endif

  if g:colors_name == 'badwolf'
    hi PmenuSel ctermfg=252 ctermbg=237

    hi FoldColumn ctermbg=NONE
    hi Folded ctermbg=NONE
    hi LineNr ctermbg=NONE
    hi NonText ctermbg=NONE
    hi SpecialKey ctermbg=NONE
    hi VertSplit ctermfg=236 ctermbg=NONE
    hi htmlEndTag ctermbg=NONE
    hi htmlTag ctermbg=NONE
    hi markdownError ctermbg=NONE ctermfg=red

    hi DiffAdd cterm=NONE ctermfg=193 ctermbg=22
    hi DiffChange cterm=NONE ctermfg=NONE ctermbg=24
    hi DiffDelete cterm=NONE ctermfg=16 ctermbg=52
    hi DiffText cterm=reverse ctermfg=81 ctermbg=16
  endif
endf

autocmd ColorScheme * call <SID>ColoringTweaks()
" }}}

fun! s:ExecPreservingCursorPos(command) "{{{
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
endf
" }}}

fun! s:IsWindowAt(dir) "{{{
  let directions = {
        \ 'top': 'k',
        \ 'right': 'l',
        \ 'bottom': 'j',
        \ 'left': 'h'
        \ }

  let current_window = winnr()
  silent! exe "normal! \<c-w>" . directions[a:dir]

  let adjacent_window = winnr()
  silent! exe current_window.'wincmd w'

  return current_window == adjacent_window
endf
"}}}

fun! s:RedefineResizeMappings() "{{{
  if <SID>IsWindowAt('top') && <SID>IsWindowAt('bottom')
    nnoremap <buffer> + <nop>
    nnoremap <buffer> - <nop>
  else
    nnoremap <buffer> + :exec 'resize ' . (winheight(0) * 3/2)<CR>
    nnoremap <buffer> - :exec 'resize ' . (winheight(0) * 2/3)<CR>
  endif

  if <SID>IsWindowAt('right')
    nnoremap <buffer> ( :exec 'vertical resize ' . (winwidth(0) * 3/2)<CR>
    nnoremap <buffer> ) :exec 'vertical resize ' . (winwidth(0) * 2/3)<CR>
  else
    nnoremap <buffer> ) :exec 'vertical resize ' . (winwidth(0) * 3/2)<CR>
    nnoremap <buffer> ( :exec 'vertical resize ' . (winwidth(0) * 2/3)<CR>
  endif
endf

autocmd WinEnter,BufEnter * :call <SID>RedefineResizeMappings()
"}}}

fun! s:SourceFileIfExists(path) "{{{
  let l:expanded_path = expand(a:path)

  if filereadable(l:expanded_path)
    execute 'source ' . l:expanded_path
  else
    echohl ErrorMsg | echo 'File ' . l:expanded_path . ' is not readable' | echohl None
  endif
endf
call <SID>SourceFileIfExists('$HOME/.vimrc.local.vim')
"}}}

fun! s:SyntaxGroupsForWordUnderCursor() "{{{
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endf
nmap <leader>sg :call <SID>SyntaxGroupsForWordUnderCursor()<CR>
" }}}

" vim: set foldmethod=marker :
