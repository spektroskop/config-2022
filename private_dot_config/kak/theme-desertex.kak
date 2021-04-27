colorscheme desertex

set-face global Default default,default
set-face global BufferPadding rgb:282828,default
# set-face global comment rgb:bdae93
# set-face global PrimarySelection rgb:282828,rgb:aaaaaa
# set-face global SecondarySelection rgb:181818,rgb:777777
# set-face global Whitespace rgb:3a3a3a+f
# set-face global WrapMarker rgb:504945
# set-face global Reference default,rgba:282828a0

set-face global StatusLine rgb:282828,rgb:aaaaaa
set-face global StatusLineMode rgb:282828+b
set-face global StatusLineInfo rgb:8f3f71
set-face global StatusCursor rgb:8f3f71
set-face global StatusLineValue rgb:282828
set-face global Prompt rgb:282828

set-face global MenuForeground rgb:282828,rgb:aaaaaa
set-face global MenuBackground rgb:aaaaaa,rgb:282828
set-face global Information rgb:282828,rgb:aaaaaa

hook global FocusIn .* %{
    set-face window StatusLine rgb:282828,rgb:aaaaaa
}

hook global FocusOut .* %{
    set-face window StatusLine rgb:383838,rgb:888888
}
