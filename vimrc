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
"" run (in vim):
"" :PlugInstall

call plug#begin()
"Plug 'sjl/gundo.vim'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler.vim'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-bufferline'
Plug 'bogado/file-line'
Plug 'editorconfig/editorconfig-vim'
Plug 'edkolev/promptline.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'mklabs/split-term.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'twerth/ir_black'
Plug 'w0rp/ale'
Plug 'zchee/deoplete-clang'
" Install correct deoplete plugins based on whether we are using vim or neovim
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" --- features ---
filetype plugin indent on
syntax on
set number
set hlsearch
" better tab-complete
set wildmenu
set wildmode=longest:full,full

" --- appearance ---
set t_Co=256
"set termguicolors
set background=dark
colors ir_black
" Highlight long lines (longer than 80 chars)
let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

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

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction
autocmd FileType python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" --- netrw ---
let netrw_liststyle=3
let netrw_winsize = -56
let netrw_banner = 0

" --- ag ---
set grepprg=ag\ $*
set grepformat=%f:%l:%m

" --- ctags ---
"" add current directory's generated tags file to available tags
"set tags+=~/.my_ctags/**/tags

" --- HardMode ---
""autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
"nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
"set number

" --- deoplete ---
let g:deoplete#enable_at_startup = 1

" --- deoplete-clang ---
let g:deoplete#sources#clang#libclang_path = '/usr/local/Cellar/llvm/5.0.0/lib/libclang.dylib'
let g:deoplete#sources#clang#clang_header = '/usr/local/Cellar/llvm/5.0.0/lib/clang'

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
let g:SuperTabDefaultCompletionType = "<c-n>"

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

" promptline
let g:promptline_preset = {
  \'a': [ promptline#slices#host(), promptline#slices#user() ],
  \'b': [ promptline#slices#cwd() ],
  \'c' : [ promptline#slices#vcs_branch() ],
  \'z' : [ '%*' ],
  \'warn' : [ promptline#slices#last_exit_code(), promptline#slices#battery() ]}

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
