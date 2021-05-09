add-highlighter shared/elm regions

add-highlighter shared/elm/string region '"' (?<!\\)(\\\\)*" group
add-highlighter shared/elm/string/ fill string

add-highlighter shared/elm/multiline_string region '"""' '"""' group
add-highlighter shared/elm/multiline_string/ fill string

add-highlighter shared/elm/block_comment region -recurse \{- \{- -\} fill comment
add-highlighter shared/elm/line_comment  region '--' $  fill comment

add-highlighter shared/elm/code default-region group

add-highlighter shared/elm/type_definition region ^\h*\w+\h+: $ group
add-highlighter shared/elm/type_definition/ regex [a-z]\w* 0:variable
add-highlighter shared/elm/type_definition/ regex [A-Z]\w* 0:type
add-highlighter shared/elm/type_definition/ regex ^\w+\b 0:meta

# add-highlighter shared/elm/code/type1 regex (\w+)\h+: 1:function
# add-highlighter shared/elm/code/type2 regex \b[A-Z]\w*\b 0:type
add-highlighter shared/elm/code/function regex "^(\w+)\h+" 1:function
add-highlighter shared/elm/code/module_lookup regex \b([A-Z]\w*)\. 1:module
add-highlighter shared/elm/code/number regex "-?\b[0-9]*\.?[0-9]+" 0:value

### let .. in
###   a : Foo bar -> baz -> Buz
###   a foo bar = 
# add-highlighter shared/elm/let_in region -recurse \blet\b \blet\b \bin\b group
# add-highlighter shared/elm/let_in/function regex "^\h+(\w+)" 1:function
# add-highlighter shared/elm/let_in/ ref elm/code/module_lookup
# add-highlighter shared/elm/let_in/ ref elm/code/string
# add-highlighter shared/elm/let_in/ ref elm/code/keywords

## TODO: shared/elm_common/ ? ref hit fra regions

# foo : Bar baz -> Hey -> ja
# foo bar baz =
# foo bar (a, b) {c, d} =
# ( a, b ) { a, b }
# { x | a = b, c = d }
# { a = b, c = d }
# { x : A, y: B }

add-highlighter shared/elm/module  region ^(import|module) $ group
add-highlighter shared/elm/module/ ref elm/code/keywords

add-highlighter shared/elm/record_update region -recurse \{\h*\w+ \{\h*\w+ \} group
add-highlighter shared/elm/record_update/after_pipe  regex \|\h*(\w+) 1:variable
add-highlighter shared/elm/record_update/after_comma regex ,\h*(\w+) 1:variable
add-highlighter shared/elm/record_update/after_brace regex \{\h*(\w+) 1:variable
add-highlighter shared/elm/record_update/ ref elm/code/module_lookup

# add-highlighter shared/elm/code/struct_assignment regex [{|,]\h*(\w+)\h*= 1:variable
# add-highlighter shared/elm/code/var1 regex ^\h*(\w*)\h*= 1:variable
# add-highlighter shared/elm/code/type_variant regex ^\h*[=|]\h*([A-Z]\w*)\b 1:type
# add-highlighter shared/elm/code/function_definition regex ^([a-z]\w*)\b 1:function
# add-highlighter shared/elm/code/operator regex '\.' 0:operator

###

# add-highlighter shared/function_definition regex ^([a-z]\w*)\b 1:function
# add-highlighter shared/elm/code/operator regex '\.' 0:operator

###

# add-highlighter shared/elm/code/var regex \h(\{|\||,)\h*([a-z]\w*)\b 2:variable  
# add-highlighter shared/elm/code/type2 regex \b[A-Z]\w*\b  0:type
# add-highlighter shared/elm/code/sig1 regex ^(\w+)\h*:(.*?$) 1:function 2:type
# add-highlighter shared/elm/code/func2 regex \.(\w+)\b 1:function
# add-highlighter shared/elm/code/var regex \b[A-Z]\w*\b 0:value
# add-highlighter shared/elm/code/var regex \(([^)]+)\)\s= 1:variable
# add-highlighter shared/elm/code/type regex \b[A-Z]\w*\b 0:type

# add-highlighter shared/elm/code/sig1 regex ^(\w+)\h*:(.*?$) 1:function 2:type
# add-highlighter shared/elm/code/func2 regex \.(\w+)\b 1:function
# add-highlighter shared/elm/code/var regex \b[A-Z]\w*\b 0:value
# add-highlighter shared/elm/code/var regex \(([^)]+)\)\s= 1:variable
# add-highlighter shared/elm/code/type regex \b[A-Z]\w*\b 0:type
# add-highlighter shared/elm/code/f regex \b([a-z]\w*)\. 1:variable
# add-highlighter shared/elm/code/property regex \.([^.\s]+)\b 1:meta
# add-highlighter shared/elm/code/func regex ^[a-z]\w*\b 0:function

evaluate-commands %sh{
    join() { eval set -- $1; local IFS="|"; echo "$*"; }

    keywords="port module import as exposing let in type if then else case of alias"
    types=""
    values=""

    printf %s "
        add-highlighter shared/elm/code/values regex \b($(join "$values"))\b 0:value
        add-highlighter shared/elm/code/keywords regex \b($(join "$keywords"))\b 0:keyword
        add-highlighter shared/elm/code/types regex \b($(join "$types"))\b 0:type
    "
}
