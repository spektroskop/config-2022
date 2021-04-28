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
    '{${fg3}}%val{cursor_line}:%val{cursor_char_column} {default}{${fg3}+b}%val{bufname}{default}{${yellow2}} %val{client}@%val{session} {default}'

face global value         ${purple2}
face global type          ${yellow2}
face global variable      ${blue2}
face global module        ${green2}
face global function      ${fg0}
face global string        ${green2}+i
face global keyword       ${red2}
face global operator      ${fg0}+b
face global attribute     ${orange2}
face global comment       ${gray2}+i
face global documentation comment
face global meta          ${aqua2}
face global builtin       ${fg0}+b

face global Default default,default

face global PrimarySelection ${bg0_hard},${blue2}+g
face global SecondarySelection ${bg0_hard},${blue1}+g

face global PrimaryCursor ${bg0_hard},${fg0}+fg
face global SecondaryCursor ${bg0_hard},${fg3}+fg
face global PrimaryCursorEol ${bg0_hard},${yellow2}+fg
face global SecondaryCursorEol ${bg0_hard},${yellow1}+fg

face global MenuInfo ${bg0_hard}
face global MenuForeground ${bg2},${blue2}
face global MenuBackground ${fg0},${bg2}

face global LineNumbers ${bg4}
face global LineNumberCursor ${yellow2},${bg1}
face global LineNumbersWrapped ${bg1}

face global Information ${fg1},${bg1}
face global Error ${bg0_hard},${red1}

face global StatusLine default,${bg1}
face global StatusLineMode ${blue2}
face global StatusLineInfo ${purple2}
face global StatusLineValue ${red2}
face global StatusCursor ${bg0_hard},${fg0}
face global Prompt ${yellow2}

face global BufferPadding ${bg4}
face global MatchingChar default,${bg1}
face global Whitespace ${bg3}+f
face global WrapMarker ${fg4}
"
}
