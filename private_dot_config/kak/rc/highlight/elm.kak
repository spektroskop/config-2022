# foo : Bar baz -> Hey -> ja
# foo bar baz =
# foo bar (a, b) {c, d} =
# ( a, b ) { a, b }
# { x | a = b, c = d }
# { a = b, c = d }
# { x : A, y: B }
# type alias Request route params =
# type Request route params =
# import Foo exposing (foo, Bar)
# import Foo.Bar
# module Foo exposing (bar, Baz)
# module Foo.Bar

add-highlighter shared/elm regions
add-highlighter shared/elm/code default-region group

add-highlighter shared/elm/string region '"' (?<!\\)(\\\\)*" group
add-highlighter shared/elm/string/ fill string

add-highlighter shared/elm/multiline_string region '"""' '"""' group
add-highlighter shared/elm/multiline_string/ fill string

add-highlighter shared/elm/block_comment region -recurse \{- \{- -\} fill comment

add-highlighter shared/elm/line_comment  region '--' $  fill comment

add-highlighter shared/elm/type_definition region '^type' '=' group
add-highlighter shared/elm/type_definition/ regex [a-z]\w* 0:variable
add-highlighter shared/elm/type_definition/ regex [A-Z]\w* 0:type
add-highlighter shared/elm/type_definition/ ref elm/code/keywords

add-highlighter shared/elm/type_signature region ^\h*\w+\h+: $ group
add-highlighter shared/elm/type_signature/ regex [a-z]\w* 0:variable
add-highlighter shared/elm/type_signature/ regex [A-Z]\w* 0:type
add-highlighter shared/elm/type_signature/ regex ^\w+\b 0:meta
add-highlighter shared/elm/type_signature/ ref elm/code/operator

add-highlighter shared/elm/code/function regex "^(\w+)\h+" 1:function
add-highlighter shared/elm/code/module_lookup regex \b([A-Z]\w*)\. 1:module
add-highlighter shared/elm/code/number regex "-?\b[0-9]*\.?[0-9]+" 0:value
add-highlighter shared/elm/code/operator regex '(\.|->?|=|\+|//?|\*|>>|<<|\|>|<\||:)' 0:operator
add-highlighter shared/elm/code/keywords regex '\b(port|module|import|as|exposing|let|in|type|if|then|else|case|of|alias)\b' 1:keyword

add-highlighter shared/elm/let_in region -recurse \blet\b \blet\b \bin\b regions
add-highlighter shared/elm/let_in/type_signature region ^\h*\w+\h+: $ group
add-highlighter shared/elm/let_in/type_signature/ regex [a-z]\w* 0:function
add-highlighter shared/elm/let_in/type_signature/ regex [A-Z]\w* 0:type
add-highlighter shared/elm/let_in/type_signature/ regex ^\w+\b 0:meta
add-highlighter shared/elm/let_in/type_signature/ ref elm/code/operator
add-highlighter shared/elm/let_in/default default-region group
add-highlighter shared/elm/let_in/default/ regex (\w+)[^\n]*= 1:function
add-highlighter shared/elm/let_in/default/ ref elm/code/keywords
add-highlighter shared/elm/let_in/default/ ref elm/code/module_lookup
add-highlighter shared/elm/let_in/default/ ref elm/code/number
add-highlighter shared/elm/let_in/default/ ref elm/code/operator
add-highlighter shared/elm/let_in/string region '"' (?<!\\)(\\\\)*" group
add-highlighter shared/elm/let_in/string/ fill string

add-highlighter shared/elm/record_update region -recurse \{\h*\w+ \{\h*\w+ \} group
add-highlighter shared/elm/record_update/after_pipe  regex \|\h*(\w+) 1:variable
add-highlighter shared/elm/record_update/after_comma regex ,\h*(\w+) 1:variable
add-highlighter shared/elm/record_update/after_brace regex \{\h*(\w+) 1:variable
add-highlighter shared/elm/record_update/ ref elm/code/module_lookup
add-highlighter shared/elm/record_update/ ref elm/code/operator

add-highlighter shared/elm/exposing region '\bexposing\b' '\)' group
add-highlighter shared/elm/exposing/ regex '\b[A-Z]\w*\b' 0:type
add-highlighter shared/elm/exposing/ regex '\b[a-z]\w*\b' 0:variable
add-highlighter shared/elm/exposing/ ref elm/code/keywords

add-highlighter shared/elm/code/ regex '^(import|module)\h+([\w.]+)' 2:meta
