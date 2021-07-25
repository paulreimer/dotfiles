set laststatus=2
set noshowmode

" Update status bar every minute
func UpdateStatusBarTime(timer)
  call lightline#update()
endfunc
au VimEnter * call timer_start(1000 * 60, 'UpdateStatusBarTime', {'repeat': -1})

let g:lightline = {
  \  'colorscheme': 'landscape',
  \  'active': {
  \    'left': [
  \      [ 'mode', 'paste' ],
  \      [ 'fugitive', 'filename' ],
  \      [ 'bufferline' ],
  \    ],
  \    'right': [
  \      ['sky_color_clock'],
  \      [ 'lineinfo' ],
  \      ['percent'],
  \      [ 'fileformat', 'fileencoding', 'filetype' ],
  \      [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \    ],
  \  },
  \  'component_function': {
  \    'fugitive': 'LightLineFugitive',
  \    'filename': 'LightLineFilename',
  \    'fileformat': 'LightLineFileformat',
  \    'filetype': 'LightLineFiletype',
  \    'fileencoding': 'LightLineFileencoding',
  \    'mode': 'LightLineMode',
  \  },
  \  'component': {
  \    'bufferline': '%{bufferline#refresh_status()}%{LightlineBufferline()[0]}'.
  \                  '%#TabLineSel#%{g:bufferline_status_info.current}'.
  \                  '%#LightLineLeft_active_2#%{LightlineBufferline()[2]}',
  \    'sky_color_clock': "%#SkyColorClock#%{' ' . sky_color_clock#statusline() . ' '}%#SkyColorClockTemp# ",
  \  },
  \  'component_raw': {
  \    'sky_color_clock': 1,
  \  },
  \  'separator': { 'left': '', 'right': '' },
  \  'subseparator': { 'left': '', 'right': '' },
  \  'component_expand': {
  \    'linter_checking': 'lightline#ale#checking',
  \    'linter_warnings': 'lightline#ale#warnings',
  \    'linter_errors': 'lightline#ale#errors',
  \    'linter_ok': 'lightline#ale#ok',
  \  },
  \  'component_type': {
  \    'linter_checking': 'left',
  \    'linter_warnings': 'warning',
  \    'linter_errors': 'error',
  \    'linter_ok': 'left',
  \  }
  \}

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo' ? '' :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo' && &ft !~? 'vimfiler' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after ]
endfunction
