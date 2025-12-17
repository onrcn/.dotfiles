package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"os/exec"
	"strings"

	"dogear/internal/config"
	"dogear/internal/detector"
	"dogear/internal/store"
)

func main() {
	cfg, err := config.Load()
	if err != nil {
		log.Fatalf("Config error: %v", err)
	}

	if len(os.Args) < 2 {
		printUsage()
		os.Exit(1)
	}

	command := os.Args[1]

	switch command {
	case "grab":
		cmdGrab(cfg)
	case "list":
		cmdList(cfg)
	case "open":
		cmdOpen()
	case "edit":
		cmdEdit(cfg)
	case "path":
		fmt.Println(cfg.CSVPath)
	default:
		printUsage()
		os.Exit(1)
	}
}

func printUsage() {
	fmt.Println("Usage: dogear <command>")
	fmt.Println("Commands:")
	fmt.Println("  grab   Detect active browser tab and save to CSV")
	fmt.Println("  list   Print 'Title - URL' list (for dmenu/wofi)")
	fmt.Println("  open   Open URL passed via stdin")
	fmt.Println("  edit   Open bookmarks CSV in default editor")
	fmt.Println("  path   Print path to bookmarks.csv")
}

func cmdGrab(cfg *config.Config) {
	tab, browser, err := detector.PickWinner(cfg)
	if err != nil {
		// Use notify-send for errors since this runs in background
		exec.Command("notify-send", "Dogear Error", err.Error()).Run()
		log.Fatalf("Error: %v", err)
	}

	added, err := store.Append(cfg.CSVPath, tab.Title, tab.URL)
	if err != nil {
		exec.Command("notify-send", "Dogear Error", fmt.Sprintf("Failed to save: %v", err)).Run()
		log.Fatalf("Failed to save: %v", err)
	}

	if added {
		fmt.Printf("Saved: [%s] %s (from %s)\n", tab.Title, tab.URL, browser)
		exec.Command("notify-send", "Dogear", fmt.Sprintf("Saved: %s", tab.Title)).Run()
	} else {
		fmt.Println("Bookmark already exists.")
		exec.Command("notify-send", "Dogear", "Bookmark already exists").Run()
	}
}

func cmdList(cfg *config.Config) {
	items, err := store.List(cfg.CSVPath)
	if err != nil {
		log.Fatalf("Failed to list: %v", err)
	}
	for _, item := range items {
		fmt.Println(item)
	}
}

func cmdOpen() {
	scanner := bufio.NewScanner(os.Stdin)
	if scanner.Scan() {
		line := scanner.Text()
		parts := strings.Split(line, " - ")
		if len(parts) < 2 {
			openBrowser(line)
			return
		}
		url := parts[len(parts)-1]
		openBrowser(url)
	}
}

func cmdEdit(cfg *config.Config) {
	editor := cfg.Editor

	var cmd *exec.Cmd

	if cfg.UseTerminal {
		// Detect terminal emulator
		terminals := []string{"kitty", "alacritty", "wezterm", "gnome-terminal", "foot", "xterm"}
		var term string
		for _, t := range terminals {
			if _, err := exec.LookPath(t); err == nil {
				term = t
				break
			}
		}

		if term == "" {
			log.Fatal("Error: use_terminal = true, but no supported terminal emulator found in PATH.")
		}

		// Launch: kitty -e nvim /path/to/csv
		cmd = exec.Command(term, "-e", editor, cfg.CSVPath)
	} else {
		// Launch directly: code /path/to/csv
		cmd = exec.Command(editor, cfg.CSVPath)
	}

	// Connect IO so you can interact with it
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Start(); err != nil {
		exec.Command("notify-send", "Dogear Error", fmt.Sprintf("Failed to launch %s: %v", editor, err)).Run()
		log.Fatalf("Failed to launch editor: %v", err)
	}
}

func openBrowser(url string) {
	url = strings.TrimSpace(url)
	if url == "" {
		return
	}
	cmd := exec.Command("xdg-open", url)
	if err := cmd.Start(); err != nil {
		log.Printf("Failed to open browser: %v", err)
	}
}
