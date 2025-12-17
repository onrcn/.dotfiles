package engine

import (
	"fmt"
	"time"
)

// Tab represents the piece of data we want
type Tab struct {
	Title   string
	URL     string
	ModTime time.Time
}

// BrowserEngine is the interface that Firefox and Chromium implementations must satisfy
type BrowserEngine interface {
	// GetActiveTab takes the profile path and returns the most recent tab
	GetActiveTab(profilePath string) (*Tab, error)
}

// Get returns the correct engine based on the type string ("firefox" or "chromium")
func Get(browserType string) (BrowserEngine, error) {
	switch browserType {
	case "firefox":
		return &FirefoxEngine{}, nil
	case "chromium":
		return &ChromiumEngine{}, nil
	default:
		return nil, fmt.Errorf("unknown browser type: %s", browserType)
	}
}
