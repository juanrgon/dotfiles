function j
    # Get the first argument
    set -l arg (echo $argv[1])

    set -l GITHUB_REPOS_DIR ~/github.com

    # if there is a single repo that matches the argument, cd into it
    if test (fd --type d --max-depth 2 --min-depth 2 --base-directory $GITHUB_REPOS_DIR | grep -c $arg) -eq 1
        cd $GITHUB_REPOS_DIR/(fd --type d --max-depth 2 --min-depth 2 --base-directory $GITHUB_REPOS_DIR | grep $arg)
        return
    end

    # use $arg as the initial fzf query
   cd ~/github.com/(fd --type d --max-depth 2 --min-depth 2 --base-directory ~/github.com | fzf --height 40% --reverse --prompt "cd into repo > " --query $arg)
end
