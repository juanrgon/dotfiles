
function fish_prompt
    echo

    set -x segments streamline_holiday_segment streamline_pwd_segment streamline_git_segment \n
    set -x streamline_leaders streamline_first_line_leader streamline_second_line_leader

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

# Function to randomly select an emoji from a given list
function choose_random_emoji
    set -l emojis $argv
    set -l count (count $emojis)

    # Check if the count is zero, which means the list is empty
    if test $count -eq 0
        echo "List of emojis is empty."
        return 1
    end

    set -l index (math (random 1 $count))
    echo $emojis[$index]
end

function thanksgiving_week
    set -l year (date "+%Y")

    # Get the day of the week for November 1 of the given year
    set -l first (date -u -d "$year-11-01T00:00:00Z" +%u 2>/dev/null; or date -u -jf "%Y-%m-%d %H:%M:%S %z" "$year-11-01 00:00:00 +0000" +%u)

    # Determine the date for the first Thursday of November
    set -l first_thursday (math "1 + ((4 - $first + 7) % 7)")

    # Add 21 to get Thanksgiving
    set -l thanksgiving_date (math "$first_thursday + 21")

    # Calculate the 7 days leading up to Thanksgiving
    for i in (seq 0 6)
        set -l day (math "$thanksgiving_date - $i")
        if test $day -lt 10
            echo "11-0$day"
        else
            echo "11-$day"
        end
    end | sort
end

function streamline_holiday_segment
    set -l current_date (date "+%m-%d")
    set -l holiday_emoji
    set -l bg_color

    # Matching based on the date
    switch $current_date
        # Week of New Year's
        case '12-26' '12-27' '12-28' '12-29' '12-30' '12-31' '01-01'
            set -l new_year_emojis "🎉" "🍾" "🎆" "🕛" "🎊"
            set holiday_emoji (choose_random_emoji $new_year_emojis)
            set bg_color "blue"

        # Week of Valentine's Day
        case '02-08' '02-09' '02-10' '02-11' '02-12' '02-13' '02-14'
            set -l valentines_emojis "💘" "❤️" "💝" "🌹" "💌"
            set holiday_emoji (choose_random_emoji $valentines_emojis)
            set bg_color "#FFC0CB"

        # On St. Patrick's Day, March 17
        case '03-17'
            set holiday_emoji "☘️"
            set bg_color "green"

        # Week of Independence Day
        case '06-28' '06-29' '06-30' '07-01' '07-02' '07-03' '07-04'
            set -l independence_emojis "🇺🇸" "🎆" "🗽" "🦅" "🎉"
            set holiday_emoji (choose_random_emoji $independence_emojis)
            set bg_color "blue"

        # Week of Halloween
        case '10-25' '10-26' '10-27' '10-28' '10-29' '10-30' '10-31'
            set -l halloween_emojis "🎃" "👻" "🦇"
            set holiday_emoji (choose_random_emoji $halloween_emojis)
            set bg_color "#333333"  # Charcoal grey

        # Week of Thanksgiving
        case (thanksgiving_week)
            set -l thanksgiving_emojis "🦃" "🌽" "🥧" "🍂" "🍗"
            set holiday_emoji (choose_random_emoji $thanksgiving_emojis)
            set bg_color "#FFA500"

        # Week of Christmas
        case '12-19' '12-20' '12-21' '12-22' '12-23' '12-24' '12-25'
            set -l christmas_emojis "🎄" "🎅" "🤶" "🦌" "⛄" "🔔" "🎁"
            set holiday_emoji (choose_random_emoji $christmas_emojis)
            set bg_color "green"

        # If no holiday, display season emoji
        case '*'
            set -l current_month (date "+%m")
            set -l season_emoji
            switch $current_month
                # Winter
                case '12' '01' '02'
                    set season_emojis "❄️" "⛄" "🧣"
                    set bg_color "#ADD8E6" # Light Blue
                # Spring
                case '03' '04' '05'
                    set season_emojis "🌸" "🌼" "🦋"
                    set bg_color "#FFC0CB"  # Pink
                # Summer
                case '06' '07' '08'
                    set season_emojis "☀️" "🏖️" "🍦"
                    set bg_color "#FFFF00"  # Yellow
                # Fall
                case '09' '10' '11'
                    set season_emojis "🍂" "🍁" "🍄"
                    set bg_color "#FFA500" # Orange
            end
            set holiday_emoji (choose_random_emoji $season_emojis)
    end

    echo $holiday_emoji
    echo $bg_color
    echo white
end
