add-highlighter shared/go regions

add-highlighter shared/go/string region '"' '"' group
add-highlighter shared/go/string/ fill string
add-highlighter shared/go/string/ regex \%#?[%a-zA-Z0-9] 0:meta
add-highlighter shared/go/string/ regex \\[a-zA-Z] 0:meta

add-highlighter shared/go/raw_string region '`' '`' group
add-highlighter shared/go/raw_string/ fill string
add-highlighter shared/go/raw_string/ regex \%#?[%a-zA-Z0-9] 0:meta

add-highlighter shared/go/rune region "'" "'" group
add-highlighter shared/go/rune/ regex '.' 0:meta
add-highlighter shared/go/rune/ regex ('.)([^'$]*) 1:meta 2:Error

add-highlighter shared/go/block_comment region /\* \*/ fill comment
add-highlighter shared/go/line_comment  region '//' $  fill comment

add-highlighter shared/go/code default-region group

evaluate-commands %sh{
    join() { local IFS="|"; echo "$*"; }

    # TODO: float, complex
    dec='[0-9]+'
    bin='0[bB]_?[10](_?[10]+)*'
    oct='0[oO]_?[0-7](_?[0-7]+)*'
    hex='0[xX]_?[0-9a-fA-F](_?[0-9a-fA-F]+)*'
    id='[^\W\d][\w]*'
    vars="($id(,\h*$id)*)"

    values=$(join true false nil iota)
    keywords=$(join package import const var type struct func defer return \
        if else for range continue break switch case default)
    types=$(join map error interface bool string byte rune int int8 int16 int32 int64 \
        uint uint8 uint16 uint32 uint64 uintptr float32 float64 complex64 complex128)

    printf %s "
        add-highlighter shared/go/code/ regex \b[+-]?($dec|$bin|$oct|$hex)\b 0:value
        add-highlighter shared/go/code/ regex \b([^\W\d_][\w]*)\( 1:function
        add-highlighter shared/go/code/ regex \b($values)\b 0:value
        add-highlighter shared/go/code/ regex \b($keywords)\b 0:keyword
        add-highlighter shared/go/code/ regex \b($types)\b 0:type
        add-highlighter shared/go/code/ regex \bvar\h+$vars 1:variable
        add-highlighter shared/go/code/ regex \b$vars\h+(:?=\h) 1:variable
    "
}
