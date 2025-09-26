function fish_greeting
    # Check if we should show copilot greeting
    if test "$BUILDING_COPILOT" = "true"
        _copilot_banner
        return
    end

    set current_hour (date +%H)

    if test $current_hour -ge 6 -a $current_hour -lt 12
        morning
    else if test $current_hour -ge 12 -a $current_hour -lt 20
        evening
    else
        night
    end
end

function morning
    printf '\e[36m'
    printf '\e[38;5;226m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n'
    printf '\e[38;5;226m┃                                                                              ┃\n'
    printf '\e[38;5;226m┃                             .mmMMMMMMMMMMMMMmm.                              ┃\n'
    printf '\e[38;5;226m┃                         .mMMMMMMMMMMMMMMMMMMMMMMMm.                          ┃\n'
    printf '\e[38;5;226m┃                      .mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm.                       ┃\n'
    printf '\e[38;5;226m┃                    .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                     ┃\n'
    printf '\e[38;5;220m┃                  .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                   ┃\n'
    printf '\e[38;5;220m┃                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  ┃\n'
    printf '\e[38;5;220m┃                MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                 ┃\n'
    printf '\e[38;5;220m┃               MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                ┃\n'
    printf '\e[38;5;214m┃              .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.               ┃\n'
    printf '\e[38;5;214m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;214m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;214m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;208m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;208m┃              `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`               ┃\n'
    printf '\e[38;5;208m┃               MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                ┃\n'
    printf '\e[38;5;208m┃                MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                 ┃\n'
    printf '\e[38;5;202m┃                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  ┃\n'
    printf '\e[38;5;202m┃                  `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                   ┃\n'
    printf '\e[38;5;202m┃                    `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                     ┃\n'
    printf '\e[38;5;202m┃                      `"MMMMMMMMMMMMMMMMMMMMMMMMMMMMM"`                       ┃\n'
    printf '\e[38;5;196m┃                         `"MMMMMMMMMMMMMMMMMMMMMMM"`                          ┃\n'
    printf '\e[38;5;196m┃                             `""MMMMMMMMMMMMM""`                              ┃\n'
    printf '\e[38;5;196m┃                                                                              ┃\n'
    printf '\e[38;5;196m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n'
    printf '\e[0m'
end


function evening
    printf '\e[36m'
    printf '\e[38;5;196m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n'
    printf '\e[38;5;196m┃                                                                              ┃\n'
    printf '\e[38;5;196m┃                             .mmMMMMMMMMMMMMMmm.                              ┃\n'
    printf '\e[38;5;202m┃                         .mMMMMMMMMMMMMMMMMMMMMMMMm.                          ┃\n'
    printf '\e[38;5;202m┃                      .mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm.                       ┃\n'
    printf '\e[38;5;202m┃                    .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                     ┃\n'
    printf '\e[38;5;208m┃                  .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                   ┃\n'
    printf '\e[38;5;208m┃                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  ┃\n'
    printf '\e[38;5;208m┃                MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                 ┃\n'
    printf '\e[38;5;208m┃               MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                ┃\n'
    printf '\e[38;5;214m┃              .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.               ┃\n'
    printf '\e[38;5;214m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;214m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;214m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;214m┃              `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`               ┃\n'
    printf '\e[38;5;220m┃               MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                ┃\n'
    printf '\e[38;5;220m┃                MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                 ┃\n'
    printf '\e[38;5;220m┃                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  ┃\n'
    printf '\e[38;5;220m┃                  `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                   ┃\n'
    printf '\e[38;5;220m┃                    `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                     ┃\n'
    printf '\e[38;5;226m┃                      `"MMMMMMMMMMMMMMMMMMMMMMMMMMMMM"`                       ┃\n'
    printf '\e[38;5;226m┃                         `"MMMMMMMMMMMMMMMMMMMMMMM"`                          ┃\n'
    printf '\e[38;5;226m┃                             `""MMMMMMMMMMMMM""`                              ┃\n'
    printf '\e[38;5;226m┃                                                                              ┃\n'
    printf '\e[38;5;226m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n'
    printf '\e[0m'
end


function midday
    printf '\e[36m'
    printf '\e[38;5;226m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n'
    printf '\e[38;5;226m┃                                                                              ┃\n'
    printf '\e[38;5;226m┃                             .mmMMMMMMMMMMMMMmm.                              ┃\n'
    printf '\e[38;5;226m┃                         .mMMMMMMMMMMMMMMMMMMMMMMMm.                          ┃\n'
    printf '\e[38;5;226m┃                      .mMMMMMMMMMMMMMMMMMMMMMMMMMMMMMm.                       ┃\n'
    printf '\e[38;5;226m┃                    .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                     ┃\n'
    printf '\e[38;5;226m┃                  .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                   ┃\n'
    printf '\e[38;5;226m┃                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  ┃\n'
    printf '\e[38;5;226m┃                MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                 ┃\n'
    printf '\e[38;5;226m┃               MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                ┃\n'
    printf '\e[38;5;226m┃              .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.               ┃\n'
    printf '\e[38;5;226m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;226m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;226m┃              MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM               ┃\n'
    printf '\e[38;5;226m┃              `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`               ┃\n'
    printf '\e[38;5;226m┃               MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                ┃\n'
    printf '\e[38;5;226m┃                MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                 ┃\n'
    printf '\e[38;5;226m┃                 MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM                  ┃\n'
    printf '\e[38;5;226m┃                  `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                   ┃\n'
    printf '\e[38;5;226m┃                    `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM`                     ┃\n'
    printf '\e[38;5;226m┃                      `"MMMMMMMMMMMMMMMMMMMMMMMMMMMMM"`                       ┃\n'
    printf '\e[38;5;226m┃                         `"MMMMMMMMMMMMMMMMMMMMMMM"`                          ┃\n'
    printf '\e[38;5;226m┃                             `""MMMMMMMMMMMMM""`                              ┃\n'
    printf '\e[38;5;226m┃                                                                              ┃\n'
    printf '\e[38;5;226m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n'
    printf '\e[0m'
end


function night
    printf '\e[36m'
    printf '\e[36m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n'
    printf '\e[36m┃                                                                              ┃\n'
    printf '\e[36m┃      *                                                            *          ┃\n'
    printf '\e[36m┃                              aaaaaaaaaaaaaaaa               *                ┃\n'
    printf '\e[36m┃                          aaaaaaaaaaaaaaaaaaaaaaaa                            ┃\n'
    printf '\e[36m┃                       aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa                         ┃\n'
    printf '\e[36m┃                     aaaaaaaaaaaaaaaaa           aaaaaa                       ┃\n'
    printf '\e[36m┃                   aaaaaaaaaaaaaaaa                  aaaa           *         ┃\n'
    printf '\e[36m┃                  aaaaaaaaaaaaaaa                      aa                     ┃\n'
    printf '\e[36m┃                 aaaaaaaaaaaaaaa                         a                    ┃\n'
    printf '\e[36m┃                 aaaaaaaaaaaaaaa                                              ┃\n'
    printf '\e[36m┃           *    aaaaaaaaaaaaaaa                                     *         ┃\n'
    printf '\e[36m┃                aaaaaaaaaaaaaaa                                               ┃\n'
    printf '\e[36m┃                aaaaaaaaaaaaaaa                                               ┃\n'
    printf '\e[36m┃                aaaaaaaaaaaaaaa                                  *            ┃\n'
    printf '\e[36m┃                 aaaaaaaaaaaaaa                                               ┃\n'
    printf '\e[36m┃                 aaaaaaaaaaaaaaa                          a                   ┃\n'
    printf '\e[36m┃                  aaaaaaaaaaaaaaa                       aa                    ┃\n'
    printf '\e[36m┃                   aaaaaaaaaaaaaaaa                  aaaa                     ┃\n'
    printf '\e[36m┃                     aaaaaaaaaaaaaaaaa.          aaaaaa        *              ┃\n'
    printf '\e[36m┃       *               aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa                         ┃\n'
    printf '\e[36m┃                          aaaaaaaaaaaaaaaaaaaaaaaa                            ┃\n'
    printf '\e[36m┃                       *      aaaaaaaaaaaaaaaa                         *      ┃\n'
    printf '\e[36m┃                                                                              ┃\n'
    printf '\e[36m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n'
    printf '\e[0m'
end

function _copilot_banner
    # Precomputed vertical gradient from #00A0FF to #FF0080 (12 steps)
    printf "\e[38;2;0;160;255m┌──                                                                         ──┐\e[0m\n"
    printf "\e[38;2;23;145;243m│                                                           ▄██████▄          │\e[0m\n"
    printf "\e[38;2;46;131;232m    GitHub                                              ▄█▀▀▀▀▀██▀▀▀▀▀█▄\e[0m\n"
    printf "\e[38;2;70;116;220m    █████┐ █████┐ █████┐ ██┐██┐     █████┐ ██████┐     ▐█      ▐▌      █▌\e[0m\n"
    printf "\e[38;2;93;102;209m   ██┌───┘██┌──██┐██┌─██┐██│██│    ██┌──██┐└─██┌─┘     ▐█▄    ▄██▄    ▄█▌\e[0m\n"
    printf "\e[38;2;116;87;197m   ██│    ██│  ██│█████┌┘██│██│    ██│  ██│  ██│      ▄▄███████▀▀███████▄▄\e[0m\n"
    printf "\e[38;2;139;73;186m   ██│    ██│  ██│██┌──┘ ██│██│    ██│  ██│  ██│     ████     ▄  ▄     ████\e[0m\n"
    printf "\e[38;2;162;58;174m   └█████┐└█████┌┘██│    ██│██████┐└█████┌┘  ██│     ████     █  █     ████\e[0m\n"
    printf "\e[38;2;185;44;163m    └────┘ └────┘ └─┘    └─┘└─────┘ └────┘   └─┘     ▀███▄            ▄███▀\e[0m\n"
    printf "\e[38;2;209;29;151m│                                                       ▀▀████████████▀▀      │\e[0m\n"
    printf "\e[38;2;232;15;140m└──                                                                         ──┘\e[0m\n"
end
