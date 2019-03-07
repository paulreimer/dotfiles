call lh#brackets#define_imap(';', 'lh#cpp#brackets#semicolon()', 1, ';')

" Override default definition from lh-brackets to take care of semi-colon
call lh#brackets#define_imap('<bs>',
  \ [{ 'condition': 'getline(".")[:col(".")-2]=~".*\"\\s*)\\+;$"',
  \   'action': 'lh#cpp#brackets#move_semicolon_back_to_string_context()'},
  \  { 'condition': 'lh#brackets#_match_any_bracket_pair()',
  \   'action': 'lh#brackets#_delete_empty_bracket_pair()'}],
  \ 1,
  \ '\<bs\>'
  \ )
