" vim-plug
" install:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" nvim +'PlugInstall --sync' +qa

call plug#begin()

Plug 'CoatiSoftware/vim-sourcetrail'
Plug 'LnL7/vim-nix'
Plug 'LucHermitte/lh-brackets'
Plug 'LucHermitte/lh-vim-lib'
Plug 'Shougo/deoplete-lsp'
Plug 'Shougo/neoinclude.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'autozimu/LanguageClient-neovim', {'branch':'next', 'do':'bash install.sh'}
Plug 'bling/vim-bufferline'
Plug 'bogado/file-line'
Plug 'dart-lang/dart-vim-plugin'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'editorconfig/editorconfig-vim'
Plug 'glts/vim-textobj-comment'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'maximbaz/lightline-ale'
Plug 'mopp/sky-color-clock.vim'
Plug 'ncm2/float-preview.nvim'
Plug 'neomake/neomake'
Plug 'qpkorr/vim-bufkill'
Plug 'thosakwe/vim-flutter'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'twerth/ir_black'
Plug 'vim-scripts/DoxygenToolkit.vim'
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

" Load configuration / settings
source .config.vim
