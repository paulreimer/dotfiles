" Drop support for pure vi
if &compatible
  set nocompatible
endif

" encoding
set encoding=utf-8
set fileformat=unix

" features
filetype plugin indent on
syntax on

" Use incremental search
set hlsearch

" Disable visual and audible bells
set noerrorbells visualbell t_vb=

" Support truecolor / 256-color
if exists('+termguicolors')
  set termguicolors
else
  set t_Co=256
endif

" Color scheme
set background=dark
colors ir_black

" Do not consider a ':' to be present in paths, use it to mean file:line
set isfname-=:

" Show N lines before search match
set scrolloff=5

" Only show line numbers on non-terminal windows
" (Must be done this way, since disabling them later incorrectly sets columns)
fun! EnableLineNumbers()
  if &buftype != 'terminal'
    setl number
  else
    setl nonumber
  endif
endfun
autocmd BufRead * call EnableLineNumbers()

" Disable searches in terminal windows from wrapping around
fun! EnableWrapScan()
  if &buftype != 'terminal'
    set wrapscan
  else
    set nowrapscan
  endif
endfun
autocmd BufEnter * call EnableWrapScan()

" Highlight tabs + trailing whitespace
set listchars=tab:→\ ,nbsp:␣,trail:·
set list
highlight NonText ctermfg=LightGray

" Do not highlight the line numbers/gutter
highlight clear SignColumn

" gitgutter
highlight GitGutterAdd    guifg=#009900 guibg=none ctermfg=2 ctermbg=none
highlight GitGutterChange guifg=#bbbb00 guibg=none ctermfg=3 ctermbg=none
highlight GitGutterDelete guifg=#ff2222 guibg=none ctermfg=1 ctermbg=none

" Popup menu color scheme
highlight Pmenu ctermbg=DarkGray
highlight PmenuSel ctermbg=DarkBlue ctermfg=White cterm=bold
highlight PmenuSbar ctermbg=LightGray

" Set terminal scrollback lines
autocmd TermOpen * setlocal scrollback=100000

" Whitespace control
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set backspace=start,indent

" Better display for messages
set cmdheight=1

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" Suppress 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c

" Allow switching buffers without warning about modifications
set hidden

" Change working directory to containing directory of edited files
set autochdir

" Update working directory when switching to a terminal buffer
function! TermAutoLcd()
  " Extract the CWD for the terminal's PID
  let l:term_pid = matchstr(expand("%"), 'term://.*//\zs[0-9]\+\ze')
  if !empty(term_pid)
    let l:term_cwd = system("lsof -a -d cwd -c zsh -p " . term_pid . " -Fn | sed -n -e 's/^n\\(.*\\)$/\\1/p'")[:-2]
    if !empty(term_cwd)
      execute "lcd " . l:term_cwd
    endif
  endif
endfunction
autocmd BufEnter term://* call TermAutoLcd()

" netrw
" disable netrw for directory listings
let loaded_netrwPlugin = 1

" ag
set grepprg=ag\ $*
set grepformat=%f:%l:%m

" Tabularize
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

" bufferline
let g:bufferline_echo = 0
let g:bufferline_separator = '  '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_modified = ' + '
let g:bufferline_fname_mod = ':t'

" fzf
set rtp+=$HOME/.fzf

" dart-vim-plugin
let dart_html_in_string=v:true
let dart_style_guide = 2

" es7
autocmd BufRead,BufNewFile *.es7 set filetype=javascript

" dita
autocmd BufRead,BufNewFile *.dita set filetype=xml

" tcomment
let g:tcomment_textobject_inlinecomment = ''
let g:tcomment_maps = 0

" vim-bufkill
let g:BufKillCreateMappings = 0

" deoplete
" configuration is in ~/.config/nvim/after/plugin/config/deoplete.vim

" float-preview.nvim
" Do not open a popup window
set completeopt-=preview

" deoplete-jedi
" Shows docstring in preview window
let g:deoplete#sources#jedi#show_docstring = 1
" Disable jedi-vim completion when using deoplete-jedi
let g:jedi#completions_enabled = 0

" float-preview-nvim
let g:float_preview#docked = 1
autocmd InsertLeave * silent! call float_preview#close()!

" neosnippet
let g:neosnippet#snippets_directory = '$HOME/Development/snippets'
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Trigger expansion of snippet immediately after completion popup is done
let g:neosnippet#enable_complete_done = 1
" If completion selects a function prototype, expand it and cycle placeholders
let g:neosnippet#enable_completed_snippet = 1
" Hide marker characters in expanded snippets
if has('conceal')
  set conceallevel=2 concealcursor=niv

  " Do not hide marker characters for JSON quotes
  autocmd FileType json setlocal conceallevel=0
endif

" snipMate
let g:snipMate = {'snippet_version': 1}
let g:snipMate['snippet_dirs'] = ['~/Development']

" ale
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_xo_use_global = 1
let g:ale_javascript_xo_options = '--prettier --space'
let g:ale_cpp_cpplint_options = '--filter=-whitespace/braces,-whitespace/parens,-whitespace/tab,-whitespace/newline,-readability/braces,-readability/alt_tokens'
let g:ale_c_clangformat_options = '-style=file'
let g:ale_html_tidy_options = '--custom-tags yes --wrap 80 --indent yes --indent-attributes yes --indent-spaces 2'
let g:ale_python_mypy_options = '--disallow-untyped-defs --disallow-incomplete-defs --check-untyped-defs --disallow-untyped-decorators'
let g:ale_rust_rls_executable = 'rust-analyzer'
let g:ale_sh_shfmt_options = '-i 2'

let g:ale_linters = {
  \ 'cpp': ['clangcheck', 'clangd', 'clangtidy', 'clazy', 'cpplint', 'flawfinder'],
  \ 'dart': ['language_server'],
  \ 'erlang': ['dialyzer', 'erl', 'syntaxerl'],
  \ 'python': ['flake8', 'pylama', 'pylint', 'mypy'],
  \ 'rust': ['rls'],
  \ 'swift': ['sourcekitlsp'],
  \ }

let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'cpp': ['clang-format'],
  \ 'dart': ['dartfmt'],
  \ 'python': ['autopep8', 'isort', 'yapf'],
  \ 'javascript': ['prettier'],
  \ 'html': ['prettier'],
  \ 'rust': ['rustfmt'],
  \ 'sh': ['shfmt'],
  \ 'swift': ['swiftformat'],
  \ 'yaml': ['prettier'],
  \ }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0
let g:ale_virtualtext_cursor = 1

" highlighting
highlight ALEError gui=undercurl term=undercurl cterm=undercurl guisp=deeppink
highlight ALEWarning gui=undercurl term=undercurl cterm=undercurl guisp=goldenrod1

highlight ALEErrorSign ctermbg=none guibg=none ctermfg=darkred guifg=deeppink
highlight ALEWarningSign ctermbg=none guibg=none ctermfg=yellow guifg=goldenrod1

let g:ale_virtualtext_prefix = '🔥 '
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:lightline#ale#indicator_checking = ""
let g:lightline#ale#indicator_warnings = ""
let g:lightline#ale#indicator_errors = ""
let g:lightline#ale#indicator_ok = ""

" DoxygenToolkit
" Use /// comments instead of /** */
let g:DoxygenToolkit_commentType = "C++"

" lh-brackets
let g:usemarks = 0
" Disable default jump mappings
let g:marker_define_jump_mappings = 0
" Enable lh-brackets where no conflict with default vim modes
let g:cb_enable_default = {
  \ '(': 'ivn',
  \ '[': 'i',
  \ '{': 'ivn',
  \ '<': 'ivn',
  \ '"': 'in',
  \ '""': 'vn',
  \ "'": 'i',
  \ "''": 'iv',
  \ }

" neomake
let g:neomake_open_list = 2

" EditorConfig-vim
let g:EditorConfig_disable_rules = ['trim_trailing_whitespace']

" ShowMultiBase
let g:ShowMultiBase_General_UseDefaultMappings = 0
let g:ShowMultiBase_Display_Decimal_Show = 1
let g:ShowMultiBase_Display_Octal_Show = 0
let g:ShowMultiBase_Display_Hexadecimal_SegmentSize = 8

" vim-fugitive
let g:fugitive_no_maps = 1

" vim-sneak
let g:sneak#label = 1

" key mappings
let mapleader = ","

" neosnippet supertab
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
 \ exists('b:snip_state') ? "\<Plug>snipMateNextOrTrigger" :
 \ "\<TAB>"
smap <expr><TAB>
 \ neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" :
 \ exists('b:snip_state') ? "\<Plug>snipMateNextOrTrigger" :
 \ "\<TAB>"
imap <expr><S-TAB>
 \ pumvisible() ? "\<C-p>" :
 \ exists('b:snip_state') ? "\<Plug>snipMateBack" :
 \ "\<S-TAB>"

" deoplete actions on close popup
inoremap <expr><CR> pumvisible() ? deoplete#close_popup() : "\<CR>"

" nvr
" delete buffer instead of quit
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD' : 'q')<CR>
cabbrev qa <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD' : 'qa')<CR>
cabbrev q! <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD!' : 'q!')<CR>
cabbrev q1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD!' : 'q!')<CR>
cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'update <BAR> BD' : 'wq')<CR>
nnoremap <silent> ZZ :update <BAR> BD <CR>
nnoremap <silent> ZQ :BD! <CR>

" screen-like key bindings
noremap <silent> <C-a>c :tabnew <BAR> te <CR> i
inoremap <silent> <C-a>c <ESC>:tabnew <BAR> te <CR> i
noremap <silent> <C-a>k :BD! <CR>
noremap <silent> <C-a><Space> :tabnext <CR>
noremap <silent> <C-a>0 0gt
noremap <silent> <C-a>1 1gt
noremap <silent> <C-a>2 2gt
noremap <silent> <C-a>3 3gt
noremap <silent> <C-a>4 4gt
noremap <silent> <C-a>5 5gt
noremap <silent> <C-a>6 6gt
noremap <silent> <C-a>7 7gt
noremap <silent> <C-a>8 8gt
noremap <silent> <C-a>9 9gt

" terminal mode screen-like key bindings
tnoremap <silent> <C-a>c <C-\><C-n> :tabnew <BAR> te <CR> i
tnoremap <silent> <C-a>k <C-\><C-n> :BD! <CR>
tnoremap <silent> <C-a><Space> <C-\><C-n> :tabnext <CR>
tnoremap <silent> <C-a>0 <C-\><C-n> 0gt
tnoremap <silent> <C-a>1 <C-\><C-n> 1gt
tnoremap <silent> <C-a>2 <C-\><C-n> 2gt
tnoremap <silent> <C-a>3 <C-\><C-n> 3gt
tnoremap <silent> <C-a>4 <C-\><C-n> 4gt
tnoremap <silent> <C-a>5 <C-\><C-n> 5gt
tnoremap <silent> <C-a>6 <C-\><C-n> 6gt
tnoremap <silent> <C-a>7 <C-\><C-n> 7gt
tnoremap <silent> <C-a>8 <C-\><C-n> 8gt
tnoremap <silent> <C-a>9 <C-\><C-n> 9gt

" use ,{hjkl} to navigate terminal windows
noremap <silent> <C-h> :tabprev <CR>
noremap <silent> <C-j> :wincmd w <CR>
noremap <silent> <C-k> :wincmd W <CR>
noremap <silent> <C-l> :tabnext <CR>
tnoremap <silent> <C-h> <C-\><C-n> :tabprev <CR>
tnoremap <silent> <C-j> <C-\><C-n> :wincmd w <CR>
tnoremap <silent> <C-k> <C-\><C-n> :wincmd W <CR>
tnoremap <silent> <C-l> <C-\><C-n> :tabnext <CR>

" yank selection into system clipboard
xnoremap <silent> <C-a>\ "+y

" send Ctrl-A to nested screen/tmux
noremap <silent> <C-a>a <C-a>

" use Ctrl-A Ctrl-A to go to last-active tab
au TabLeave * let g:lasttab = tabpagenr()
noremap <silent> <C-a><C-a> :exe "tabn ".g:lasttab<CR>
tnoremap <silent> <C-a><C-a> <C-\><C-n> :exe "tabn ".g:lasttab<CR>

" use Ctrl-A Shift-A to rename current tab
noremap <silent> <C-a>A :keepalt file<space>

" use F18 to trigger outermost vim escape
" (note: CapsLock should be bound to F18)
inoremap <silent> <F18> <C-\><C-n>
tnoremap <silent> <F18> <C-\><C-n>
" some keyboard mappings refer to F18 as Shift-F6
inoremap <silent> <S-F6> <C-\><C-n>
tnoremap <silent> <S-F6> <C-\><C-n>

" ALE
nmap <silent> <C-]> :ALEGoToDefinition<CR>
nmap <silent> <leader>gd :ALEGoToDefinition<CR>
nmap <silent> <leader>gD :ALEGoToDeclaration<CR>
nmap <silent> <leader>gt :ALEGoToTypeDefinition<CR>
nmap <silent> <leader>gr :ALEFindReferences<CR>
nmap <silent> <leader>gs :ALEGoToDefinitionInSplit<CR>

" Override ALE binding
autocmd FileType python nmap <silent> <leader>d :jedi#show_documentation()<CR>

" fzf
nmap <silent> <leader>f :Ag<space>
nmap <silent> <leader>F :Files<CR>
nmap <silent> <leader>b :Buffers<CR>
nmap <silent> <leader>h :History:<CR>
nmap <silent> <leader>/ :Lines<CR>
nmap <silent> <leader>gf :Ag<space>

" Tabularize
nmap <silent> <leader>t :TabFirst
nmap <silent> <leader>T :Tabularize /

" gitgutter
let g:gitgutter_map_keys = 0
omap <silent> ih <Plug>GitGutterTextObjectInnerPending
omap <silent> ah <Plug>GitGutterTextObjectOuterPending
xmap <silent> ih <Plug>GitGutterTextObjectInnerVisual
xmap <silent> ah <Plug>GitGutterTextObjectOuterVisual

" DoxygenToolkit
nmap <silent> <leader>D :Dox<CR>

" vim-jedi
" Disable all shortcuts
let g:jedi#goto_command = ""
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""

" Sourcetrail
nmap <silent> <leader>s :SourcetrailActivateToken<CR>

" neomake
nmap <silent> <leader>m :Neomake!<CR>

" ShowMultiBase
noremap <silent> <leader>x :ShowMultiBase<CR>

" yank current /path/to/file:line into unnamed register
nmap <silent> <leader>y :let @" = join([expand('%:p'),  line(".")], ':')<CR>

" run c++filt on symbol under cursor
nnoremap <silent> <leader>c :echo system('c++filt', expand("<cword>"))<CR>

" calculator
nnoremap <silent> <leader>= :echo<space>

" ALE
nnoremap <silent> <leader>r :ALERename<CR>

" tcomment
nmap <silent> gcc <Plug>TComment_gcc
nmap <silent> gc <Plug>TComment_gc
smap <silent> gc <Plug>TComment_gc
vmap <silent> gc <Plug>TComment_gc
xmap <silent> gc <Plug>TComment_gc

" lh-brackets
imap <silent> <C-l> <Plug>MarkersCloseAllAndJumpToLast

" vim-sneak
map <silent> f <Plug>Sneak_s
map <silent> F <Plug>Sneak_S

" sky-color-clock.vim
set statusline+=%#SkyColorClockTemp#\ %#SkyColorClock#%{sky_color_clock#statusline()}
let g:sky_color_clock#datetime_format = '%a %d %l:%M%p'
let g:sky_color_clock#enable_emoji_icon = 0
let g:sky_color_clock#openweathermap_api_key = '4532f4c71abfc2f9969fd33e026db7b5'
let g:sky_color_clock#openweathermap_city_id = '6173331'

"-------------------------------------------------------------------------------
"-------------------------------------------------------------------------------
" lightline
set laststatus=2
set noshowmode

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
