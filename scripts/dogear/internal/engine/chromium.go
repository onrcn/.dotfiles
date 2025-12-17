package engine

import (
	"database/sql"
	"fmt"
	"io"
	"os"
	"path/filepath"

	_ "modernc.org/sqlite" // Pure Go SQLite driver
)

type ChromiumEngine struct{}

func (e *ChromiumEngine) GetActiveTab(profilePath string) (*Tab, error) {
	historyPath := filepath.Join(profilePath, "History")

	info, err := os.Stat(historyPath)
	if err != nil {
		return nil, fmt.Errorf("chromium history not found: %w", err)
	}
	modTime := info.ModTime()

	// 1. Copy DB to temp file (to avoid "database is locked" errors)
	tmpFile, err := os.CreateTemp("", "dogear-chrome-db-*.sqlite")
	if err != nil {
		return nil, fmt.Errorf("failed to create temp file: %w", err)
	}
	tmpName := tmpFile.Name()
	defer os.Remove(tmpName) // Cleanup on exit

	// Perform copy
	src, err := os.Open(historyPath)
	if err != nil {
		tmpFile.Close()
		return nil, err
	}
	_, err = io.Copy(tmpFile, src)
	src.Close()
	tmpFile.Close()
	if err != nil {
		return nil, fmt.Errorf("failed to copy history db: %w", err)
	}

	// 2. Open SQLite DB
	db, err := sql.Open("sqlite", tmpName)
	if err != nil {
		return nil, fmt.Errorf("failed to open sqlite: %w", err)
	}
	defer db.Close()

	// 3. Query
	// We want the last visited URL.
	// Chromium times are microseconds (1e-6) since Windows epoch (1601-01-01).
	// We just sort by visit_time DESC.
	query := `
		SELECT urls.title, urls.url
		FROM urls
		JOIN visits ON visits.url = urls.id
		ORDER BY visits.visit_time DESC
		LIMIT 1;
	`

	var title, url string
	err = db.QueryRow(query).Scan(&title, &url)
	if err != nil {
		return nil, fmt.Errorf("query failed (history might be empty): %w", err)
	}

	if title == "" {
		title = url // Fallback
	}

	return &Tab{
		Title:   title,
		URL:     url,
		ModTime: modTime,
	}, nil
}
