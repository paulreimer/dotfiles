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
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Shougo/neoinclude.vim'
Plug 'airblade/vim-gitgutter'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-css-color'
Plug 'bling/vim-bufferline'
Plug 'bogado/file-line'
Plug 'chrisbra/csv.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'editorconfig/editorconfig-vim'
Plug 'gleam-lang/gleam.vim'
Plug 'glts/vim-textobj-comment'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'itchyny/lightline.vim'
Plug 'jjo/vim-cue'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-user'
Plug 'keith/swift.vim'
Plug 'maximbaz/lightline-ale'
Plug 'mopp/sky-color-clock.vim'
Plug 'ncm2/float-preview.nvim'
Plug 'nishigori/increment-activator'
Plug 'neomake/neomake'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'onsails/lspkind-nvim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'qpkorr/vim-bufkill'
Plug 'romgrk/nvim-treesitter-context'
Plug 'sakhnik/nvim-gdb'
Plug 'thosakwe/vim-flutter'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'twerth/ir_black'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'vim-scripts/ShowMultiBase'
Plug 'w0rp/ale'
Plug 'zah/nim.vim'
Plug 'ziglang/zig.vim'
call plug#end()

" Load configuration / settings
source .config.vim
