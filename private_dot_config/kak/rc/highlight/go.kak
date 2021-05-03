add-highlighter shared/go regions

add-highlighter shared/go/string region '"' '"|$' group
add-highlighter shared/go/string/ fill string
add-highlighter shared/go/string/percent regex \%#?[%a-zA-Z0-9] 0:meta
add-highlighter shared/go/string/ regex \\[a-zA-Z] 0:meta

add-highlighter shared/go/raw_string region '`' '`' group
add-highlighter shared/go/raw_string/ fill string
add-highlighter shared/go/raw_string/ ref go/string/percent

add-highlighter shared/go/rune region "'" "'|$" group
add-highlighter shared/go/rune/ regex '.' 0:attribute
add-highlighter shared/go/rune/ regex ('.)([^'$]*) 1:attribute 2:Information

add-highlighter shared/go/block_comment region /\* \*/ fill comment
add-highlighter shared/go/line_comment  region '//' $  fill comment

add-highlighter shared/go/code default-region group
add-highlighter shared/go/code/numbers regex (0[bBoOxX]|[-+]?\d|\.\d)[\w.]*i? 0:value
add-highlighter shared/go/code/var regex var\h+(\w+(,\h*\w+)*) 1:variable
add-highlighter shared/go/code/short_var regex \b(\w+(,\h*\w+)*)\h+(:?=\h) 1:variable
add-highlighter shared/go/code/function_call regex \b(\w+)\( 1:function

# add-highlighter shared/go/code/slice regex \[([^\]]+)\] 1:value
# add-highlighter shared/go/code/map regex map\[([^\]]+)\] 1:type

# add-highlighter shared/go/var region 'var' '\h*=|$' group
# add-highlighter shared/go/var/ ref go/code/function
# add-highlighter shared/go/var/ ref go/code/keywords
# add-highlighter shared/go/var/ ref go/code/map
# add-highlighter shared/go/var/ ref go/code/numbers
# add-highlighter shared/go/var/ ref go/code/var
# add-highlighter shared/go/var/types1 regex var\h+\w+,?\h.*?(\w+)\h*(=|$) 1:type

# add-highlighter shared/go/func region 'func' '\{' group
# add-highlighter shared/go/func/ ref go/code/keywords
# add-highlighter shared/go/func/ ref go/code/map
# add-highlighter shared/go/func/ ref go/code/numbers
# add-highlighter shared/go/func/ ref go/code/types
# add-highlighter shared/go/func/ ref go/code/values
# add-highlighter shared/go/func/ ref go/code/function
# add-highlighter shared/go/func/types regex \*?([\w]+)[,)] 1:type

evaluate-commands %sh{
    join() { eval set -- $1; local IFS="|"; echo "$*"; }

    # fake_number='(0[bBoOxX]|[-+]?\d|\.\d)[\w.]*i?'
    # id='([^\W\d][\w]*)'
    # vars="($id(,\h*$id)*)"

    keywords="break case chan const continue default defer else fallthrough for func go goto
              if import interface map package range return select struct switch type var"
    types="map error interface bool string byte rune float32 float64 complex64 complex128
           int int8 int16 int32 int64 uint uint8 uint16 uint32 uint64 uintptr"
    values="true false nil iota"

    printf %s "
        add-highlighter shared/go/code/values regex \b($(join "$values"))\b 0:value
        add-highlighter shared/go/code/keywords regex \b($(join "$keywords"))\b 0:keyword
        add-highlighter shared/go/code/types regex \b($(join "$types"))\b 0:type

        # add-highlighter shared/go/code/numbers regex $fake_number 0:value
        # add-highlighter shared/go/code/function_call regex \b$id\( 1:function
        # add-highlighter shared/go/code/var regex \bvar\h+$vars 1:variable
        # add-highlighter shared/go/code/short_var regex \b$vars\h+(:?=\h) 1:variable
    "
}
