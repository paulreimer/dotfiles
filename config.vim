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

" Use mouse in Normal + Terminal modes
set mouse=n

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

" Find git root directory, use it for fzf files search
fun! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfun
command! ProjectFiles execute 'Files' s:find_git_root()

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
    let l:term_cwd = system("lsof -a -d cwd -c zsh -p " . term_pid . " -Fn 2>/dev/null | sed -n -e 's/^n\\(.*\\)$/\\1/p'")[:-2]
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

" jedi
let g:jedi#completions_enabled = 0

" float-preview.nvim
" Do not open a popup window
set completeopt-=preview
let g:float_preview#docked = 1
autocmd CompleteDone * silent! call float_preview#close()!
autocmd InsertLeave * silent! call float_preview#close()!

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
  \ 'zig': ['zls'],
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

" nvim-compe
lua <<EOF
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  source = {
    omni = false;
    path = true;
    buffer = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
EOF

" vsnip
let g:vsnip_extra_mapping = v:false

" nvim-lspconfig
lua <<EOF
-- vim.lsp.set_log_level("debug")

-- Enable LSP snippet support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require'lspconfig'.clangd.setup{
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--all-scopes-completion",
    "--completion-style=detailed"
  },
  filetypes = {"c", "cpp", "objc", "objcpp"},
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true
  },
}
require'lspconfig'.jedi_language_server.setup{
  capabilities = capabilities,
  -- cmd = {"/nix/store/845rimzb6jrqmbzj9xmrgl7sz890wdd0-python3-3.8.9-env/bin/python3.8", "/Users/paulreimer/.local/bin/jedi-language-server"}
  cmd = {"python3", "/Users/paulreimer/.local/bin/jedi-language-server"}
}
EOF

" nvim-lspkind
lua <<EOF
require('lspkind').init()
EOF

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- ensure_installed = "maintained",
  ensure_installed = {
    "c",
    "cpp",
    "css",
    "dart",
    "dockerfile",
    "erlang",
    "html",
    "javascript",
    "json",
    "lua",
    "nix",
    "python",
    "rust",
    "yaml",
    "zig"
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "cpp" },
  }
}
EOF

" use tree-sitter for folding
set foldlevelstart=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

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

" vim-sourcetrail
let g:sourcetrail_to_vim_port = 6668

" zig-vim
" Disable automatic code formatting on save
let g:zig_fmt_autosave = 0

" increment-activator
let g:increment_activator_no_default_key_mappings = 1

" nvim-ts-rainbow
lua <<EOF
require'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = 1000,
  }
}
EOF

" vim-matchup
lua <<EOF
require'nvim-treesitter.configs'.setup {
  matchup = {
    enable = true,
  },
}
EOF

" key mappings
let mapleader = ","

" nvim-compe supertab
lua <<EOF
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
  if vim.fn.call("vsnip#jumpable", {1}) == 1 then
    return t "<Plug>(vsnip-jump-next)"
  elseif vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

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
nmap <silent> <leader>f :ProjectFiles<CR>
nmap <leader>F :Ag<space>
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

" vim-sourcetrail
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

" increment-activator
nmap <silent> <leader>a <Plug>(increment-activator-increment)
nmap <silent> <leader>z <Plug>(increment-activator-decrement)

" nvim-compe
inoremap <silent><expr> <C-n> compe#complete()
inoremap <silent><expr> <CR> compe#confirm('<CR>')
inoremap <silent><expr> <C-e> compe#close('<C-e>')

" sky-color-clock.vim
set statusline+=%#SkyColorClockTemp#\ %#SkyColorClock#%{sky_color_clock#statusline()}
let g:sky_color_clock#datetime_format = '%a %d %l:%M%p'
let g:sky_color_clock#enable_emoji_icon = 0
let g:sky_color_clock#openweathermap_api_key = '4532f4c71abfc2f9969fd33e026db7b5'
let g:sky_color_clock#openweathermap_city_id = '6173331'
