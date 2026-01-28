package main

import (
	"fmt"
	"os/exec"
	"strings"
)

func main() {
	// Get branch name
	branchCmd := exec.Command("git", "branch", "--show-current")
	branchOutput, err := branchCmd.Output()
	if err != nil {
		return // Not a git repo
	}
	branch := strings.TrimSpace(string(branchOutput))
	if branch == "" {
		return
	}

	// Check status
	statusCmd := exec.Command("git", "status", "--porcelain")
	statusOutput, err := statusCmd.Output()
	if err != nil {
		return
	}

	status := strings.TrimSpace(string(statusOutput))

	// Determine color based on status
	// ANSI: 42 = green bg, 43 = yellow bg, 41 = red bg, 30 = black fg
	var bgColor string
	var statusIndicators string

	if status == "" {
		// Clean
		bgColor = "42" // green
	} else {
		lines := strings.Split(status, "\n")
		hasUntracked := false
		hasModified := false
		hasStaged := false

		for _, line := range lines {
			if len(line) < 2 {
				continue
			}
			index := line[0]
			worktree := line[1]

			if index == '?' {
				hasUntracked = true
			}
			if worktree == 'M' || worktree == 'D' {
				hasModified = true
			}
			if index == 'M' || index == 'A' || index == 'D' || index == 'R' {
				hasStaged = true
			}
		}

		if hasModified {
			bgColor = "41" // red - uncommitted changes
		} else if hasStaged {
			bgColor = "43" // yellow - staged changes
		} else if hasUntracked {
			bgColor = "43" // yellow - untracked files
		} else {
			bgColor = "42" // green
		}

		// Build status indicators
		if hasModified {
			statusIndicators += "!"
		}
		if hasStaged {
			statusIndicators += "+"
		}
		if hasUntracked {
			statusIndicators += "?"
		}
	}

	// Output with ANSI colors
	// Include leading chevron with blue fg and dynamic bg, then segment, then trailing chevron
	icon := "\uf418" // git branch icon
	chevron := "\ue0b0"
	fmt.Printf("\033[%s;34m%s\033[%s;30m %s %s %s \033[0m\033[%sm%s\033[0m", bgColor, chevron, bgColor, icon, branch, statusIndicators, strings.Replace(bgColor, "4", "3", 1), chevron)
}
