define-command -override select-next-word %{
    select-word '<a-:>' 'w' '/'
}

define-command -override select-next-big-word %{
    select-word '<a-:>' '<a-w>' '/'
}

define-command -override select-previous-word %{
    select-word '<a-;>' 'w' '<a-/>'
}

define-command -override select-previous-big-word %{
    select-word '<a-;>' '<a-w>' '<a-/>'
}

define-command -override -params 3 select-word %{
    set-register s %val{selections_desc}

    try %{ execute-keys '<a-i>' %arg{2} %arg{1} }

    evaluate-commands %sh{
        if [ $kak_selections_desc = $kak_reg_s ]; then
            printf 'execute-keys "%s\w<ret><a-i>%s%s"' "$3" "$2" "$1"
        fi
    }
}

map global normal w     :select-next-word<ret>
map global normal <a-w> :select-next-big-word<ret>
map global normal b     :select-previous-word<ret>
map global normal <a-b> :select-previous-big-word<ret>
map global normal q     :select-previous-word<ret>
map global normal <a-q> :select-previous-big-word<ret>
