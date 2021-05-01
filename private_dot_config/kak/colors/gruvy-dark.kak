evaluate-commands %sh{

alpha() {
    echo "$(echo $1|sed 's,rgb,rgba,')$2"
}

bg0_soft="rgb:32302f"
bg0_medium="rgb:282828"
bg0_hard="rgb:1d2021"
bg1="rgb:3c3836"
bg2="rgb:504945"
bg3="rgb:665c54"
bg4="rgb:7c6f64"

fg0="rgb:fbf1c7"
fg1="rgb:ebdbb2"
fg2="rgb:d5c4a1"
fg3="rgb:bdae93"
fg4="rgb:a89984"

red1="rgb:cc241d"
red2="rgb:fb4934"
green1="rgb:98971a"
green2="rgb:b8bb26"
yellow1="rgb:d79921"
yellow2="rgb:fabd2f"
blue1="rgb:458588"
blue2="rgb:83a598"
purple1="rgb:b16286"
purple2="rgb:d3869b"
aqua1="rgb:689d6a"
aqua2="rgb:8ec07c"
gray1="rgb:928374"
gray2="rgb:a89984"
orange1="rgb:fe8019"
orange2="rgb:d65d0e"

echo "

declare-option -hidden str theme_modeline \
    '{{mode_info}} {{context_info}} {gruvyCursor}%val{cursor_line}:%val{cursor_char_column} {gruvyBufname}%opt{bufname}{gruvyClient} %val{client}@%val{session} '

define-command -hidden -override gruvy-active %{
    set-face window Information ${fg1},${bg1}
    set-face window StatusLine default,${bg1}
    set-face window StatusLineInfo ${yellow2}
    set-face window gruvyBufname ${fg3}+b
    set-face window gruvyClient ${yellow2}
    set-face window gruvyCursor ${fg3}
    set-face window PrimaryCursor ${bg0_hard},${fg0}+fg
}

define-command -hidden -override gruvy-inactive %{
    set-face window Information ${bg4},${bg0_hard}
    set-face window StatusLine ${bg4},${bg0_hard}
    set-face window StatusLineInfo ${bg4}
    set-face window gruvyBufname ${bg4}
    set-face window gruvyClient ${bg4}
    set-face window gruvyCursor ${bg4}
    set-face window PrimaryCursor ${bg0_hard},${bg3}+fg
}

hook global -group gruvy WinDisplay .* %{ gruvy-active }
hook global -group gruvy FocusIn .* %{ gruvy-active }
hook global -group gruvy FocusOut .* %{ gruvy-inactive }

set-face global value         ${purple2}
set-face global type          ${yellow2}
set-face global variable      ${blue2}
set-face global module        ${green2}
set-face global function      ${aqua2}+b
set-face global string        ${green2}+i
set-face global keyword       ${red2}
set-face global operator      default+b
set-face global attribute     ${orange2}
set-face global comment       ${gray2}+i
set-face global documentation comment
set-face global meta          ${aqua2}+b
set-face global builtin       ${aqua2}

set-face global title     ${green2}+b
set-face global header    ${orange2}
set-face global mono      ${fg4}
set-face global block     ${aqua2}
set-face global link      ${blue2}+u
set-face global bullet    ${yellow2}
set-face global list      ${fg0}

set-face global Default default,default

set-face global PrimarySelection $(alpha $bg0_hard a0),${blue2}+g
set-face global SecondarySelection $(alpha $bg0_hard a0),${blue1}+g

set-face global SecondaryCursor ${bg0_hard},${fg3}+fg
set-face global PrimaryCursorEol ${bg0_hard},${yellow2}+fg
set-face global SecondaryCursorEol ${bg0_hard},${yellow1}+fg

set-face global MenuInfo ${bg0_hard}
set-face global MenuForeground ${bg2},${blue2}
set-face global MenuBackground ${fg0},${bg2}

set-face global LineNumbers ${bg4}
set-face global LineNumberCursor ${yellow2},${bg1}
set-face global LineNumbersWrapped ${bg1}

set-face global Error ${bg0_hard},${red1}

set-face global StatusLineMode ${yellow2}
set-face global StatusLineValue ${purple2}
set-face global StatusCursor ${bg0_hard},${fg0}
set-face global Prompt ${yellow2}

set-face global BufferPadding ${bg4}
set-face global MatchingChar default,${bg1}
set-face global Whitespace ${bg0_medium}+f
set-face global WrapMarker ${fg4}

"
}
