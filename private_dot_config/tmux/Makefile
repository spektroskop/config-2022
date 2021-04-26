.PHONY: build zoomer popup layout

build: zoomer popup layout

zoomer:
	cd zoomer && go build -o ~/.local/bin/tmux-zoomer -v .

popup:
	cp tmux-popup ~/.local/bin/tmux-popup

layout:
	cp tmux-save-layout ~/.local/bin/tmux-save-layout
	cp tmux-restore-layout ~/.local/bin/tmux-restore-layout
