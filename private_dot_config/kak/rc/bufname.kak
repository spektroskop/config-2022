declare-option -hidden str bufname
define-command -hidden -override shorten-bufname %{
    set-option buffer bufname %sh{
        printf "%s\n" "${kak_bufname}" | perl -pe 's:(?(?<=/)|(?<=^))([^\p{Letter}\p{Digit}]+.|[^/]).+?/:\1/:g'
    }
}
hook global WinDisplay .* shorten-bufname
hook global BufWritePost .* shorten-bufname
# hook global NormalIdle .* shorten-bufname
