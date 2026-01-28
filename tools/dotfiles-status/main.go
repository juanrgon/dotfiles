package main

import (
	"crypto/md5"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
	"time"
)

const cacheDuration = 60 * time.Second
const cleanMarker = "__CLEAN__"

func main() {
	home, err := os.UserHomeDir()
	if err != nil {
		return
	}

	// Check common dotfiles locations
	dotfilesPath := findDotfiles(home)
	if dotfilesPath == "" {
		return
	}

	// Check cache first
	cacheFile := getCacheFile(home, dotfilesPath)
	if cached, ok := readCache(cacheFile); ok {
		if cached != cleanMarker {
			fmt.Print(cached)
		}
		return
	}

	status := checkStatus(dotfilesPath)
	if status == "" {
		writeCache(cacheFile, cleanMarker)
	} else {
		writeCache(cacheFile, status)
		fmt.Print(status)
	}
}

func getCacheFile(home, repoPath string) string {
	// Create unique cache file based on repo path
	hash := fmt.Sprintf("%x", md5.Sum([]byte(repoPath)))[:8]
	cacheDir := filepath.Join(home, ".cache", "dotfiles-status")
	os.MkdirAll(cacheDir, 0755)
	return filepath.Join(cacheDir, hash)
}

func readCache(cacheFile string) (string, bool) {
	info, err := os.Stat(cacheFile)
	if err != nil {
		return "", false
	}

	// Check if cache is still valid
	if time.Since(info.ModTime()) > cacheDuration {
		return "", false
	}

	data, err := os.ReadFile(cacheFile)
	if err != nil {
		return "", false
	}

	return string(data), true
}

func writeCache(cacheFile, status string) {
	os.WriteFile(cacheFile, []byte(status), 0644)
}

func findDotfiles(home string) string {
	paths := []string{
		filepath.Join(home, "github.com", os.Getenv("GITHUB_HANDLE"), "dotfiles"),
		filepath.Join(home, "github.com", "juanrgon", "dotfiles"),
		filepath.Join(home, "dotfiles"),
		filepath.Join(home, ".dotfiles"),
	}

	for _, p := range paths {
		if isGitRepo(p) {
			return p
		}
	}
	return ""
}

func isGitRepo(path string) bool {
	gitDir := filepath.Join(path, ".git")
	info, err := os.Stat(gitDir)
	return err == nil && info.IsDir()
}

func checkStatus(repoPath string) string {
	var indicators []string

	// Check for uncommitted changes (dirty) - this is fast
	if isDirty(repoPath) {
		indicators = append(indicators, "!")
	}

	// Check for unpushed commits - can be slower
	ahead, behind := getAheadBehind(repoPath)
	if ahead > 0 {
		indicators = append(indicators, fmt.Sprintf("⇡%d", ahead))
	}
	if behind > 0 {
		indicators = append(indicators, fmt.Sprintf("⇣%d", behind))
	}

	if len(indicators) == 0 {
		return ""
	}

	return "dotfiles[" + strings.Join(indicators, "") + "]"
}

func isDirty(repoPath string) bool {
	cmd := exec.Command("git", "-C", repoPath, "status", "--porcelain")
	output, err := cmd.Output()
	if err != nil {
		return false
	}
	return len(strings.TrimSpace(string(output))) > 0
}

func getAheadBehind(repoPath string) (ahead, behind int) {
	// Get current branch
	branchCmd := exec.Command("git", "-C", repoPath, "rev-parse", "--abbrev-ref", "HEAD")
	branchOutput, err := branchCmd.Output()
	if err != nil {
		return 0, 0
	}
	branch := strings.TrimSpace(string(branchOutput))

	// Get ahead/behind counts
	cmd := exec.Command("git", "-C", repoPath, "rev-list", "--left-right", "--count", fmt.Sprintf("origin/%s...HEAD", branch))
	output, err := cmd.Output()
	if err != nil {
		return 0, 0
	}

	parts := strings.Fields(string(output))
	if len(parts) == 2 {
		fmt.Sscanf(parts[0], "%d", &behind)
		fmt.Sscanf(parts[1], "%d", &ahead)
	}

	return ahead, behind
}
