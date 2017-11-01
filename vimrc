" --- Drop support for pure vi ---
set nocompatible

" --- encoding ---
set encoding=utf-8
set fileformat=unix

" --- Vundle ---
" install:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" then run vim:
" :PluginInstall
" wait for plugins to fetch/install/upgrade
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'bling/vim-bufferline'
Plugin 'bogado/file-line'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/fzf.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'twerth/ir_black'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'majutsushi/tagbar'
"Plugin 'sjl/gundo.vim'
Plugin 'w0rp/ale'
Plugin 'mklabs/split-term.vim'

call vundle#end()

" --- features ---
filetype plugin indent on
syntax on
set number
set hlsearch
" more tab-complete
set wildmenu

" --- appearance ---
set t_Co=256
set background=dark
colors ir_black
" Highlight long lines (longer than 80 chars)
let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

highlight clear SignColumn

" --- whitespace control ---
" set smarttab
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=start,indent
"set paste

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

" --- YouCompleteMe ---
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

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

" generate ctags
"map <leader>T :!/opt/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" vimfiler
let g:vimfiler_as_default_explorer = 1
" Disable netrw.vim
let g:loaded_netrwPlugin = 1
map <leader>e :VimFilerExplorer -parent -auto-expand<CR>
autocmd VimEnter * if !argc() | VimFiler | endif

" split-term
"let g:disable_key_mappings = 1
