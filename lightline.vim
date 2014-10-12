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
let s:black           = [ '#000000', 16  ]
let s:blue            = [ '#268bd2', 33  ]
let s:brightestorange = [ '#ffaf00', 214 ]
let s:brightestred    = [ '#ff0000', 196 ]
let s:brightgreen     = [ '#afdf00', 148 ]
let s:brightorange    = [ '#ff8700', 208 ]
let s:brightpurple    = [ '#dfdfff', 189 ]
let s:brightred       = [ '#df0000', 160 ]
let s:cyan            = [ '#2aa198', 37  ]
let s:darkblue        = [ '#0087af', 31  ]
let s:darkestblue     = [ '#005f87', 24  ]
let s:darkestcyan     = [ '#005f5f', 23  ]
let s:darkestgreen    = [ '#005f00', 22  ]
let s:darkestpurple   = [ '#5f00af', 55  ]
let s:darkestred      = [ '#5f0000', 52  ]
let s:darkgreen       = [ '#008700', 28  ]
let s:darkred         = [ '#870000', 88  ]
let s:darkgray        = [ '#1c1c1c', 234 ]
let s:gray0           = [ '#121212', 233 ]
let s:gray1           = [ '#262626', 235 ]
let s:gray2           = [ '#303030', 236 ]
let s:gray3           = [ '#4e4e4e', 239 ]
let s:gray4           = [ '#585858', 240 ]
let s:gray5           = [ '#606060', 241 ]
let s:gray6           = [ '#808080', 244 ]
let s:gray7           = [ '#8a8a8a', 245 ]
let s:gray8           = [ '#9e9e9e', 247 ]
let s:gray9           = [ '#bcbcbc', 250 ]
let s:gray10          = [ '#d0d0d0', 252 ]
let s:green           = [ '#859900', 64  ]
let s:magenta         = [ '#d33682', 125 ]
let s:mediumcyan      = [ '#87dfff', 117 ]
let s:mediumgreen     = [ '#5faf00', 70  ]
let s:mediumpurple    = [ '#875fdf', 98  ]
let s:mediumred       = [ '#af0000', 124 ]
let s:orange          = [ '#cb4b16', 166 ]
let s:red             = [ '#dc322f', 160 ]
let s:violet          = [ '#6c71c4', 61  ]
let s:white           = [ '#ffffff', 231 ]
let s:yellow          = [ '#b58900', 136 ]

let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {} }

let s:p.normal.left      = [ [s:white, s:red], [s:darkestgreen, s:brightgreen], [s:white, s:gray4], [s:white, s:gray4], [s:red, s:gray2] ]
let s:p.normal.middle    = [ [s:gray7, s:gray2] ]
let s:p.normal.right     = [ [s:gray5, s:gray10], [s:gray9, s:gray4], [s:gray8, s:gray2] ]
let s:p.normal.error     = [ [s:gray0, s:brightestred] ]
let s:p.normal.warning   = [ [s:gray0, s:brightorange] ]
let s:p.insert.left      = [ s:p.normal.left[0], [s:darkestcyan, s:white], [s:white, s:darkblue], [s:white, s:darkblue] ]
let s:p.insert.middle    = [ [s:mediumcyan, s:darkestblue] ]
let s:p.insert.right     = [ [s:darkestcyan, s:mediumcyan], [s:mediumcyan, s:darkblue], [s:mediumcyan, s:darkestblue] ]
let s:p.visual.left      = [ s:p.normal.left[0], [s:darkred, s:brightorange], s:p.normal.left[2], s:p.normal.left[3], s:p.normal.left[4] ]
let s:p.replace.left     = [ s:p.normal.left[0], [s:white, s:brightred], s:p.normal.left[2], s:p.normal.left[3], s:p.normal.left[4] ]
let s:p.replace.middle   = [ [s:gray7, s:gray2] ]
let s:p.replace.right    = [ [s:gray5, s:gray10], [s:gray9, s:gray4], [s:gray8, s:gray2] ]
let s:p.inactive.left    = [ [s:gray1, s:gray5], [s:gray7, s:darkgray] ]
let s:p.inactive.middle  = [ [s:darkgray, s:darkgray] ]
let s:p.inactive.right   = [ [s:gray1, s:gray5], [s:gray4, s:gray1], [s:gray4, s:gray0] ]
let s:p.tabline.left     = [ [s:gray9, s:gray1] ]
let s:p.tabline.middle   = [ [s:gray2, s:gray8] ]
let s:p.tabline.right    = [ [s:gray9, s:gray3] ]
let s:p.tabline.tabsel   = [ [s:gray9, s:gray4] ]

let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#flatten(s:p)
