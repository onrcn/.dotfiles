package utils

import (
	"os"
	"path/filepath"
	"strings"
)

func ExpandPath(path string) (string, error) {
	if strings.HasPrefix(path, "~/") {
		home, err := os.UserHomeDir()
		if err != nil {
			return "", err
		}
		return filepath.Join(home, path[2:]), nil
	}
	return path, nil
}

func EnsureDir(path string) error {
	return os.MkdirAll(path, 0755)
}

func GetDefaultConfigPath() (string, error) {
	configDir, err := os.UserConfigDir() // Usually ~/.config
	if err != nil {
		return "", err
	}
	return filepath.Join(configDir, "dogear", "config.toml"), nil
}

func GetDefaultDataPath() (string, error) {
	// XDG_DATA_HOME logic or fallback
	dataHome := os.Getenv("XDG_DATA_HOME")
	if dataHome == "" {
		home, err := os.UserHomeDir()
		if err != nil {
			return "", err
		}
		dataHome = filepath.Join(home, ".local", "share")
	}
	return filepath.Join(dataHome, "dogear", "bookmarks.csv"), nil
}
