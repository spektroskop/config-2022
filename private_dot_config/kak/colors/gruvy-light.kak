evaluate-commands %sh{

alpha() {
    echo "$(echo $1|sed 's,rgb,rgba,')$2"
}

bg0_soft="rgb:f2e5bc"
bg0_medium="rgb:fbf1c7"
bg0_hard="rgb:f9f5d7"
bg1="rgb:ebdbb2" 
bg2="rgb:d5c4a1"
bg3="rgb:bdae93"
bg4="rgb:a89984"

fg0="rgb:282828"
fg1="rgb:3c3836"
fg2="rgb:504945"
fg3="rgb:665c54"
fg4="rgb:7c6f64"

red1="rgb:cc241d"
red2="rgb:9d0006"
green1="rgb:98971a"
green2="rgb:79740e"
yellow1="rgb:d79921"
yellow2="rgb:b57614"
blue1="rgb:458588"
blue2="rgb:076678"
purple1="rgb:b16286"
purple2="rgb:8f3f71"
aqua1="rgb:689d6a"
aqua2="rgb:427b58"
gray1="rgb:928374"
gray2="rgb:7c6f64"
orange1="rgb:af3a03"
orange2="rgb:d65d0e"

echo "

declare-option -hidden str theme_modeline \
    '{{mode_info}} {{context_info}} {gruvyCursor}%val{cursor_line}:%val{cursor_char_column} {gruvyBufname}%val{bufname}{gruvyClient} %val{client}@%val{session} '

define-command -hidden -override gruvy-active %{
    set-face window Information ${fg1},${bg1}
    set-face window StatusLine ${fg4},${bg1}
    set-face window StatusLineInfo ${blue2}
    set-face window gruvyBufname ${fg1}+b
    set-face window gruvyClient ${blue2}
    set-face window gruvyCursor ${fg1}
}

define-command -hidden -override gruvy-inactive %{
    set-face window Information ${fg2},${bg3}
    set-face window StatusLine ${fg2},${bg3}
    set-face window StatusLineInfo ${fg2}
    set-face window gruvyBufname ${fg2}
    set-face window gruvyClient ${fg2}
    set-face window gruvyCursor ${fg2}
}

hook global -group gruvy FocusIn .* %{ gruvy-active }
hook global -group gruvy FocusOut .* %{ gruvy-inactive }

set-face global gruvyCursor ${fg1}
set-face global gruvyBufname ${fg1}+b
set-face global gruvyClient ${blue2}

set-face global value         ${purple2}
set-face global type          ${yellow2}
set-face global variable      ${blue2}
set-face global module        ${green2}
set-face global function      ${fg0}
set-face global string        ${green2}+i
set-face global keyword       ${red2}
set-face global operator      ${fg0}+b
set-face global attribute     ${orange2}
set-face global comment       ${gray2}+i
set-face global documentation comment
set-face global meta          ${aqua2}
set-face global builtin       ${aqua2}

set-face global title     ${green2}+b
set-face global header    ${orange2}
set-face global mono      ${fg4}
set-face global block     ${aqua2}
set-face global link      ${blue2}+u
set-face global bullet    ${yellow2}
set-face global list      ${fg0}

set-face global Default default,default

set-face global PrimarySelection ${bg0_hard},${blue2}+g
set-face global SecondarySelection ${bg0_hard},${blue1}+g

set-face global PrimaryCursor ${bg0_hard},${fg0}+fg
set-face global SecondaryCursor ${bg0_hard},${fg3}+fg
set-face global PrimaryCursorEol ${bg0_hard},${yellow2}+fg
set-face global SecondaryCursorEol ${bg0_hard},${yellow1}+fg

set-face global MenuInfo ${bg0_hard}
set-face global MenuForeground ${bg2},${blue2}
set-face global MenuBackground ${fg0},${bg2}

set-face global LineNumbers ${bg0_hard}
set-face global LineNumberCursor ${yellow2},${bg1}
set-face global LineNumbersWrapped ${bg1}

set-face global Information ${fg1},${bg1}
set-face global Error ${bg0_hard},${red1}

set-face global StatusLine default,${bg1}
set-face global StatusLineMode ${yellow2}
set-face global StatusLineInfo ${blue2}
set-face global StatusLineValue ${blue2}
set-face global StatusCursor ${bg0_hard},${fg0}
set-face global Prompt ${yellow2}

set-face global BufferPadding ${bg4}
set-face global MatchingChar default,${bg1}
set-face global Whitespace ${bg3}+f
set-face global WrapMarker ${fg4}

"
}
