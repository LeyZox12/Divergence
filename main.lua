DIVERGENCE = {}
DIVERGENCE.onMoney = ease_dollars


ease_dollars = function(mod, instant)
    for _, v in ipairs(G.vouchers.cards) do
      if v.config.center.key == 'v_divergence_eco' and mod > 0 then
        mod = mod +1
      end
    end
    local out = DIVERGENCE.onMoney(mod, instant)
    return out
end

DIVERGENCE.onColdBreak = function()
  for _, j in ipairs(G.jokers.cards) do
    if j.config.center.key == 'j_divergence_cold_joker' then
      local card_ability = j and j.ability or j.config
      card_ability.extra.currMult = card_ability.extra.currMult + card_ability.extra.multGain
      j:juice_up()
    end
  end
end

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
    
    local card_ability = card and card.ability or self.config
    if context.main_scoring and context.cardarea == G.hand  then
      return {x_chips = 1.25}
    end
    if context.main_scoring and context.cardarea == G.play then
      return{chips = 50}
    end
    if context.destroy_card then
      juice_card(card)
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.5,
        func = function()
          card_ability.extra.currentRounds = card_ability.extra.currentRounds + 1
          card.children.center:set_sprite_pos({x = 0, y = card_ability.extra.currentRounds})
          if card_ability.extra.currentRounds == card_ability.extra.maxRounds then
            DIVERGENCE.onColdBreak()
            card:shatter()
          end
            return true end }))
      return
    end
  end,
  discovered = true,
  atlas = "enhancements"
}

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
  can_use = 
  function(self)
    return self.config.max_highlighted >= #G.hand.highlighted and #G.hand.highlighted > 0 
  end,
  discovered = true,
  atlas = "tarots"
}

SMODS.Voucher{
  name = "steady_economy",
  key = "eco",
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

SMODS.Voucher{
  name = "overkill",
  key = "eco_up",
  pos = {x = 0, y = 1},
  config = {
    extra = {
      gain = 1,
      percent = 5,
      limitMoney = 50,
      moneyGained = 0
    }
  },
  loc_vars = function(self, info_queue, card)
    local card_ability = card and card.ability or self.config
    return {
        vars = {card_ability.extra.gain, card_ability.extra.percent, card_ability.extra.limitMoney}
    }
  end,
  calculate = function(self, card, context)
    local card_ability = card and card.ability or self.config
    if context.end_of_round and context.cardarea == G.vouchers then
      local moneyGain = math.floor((G.GAME.chips / G.GAME.blind.chips - 1) * 100 / card_ability.extra.percent * card_ability.extra.gain)
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
  requires = {'v_divergence_eco'},
  discovered = true,
  atlas = "vouchers"
}

SMODS.Joker{
  name = "cold_joker",
  key = "cold_joker",
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
