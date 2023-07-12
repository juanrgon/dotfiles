function fish_greeting
  set current_hour (date +%H)

    if test $current_hour -ge 6 -a $current_hour -lt 9
        morning
    else if test $current_hour -ge 9 -a $current_hour -lt 15
        midday
    else if test $current_hour -ge 15 -a $current_hour -lt 19
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
