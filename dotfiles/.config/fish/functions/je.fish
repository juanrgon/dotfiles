# Jump to a repo and open it in the editor
function je
    j $argv

    # if EDITOR includes "--wait" (e.g. for VSCode or Cursor's `code` and `cursor` commands), remove it,
    # otherwise the current editor window will be replaced, instead of a new one being opened.
    set EDITOR_WITHOUT_WAIT (echo $EDITOR | sed 's/--wait//g')
    eval $EDITOR_WITHOUT_WAIT .
end
