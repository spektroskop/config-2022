add-highlighter shared/elm regions

add-highlighter shared/elm/string region '"' (?<!\\)(\\\\)*" group
add-highlighter shared/elm/string/ fill string

add-highlighter shared/elm/multiline_string region '"""' '"""' group
add-highlighter shared/elm/multiline_string/ fill string

add-highlighter shared/elm/block_comment region -recurse \{- \{- -\} fill comment
add-highlighter shared/elm/line_comment  region '--' $  fill comment

add-highlighter shared/elm/code default-region group

evaluate-commands %sh{
    join() { eval set -- $1; local IFS="|"; echo "$*"; }

    keywords=""
    types=""
    values=""

    printf %s "
        add-highlighter shared/elm/code/values regex \b($(join "$values"))\b 0:value
        add-highlighter shared/elm/code/keywords regex \b($(join "$keywords"))\b 0:keyword
        add-highlighter shared/elm/code/types regex \b($(join "$types"))\b 0:type
    "
}
