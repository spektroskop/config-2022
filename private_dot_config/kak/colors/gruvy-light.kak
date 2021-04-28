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
    '{${fg1}}%val{cursor_line}:%val{cursor_char_column} {default}{${fg1}+b}%val{bufname}{default}{${aqua2}} %val{client}@%val{session} {default}'

remove-hooks window gruvy

define-command -override gruvy-active %{
    set-face window StatusLine ${fg4},${bg1}
}

define-command -override gruvy-inactive %{
    set-face window StatusLine ${fg4},${bg3}
}

hook global -group gruvy FocusIn .* %{ gruvy-active }
hook global -group gruvy FocusOut .* %{ gruvy-inactive }
gruvy-active

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
# face global builtin       ${fg0}+b
face global builtin       ${aqua2}

face global Default default,default

face global PrimarySelection ${bg0_hard},${blue2}+g
face global SecondarySelection ${bg0_hard},${blue1}+g

face global PrimaryCursor ${bg0_hard},${fg0}+fg
face global SecondaryCursor ${bg0_hard},${fg3}+fg
face global PrimaryCursorEol ${bg0_hard},${blue2}+fg   # TODO forskjellig fra selection
face global SecondaryCursorEol ${bg0_hard},${blue1}+fg # TODO forskjellig fra selection

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
