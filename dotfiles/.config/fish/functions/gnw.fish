# Create a new branch in a worktree with the gnw script, then cd into it.
# In a VS Code terminal the script opens a new window instead, so stay put.
#
# This has to be a function, not a script, because a script can't
# change the directory of the shell that runs it.
function gnw --description "New branch in a new worktree, then cd there"
    set -l out (command gnw $argv)
    or return

    if test (count $out) -eq 1; and test -d "$out[1]"; and test "$TERM_PROGRAM" != vscode
        cd $out[1]
    else if test (count $out) -gt 0
        printf '%s\n' $out
    end
end
