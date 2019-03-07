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

Plug 'Shougo/deoplete-lsp'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter'
Plug 'autozimu/LanguageClient-neovim', {'branch':'next', 'do':'bash install.sh'}
Plug 'bling/vim-bufferline'
Plug 'bogado/file-line'
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'glts/vim-textobj-comment'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'mopp/sky-color-clock.vim'
Plug 'qpkorr/vim-bufkill'
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

" Use incremental search
set hlsearch

" Disable visual and audible bells
set noerrorbells visualbell t_vb=

" Support 256-colors
set t_Co=256

" Color scheme
set background=dark
colors ir_black

" Only show line numbers on non-terminal windows
" (Must be done this way, since disabling them later incorrectly sets columns)
fun! EnableLineNumbers()
  if &buftype != 'terminal'
    setl number
  endif
endfun
autocmd BufEnter * call EnableLineNumbers()

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
autocmd BufEnter * call HighlightLongLines()

" Highlight tabs + trailing whitespace
set listchars=tab:→\ ,nbsp:␣,trail:·
set list
highlight NonText ctermfg=LightGray

" Do not highlight the line numbers/gutter
highlight clear SignColumn

" Popup menu color scheme
highlight Pmenu ctermbg=DarkGray
highlight PmenuSel ctermbg=DarkBlue ctermfg=White cterm=bold
highlight PmenuSbar ctermbg=LightGray

" whitespace control
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set backspace=start,indent

" Suppress 'match x of y', 'The only match' and 'Pattern not found' messages
set shortmess+=c

" Allow switching buffers without warning about modifications
set hidden

" zsh
set shell=/usr/local/bin/zsh\ --login

" change cwd to current buffer file's dir
set autochdir

" netrw
let netrw_liststyle=3
let netrw_winsize = -56
let netrw_banner = 0

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
set rtp+=/usr/local/opt/fzf

" dart-vim-plugin
let dart_html_in_string=v:true
let dart_style_guide = 2

" es7
autocmd BufRead,BufNewFile *.es7 setfiletype=javascript

" tcomment
let g:tcomment_textobject_inlinecomment = ''

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_smart_case = 1

" neosnippet
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips/']
let g:UltiSnipsEditSplit="vertical"

" ale
let g:ale_javascript_prettier_use_global = 1
let g:ale_javascript_xo_use_global = 1
let g:ale_javascript_xo_options = '--prettier --space'
let g:ale_cpp_cpplint_options = '--filter=-whitespace/braces,-whitespace/parens,-whitespace/newline,-readability/braces,-readability/alt_tokens'
let g:ale_c_clangformat_executable = '/usr/local/bin/clang-format'
let g:ale_html_tidy_executable = '/usr/local/bin/tidy'
let g:ale_html_tidy_options = '--custom-tags yes --wrap 80 --indent yes --indent-attributes yes --indent-spaces 2'

let g:ale_linters = {
  \ 'cpp': ['clangcheck', 'clangd', 'clangtidy', 'clazy', 'cpplint', 'flawfinder']
  \ }

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

" highlighting
highlight ALEError gui=undercurl term=undercurl cterm=undercurl guisp=deeppink
highlight ALEWarning gui=undercurl term=undercurl cterm=undercurl guisp=goldenrod1

" LanguageClient-neovim
if has('nvim')

let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'reason': ['ocaml-language-server', '--stdio'],
  \ 'ocaml': ['ocaml-language-server', '--stdio'],
  \ }
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/Users/paulreimer/.config/nvim/settings.json'

endif

" key mappings
let mapleader = ","

" ultisnips
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" neosnippet
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" deoplete
inoremap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"

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
"  " only expand Lsp if UltiSnips#ExpandSnippetOrJump not effect.
  let l:value = v:completed_item['word']
  let l:matched = len(l:value)
  if l:matched <= 0
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

" nvr
" delete buffer instead of quit
cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD' : 'q')<CR>
cabbrev q! <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD!' : 'q!')<CR>
cabbrev q1 <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'BD!' : 'q!')<CR>
cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'update <BAR> BD' : 'wq')<CR>
nnoremap ZZ :update <BAR> BD <CR>

" screen-like key bindings
noremap <C-a>c :tabnew <BAR> te <CR>
noremap <C-a>k :tabclose <CR>
"noremap <C-a><C-a> <C-^>
noremap <C-a><Space> :tabnext <CR>
noremap <C-a>0 0gt
noremap <C-a>1 1gt
noremap <C-a>2 2gt
noremap <C-a>3 3gt
noremap <C-a>4 4gt
noremap <C-a>5 5gt
noremap <C-a>6 6gt
noremap <C-a>7 7gt
noremap <C-a>8 8gt
noremap <C-a>9 9gt

" terminal mode screen-like key bindings
tnoremap <C-a>c <C-\><C-n> :tabnew <BAR> te <CR>
tnoremap <C-a>k <C-\><C-n> :tabclose <CR>
"tnoremap <C-a><C-a> <C-\><C-n> <C-^>
tnoremap <C-a><Space> <C-\><C-n> :tabnext <CR>
tnoremap <C-a>0 <C-\><C-n> 0gt
tnoremap <C-a>1 <C-\><C-n> 1gt
tnoremap <C-a>2 <C-\><C-n> 2gt
tnoremap <C-a>3 <C-\><C-n> 3gt
tnoremap <C-a>4 <C-\><C-n> 4gt
tnoremap <C-a>5 <C-\><C-n> 5gt
tnoremap <C-a>6 <C-\><C-n> 6gt
tnoremap <C-a>7 <C-\><C-n> 7gt
tnoremap <C-a>8 <C-\><C-n> 8gt
tnoremap <C-a>9 <C-\><C-n> 9gt

" use Esc to exit terminal mode
tnoremap <Esc> <C-\><C-n>

" yank selection into system clipboard
xnoremap <C-a>\ "*y

" Send Ctrl-A to nested screen/tmux
noremap <C-a>a <C-a>

" use Ctrl-A Ctrl-A to go to last-active tab
au TabLeave * let g:lasttab = tabpagenr()
noremap <C-a><C-a> :exe "tabn ".g:lasttab<CR>
tnoremap <C-a><C-a> <C-\><C-n> :exe "tabn ".g:lasttab<CR>

" fzf
nmap <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :Commits<CR>
nmap <leader>/ :Lines<CR>
nmap <leader>g :Ag<space>

" Tabularize
nmap <leader>t :TabFirst
nmap <leader>T :Tabularize /

" tagbar
nmap <leader>c :TagbarToggle<CR>

" gitgutter
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

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
