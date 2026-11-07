# git checkout, with two extras:
#
#   gco <pr-url>   check out a pull request with gh
#   gco <branch>   if another worktree already has <branch>, cd there
#                  instead of failing with "already used by worktree"
#
# This has to be a function, not a script, because a script can't
# change the directory of the shell that runs it.
function gco --wraps 'git checkout' --description "git checkout, or cd to the branch's worktree"
    if string match -qr '^https?://' -- $argv[1]
        gh pr checkout $argv
        return
    end

    if test (count $argv) -eq 1; and not string match -q -- '-*' $argv[1]
        set -l path
        for line in (git worktree list --porcelain 2>/dev/null)
            switch $line
                case 'worktree *'
                    set path (string sub --start 10 -- $line)
                case "branch refs/heads/$argv[1]"
                    if test -d "$path"; and test "$path" != (git rev-parse --show-toplevel)
                        cd $path
                        return
                    end
            end
        end
    end

    git checkout $argv
end
