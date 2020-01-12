if ! exists('g:loaded_deoplete')
  finish
endif

let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_smart_case = 1

" Set default sources
call deoplete#custom#option('sources', {
  \ '_': ['file/include', 'neosnippet', 'ale', 'member', 'buffer', 'zsh', 'emoji'],
  \ 'python': ['file/include', 'neosnippet', 'jedi', 'member', 'buffer'],
  \ })

" Set the max popup menu width
call deoplete#custom#source('_', 'max_abbr_width', 180)
call deoplete#custom#source('_', 'max_menu_width', 180)
" Set the max popup menu height
call deoplete#custom#option('max_list', 10)

call deoplete#enable()
