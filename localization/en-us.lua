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
            },
            j_divergence_collector_joker={
                name = "Collector Joker",
                text = {
                    "{X:mult,C:white}X#1#{} mult for every joker with",
                    "the same {C:attention}edition{} {C:inactive}(exept{} {C:dark_edition}negative{}{C:inactive}){}",
                    "{C:inactive}(currently{} {X:mult,C:white}X#2#{}{C:inactive}){}"
                }
            }
        },
        Other={
            divergence_stagestruck={
                name = "Stage-Struck",
                text = {
                    "Can be found again, {C:inactive}(as if{}",
                    "{C:attention}Showman{} {C:inactive}were present){}"
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
                    "Apply a {C:attention}Stage-Struck Sticker{}",
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
            v_divergence_backstage_pass={
                name = "Backstage Pass",
                text = {
                    "{C:attention}Jokers{} may appear",
                    "with {C:attention}Stage-Struck{}"
                }
            },
            v_divergence_standing_ovation={
                name = "Standing Ovation",
                text = {
                    "{C:attention}Jokers{} with {C:attention}Stage-Struck{}",
                    "appear {C:attention}X#1#{} more often"
                }
            }
        }
    },
    misc={
        labels={
            divergence_stagestruck = "Stage-Struck"
        }
    },
}
