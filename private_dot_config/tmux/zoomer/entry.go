package main

import (
	"bufio"
	"os/exec"
	"strconv"
	"strings"
)

type Entry struct {
	Active bool
	ID     string
	Width  int
	Height int
	Zoomed bool
}

func NewEntry(str string) (Entry, error) {
	var entry Entry
	fields := strings.Fields(str)

	width, err := strconv.Atoi(fields[2])
	if err != nil {
		return entry, err
	}

	height, err := strconv.Atoi(fields[3])
	if err != nil {
		return entry, err
	}

	entry.Active = fields[0] == "1"
	entry.ID = fields[1]
	entry.Width = width
	entry.Height = height

	if len(fields) == 5 {
		entry.Zoomed = fields[4] == "1"
	}

	return entry, nil
}

func GetWindows() (*Entry, []Entry, error) {
	return Get("lsw",
		"#{window_active} #{window_id} "+
			"#{window_width} #{window_height} "+
			"#{window_zoomed_flag}",
	)
}

func GetPanes() (*Entry, []Entry, error) {
	return Get("lsp",
		"#{pane_active} #{pane_id} "+
			"#{pane_width} #{pane_height}",
	)
}

func Get(q, f string) (*Entry, []Entry, error) {
	cmd := exec.Command("tmux", q, "-F", f)

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return nil, nil, err
	}

	if err := cmd.Start(); err != nil {
		return nil, nil, err
	}

	var active *Entry
	var entries []Entry

	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		entry, err := NewEntry(scanner.Text())
		if err != nil {
			return active, entries, err
		}

		if entry.Active {
			active = &entry
			continue
		}

		entries = append(entries, entry)
	}

	return active, entries, scanner.Err()
}
