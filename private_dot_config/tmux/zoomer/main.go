package main

import (
	"flag"
	"fmt"
	"os/exec"
)

var ratio = flag.Float64("ratio", 1.618, "")

func Foo(a, b int) (_ int, err error) {
	return 0, nil
}

func Bar(a, b int) (
	int,
	error,
) {
	return 0, nil
}

func main() {
	flag.Parse()

	activeWindow, _, err := GetWindows()
	if err != nil {
		panic(err)
	}

	if activeWindow.Zoomed {
		return
	}

	activePane, panes, err := GetPanes()
	if err != nil {
		panic(err)
	}

	width := int(float64(activeWindow.Width) / *ratio)
	height := int(float64(activeWindow.Height) / *ratio)
	cmds := []string{"resize-pane", "-t", activePane.ID,
		"-x", fmt.Sprint(width), "-y", fmt.Sprint(height)}

	var row, col []Entry
	for _, p := range panes {
		if p.Width == activePane.Width {
			col = append(col, p)
		}

		if p.Height == activePane.Height {
			row = append(row, p)
		}
	}

	if len(row) > 1 {
		x := fmt.Sprint((activeWindow.Width - width) / len(row))
		for _, p := range row {
			cmds = append(cmds, ";", "resize-pane", "-t", p.ID, "-x", x)
		}
	}

	if len(col) > 1 {
		y := fmt.Sprint((activeWindow.Height - height) / len(col))
		for _, p := range col {
			cmds = append(cmds, ";", "resize-pane", "-t", p.ID, "-y", y)
		}
	}

	cmd := exec.Command("tmux", cmds...)
	if err := cmd.Run(); err != nil {
		panic(err)
	}
}
