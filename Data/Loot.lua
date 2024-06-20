local _, ns = ...
local Parrot = ns.addon
if not Parrot then return end

local L = LibStub("AceLocale-3.0"):GetLocale("Parrot")

local newDict = Parrot.newDict
local Deformat = Parrot.Deformat

local LOOT_ITEM_SELF = _G.LOOT_ITEM_SELF
local LOOT_ITEM_SELF_MULTIPLE = _G.LOOT_ITEM_SELF_MULTIPLE
local LOOT_ITEM_PUSHED_SELF = _G.LOOT_ITEM_PUSHED_SELF
local LOOT_ITEM_PUSHED_SELF_MULTIPLE = _G.LOOT_ITEM_PUSHED_SELF_MULTIPLE
local LOOT_ITEM_CREATED_SELF = _G.LOOT_ITEM_CREATED_SELF
local LOOT_ITEM_CREATED_SELF_MULTIPLE = _G.LOOT_ITEM_CREATED_SELF_MULTIPLE
local LOOT_ITEM_REFUND = _G.LOOT_ITEM_REFUND
local LOOT_ITEM_REFUND_MULTIPLE = _G.LOOT_ITEM_REFUND_MULTIPLE
local ITEM_QUALITY_COLORS = _G.ITEM_QUALITY_COLORS

local critItemType = {
    ["Elixir"] = true,
    ["Potion"] = true,
    ["Flask"] = true
}

local function parse_CHAT_MSG_LOOT(chatmsg)
    -- check for multiple
    local isCrit = false
    local itemLink, amount = Deformat(chatmsg, LOOT_ITEM_SELF_MULTIPLE)
    if not itemLink then
        itemLink, amount = Deformat(chatmsg, LOOT_ITEM_PUSHED_SELF_MULTIPLE)
    end
    if not itemLink then
        itemLink, amount = Deformat(chatmsg, LOOT_ITEM_CREATED_SELF_MULTIPLE)
        if itemLink then isCrit = true end
    end
    if not itemLink then
        itemLink, amount = Deformat(chatmsg, LOOT_ITEM_REFUND_MULTIPLE)
    end

    -- check for single
    if not itemLink then
        itemLink = Deformat(chatmsg, LOOT_ITEM_SELF)
    end
    if not itemLink then
        itemLink = Deformat(chatmsg, LOOT_ITEM_PUSHED_SELF)
    end
    if not itemLink then
        itemLink = Deformat(chatmsg, LOOT_ITEM_CREATED_SELF)
    end
    if not itemLink then
        itemLink = Deformat(chatmsg, LOOT_ITEM_REFUND)
    end

    -- if something has been looted
    if itemLink then
        if not amount then
            amount = 1
        end
        local name, _, quality, _, _, _, itemType, _, _, texture = GetItemInfo(itemLink)
        -- check min quality
        if quality < 1 then
            return
        end

        if isCrit and not critItemType[itemType] then
            isCrit = false
        end

        local color = ITEM_QUALITY_COLORS[quality]
        if color then
            name = ("%s%s|r"):format(color.hex, name)
        end

        if amount > 1 then
            name = amount .. " x " .. name
        end

        return newDict(
            "name", name,
            "icon", texture,
            "isCrit", isCrit
        )
    end
end

Parrot:RegisterCombatEvent {
    category = "Notification",
    subCategory = L["Loot"],
    name = "Loot items",
    localName = L["Loot items"],
    defaultTag = L["[Name]"],
    tagTranslations = {
        Name = "name",
        Icon = "icon",
    },
    tagTranslationsHelp = {
        Name = L["The name of the item."],
    },
    canCrit = true,
    events = {
        CHAT_MSG_LOOT = { parse = parse_CHAT_MSG_LOOT, },
    },
    color = "ffffff", -- white
}


local LOOT_MONEY_SPLIT, YOU_LOOT_MONEY = _G.LOOT_MONEY_SPLIT, _G.YOU_LOOT_MONEY
local LOOT_CURRENCY_REFUND, LOOT_MONEY_REFUND = _G.LOOT_CURRENCY_REFUND, _G.LOOT_MONEY_REFUND
local GOLD_AMOUNT, SILVER_AMOUNT, COPPER_AMOUNT = _G.GOLD_AMOUNT, _G.SILVER_AMOUNT, _G.COPPER_AMOUNT

local function parse_CHAT_MSG_MONEY(chatmsg)
    local moneystring = Deformat(chatmsg, LOOT_MONEY_SPLIT) or Deformat(chatmsg, YOU_LOOT_MONEY)
    if not moneystring then
        moneystring = Deformat(chatmsg, LOOT_CURRENCY_REFUND) or Deformat(chatmsg, LOOT_MONEY_REFUND)
    end
    if moneystring then
        local icon = 133784
        if moneystring:match(SILVER_AMOUNT) and not moneystring:match(GOLD_AMOUNT) then
            icon = 133786
        elseif moneystring:match(COPPER_AMOUNT) and not moneystring:match(SILVER_AMOUNT) and not moneystring:match(GOLD_AMOUNT) then
            icon = 133788
        end

        return newDict("amount", moneystring, "icon", icon)
    end
end

Parrot:RegisterCombatEvent {
    category = "Notification",
    subCategory = L["Loot"],
    name = "Loot money",
    localName = L["Loot money"],
    defaultTag = L["[Amount]"],
    tagTranslations = {
        Amount = "amount",
        Icon = "icon",
    },
    tagTranslationsHelp = {
        Amount = L["The amount of gold looted."],
    },
    events = {
        CHAT_MSG_MONEY = { parse = parse_CHAT_MSG_MONEY, },
    },
    color = "ffffff", -- white
}
