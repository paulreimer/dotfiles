if ! exists('g:loaded_deoplete')
  finish
endif

call deoplete#custom#option('min_pattern_length', 1)
call deoplete#custom#option('smart_case', v:true)

" Set default sources
call deoplete#custom#option('sources', {
  \ '_': ['file/include', 'neosnippet', 'ale', 'member', 'buffer', 'zsh', 'emoji'],
  \ 'python': ['file/include', 'neosnippet', 'jedi', 'member', 'buffer'],
  \ })

" Set the max popup menu width
call deoplete#custom#source('_', 'max_abbr_width', 180)
call deoplete#custom#source('_', 'max_menu_width', 180)

" Insert unicode emoji characters
call deoplete#custom#source('emoji', 'converters', ['converter_emoji'])
" Filetypes which should get emoji completion
call deoplete#custom#source('emoji', 'filetypes', [])

call deoplete#enable()
