package detector

import (
	"fmt"
	"time"

	"dogear/internal/config"
	"dogear/internal/engine"
)

// PickWinner iterates all configured browsers and returns the tab
// from the one that was modified most recently.
func PickWinner(cfg *config.Config) (*engine.Tab, string, error) {
	var bestTab *engine.Tab
	var bestBrowserName string

	// Threshold: If a browser hasn't been touched in 24 hours, ignore it?
	// For now, we'll just take the absolute latest.

	for _, b := range cfg.Browsers {
		eng, err := engine.Get(b.Type)
		if err != nil {
			continue // Skip unknown types
		}

		tab, err := eng.GetActiveTab(b.Path)
		if err != nil {
			// Browser might be closed or profile path invalid.
			// Log it if you want debug mode, otherwise silent skip.
			continue
		}

		// Compare timestamps
		if bestTab == nil || tab.ModTime.After(bestTab.ModTime) {
			bestTab = tab
			bestBrowserName = b.Name
		}
	}

	if bestTab == nil {
		return nil, "", fmt.Errorf("no active browsers found (check if they are open or paths are correct)")
	}

	// "Stale Data" Check
	// If the winner hasn't been updated in a long time (e.g. 10 minutes),
	// it might mean the user just walked away or is looking at a static page.
	// We proceed anyway, but we could add a warning here.
	if time.Since(bestTab.ModTime) > 10*time.Minute {
		// Just a debug note, we still return it.
	}

	return bestTab, bestBrowserName, nil
}
