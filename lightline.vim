" Components
"
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'paste' ], [ 'mode' ], [ 'fugitive' ], [ 'filename' ], [ 'flags' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', 'trailing', 'indentation', 'syntastic' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename' ], [ 'flags' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component_function': {
      \   'mode': 'MyMode',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFileName',
      \   'flags': 'MyFlags',
      \   'fileformat': 'MyFileFormat',
      \   'fileencoding': 'MyFileEncoding',
      \   'filetype': 'MyFileType',
      \   'percent': 'MyPercent',
      \   'lineinfo': 'MyLineInfo',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \   'trailing': 'TrailingSpaceWarning',
      \   'indentation': 'MixedIndentSpaceWarning',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \   'trailing': 'warning',
      \   'indentation': 'warning',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyMode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! MyFugitive()
  let fname = expand('%:t')
  try
    if &ft !~? 'help' && fname !~? 'NERD' && exists('*fugitive#head')
      let mark = ' '
      let _ = fugitive#head()
      return strlen(_) ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileName()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' :
        \ ('' != fname ? fname : '[No Name]')
endfunction

function! MyModified()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' :
        \ &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! MyFlags()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
       \ ('' != MyModified() ? MyModified() . ' ' : '')
endfunction

function! MyFileFormat()
  return &ft !~? 'help' && winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFileEncoding()
  return &ft !~? 'help' && winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyLineInfo()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' : printf(" %3d:%-2d", line('.'), col('.'))
endfunction

function! MyPercent()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' : printf("%3d%%", line('.') * 100 / line('$'))
endfunction

autocmd CursorHold,BufWritePost,InsertLeave * call s:component_expand()
function! s:component_expand()
  call TrailingSpaceWarning()
  call MixedIndentSpaceWarning()
  call lightline#update()
endfunction

function! TrailingSpaceWarning()
  if &ft == 'help' || winwidth(0) < 70
    return ''
  endif

  let trailing = search('\s$', 'nw')
  if trailing != 0
    return '… trailing[' . trailing . ']'
  else
    return ''
  endif
endfunction

function! MixedIndentSpaceWarning()
  if &ft == 'help' || winwidth(0) < 70
    return ''
  endif

  let tabs = search('^\t', 'nw')
  let spaces = search('^ ', 'nw')

  if (tabs != 0) && (spaces != 0)
    return '» mixed-indent[' . tabs . ']'
  else
    return ''
  endif
endfunction

" Colors
"
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ ['white', 'red'], ['darkestgreen', 'brightgreen', 'bold'], ['white', 'gray4'], [ 'white', 'gray4', 'bold' ], [ 'red', 'gray2' ] ]
let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]
let s:p.normal.right = [ ['gray5', 'gray10'], ['gray9', 'gray4'], ['gray8', 'gray2'] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'brightorange' ] ]

let s:p.visual.left = [ s:p.normal.left[0], ['darkred', 'brightorange', 'bold'], s:p.normal.left[2], s:p.normal.left[3], s:p.normal.left[4] ]

let s:p.insert.left = [ s:p.normal.left[0], ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'], ['white', 'darkblue', 'bold'] ]
let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]

let s:p.replace.left = [ s:p.normal.left[0], ['white', 'brightred', 'bold'], s:p.normal.left[2], s:p.normal.left[3], s:p.normal.left[4] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right

let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
let s:p.inactive.left = [ s:p.inactive.right[1], s:p.normal.middle[0] ]

let s:p.tabline.left = [ [ 'gray9', 'gray1' ] ]
let s:p.tabline.tabsel = [ [ 'gray9', 'gray4' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray8' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray3' ] ]

let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#fill(s:p)
