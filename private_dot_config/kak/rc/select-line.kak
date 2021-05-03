define-command -override -params 1 extend-line-down %{
  execute-keys "<a-:>%arg{1}X"
}

define-command -override -params 1 extend-line-up %{
  execute-keys "<a-:><a-;>%arg{1}K<a-;>"
  try %{
    execute-keys -draft ';<a-K>\n<ret>'
    execute-keys X
  }
  execute-keys '<a-;><a-X>'
}

map global normal x ':extend-line-down %val{count}<ret>' -docstring 'Extend selection down'
map global normal X ':extend-line-up %val{count}<ret>'   -docstring 'Extend selection up'
