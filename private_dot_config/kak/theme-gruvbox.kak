colorscheme gruvbox

set-face global Default default,default
set-face global BufferPadding rgb:504945,default
set-face global comment rgb:bdae93                                                               
set-face global PrimarySelection rgba:ebdbb2a0,rgb:436558+g
set-face global SecondarySelection rgba:282828a0,rgb:436558+g
set-face global Whitespace rgb:3a3a3a+f
set-face global WrapMarker rgb:504945
set-face global Reference default,rgba:282828a0

hook global FocusIn .* %{
    set-face window StatusLine rgb:ebdbb2,rgb:282828
}

hook global FocusOut .* %{
    set-face window StatusLine rgb:504945,rgb:181818
}
