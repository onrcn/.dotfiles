package engine

import (
	"encoding/binary"
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"

	"github.com/pierrec/lz4/v4"
)

type FirefoxEngine struct{}

// JSON structures to parse recovery.jsonlz4
type fxState struct {
	Windows []fxWindow `json:"windows"`
}

type fxWindow struct {
	Tabs     []fxTab `json:"tabs"`
	Selected int     `json:"selected"` // 1-based index
	ZOrder   int     `json:"zIndex"`
}

type fxTab struct {
	Entries []fxEntry `json:"entries"`
	Index   int       `json:"index"` // 1-based index of current history item
}

type fxEntry struct {
	Title string `json:"title"`
	URL   string `json:"url"`
}

func (e *FirefoxEngine) GetActiveTab(profilePath string) (*Tab, error) {
	// The file is usually at: <profile>/sessionstore-backups/recovery.jsonlz4
	recoveryPath := filepath.Join(profilePath, "sessionstore-backups", "recovery.jsonlz4")

	info, err := os.Stat(recoveryPath)
	if err != nil {
		return nil, fmt.Errorf("firefox session file not found: %w", err)
	}
	modTime := info.ModTime()

	// 1. Read the file
	data, err := os.ReadFile(recoveryPath)
	if err != nil {
		return nil, err
	}

	// 2. Decompress (MozLz4 Magic Header check)
	jsonBytes, err := decompressMozLz4(data)
	if err != nil {
		return nil, fmt.Errorf("decompression failed: %w", err)
	}

	// 3. Parse JSON
	var state fxState
	if err := json.Unmarshal(jsonBytes, &state); err != nil {
		return nil, fmt.Errorf("invalid json: %w", err)
	}

	if len(state.Windows) == 0 {
		return nil, fmt.Errorf("no windows found in session")
	}

	// Heuristic: Pick the first window, or ideally the one with highest zIndex (most recently used)
	// For simplicity, we just grab the first window's active tab.
	win := state.Windows[0]

	// 'selected' is 1-based
	selIdx := win.Selected - 1
	if selIdx < 0 || selIdx >= len(win.Tabs) {
		selIdx = 0
	}

	if len(win.Tabs) == 0 {
		return nil, fmt.Errorf("window has no tabs")
	}

	tab := win.Tabs[selIdx]

	// The tab has a history ('entries'). We want the current one.
	entryIdx := tab.Index - 1
	if entryIdx < 0 || entryIdx >= len(tab.Entries) {
		entryIdx = len(tab.Entries) - 1
	}

	if len(tab.Entries) == 0 {
		return nil, fmt.Errorf("tab has no history")
	}

	entry := tab.Entries[entryIdx]

	return &Tab{
		Title:   entry.Title,
		URL:     entry.URL,
		ModTime: modTime,
	}, nil
}

// decompressMozLz4 handles the proprietary Mozilla header
func decompressMozLz4(src []byte) ([]byte, error) {
	if len(src) < 12 {
		return nil, fmt.Errorf("file too short")
	}
	// Check magic bytes: "mozLz40\0"
	magic := []byte{0x6d, 0x6f, 0x7a, 0x4c, 0x7a, 0x34, 0x30, 0x00}
	for i, b := range magic {
		if src[i] != b {
			return nil, fmt.Errorf("invalid magic header")
		}
	}

	// Bytes 8-12 contain the uncompressed size (Little Endian uint32)
	uncompressedSize := binary.LittleEndian.Uint32(src[8:12])

	// The rest is the LZ4 block
	block := src[12:]

	out := make([]byte, uncompressedSize)
	n, err := lz4.UncompressBlock(block, out)
	if err != nil {
		return nil, err
	}
	if uint32(n) != uncompressedSize {
		return nil, fmt.Errorf("decompressed size mismatch")
	}

	return out, nil
}
