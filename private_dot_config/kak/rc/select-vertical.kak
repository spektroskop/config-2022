plug "occivink/kakoune-vertical-selection" config %{
    map global user v     ':vertical-selection-down<ret>'        -docstring 'Select down'
    map global user <a-v> ':vertical-selection-up<ret>'          -docstring 'Select up'
    map global user V     ':vertical-selection-up-and-down<ret>' -docstring 'Select up and down'
}
