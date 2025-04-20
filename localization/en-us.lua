return
{
    descriptions={
        Joker={
            j_divergence_frozen_joker={
                name = "Frozen Joker",
                text = {
                    "This joker gains {X:chips,C:white}X#2#{} Chips",
                    "for every {C:attention}Ice Card{}",
                    "that is destroyed",
                    "{C:inactive}(currently{} {X:chips,C:white}X#1#{} {C:inactive}Chips){}"
                }
            }
        },
        Other={
            divergence_stagestruck={
                name = "Stagestruck",
                text = {
                    "Can be found again, ({C:inactive}as if{}",
                    "{C:attention}Showman{} {C:inactive}was here{}"
                }
            }
        },
        Spectral={
            c_divergence_pact={
                name = "Pact",
                text = {
                    "Apply a random {C:attention}Seal{}",
                    "to up to {C:attention}#1#{} cards"
                }
            },
            c_divergence_echo={
                name = "Echo",
                text = {
                    "Apply a {C:attention}Stagestruck Sticker{}",
                    "to up to {C:attention}#1#{} Joker"
                }
            }
        },
        Tarot={
            c_divergence_caver={
                name="The Caver",
                text = {
                    "Enhances up to {C:attention}3{} Cards into",
                    "{C:attention}Ice Cards{}"
                },
            },
        },
        Enhanced={
            m_divergence_ice={
                name = "Ice Card",
                text = {
                "{C:blue}+50{} chips",
                "{X:chips,C:white}X#1#{} chips while this card is held in hand,", 
                "{C:red}melts{} after {C:attention}3 hands {C:inactive}#3#/#2#{},",
                "no rank or suit"
                }
            }
        },
        Voucher={
            v_divergence_steady_income={
                name = "Steady Income",
                text = {
                "Gives an extra {C:money}$#1#{}",
                "each time you earn money"
                }
            },
            v_divergence_overkill={
                name = "Overkill",
                text = {
                    "Earn {C:money}$#1#{} for each {C:attention}#2#%{}",
                    "over the required chips",
                    "at the end of round",
                    "{C:inactive}(capped at {}{C:money}#3#${}{C:inactive}){}"
                }
            },
            v_divergence_showman_voucher={
                name = "Showman Voucher",
                text = {
                    "Increase the probability of finding",
                    "{C:attention}Showman Stickers{} on jokers",
                    "by {C:attention}#1#%{}"
                }
            },
            v_divergence_showman_voucher_up={
                name = "Showman Voucher Premium",
                text = {
                    "Increase the probability of finding",
                    "{C:attention}Showman Stickers{} on jokers",
                    "by {C:attention}#1#%{}"
                }
            }
        }
    },
    misc={
        labels={
            divergence_stagestruck = "Stagestruck"
        }
    },
}
