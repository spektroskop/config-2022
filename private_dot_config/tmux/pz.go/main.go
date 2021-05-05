package main

import (
	"flag"
	"fmt"
	"strings"
)

var ratio = flag.Float64("ratio", 1.618, "")
var skipSuffix = flag.String("skip", "~", "")
var force = flag.Bool("force", false, "")

func buildCommand(existing []string, format string, args ...interface{}) []string {
	cmd := fmt.Sprintf(format, args)
	if len(existing) != 0 {
		return append(append(existing, ";"), cmd)
	}
	return append(existing, cmd)
}

func shouldIgnore(entry *Entry) bool {
	return entry.Zoomed || strings.HasSuffix(entry.Name, "~")
}

func main() {
	flag.Parse()

	activeWindow, err := GetActiveWindow()
	if err != nil {
		panic(err)
	}

	if !*force && shouldIgnore(activeWindow) {
		fmt.Println("asdf")
		return
	}

	activePane, panes, err := GetPanes()
	if err != nil {
		panic(err)
	}

	width := int(float64(activeWindow.Width) / *ratio)
	height := int(float64(activeWindow.Height) / *ratio)

	var resizeCommand []string

	resizeCommand = append(resizeCommand, fmt.Sprintf(
		"resize-pane -t %s -x %d -y %d",
		activePane.ID, width, height,
	))

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
		x := (activeWindow.Width - width) / len(row)
		for _, p := range row {
			resizeCommand = append(resizeCommand, fmt.Sprintf(
				"resize-pane -t %s -x %d",
				p.ID, x,
			))
		}
	}

	if len(col) > 1 {
		y := (activeWindow.Height - height) / len(col)
		for _, p := range col {
			resizeCommand = append(resizeCommand, fmt.Sprintf(
				"resize-pane -t %s -y %d",
				p.ID, y,
			))
		}
	}

	fmt.Println(strings.Join(resizeCommand, " ; "))
}
