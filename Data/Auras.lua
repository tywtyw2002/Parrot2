local Parrot = Parrot
local L = LibStub("AceLocale-3.0"):GetLocale("Parrot_Auras")

local newList, del = Parrot.newList, Parrot.del
local newDict = Parrot.newDict
local unpackDictAndDel = Parrot.unpackDictAndDel
local debug = Parrot.debug

local function parseAura(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)

	local info = newList()
	info.spellID = spellId
	info.abilityName = spellName
	info.sourceID = srcGUID
	info.sourceName = srcName
	info.recipientID = dstGUID
	info.recepientName = dstName
	info.icon = select(3, GetSpellInfo(spellId))
	info.amount = amount
	return info

end

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Buff gains",
	localName = L["Buff gains"],
	defaultTag = "([Name])",
	combatLogEvents = {
		SPELL_AURA_APPLIED = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "BUFF" and dstGUID == UnitGUID("player")
				end,
			func = parseAura,
		},
	},
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff gained."],
	},
	color = "b2b200", -- dark yellow
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff gains",
	localName = L["Debuff gains"],
	defaultTag = "([Name])",
	combatLogEvents = {
		SPELL_AURA_APPLIED = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "DEBUFF" and dstGUID == UnitGUID("player")
				end,
			func = parseAura,
		},
	},
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
	},
	tagTranslationsHelp = {
		Name = L["The name of the debuff gained."],
	},
	color = "007f7f", -- dark cyan
}


Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Buff stack gains",
	localName = L["Buff stack gains"],
	defaultTag = "([Name] -[Amount]-)",
	combatLogEvents = {
		SPELL_AURA_APPLIED_DOSE = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "BUFF" and dstGUID == UnitGUID("player")
				end,
			func = parseAura,
		}
	},
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
		Amount = "amount",
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff gained."],
		Name = L["New Amount of stacks of the buff."],
	},
	color = "b2b200", -- dark yellow
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff stack gains",
	localName = L["Debuff stack gains"],
	defaultTag = "([Name] -[Amount]-)",
	combatLogEvents = {
		SPELL_AURA_APPLIED_DOSE = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "DEBUFF" and dstGUID == UnitGUID("player")
				end,
			func = parseAura,
		}
	},
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
		Amount = "amount",
	},
	tagTranslationsHelp = {
		Name = L["The name of the debuff gained."],
		Name = L["New Amount of stacks of the debuff."],
	},
	color = "007f7f", -- dark cyan
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Buff fades",
	localName = L["Buff fades"],
	defaultTag = "-([Name])",
	combatLogEvents = {
		SPELL_AURA_REMOVED = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "BUFF" and dstGUID == UnitGUID("player")
				end,
			func = parseAura,
		},
	},
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
	},
	tagTranslationsHelp = {
		Name = L["The name of the buff lost."],
	},
	color = "e5e500", -- yellow
}


Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Debuff fades",
	localName = L["Debuff fades"],
	defaultTag = "-([Name])",
	combatLogEvents = {
		SPELL_AURA_REMOVED = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "DEBUFF" and dstGUID == UnitGUID("player")
				end,
			func = parseAura,
		},
	},
	tagTranslations = {
		Name = "abilityName",
		Icon = "icon",
	},
	tagTranslationsHelp = {
		Name = L["The name of the debuff lost."],
	},
	color = "00d8d8", -- cyan
}


Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Target buff gains",
	localName = L["Target buff gains"],
	defaultTag = "[Unitname] gains [Buffname]",
	combatLogEvents = {
		SPELL_AURA_APPLIED = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "BUFF" and dstGUID == UnitGUID("target")
				end,
			func = parseAura,
		}
	},
	tagTranslations = {
		Buffname = "abilityName",
		Icon = "icon",
		Unitname = "recepientName",
	},
	tagTranslationsHelp = {
		Buffname = L["The name of the buff gained."],
		Unitname = L["The name of the unit that gained the buff."],
	},
	color = "b2b200", -- dark yellow
	defaultDisabled = true,
}

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Target buff stack gains",
	localName = L["Target buff stack gains"],
	defaultTag = "[Unitname] gains [Buffname] -[Amount]-)",
	combatLogEvents = {
		SPELL_AURA_APPLIED_DOSE = {
			check = function(_, _, _, dstGUID, _, _, _, _, _, auraType)
					return auraType == "BUFF" and dstGUID == UnitGUID("target")
				end,
			func = parseAura,
		}
	},

	tagTranslations = {
		Buffname = "abilityName",
		Icon = "icon",
		Amount = "amount",
		Unitname = "dstName",
	},
	tagTranslationsHelp = {
		Buffname = L["The name of the buff gained."],
		Amount = L["New Amount of stacks of the buff."],
		Unitname = L["The name of the unit that gained the buff."],
	},
	color = "b2b200", -- dark yellow
	defaultDisabled = true,
}

local function parseItembuff(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellName, itemId, itemName)

	local info = newList()
	info.itemId = itemId
	info.abilityName = spellName
	info.itemName = itemName

	return info

end

Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Item buff gains",
	localName = L["Item buff gains"],
	defaultTag = "([Name])",
	combatLogEvents = {
		ENCHANT_APPLIED = {
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			func = parseItembuff,
		},
	},
	tagTranslations = {
		Name = "abilityName",
		ItemName = "itemName",
		Icon = function(info)
			return GetItemIcon(info.itemId)
		end,
	},
	tagTranslationsHelp = {
		Name = L["The name of the item buff gained."],
		ItemName = L["The name of the item, the buff has been applied to."],
	},
	color = "b2b2b2", -- gray
}



Parrot:RegisterCombatEvent{
	category = "Notification",
	subCategory = L["Auras"],
	name = "Item buff fades",
	localName = L["Item buff fades"],
	defaultTag = "-([Name])",
	combatLogEvents = {
		ENCHANT_REMOVED = {
			check = function(_, _, _, dstGUID)
					return dstGUID == UnitGUID("player")
				end,
			func = parseItembuff,
		},
	},
	tagTranslations = {
		Name = "abilityName",
		ItemName = "itemName",
		Icon = function(info)
			return GetItemIcon(info.itemId)
		end,
	},
	tagTranslationsHelp = {
		Name = L["The name of the item buff lost."],
		ItemName = L["The name of the item, the buff has faded from."],
	},
	color = "e5e5e5", -- light gray
}

local function compareUnitAndSpell(ref, info)
	if not ref.unit or not ref.spell or not info.dstGUID then
		debug("bailout, incomplete ref")
		return false
	end

	local good = (info.dstGUID == UnitGUID(ref.unit)) and (ref.auraType == info.auraType)
	if good then
		if type(ref.spell) == 'number' then
			return ref.spell == info.spellId
		else
			return ref.spell == info.spellName
		end
	end
	return false
end

local unitChoices = {
	["player"] = PLAYER,
	["focus"] = FOCUS,
	["target"] = TARGET,
	["pet"] = PET,
}

local auraTypeChoices = {
	["BUFF"] = L["Buff"],
	["DEBUFF"] = L["Debuff"],
}

local function parseSpell(arg)
	return tostring(arg or "")
end
local function saveSpell(arg)
	return tonumber(arg) or arg
end

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Aura gain",
	localName = L["Aura gain"],
	combatLogEvents = {
		{
			eventType = "SPELL_AURA_APPLIED",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)
				return newDict(
					"spellId", spellId,
					"spellName", spellName,
					"dstGUID", dstGUID,
					"auraType", auraType
				)
			end,
		},
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			auraType = {
				name = L["Aura type"],
				desc = L["Type of the aura"],
				type = 'select',
				values = auraTypeChoices,
			},
		},
	},
	check = compareUnitAndSpell,
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Aura stack gain",
	localName = L["Aura stack gain"],
	combatLogEvents = {
		{
			eventType = "SPELL_AURA_APPLIED_DOSE",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)
				return newDict(
					"spellId", spellId,
					"spellName", spellName,
					"dstGUID", dstGUID,
					"auraType", auraType,
					"amount", amount
				)
			end,
		},
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			amount = {
				name = L["Amount"],
				desc = L["Amount of stacks of the aura"],
				type = 'number',
				min = 1,
				max = 100,
				step = 1,
			},
			auraType = {
				name = L["Aura type"],
				desc = L["Type of the aura"],
				type = 'select',
				values = auraTypeChoices,
			},
		},
	},
	check = function(ref, info)
			if not ref.amount then
				return false
			end
			return compareUnitAndSpell(ref, info) and ref.amount == info.amount
		end,
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Aura fade",
	localName = L["Aura fade"],
	combatLogEvents = {
		{
			eventType = "SPELL_AURA_REMOVED",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount)
				return newDict(
					"spellId", spellId,
					"spellName", spellName,
					"dstGUID", dstGUID,
					"auraType", auraType
				)
			end,
		},
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			auraType = {
				name = L["Aura type"],
				desc = L["Type of the aura"],
				type = 'select',
				values = auraTypeChoices,
			},
		},
	},
	check = compareUnitAndSpell,
}

local function checkItemBuff(ref, info)
	if ref.unit and ref.spell then
		return ref.spell == info.spellName and UnitGUID(ref.unit) == info.dstGUID
	else
		return false
	end
end

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Item buff gain",
	localName = L["Item buff gain"],
	combatLogEvents = {
		{
			eventType = "ENCHANT_APPLIED",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellName, itemId, itemName)
				return {
					spellName = spellName,
					itemName = itemName,
					dstGUID = dstGUID,
				}
			end,
		}
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name"],
				type = 'string',
			},
		},
	},
	check = checkItemBuff,
}

Parrot:RegisterPrimaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Item buff fade",
	localName = L["Item buff fade"],
	combatLogEvents = {
		{
			eventType = "ENCHANT_REMOVED",
			triggerData = function(srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellName, itemId, itemName)
				return {
					spellName = spellName,
					itemName = itemName,
					dstGUID = dstGUID,
				}
			end,
		}
	},
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name"],
				type = 'string',
			},
		},
	},
	check = checkItemBuff,
}

Parrot:RegisterSecondaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Buff inactive",
	localName = L["Buff inactive"],
--	notLocalName = L["Aura active"],
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			byplayer = {
				name = L["Own aura"],
				desc = L["Only return true, if the Aura has been applied by yourself"],
				type = 'toggle',
			},
		},
	},
	check = function(param)
		if not param.unit or not param.spell then
			return false
		end
		local name, _, _, _, _, _, _, unitCaster = UnitAura(param.unit, param.spell)
		if name then
			-- aura present, but condition is false if the aura has not been cast by
			-- the player?
			if param.byplayer then
				return unitCaster ~= param.unit
			else
				return false
			end
		else
			return true
		end
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Buff active",
	localName = L["Buff active"],
--	notLocalName = L["Aura active"],
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			byplayer = {
				name = L["Own aura"],
				desc = L["Only return true, if the Aura has been applied by yourself"],
				type = 'toggle',
			},
		},
	},
	check = function(param)
		if not param.unit or not param.spell then
			return false
		end
		local name, _, _, _, _, _, _, unitCaster = UnitAura(param.unit, param.spell)
		if name then
			if param.byplayer == true then
				return unitCaster == param.unit
			else
				return true
			end
		else
			return false
		end
--		return not UnitAura(param.unit, param.spell or "")
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Debuff inactive",
	localName = L["Debuff inactive"],
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			byplayer = {
				name = L["Own aura"],
				desc = L["Only return true, if the Aura has been applied by yourself"],
				type = 'toggle',
			},
		},
	},
	check = function(param)
		if not param.unit or not param.spell then
			return false
		end
		local name, _, _, _, _, _, _, unitCaster = UnitDebuff(param.unit, param.spell)
		if name then
			-- aura present, but condition is false if the aura has not been cast by
			-- the player?
			if param.byplayer then
				return unitCaster ~= param.unit
			else
				return false
			end
		else
			return true
		end
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Debuff active",
	localName = L["Debuff active"],
--	notLocalName = L["Aura active"],
	param = {
		type = 'group',
		args = {
			unit = {
				name = L["Unit"],
				desc = L["The unit that is affected"],
				type = 'select',
				values = unitChoices,
			},
			spell = {
				name = L["Spell"],
				desc = L["Buff name or spell id"],
				type = 'string',
				usage = "<Buff name or spell id>",
				save = saveSpell,
				parse = parseSpell,
			},
			byplayer = {
				name = L["Own aura"],
				desc = L["Only return true, if the Aura has been applied by yourself"],
				type = 'toggle',
			},
		},
	},
	check = function(param)
		if not param.unit or not param.spell then
			return false
		end
		local name, _, _, _, _, _, _, unitCaster = UnitDebuff(param.unit, param.spell)
		if name then
			if param.byplayer == true then
				return unitCaster == param.unit
			else
				return true
			end
		else
			return false
		end
--		return not UnitAura(param.unit, param.spell or "")
	end,
}

Parrot:RegisterSecondaryTriggerCondition {
	subCategory = L["Auras"],
	name = "Item buff active",
	localName = L["Item buff active"],
	param = {
		type = 'select',
		values = {
			[0] = L["Any"],
			[1] = L["Main hand"],
			[2] = L["Off hand"],
			[3] = L["Both"],
		},
	},
	check = function(param)
		if not param then
			return false
		end
		local main, _, _, off = GetWeaponEnchantInfo()
		if param == 0 then
			return main == 1 or off == 1
		elseif param == 1 then
			return main == 1
		elseif param == 2 then
			return off == 1
		elseif param == 3 then
			return main == 1 and off == 1
		end
	end,
}
