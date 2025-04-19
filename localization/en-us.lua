return
{
    descriptions={
        Joker={
            j_divergence_frozen_joker={
                name = "Cold Joker",
                text = {
                    "This joker gains {X:chips,C:white}X#2#{} Chips",
                    "for every {C:attention}Ice Card{}",
                    "that is destroyed",
                    "{C:inactive}(currently{} {X:chips,C:white}X#1#{} {C:inactive}Chips){}"
                }
            }
        },
        Tarot={
            c_divergence_caver={
                name="The Caver",
                text = {
                    "Enhances up to {C:attention}3{} Cards into",
                    "{C:attention}Ice Cards{}",
                },
            },
        },
        Enhanced=
        {
            m_divergence_ice={
                name = "Ice Card",
                text = {
                "{C:blue}+50{} chips",
                "{X:chips,C:white}X#1#{} chips while this card is held in hand,", 
                "{C:red}melts{} after {C:attention}3 hands {C:inactive}#3#/#2#{},",
                "no rank or suit",
                },
            },
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
            }
        }
    },
}
