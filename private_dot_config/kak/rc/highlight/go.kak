add-highlighter shared/go regions

add-highlighter shared/go/string region '"' '"|$' group
add-highlighter shared/go/string/ fill string
add-highlighter shared/go/string/ regex \%#?[%a-zA-Z0-9] 0:meta
add-highlighter shared/go/string/ regex \\[a-zA-Z] 0:meta

add-highlighter shared/go/raw_string region '`' '`' group
add-highlighter shared/go/raw_string/ fill string
add-highlighter shared/go/raw_string/ regex \%#?[%a-zA-Z0-9] 0:meta

add-highlighter shared/go/rune region "'" "'|$" group
add-highlighter shared/go/rune/ regex '.' 0:meta
add-highlighter shared/go/rune/ regex ('.)([^'$]*) 1:meta 2:Error

add-highlighter shared/go/block_comment region /\* \*/ fill comment
add-highlighter shared/go/line_comment  region '//' $  fill comment

add-highlighter shared/go/code default-region group

evaluate-commands %sh{
    join() { eval set -- $1; local IFS="|"; echo "$*"; }

    # https://golang.org/ref/spec
    dec_dig='([0-9](_?[0-9]+)*)' ; dec_lit="($dec_dig)"
    bin_dig='([01](_?[01]+)*)' ; bin_lit="(0[bB]_?$bin_dig)"
    oct_dig='([0-7](_?[0-7]+)*)' ; oct_lit="(0[oO]_?$oct_dig)"
    hex_dig='([0-9a-fA-F](_?[0-9a-fA-F]+)*)' ; hex_lit="(0[xX]_?$hex_dig)"
    int_lit="($dec_lit|$bin_lit|$oct_lit|$hex_lit)"
    dec_exp="([eE][+-]?$dec_dig)"
    dec_float_lit="(($dec_dig\.$dec_dig?$dec_exp?)|($dec_dig$dec_exp)|(\.$dec_dig$dec_exp?))"
    hex_man="((_?$hex_dig\.$hex_dig?)|(_?$hex_dig)|(\.$hex_dig))"
    hex_exp="([pP][+-]?$dec_dig)"
    hex_float_lit="(0[xX]$hex_man$hex_exp)"
    float_lit="($dec_float_lit|$hex_float_lit)"
    imag_lit="(($dec_dig|$int_lit|$float_lit)i)"

    number="($int_lit|$float_lit|$imag_lit)"
    simple_number='(-?(\d(_?\d+)*)(\.(\d(_?\d+)*))?)'
    id='([^\W\d][\w]*)'
    vars="($id(,\h*$id)*)"

    values="true false nil iota"
    keywords="package import
              const var
              type struct
              func defer return
              if else for range continue break
              switch case default"
    types="map error interface
           bool string byte rune
           int int8 int16 int32 int64
           uint uint8 uint16 uint32 uint64 uintptr
           float32 float64 complex64 complex128"

    printf %s "
        add-highlighter shared/go/code/ regex (\b|\.)$number\b 0:value
        # add-highlighter shared/go/code/ regex \b$simple_number\b 0:value
        add-highlighter shared/go/code/ regex \[([^\]]+)\] 1:value
        add-highlighter shared/go/code/ regex \b$id\( 1:function
        add-highlighter shared/go/code/ regex \b($(join "$values"))\b 0:value
        add-highlighter shared/go/code/ regex \b($(join "$keywords"))\b 0:keyword
        add-highlighter shared/go/code/ regex \b($(join "$types"))\b 0:type
        add-highlighter shared/go/code/ regex map\[([^\]]+)\] 1:type
        add-highlighter shared/go/code/ regex \[\]([^\h]+)(\h|$) 1:type
        add-highlighter shared/go/code/ regex \bvar\h+$vars 1:variable
        add-highlighter shared/go/code/ regex \b$vars\h+(:?=\h) 1:variable
    "
}
