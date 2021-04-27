source "%val{config}/theme-gruvbox.kak"

set-face global PrimarySelection rgb:282828,rgb:aaaaaa
set-face global SecondarySelection rgb:181818,rgb:777777
set-face global StatusLine rgb:282828,rgb:aaaaaa
set-face global StatusLineMode rgb:282828+b
set-face global StatusLineInfo rgb:282828
set-face global StatusCursor rgb:282828
set-face global StatusLineValue rgb:282828
set-face global Prompt rgb:282828

set-face global MenuForeground rgb:282828,rgb:aaaaaa
set-face global MenuBackground rgb:aaaaaa,rgb:282828
set-face global Information rgb:282828,rgb:aaaaaa

hook global FocusIn .* %{
    set-face window StatusLine rgb:282828,rgb:aaaaaa
}

hook global FocusOut .* %{
    # set-face window StatusLine rgb:282828,rgb:aaaaaa
    set-face window StatusLine rgb:282828,rgb:555555
}
