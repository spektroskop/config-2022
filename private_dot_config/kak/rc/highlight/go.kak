add-highlighter shared/go regions

add-highlighter shared/go/double_string region '"' '"' group
add-highlighter shared/go/double_string/ fill string
add-highlighter shared/go/double_string/ regex \%[%\w] 0:meta
add-highlighter shared/go/double_string/ regex \\\w 0:meta

add-highlighter shared/go/back_string region '`' '`' group
add-highlighter shared/go/back_string/ fill string
add-highlighter shared/go/back_string/ regex \%[%#a-zA-Z] 0:meta
add-highlighter shared/go/back_string/ regex \\\w 0:meta

add-highlighter shared/go/single_string region "'" "'" fill string
add-highlighter shared/go/block_comment region /\* \*/ fill comment
add-highlighter shared/go/line_comment  region '//' $  fill comment

add-highlighter shared/go/code default-region group
add-highlighter shared/go/code/ regex \b[+-]?\d+(\.\d+)?\b 0:value
add-highlighter shared/go/code/ regex \b(true|false|nil|iota)\b 0:value
add-highlighter shared/go/code/ regex \b(switch|case|default|defer|continue|break|range|type|struct|package|import|const|var|func|if|else|for|return)\b 0:keyword
add-highlighter shared/go/code/ regex \b([\w._]+)\( 1:function
add-highlighter shared/go/code/ regex \b(map|error|interface|bool|int|float64|string|rune|byte)\b 0:type
add-highlighter shared/go/code/ regex \b(\[\]\w+)\b 0:type
add-highlighter shared/go/code/ regex \bvar\s+([\w.]+(,\s+[\w.]+)*) 1:variable
add-highlighter shared/go/code/ regex \b([\w.]+(,\s+[\w.]+)*)\s+(:?=\s) 1:variable
