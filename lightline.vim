" Components {{{
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'paste' ], [ 'mode' ], [ 'fugitive' ], [ 'filename' ], [ 'flags' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype', 'trailing', 'indentation', 'syntastic', 'ternjs' ] ]
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
      \   'ternjs': 'TernJS',
      \   'trailing': 'TrailingSpaceWarning',
      \   'indentation': 'MixedIndentSpaceWarning',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \   'ternjs': 'ternjs',
      \   'trailing': 'warning',
      \   'indentation': 'warning',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
"}}}

" Display always "{{{
function! MyMode()
  if s:ftMatches('help') | return '' | endif
  if s:fnameMatches('NERD_tree') | return 'NERDTree' | endif
  return s:bufferMinPercent(35) ? lightline#mode() : strpart(lightline#mode(), 0, 1)
endfunction

function! MyFileName()
  if s:fnameMatches('NERD_tree') | return '' | endif
  let fname = expand('%:t')
  return empty(fname) ? '[No Name]' : fname
endfunction

function! MyModified()
  return s:isFileBuffer() ? (&modified ? '+' : (&modifiable ? '' : '-')) : ''
endfunction

function! MyReadonly()
  return (s:ftMatches('help') || &readonly) ? '' : ''
endfunction

function! MyFlags()
  return (empty(MyReadonly()) ? '' : MyReadonly() . ' ') .
       \ (empty(MyModified()) ? '' : MyModified() . ' ')
endfunction

function! MyLineInfo()
  return s:fnameMatches('NERD_tree') ? '' : printf(" %3d:%-2d", line('.'), col('.'))
endfunction

function! MyPercent()
  return s:fnameMatches('NERD_tree') ? '' : printf("%3d%%", line('.') * 100 / line('$'))
endfunction
"}}}
" Hide if smaller than 70 {{{
function! TrailingSpaceWarning()
  if s:ftMatches('help') || winwidth(0) < 80 | return '' | endif
  let l:trailing = search('\s$', 'nw')
  return (l:trailing != 0) ? '… trailing[' . trailing . ']' : ''
endfunction

function! TernJS()
  return empty(get(b:, 'tern_type', '')) ? '' : DisplayTernType()
endfunction

function! MixedIndentSpaceWarning()
  if s:ftMatches('help') || winwidth(0) < 80 | return '' | endif
  let l:tabs = search('^\t', 'nw')
  let l:spaces = search('^ ', 'nw')
  return (l:tabs != 0 && l:spaces != 0) ? '» mixed-indent[' . tabs . ']' : ''
endfunction
"}}}
" Hide if smaller than 40% {{{
function! MyFileFormat()
  return !s:ftMatches('help') && s:bufferMinPercent(40) ? &fileformat : ''
endfunction

function! MyFileEncoding()
  return !s:ftMatches('help') && s:bufferMinPercent(40) ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction
"}}}
" Hide if smaller than 30% {{{
function! MyFileType()
  return s:bufferMinPercent(30) ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction
"}}}
" Hide if smaller than 25% {{{
function! MyFugitive()
  if !s:isFileBuffer() || !s:bufferMinPercent(25) | return '' | endif
  if exists('*fugitive#head')
    let l:branch = fugitive#head()
    return strlen(l:branch) ? ' '.l:branch : ''
  endif
endfunction
"}}}

" Helper functions {{{
au VimEnter * let g:total_width = winwidth(0)

function! s:bufferMinPercent(percent)
  return winwidth(0) > (g:total_width * a:percent / 100)
endfunction

function! s:ftMatches(ft_name)
  return &ft =~ a:ft_name
endfunction

function! s:fnameMatches(file_name)
  return expand('%:t') =~ a:file_name
endfunction

function! s:isFileBuffer()
  return empty(&buftype)
endfunction
"}}}

" Components manual update config {{{
augroup ComponentExpand
  autocmd!
  autocmd CursorHold,BufWritePost,InsertLeave * call s:flags()
augroup END

function! s:flags()
  if exists('#lightline')
    call TrailingSpaceWarning()
    call MixedIndentSpaceWarning()
    call lightline#update()
  endif
endfunction
"}}}

" Colors definitions {{{
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
"}}}
" Color scheme {{{
let s:p = { 'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {} }

let s:p.normal.left      = [ [s:white, s:red], [s:darkestgreen, s:brightgreen], [s:white, s:gray4], [s:white, s:gray4], [s:red, s:gray2] ]
let s:p.normal.middle    = [ [s:gray7, s:gray2] ]
let s:p.normal.right     = [ [s:gray5, s:gray10], [s:gray9, s:gray4], [s:gray8, s:gray2] ]
let s:p.normal.error     = [ [s:gray0, s:brightestred] ]
let s:p.normal.warning   = [ [s:gray0, s:brightorange] ]
let s:p.normal.ternjs    = [ [s:brightgreen, s:gray2] ]
let s:p.insert.left      = [ s:p.normal.left[0], [s:darkestcyan, s:white], [s:white, s:darkblue], [s:white, s:darkblue] ]
let s:p.insert.middle    = [ [s:mediumcyan, s:darkestblue] ]
let s:p.insert.right     = [ [s:darkestcyan, s:mediumcyan], [s:mediumcyan, s:darkblue], [s:mediumcyan, s:darkestblue] ]
let s:p.insert.ternjs    = [ [s:mediumcyan, s:darkestblue] ]
let s:p.visual.left      = [ s:p.normal.left[0], [s:darkred, s:brightorange], s:p.normal.left[2], s:p.normal.left[3], s:p.normal.left[4] ]
let s:p.replace.left     = [ s:p.normal.left[0], [s:white, s:brightred], s:p.normal.left[2], s:p.normal.left[3], s:p.normal.left[4] ]
let s:p.replace.middle   = [ [s:gray7, s:gray2] ]
let s:p.replace.right    = [ [s:gray5, s:gray10], [s:gray9, s:gray4], [s:gray8, s:gray2] ]
let s:p.inactive.left    = [ [s:gray7, s:gray2], [s:gray7, s:gray2] ]
let s:p.inactive.middle  = [ [s:gray7, s:gray2] ]
let s:p.inactive.right   = [ [s:gray7, s:gray2], [s:gray7, s:gray2], [s:gray7, s:gray2] ]
let s:p.tabline.left     = [ [s:gray9, s:gray1] ]
let s:p.tabline.middle   = [ [s:gray2, s:gray8] ]
let s:p.tabline.right    = [ [s:gray9, s:gray3] ]
let s:p.tabline.tabsel   = [ [s:gray9, s:gray4] ]

let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#flatten(s:p)
"}}}

" vim: set foldmethod=marker :
