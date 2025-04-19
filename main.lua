DIVERGENCE = {}

--Hook for the easy_dollar function
DIVERGENCE.onMoney = ease_dollars
ease_dollars = function(mod, instant)
    for _, v in ipairs(G.vouchers.cards) do
      if v.config.center.key == 'v_divergence_steady_income' and mod > 0 then
        mod = mod +1
      end
    end
    local out = DIVERGENCE.onMoney(mod, instant)
    return out
end

--When Ice Card breaks
DIVERGENCE.onIceBreak = function()
  for _, j in ipairs(G.jokers.cards) do
    if j.config.center.key == 'j_divergence_frozen_joker' then
      local card_ability = j and j.ability or j.config
      card_ability.extra.currMult = card_ability.extra.currMult + card_ability.extra.multGain
      j:juice_up()
    end
  end
end

-- SETUP SPRITESHEETS --
SMODS.Atlas{
  key = "modicon",
  path = "Icon.png",
  px = 34,
  py = 34,
}

SMODS.Atlas{
  key = "jokers",
  path = "Jokers.png",
  px = 71,
  py = 95,
}

SMODS.Atlas{
  key = "enhancements",
  path = "Enhancements.png",
  px = 71,
  py = 95,
}

SMODS.Atlas{
  key = "tarots",
  path = "Tarots.png",
  px = 71,
  py = 95,
}

SMODS.Atlas{
  key = "vouchers",
  path = "Vouchers.png",
  px = 70,
  py = 94,
}
----

--Ice Cards Enhancement
SMODS.Enhancement
{
  name = "ice",
  key = "ice",
  config = {
    h_c_mult = 1.25,
    extra={
      mult = 1.25,
      maxRounds = 3,
      currentRounds = 0
    }
  },
  no_rank = true,
  no_suit = true,
  replace_base_card = true,
  always_scores = true,
  pos = {x = 0, y = 0},
    
  loc_vars = function(self, info_queue, card)
    local card_ability = card and card.ability or self.config
    return {
        vars = { card_ability.extra.mult, card_ability.extra.maxRounds, card_ability.extra.currentRounds}
    }
  end,
    
  update = function(self, card, dt)
      local card_ability = card and card.ability or self.config
      card.children.center:set_sprite_pos({x = 0, y = card_ability.extra.currentRounds})
  end,
    
  calculate = function(self, card, context)
    --Card Scoring
    local card_ability = card and card.ability or self.config
    if context.main_scoring then
      --In hand
      if context.cardarea == G.hand then
        return {x_chips = 1.25}
      --In played hand
      elseif context.cardarea == G.play then
        return {chips = 50}
      end
    end
        
    if context.destroy_card then
      juice_card(card)
      --Change Card extra.currentRounds / Shatter
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0,
        func = function()
          card_ability.extra.currentRounds = card_ability.extra.currentRounds + 1
          card.children.center:set_sprite_pos({x = 0, y = card_ability.extra.currentRounds})
          if card_ability.extra.currentRounds == card_ability.extra.maxRounds then
            DIVERGENCE.onIceBreak()
            card:shatter()
          end
          return true
      end }))
      return
    end
  end,
    
  discovered = true,
  atlas = "enhancements"
}

--Caver Tarot Card
SMODS.Consumable
{
  name = "caver",
  key = "caver",
  set = "Tarot",
  effect = 'Enhance',
  pos = {x = 0, y = 0},
  config = {
      mod_conv = "m_divergence_ice",
      max_highlighted = 3
  },
  loc_vars = function(self, info_queue, card)
  info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        
  local card_ability = card and card.ability or self.config
  return {
      vars = {card_ability.mod_conv, card_ability.max_highlighted}
  }
  end,

  --Amount of cards it can be used on at once
  can_use = 
  function(self)
    return self.config.max_highlighted >= #G.hand.highlighted and #G.hand.highlighted > 0 
  end,
    
  discovered = true,
  atlas = "tarots"
}

--Pact Spectral Card
SMODS.Consumable
{
  name = "pact",
  key = "pact",
  set = "Spectral",
  pos = {x = 0, y = 1},
  config = {
    extra={
      max_highlighted = 3
      }
    },
  loc_vars = function(self, info_queue, card)
  info_queue[#info_queue+1] = G.P_CENTERS[self.config.mod_conv]
        
  local card_ability = card and card.ability or self.config
  return {
      vars = {card_ability.extra.max_highlighted}
  }
  end,

  use = function(self)
    for _, card in ipairs(G.hand.highlighted) do
      G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        local seal = pseudorandom_element(G.P_SEALS, pseudoseed("divergence_seal"))
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        card:set_seal(seal.key, nil, true)
      return true
      end}))
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
      G.hand:unhighlight_all();
      return true
    end }))
  end,

  --Amount of cards it can be used on at once
  can_use = function(self, card)
    local card_ability = card and card.ability or self.config
    return 0 < #G.hand.highlighted and #G.hand.highlighted <= card_ability.extra.max_highlighted
  end,
    
  discovered = true,
  atlas = "tarots"
}

--Steady Income Voucher
SMODS.Voucher{
  name = "steady_income",
  key = "steady_income",
  pos = {x = 0, y = 0},
  cost = 10,
  config = {
    extra = {
      gain = 1,
      lastMoney = 0,
      isRedeemed = false
    }
  },
  redeem = function(self, card)
    local card_ability = card and card.ability or self.config
    card_ability.extra.isRedeemed = true
    card_ability.extra.lastMoney = G.GAME.dollars
  end,
    
  loc_vars = function(self, info_queue, card)
    local card_ability = card and card.ability or self.config
    return {
        vars = {card_ability.extra.gain}
    }
  end,

  discovered = true,
  atlas = "vouchers"
}

--Overkill Voucher
SMODS.Voucher{
  name = "overkill",
  key = "overkill",
  pos = {x = 0, y = 1},
  config = {
    extra = {
      gain = 1,
      percentage = 5,
      limitMoney = 50,
      moneyGained = 0
    }
  },
  loc_vars = function(self, info_queue, card)
    local card_ability = card and card.ability or self.config
    return {
        vars = {card_ability.extra.gain, card_ability.extra.percentage, card_ability.extra.limitMoney}
    }
  end,
    
  calculate = function(self, card, context)
    local card_ability = card and card.ability or self.config
    if context.end_of_round and context.cardarea == G.vouchers then
      local moneyGain = math.floor((G.GAME.chips / G.GAME.blind.chips - 1) * 100 / card_ability.extra.percentage * card_ability.extra.gain)
      if moneyGain > card_ability.extra.limitMoney then
        moneyGain = card_ability.extra.limitMoney
      end
      card_ability.extra.moneyGained = moneyGain
    end
  end,
    
  calc_dollar_bonus = function(self, card)
    local card_ability = card and card.ability or self.config
    local gain = card_ability.extra.moneyGained
    card_ability.extra.moneyGained = 0
    return gain
  end,
    
  requires = {'v_divergence_steady_income'}, --Sets Overkill as the upgrade of Steady Income
  discovered = true,
  atlas = "vouchers"
}

--Frozen Joker
SMODS.Joker{
  name = "frozen_joker",
  key = "frozen_joker",
  config = {
    extra = {
      currMult = 1.0,
      multGain = 0.15
    }
  },
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    local card_ability = card and card.ability or self.config
    info_queue[#info_queue+1] = G.P_CENTERS["m_divergence_ice"]
    return{
      vars = {card_ability.extra.currMult, card_ability.extra.multGain}
    }
  end,
    
  calculate = function(self, card, context)
    local card_ability = card and card.ability or self.config
    if context.joker_main then
      return {x_chips = card_ability.extra.currMult}
    end
  end,
    
  discovered = true,
  atlas = "jokers"
}
