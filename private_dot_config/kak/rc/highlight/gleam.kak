add-highlighter shared/gleam regions

add-highlighter shared/gleam/string region '"' (?<!\\)(\\\\)*" group
add-highlighter shared/gleam/string/ fill string

add-highlighter shared/gleam/code default-region group
