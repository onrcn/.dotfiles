package store

import (
	"encoding/csv"
	"fmt"
	"os"
	"strings"
	"syscall"
)

// Append adds a new bookmark if it doesn't already exist.
// Returns true if added, false if duplicate.
func Append(csvPath, title, url string) (bool, error) {
	// 1. Open the file (Create if missing, Read/Write mode)
	f, err := os.OpenFile(csvPath, os.O_RDWR|os.O_CREATE, 0644)
	if err != nil {
		return false, fmt.Errorf("failed to open csv: %w", err)
	}
	defer f.Close()

	// 2. Exclusive Lock (Thread-safety for Syncthing/Multiple runs)
	if err := syscall.Flock(int(f.Fd()), syscall.LOCK_EX); err != nil {
		return false, fmt.Errorf("failed to lock csv: %w", err)
	}
	defer syscall.Flock(int(f.Fd()), syscall.LOCK_UN)

	// 3. Read existing to check for duplicates
	// The standard reader handles quoted fields ("Title","URL") automatically,
	// so this works regardless of how the file was previously saved.
	reader := csv.NewReader(f)
	records, err := reader.ReadAll()
	if err != nil {
		// Ignore empty file errors, but proceed with caution on corrupt files.
		if info, _ := f.Stat(); info.Size() > 0 {
			// It might be header-only or corrupt
		}
	}

	// Simple De-duplication
	for _, row := range records {
		if len(row) >= 2 {
			if row[1] == url {
				return false, nil // Already exists
			}
		}
	}

	// 4. Append
	// We need to seek to the end because the reader moved the cursor
	if _, err := f.Seek(0, 2); err != nil {
		return false, err
	}

	// MANUAL WRITE: Force double quotes around every field.
	// Standard csv.Writer doesn't support "AlwaysQuote", so we do it ourselves.

	// Escape internal quotes: " becomes "" according to CSV rules
	safeTitle := strings.ReplaceAll(title, "\"", "\"\"")
	safeUrl := strings.ReplaceAll(url, "\"", "\"\"")

	// Format: "Title","URL"\n
	line := fmt.Sprintf("\"%s\",\"%s\"\n", safeTitle, safeUrl)

	if _, err := f.WriteString(line); err != nil {
		return false, err
	}

	return true, nil
}

// List returns all bookmarks as formatted strings "Title - URL"
func List(csvPath string) ([]string, error) {
	f, err := os.Open(csvPath)
	if err != nil {
		// If file doesn't exist, just return empty list
		if os.IsNotExist(err) {
			return []string{}, nil
		}
		return nil, err
	}
	defer f.Close()

	reader := csv.NewReader(f)
	records, err := reader.ReadAll()
	if err != nil {
		return nil, err
	}

	var output []string
	for _, row := range records {
		if len(row) >= 2 {
			// Format: "Title - URL"
			output = append(output, fmt.Sprintf("%s - %s", row[0], row[1]))
		}
	}
	return output, nil
}
