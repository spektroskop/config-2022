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

// active id name|- width height zoomed|-
func NewEntry(str string) (Entry, error) {
	var entry Entry
	fields := strings.Fields(str)
	if len(fields) < 6 {
		return entry, errors.New("bad format")
	}

	width, err := strconv.Atoi(fields[3])
	if err != nil {
		return entry, err
	}

	height, err := strconv.Atoi(fields[4])
	if err != nil {
		return entry, err
	}

	entry.Active = fields[0] == "1"
	entry.ID = fields[1]
	entry.Name = fields[2]
	entry.Width = width
	entry.Height = height
	entry.Zoomed = fields[5] == "1"

	return entry, nil
}

func GetWindows() (*Entry, []Entry, error) {
	return Get("lsw",
		"#{window_active}",
		"#{window_id}", "#{window_name}",
		"#{window_width}", "#{window_height}",
		"#{window_zoomed_flag}",
	)
}

func GetActiveWindow() (*Entry, error) {
	return GetActive("lsw",
		"#{window_active}",
		"#{window_id}", "#{window_name}",
		"#{window_width}", "#{window_height}",
		"#{window_zoomed_flag}",
	)
}

func GetPanes() (*Entry, []Entry, error) {
	return Get("lsp",
		"#{pane_active}",
		"#{pane_id}", "-",
		"#{pane_width}", "#{pane_height}",
		"-",
	)
}

func GetActive(q string, f ...string) (*Entry, error) {
	cmd := exec.Command("tmux", q, "-F", strings.Join(f, " "))

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return nil, err
	}

	if err := cmd.Start(); err != nil {
		return nil, err
	}
	scanner := bufio.NewScanner(stdout)
	for scanner.Scan() {
		entry, err := NewEntry(scanner.Text())
		if err != nil {
			return nil, err
		}

		if entry.Active {
			return &entry, nil
		}
	}

	return nil, errors.New("no active window")
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
