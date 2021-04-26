#!/usr/bin/env bash
cd ~/.config/tmux/zoomer && go build -o ~/.local/bin/tmux-zoomer -v .
cp -v ~/.config/tmux/tmux-popup ~/.local/bin/tmux-popup
cp -v ~/.config/tmux/tmux-save-layout ~/.local/bin/tmux-save-layout
cp -v ~/.config/tmux/tmux-restore-layout ~/.local/bin/tmux-restore-layout
