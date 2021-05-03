define-command connect -override -params 1.. -command-completion %{
    %arg{1} sh -c %{
        export KAKOUNE_SESSION=$1
        export KAKOUNE_CLIENT=$2
        shift 3
        [ $# = 0 ] && set "$SHELL"
        "$@"
    } -- %val{session} %val{client} %arg{@}
}

define-command -override connect-terminal -params .. -shell-completion %{
    connect terminal %arg{@}
}

alias global > connect-terminal
