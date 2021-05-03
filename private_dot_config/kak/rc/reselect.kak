declare-option -hidden str reselect_state
define-command -override reselect %{
    set-option window reselect_state "%reg{z}"
    execute-keys '"zZ:nop<ret>'
    hook -once global ModeChange pop:insert:.* %{
        execute-keys '"zz:nop<ret>'
        set-register z "%opt{reselect_state}"
    }
}

map global normal i ':reselect<ret>;i'
map global normal a ';li'
