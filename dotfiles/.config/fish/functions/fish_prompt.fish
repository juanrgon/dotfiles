
function fish_prompt
    echo
    set -l segments streamline_os_icon_segment streamline_pwd_segment streamline_git_segment
    if set -q streamline_segments
        set segments $streamline_segments
    end
    set segments (string join ' ' $segments)

    set -l streamline_multiline_segments (string split '\n' $segments)

    set -l linenum 0
    for cmds_string in $streamline_multiline_segments
        set linenum (math $linenum + 1)
        if [ $linenum -gt 1 ]
            echo -n -s -e (set_color normal) '\n'
        end

        streamline_print_prompt_leader $linenum

        set -l prompt_cmds $cmds_string
        set prompt_cmds (string trim $prompt_cmds)
        set prompt_cmds (string replace -a -r '\s+' ' ' $prompt_cmds)
        streamline_prompt (string split ' ' $prompt_cmds)
    end

end

function streamline_pwd_segment
    echo (prompt_pwd)
    echo blue
    echo black
end


function streamline_print_prompt_leader -a linenum
    if [ (count $streamline_leaders) -ge $linenum ]
        set -l leader $streamline_leaders[$linenum]
        set -l leader_components (eval $leader)
        set -l leader_text $leader_components[1]
        set -l leader_bg_color $leader_components[2]
        set -l leader_fg_color $leader_components[3]
        echo -n -s (set_color -b $leader_bg_color) (set_color $leader_fg_color) $leader_text
    end
end

function streamline_prompt
    set -l segments $argv
    set bg_color normal
    set fg_color normal
    set text

    set divider_icon
    for segment in $segments
        set -l prev_bg_color $bg_color
        set -l components (eval $segment)

        set -l text
        set -l fg_color
        switch (count $components)
          case 0
            continue
          case 3
              set text $components[1]
              set bg_color $components[2]
              set fg_color $components[3]
          case '*'
              set text "("ERROR with $segment")"
              set bg_color black
              set fg_color red
        end

        echo -n -s (set_color -b $bg_color) (set_color $prev_bg_color) $divider
        echo -n -s (set_color -b $bg_color) (set_color $fg_color) " $text "
        set divider ''
    end
    echo -n -s (set_color normal) (set_color $bg_color) $divider ' '
end

############
# STREAMLINE
############
function streamline_os_icon_segment
    set -l os_icon
    switch (uname)
        case Darwin
	    set os_icon ''
        case Linux
            set os_icon ''
        case Windows_NT
	    set os_icon ''
    end
    echo $os_icon
    echo black
    echo white
end

function streamline_dir_segment
    echo (prompt_pwd)  # prompt_pwd is a built-in fish function
    echo blue
    echo black
end

function streamline_git_segment
    if git_is_repo  # git_is_repo is a built-in fish function
        echo " "(git_branch_name)  # git_branch_name is a built-in fish function
        if git_is_dirty # git_branch_name is a built-in fish function
            echo red
        else if git_is_staged  # git_is_staged is a built-in fish function
            echo yellow
        else
            echo green
        end
        echo black
    end
end

# what to show at the beginning of the first line of the prompt
function streamline_first_line_leader
    echo '╭─'
    echo normal
    echo blue
end

# what to show at the beginning of the second line of the prompt
function streamline_second_line_leader
    echo '╰─'
    echo normal
    echo blue
end

set -x streamline_segments streamline_os_icon_segment streamline_dir_segment streamline_git_segment \n
# define leaders to display on each line of the prompt
set -x streamline_leaders streamline_first_line_leader streamline_second_line_leader
