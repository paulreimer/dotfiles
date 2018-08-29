" --- Drop support for pure vi ---
if &compatible
  set nocompatible
endif

" --- encoding ---
set encoding=utf-8
set fileformat=unix

" --- vim-plug ---
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
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {'branch':'next', 'do':'bash install.sh'}
Plug 'bling/vim-bufferline'
Plug 'bogado/file-line'
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'glts/vim-textobj-comment'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'mklabs/split-term.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'twerth/ir_black'
Plug 'w0rp/ale'
Plug 'reasonml-editor/vim-reason-plus'

" Install correct deoplete plugins based on whether we are using vim or neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" --- features ---
filetype plugin indent on
syntax on
set hlsearch
" better tab-complete
"set wildmenu
"set wildmode=longest:full,full

" --- appearance ---
set t_Co=256
"set termguicolors
set background=dark
colors ir_black

" Line numbers
set number
" Do not show line numbers on terminal windows
au TermOpen * setlocal nonumber norelativenumber

" Highlight long lines (longer than 80 chars)
let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

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

" --- whitespace control ---
" set smarttab
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=start,indent

" --- netrw ---
let netrw_liststyle=3
let netrw_winsize = -56
let netrw_banner = 0

" --- ag ---
set grepprg=ag\ $*
set grepformat=%f:%l:%m

" --- deoplete ---
let g:deoplete#enable_at_startup = 1

" --- deoplete-clang ---
"let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
"let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/lib/clang'
"let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang-6.0.so.1'
"let g:deoplete#sources#clang#clang_header = '/usr/include/clang'

" --- Tabularize ---
command! -nargs=1 -range TabFirst exec <line1> . ',' . <line2> . 'Tabularize /^[^' . escape(<q-args>, '\^$.[?*~') . ']*\zs' . escape(<q-args>, '\^$.[?*~')

" --- bufferline ---
let g:bufferline_echo = 0
let g:bufferline_separator = '  '
let g:bufferline_active_buffer_left = ''
let g:bufferline_active_buffer_right = ''
let g:bufferline_modified = ' + '
let g:bufferline_fname_mod = ':t'

"" --- fzf ---
set rtp+=/usr/local/opt/fzf

" --- vimfiler ---
let g:vimfiler_as_default_explorer = 1
" Disable netrw.vim
let g:loaded_netrwPlugin = 1
map <leader>e :VimFilerExplorer -parent -auto-expand<CR>
autocmd VimEnter * if !argc() | VimFiler | endif

" --- split-term ---
"let g:disable_key_mappings = 1

" --- tagbar ---
"autocmd BufEnter *.cpp nested TagbarOpen

" --- supertab ---
"let g:SuperTabDefaultCompletionType = "<c-n>"

" --- dart-vim-plugin ---
let dart_html_in_string=v:true
let dart_style_guide = 2

" --- vim-lsp ---
" *.c, *.cpp, *.obj, *.objcpp
"if executable('clangd')
"  au User lsp_setup call lsp#register_server({
"    \ 'name': 'clangd',
"    \ 'cmd': {server_info->['clangd']},
"    \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
"    \ })
"endif
"
" *.dart
"if executable('dart_language_server')
"  au User lsp_setup call lsp#register_server({
"    \ 'name': 'dart_language_server',
"    \ 'cmd': {server_info->['dart_language_server']},
"    \ 'whitelist': ['dart'],
"    \ })
"endif

" --- neosnippet ---
"if has('conceal')
"  set conceallevel=2 concealcursor=niv
"endif

" --- LanguageClient-neovim ---
if has('nvim')
" Required for operations modifying multiple buffers like rename.
set hidden

"  \ 'cpp': ['/Users/paulreimer/Development/lib/cquery/build/release/bin/cquery', '--log-file=/tmp/cq.log']
"
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd', '-enable-snippets'],
  \ 'reason': ['ocaml-language-server', '--stdio'],
  \ 'ocaml': ['ocaml-language-server', '--stdio'],
  \ }
let g:LanguageClient_loadSettings = 1
" Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/Users/paulreimer/.config/nvim/settings.json'

" Send textDocument/hover when cursor moves.
"augroup LanguageClient_config
"  au!
"  au BufEnter * let b:Plugin_LanguageClient_started = 0
"  au User LanguageClientStarted setl signcolumn=yes
"  au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
"  au User LanguageClientStopped setl signcolumn=auto
"  au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
"  au CursorMoved * if b:Plugin_LanguageClient_started | call LanguageClient_textDocument_hover() | endif
"augroup END

endif

" --- ale ---
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_xo_use_global = 1
let g:ale_javascript_xo_options = '--prettier --space'
let g:ale_cpp_cpplint_options = '--filter=-whitespace/braces,-whitespace/parens,-whitespace/newline,-readability/braces,-readability/alt_tokens'
let g:ale_html_tidy_options = '--custom-tags yes --wrap 80 --indent yes --indent-attributes yes --indent-spaces 2'

"  \ 'html': ['tidy', 'prettier'],
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'cpp': ['clang-format'],
  \ 'dart': ['dartfmt'],
  \ 'python': ['autopep8', 'isort'],
  \ 'javascript': ['prettier'],
  \ 'html': ['tidy'],
  \ }
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" --- es7 ---
"au BufRead,BufNewFile *.es7 setfiletype=javascript

" tcomment
let g:tcomment_textobject_inlinecomment = ''

" --- tab behaviour ---
" Map expression when a tab is hit:
"   checks if the completion popup is visible
"   if yes
"     then it cycles to next item
"   else
"     if expandable_or_jumpable
"       then expands_or_jumps
"       else returns a normal TAB

" --- key mappings ---
let mapleader = ","

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

"" --- neosnippet ---
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" LanguageClient-neovim
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> gf :call LanguageClient_textDocument_codeAction()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" ------------------------------------------------------------------------------
" ------------------------------------------------------------------------------
" --- lightline ---
set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'landscape',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], [ 'bufferline' ] ],
  \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ],
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
  \                 '%#LightLineLeft_active_2#%{LightlineBufferline()[2]}'
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
