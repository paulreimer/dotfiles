" Drop support for pure vi
if &compatible
  set nocompatible
endif

" encoding
set encoding=utf-8
set fileformat=unix

" vim-plug
"" install:
"" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
""   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"" nvim +'PlugInstall --sync' +qa

call plug#begin()
"Plug 'easymotion/vim-easymotion'
"Plug 'edkolev/promptline.vim'
"Plug 'ervandew/supertab'
"Plug 'majutsushi/tagbar'
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'sjl/gundo.vim'

Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neopairs.vim'
"Plug 'Shougo/neosnippet'
"Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {'branch':'next', 'do':'bash install.sh'}
Plug 'bling/vim-bufferline'
Plug 'bogado/file-line'
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'glts/vim-textobj-comment'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'mklabs/split-term.vim'
Plug 'mopp/sky-color-clock.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'sirver/UltiSnips'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'twerth/ir_black'
Plug 'w0rp/ale'

" Install correct deoplete plugins based on whether we are using vim or neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" features
filetype plugin indent on
syntax on
set hlsearch
set noerrorbells visualbell t_vb=
" better tab-complete
"set wildmenu
"set wildmode=longest:full,full

" appearance
set t_Co=256
"set termguicolors
set background=dark
colors ir_black

" Line numbers
set number
" Do not show line numbers on terminal windows
autocmd TermOpen * setlocal nonumber norelativenumber

" Highlight long lines in source files (longer than 80 chars)
fun! HighlightLongLines()
  " Only highlight for source files (not terminals)
  if &buftype != 'terminal'
    let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
  else
    " This will clear all matches when entering a terminal window(?)
    call clearmatches()
  endif
endfun
autocmd BufWinEnter * call HighlightLongLines()

" Highlight tabs + trailing whitespace
set listchars=tab:→\ ,nbsp:␣,trail:·
set list
highlight NonText ctermfg=LightGray

" Highlight the current cursor column
"set cursorcolumn

" Do not highlight the line numbers/gutter
highlight clear SignColumn

" Popup menu color scheme
highlight Pmenu ctermbg=DarkGray
highlight PmenuSel ctermbg=DarkBlue ctermfg=White cterm=bold
highlight PmenuSbar ctermbg=LightGray

" whitespace control
" set smarttab
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=start,indent

" zsh
set shell=/usr/local/bin/zsh\ --login
autocmd BufEnter term://* startinsert

" netrw
let netrw_liststyle=3
let netrw_winsize = -56
let netrw_banner = 0

" ag
set grepprg=ag\ $*
set grepformat=%f:%l:%m

" deoplete
let g:deoplete#enable_at_startup = 1
"let g:LanguageClient_hasSnippetSupport = 1

" deoplete-clang
"let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
"let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/lib/clang'
"let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang-6.0.so.1'
"let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

" Tabularize
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

" bufferline
let g:bufferline_echo = 0
let g:bufferline_separator = '  '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_modified = ' + '
let g:bufferline_fname_mod = ':t'

"" fzf
set rtp+=/usr/local/opt/fzf

" vimfiler
let g:vimfiler_as_default_explorer = 1
" Disable netrw.vim
let g:loaded_netrwPlugin = 1
map <leader>e :VimFilerExplorer -parent -auto-expand<CR>
autocmd VimEnter * if !argc() | VimFiler | endif

" split-term
"let g:disable_key_mappings = 1

" tagbar
"autocmd BufEnter *.cpp nested TagbarOpen

" supertab
"let g:SuperTabDefaultCompletionType = "<c-n>"

" dart-vim-plugin
let dart_html_in_string=v:true
let dart_style_guide = 2

" vim-lsp
" *.c, *.cpp, *.obj, *.objcpp
"if executable('clangd')
"  autocmd User lsp_setup call lsp#register_server({
"    \ 'name': 'clangd',
"    \ 'cmd': {server_info->['clangd']},
"    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"    \ })
"endif
"
" *.dart
"if executable('dart_language_server')
"  autocmd User lsp_setup call lsp#register_server({
"    \ 'name': 'dart_language_server',
"    \ 'cmd': {server_info->['dart_language_server']},
"    \ 'whitelist': ['dart'],
"    \ })
"endif

" neosnippet
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

" LanguageClient-neovim
if has('nvim')
" Required for operations modifying multiple buffers like rename.
set hidden

"  \ 'cpp': ['/Users/paulreimer/Development/lib/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log']
"  \ 'cpp': ['clangd', '-enable-snippets'],
"
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['cquery'],
  \ 'reason': ['ocaml-language-server', '--stdio'],
  \ 'ocaml': ['ocaml-language-server', '--stdio'],
  \ }
let g:LanguageClient_loadSettings = 1
" Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/Users/paulreimer/.config/nvim/settings.json'

" Send textDocument/hover when cursor moves.
"augroup LanguageClient_config
"  autocmd!
"  autocmd BufEnter * let b:Plugin_LanguageClient_started = 0
"  autocmd User LanguageClientStarted setl signcolumn=yes
"  autocmd User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
"  autocmdtocmd User LanguageClientStopped setl signcolumn=auto
"  autocmd User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
"  autocmd CursorMoved * if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_hover() | endif
"augroup END

endif

" ale
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_xo_use_global = 1
let g:ale_javascript_xo_options = '--prettier --space'
let g:ale_cpp_cpplint_options = '--filter=-whitespace/braces,-whitespace/parens,-whitespace/newline,-readability/braces,-readability/alt_tokens'
let g:ale_c_clangformat_executable = '/usr/local/bin/clang-format'
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
let g:ale_html_tidy_options = '--custom-tags yes --wrap 80 --indent yes --indent-attributes yes --indent-spaces 2'

"  \ 'html': ['tidy', 'prettier'],
"  \ 'html': ['tidy'],
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'cpp': ['clang-format'],
  \ 'dart': ['dartfmt'],
  \ 'python': ['autopep8', 'isort'],
  \ 'javascript': ['prettier'],
  \ 'html': ['prettier'],
  \ }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" es7
"autocmd BufRead,BufNewFile *.es7 setfiletype=javascript

" tcomment
let g:tcomment_textobject_inlinecomment = ''

" key mappings
let mapleader = ","

" delete buffer instead of quit
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'bd' : 'q')<CR>
cabbrev q! <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'bd!' : 'q!')<CR>
cabbrev q1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'bd!' : 'q!')<CR>
cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'update <BAR> bd' : 'wq')<CR>
nnoremap ZZ :update <BAR> bd <CR>

" screen-like key bindings
nnoremap <C-a>c :bn <BAR> te <CR>
nnoremap <C-a>k :bd <CR>
nnoremap <C-a><C-a> <C-^>
nnoremap <C-a><Space> :bn <CR>
nnoremap <C-a>0 :b0 <CR>
nnoremap <C-a>1 :b1 <CR>
nnoremap <C-a>2 :b2 <CR>
nnoremap <C-a>3 :b3 <CR>
nnoremap <C-a>4 :b4 <CR>
nnoremap <C-a>5 :b5 <CR>
nnoremap <C-a>6 :b6 <CR>
nnoremap <C-a>7 :b7 <CR>
nnoremap <C-a>8 :b8 <CR>
nnoremap <C-a>9 :b9 <CR>

" yank selection into system clipboard
xnoremap <C-a>\ "*y

tnoremap <C-a>c <C-\><C-n> :bn <BAR> te <CR>
tnoremap <C-a>k <C-\><C-n> :bd <CR>
tnoremap <C-a><C-a> <C-\><C-n> <C-^>
tnoremap <C-a><Space> <C-\><C-n> :bn <CR>

" use Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" fzf
map <leader>f :Files<CR>
map <leader>b :Buffers<CR>
map <leader>h :Commits<CR>
map <leader>/ :Lines<CR>
map <leader>g :Ag

" Tabularize
map <leader>t :TabFirst
map <leader>T :Tabularize /

" tagbar
nmap <leader>c :TagbarToggle<CR>

" easymotion
"nmap F <Plug>(easymotion-prefix)s

" gitgutter
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

""" neosnippet
"imap <C-k> <Plug>(neosnippet_expand_or_jump)
"smap <C-k> <Plug>(neosnippet_expand_or_jump)
"xmap <C-k> <Plug>(neosnippet_expand_target)
"
"" SuperTab like snippets' behavior.
"" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" :
" \     pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"
""imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
""imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
""inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

"" LanguageClient-neovim
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> gf :call LanguageClient_textDocument_codeAction()<CR>
"nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
"
" from: https://github.com/andreyorst/dotfiles/blob/18435af0f18377d0566ab38bb70977aecc650469/.config/nvim/plugin_configs.vim#L120
" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips/']
let g:UltiSnipsEditSplit="vertical"

" disable default triggers, use custom functions
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<NUL>"
let g:UltiSnipsJumpBackwardTrigger = "<NUL>"

" If deoplete popup is visible <Cr> will expand or jump. If not it will
" close deoplete popup and leave everything as is. If used while editing an
" expanded snippet it will complete the word and jump to next placeholder.
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandOrClosePopup()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    let close_popup = deoplete#close_popup()
    return close_popup
  endif
endfunction

" If deoplete popup is visible <Tab> acts like <C-n> wich selects next
" completion item from the list. If there is no popup then <Tab> acts as
" jump to next snippet placeholder, if we are editing a snippet. If
" no popup and no snippet <Tab> acts like <Tab>
function! SmartTab()
  if pumvisible() == 1
    return "\<C-n>"
  else
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return snippet
    else
      return "\<Tab>"
    endif
  endif
endfunction

" The same as previous, but selects previous item and jumps backwards, or
" acts like S-<Tab>
function! SmartSTab()
  if pumvisible() == 1
    return "\<C-p>"
  else
    let snippet = UltiSnips#JumpBackwards()
    if g:ulti_expand_or_jump_res > 0
      return snippet
    else
      return "\<S-Tab>"
    endif
endfunction

"inoremap <silent><expr><CR> pumvisible() ? "<C-R>=<SID>ExpandOrClosePopup()<CR>" : delimitMate#WithinEmptyPair() ? "\<C-R>=delimitMate#ExpandReturn()\<CR>" : "\<Cr>"
inoremap <silent><expr><CR> pumvisible() ? "<C-R>=<SID>ExpandOrClosePopup()<CR>" : "\<Cr>"
inoremap <silent><Tab>      <C-R>=SmartTab()<CR>
snoremap <silent><Tab>      <Esc>:call UltiSnips#JumpForwards()<CR>
inoremap <silent><S-Tab>    <C-R>=SmartSTab()<CR>
snoremap <silent><S-Tab>    <Esc>:call UltiSnips#JumpBackwards()<CR>

" LanguageClient-neovim
" Workaround for LanguageClient-neovim inserting unusable snippet
" from: https://github.com/autozimu/LanguageClient-neovim/issues/379#issuecomment-403876177
let g:ulti_expand_res = 0 "default value, just set once
function! CompleteSnippet()
  if empty(v:completed_item)
    return
  endif

  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res > 0
    return
  endif

  let l:complete = type(v:completed_item) == v:t_dict ? v:completed_item.word : v:completed_item
  let l:comp_len = len(l:complete)

  let l:cur_col = mode() == 'i' ? col('.') - 2 : col('.') - 1
  let l:cur_line = getline('.')

  let l:start = l:comp_len <= l:cur_col ? l:cur_line[:l:cur_col - l:comp_len] : ''
  let l:end = l:cur_col < len(l:cur_line) ? l:cur_line[l:cur_col + 1 :] : ''

  call setline('.', l:start . l:end)
  call cursor('.', l:cur_col - l:comp_len + 2)

  call UltiSnips#Anon(l:complete)
endfunction

autocmd CompleteDone * call CompleteSnippet()

" sky-color-clock.vim
set statusline+=%#SkyColorClockTemp#\ %#SkyColorClock#%{sky_color_clock#statusline()}
"let g:sky_color_clock#latitude
"let g:sky_color_clock#color_stops
let g:sky_color_clock#datetime_format = '%a %d %l:%M%p'
let g:sky_color_clock#enable_emoji_icon = 0
let g:sky_color_clock#openweathermap_api_key = '4532f4c71abfc2f9969fd33e026db7b5'
let g:sky_color_clock#openweathermap_city_id = '6173331'
"let g:sky_color_clock#temperature_color_stops

"-------------------------------------------------------------------------------
"-------------------------------------------------------------------------------
" lightline
set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'landscape',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'bufferline' ] ],
  \   'right': [ ['sky_color_clock'], [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ],
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'filename': 'LightLineFilename',
  \   'fileformat': 'LightLineFileformat',
  \   'filetype': 'LightLineFiletype',
  \   'fileencoding': 'LightLineFileencoding',
  \   'mode': 'LightLineMode',
  \ },
  \ 'component': {
  \   'bufferline': '%{bufferline#refresh_status()}%{LightlineBufferline()[0]}'.
  \                 '%#TabLineSel#%{g:bufferline_status_info.current}'.
  \                 '%#LightLineLeft_active_2#%{LightlineBufferline()[2]}',
  \   'sky_color_clock': "%#SkyColorClock#%{' ' . sky_color_clock#statusline() . ' '}%#SkyColorClockTemp# ",
  \ },
  \ 'component_raw': {
  \   'sky_color_clock': 1,
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ }

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
