package main

import (
	"flag"
	"fmt"
	"os/exec"
	"strings"
)

var ratio = flag.Float64("ratio", 1.618, "")
var skipSuffix = flag.String("skip", "~", "")
var force = flag.Bool("force", false, "")

func buildCommand(existing []string, args ...string) []string {
	if len(existing) != 0 {
		return append(append(existing, ";"), args...)
	}
	return args
}

func main() {
	flag.Parse()

	activeWindow, _, err := GetWindows()
	if err != nil {
		panic(err)
	}

	if activeWindow.Zoomed || strings.HasSuffix(activeWindow.Name, "~") {
		return
	}

	activePane, panes, err := GetPanes()
	if err != nil {
		panic(err)
	}

	width := int(float64(activeWindow.Width) / *ratio)
	height := int(float64(activeWindow.Height) / *ratio)

	resizeCommand := buildCommand(nil,
		"resize-pane",
		"-t", activePane.ID,
		"-x", fmt.Sprint(width),
		"-y", fmt.Sprint(height),
	)

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
			resizeCommand = buildCommand(resizeCommand, "resize-pane",
				"-t", p.ID, "-x", x,
			)
		}
	}

	if len(col) > 1 {
		y := fmt.Sprint((activeWindow.Height - height) / len(col))
		for _, p := range col {
			resizeCommand = buildCommand(resizeCommand, "resize-pane",
				"-t", p.ID, "-y", y,
			)
		}
	}

	cmd := exec.Command("tmux", resizeCommand...)
	if err := cmd.Run(); err != nil {
		panic(err)
	}
}
