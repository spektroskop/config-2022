package main

import (
	"bufio"
	"errors"
	"os/exec"
	"strconv"
	"strings"
)

type Entry struct {
	ID     string
	Name   string
	Active bool
	Zoomed bool
	Width  int
	Height int
}

func NewEntry(str string) (Entry, error) {
	var entry Entry
	fields := strings.Fields(str)
	if len(fields) < 6 {
		return entry, errors.New("bad format")
	}

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
	entry.Zoomed = fields[4] == "1"
	entry.Name = fields[5]

	return entry, nil
}

func GetWindows() (*Entry, []Entry, error) {
	return Get("lsw",
		"#{window_active}",
		"#{window_id}",
		"#{window_width}",
		"#{window_height}",
		"#{window_zoomed_flag}",
		"#{window_name}",
	)
}

func GetPanes() (*Entry, []Entry, error) {
	return Get("lsp",
		"#{pane_active}",
		"#{pane_id}",
		"#{pane_width}",
		"#{pane_height}",
		"-",
		"-",
	)
}

func Get(q string, f ...string) (*Entry, []Entry, error) {
	cmd := exec.Command("tmux", q, "-F", strings.Join(f, " "))

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
