execute pathogen#infect()

set nocompatible

" --- Key Mappings ---
let mapleader = ","
" vcscommand
map <leader>a :VCSAdd<CR>
map <leader>c :VCSCommit<CR>
map <leader>s :VCSStatus<CR>
map <leader>d :VCSDiff<CR>
" Tabularize
map <leader>t :Tabularize /
" Tex forward search
map <leader>r :w<CR>:silent !/Users/paulreimer/Applications/Skim.app/Contents/SharedSupport/displayline <C-r>=line('.')<CR> %<.pdf %<CR>
" generate ctags
map <leader>T :!/opt/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
" NERDTree
map <leader>D :execute 'NERDTreeToggle ' . getcwd()<CR>
" FuzzyFinder
map <leader>f :FuzzyFinderFile<CR>
map <leader>F :FuzzyFinderDir<CR>
map <leader>B :FuzzyFinderBuffer<CR>

" --- features ---
filetype plugin on
filetype indent on
syntax on
set number
set hlsearch

" --- appearance ---
set t_Co=256
set background=dark
" colors monokai
" colors molokai
" colors Tomorrow-Night-Eighties
" colors desert
colors ir_black
" colors solarized
" colors hybrid
set gfn=Droid\ Sans\ Mono:h12.00
" Highlight long lines (longer than 80 chars)
let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

highlight clear SignColumn

" --- whitespace control ---
set tabstop=2
set shiftwidth=2
set smarttab
" set autoindent
set expandtab
set backspace=start,indent
set paste

" --- ack ---
set grepprg=ack\ $*
set grepformat=%f:%l:%m
"set grepprg=grep\ -nH\ $*

" --- Vim/Latex ---
let g:Tex_DefaultTargetFormat = 'pdf'

let g:tex_flavor='latex'
let g:Tex_ViewRule_ps = 'Skim'
let g:Tex_ViewRule_pdf = 'Skim'
let g:Tex_ViewRule_dvi = 'Skim'

let g:Tex_CompileRule_pdf = 'xelatex --synctex=1 --interaction=nonstopmode $*'

" --- OmniCppComplete ---
set nocp
" auto close options when exiting insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone
" activation
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window

" add current directory's generated tags file to available tags
set tags+=~/.my_ctags/**/tags

" --- SuperTab ---
let g:SuperTabDefaultCompletionType = "context"

" --- HardMode ---
"autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
nnoremap <leader>h <Esc>:call ToggleHardMode()<CR>
