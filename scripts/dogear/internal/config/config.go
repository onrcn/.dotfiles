package config

import (
	"fmt"
	"os"
	"path/filepath"

	"dogear/internal/utils"

	"github.com/BurntSushi/toml"
)

type Browser struct {
	Name string `toml:"name"`
	Type string `toml:"type"`
	Path string `toml:"path"`
}

type Config struct {
	CSVPath     string    `toml:"csv_path"`
	Editor      string    `toml:"editor"`
	UseTerminal bool      `toml:"use_terminal"` // New explicit setting
	Browsers    []Browser `toml:"browsers"`
}

func Load() (*Config, error) {
	configPath, err := utils.GetDefaultConfigPath()
	if err != nil {
		return nil, fmt.Errorf("could not determine config path: %w", err)
	}

	// 1. Create default if missing
	if _, err := os.Stat(configPath); os.IsNotExist(err) {
		if err := createDefaultConfig(configPath); err != nil {
			return nil, fmt.Errorf("failed to create default config: %w", err)
		}
		fmt.Printf("Created default config at: %s\n", configPath)
	}

	// 2. Read
	var cfg Config
	if _, err := toml.DecodeFile(configPath, &cfg); err != nil {
		return nil, fmt.Errorf("invalid config file: %w", err)
	}

	// Defaults for existing configs
	if cfg.Editor == "" {
		cfg.Editor = "vim"
		cfg.UseTerminal = true // Default to true for safety
	}

	// 3. Expand paths
	if cfg.CSVPath, err = utils.ExpandPath(cfg.CSVPath); err != nil {
		return nil, err
	}
	for i := range cfg.Browsers {
		if cfg.Browsers[i].Path, err = utils.ExpandPath(cfg.Browsers[i].Path); err != nil {
			return nil, err
		}
	}

	return &cfg, nil
}

func createDefaultConfig(path string) error {
	if err := utils.EnsureDir(filepath.Dir(path)); err != nil {
		return err
	}
	defaultCSV, _ := utils.GetDefaultDataPath()

	defaultContent := fmt.Sprintf(`# Dogear Configuration

csv_path = "%s"

# Editor Settings
editor = "nvim"
use_terminal = true  # Set to false if using VSCode, Sublime, etc.

# Browser Profiles
# [[browsers]]
# name = "zen"
# type = "firefox"
# path = "~/.zen/default-release"
`, defaultCSV)

	return os.WriteFile(path, []byte(defaultContent), 0644)
}
