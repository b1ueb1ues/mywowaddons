local _G = getfenv(0)
local ADDON_NAME, addon = ...

local string = _G.string
local pairs = _G.pairs
local floor, abs = _G.math.floor, _G.math.abs
local tonumber = _G.tonumber
local tostring = _G.tostring

addon.addonName = "Compact Runes"
addon.addonNameCondensed = "CompactRunes"

-- Try to remove the Git hash at the end, otherwise return the passed in value.
local function cleanupVersion(version)
	local iter = string.gmatch(version, "(.*)-[a-z0-9]+$")
	if iter then
		local ver = iter()
		if ver and #ver >= 3 then
			return ver
		end
	end
	return version
end

addon.addonTitle = _G.GetAddOnMetadata(ADDON_NAME,"Title")
addon.addonVersion = cleanupVersion("8.0.3")

addon.CURRENT_BUILD, addon.CURRENT_INTERNAL,
    addon.CURRENT_BUILD_DATE, addon.CURRENT_UI_VERSION = _G.GetBuildInfo()
addon.WoD = addon.CURRENT_UI_VERSION >= 60000
addon.Legion = addon.CURRENT_UI_VERSION >= 70000
addon.BfA = addon.CURRENT_UI_VERSION >= 80000

local function round(number)
    if not number then return 0 end
    return floor(number+0.5)
end
addon.round = round

addon.modules = {}
function addon:RegisterModule(name, obj)
	addon.modules[name] = obj
end
function addon:UnregisterModule(name)
	addon.modules[name] = nil
end

addon.callbacks = {
	["TalentUpdate"] = {},
	["ResetStats"] = {},
	["CombatStart"] = {},
	["CombatEnd"] = {},
	["ProfileUpdate"] = {},
	["PlayerAlive"] = {},
	["PlayerDead"] = {},
	["GearUpdate"] = {},
	["FrameLock"] = {},
}
function addon:RegisterCallback(event, name, func)
	local callbacks = addon.callbacks[event]
	if not callbacks then return end
	if name and func and _G.type(func) == "function" then
		callbacks[name] = func
	end
end
function addon:UnregisterCallback(event, name)
	local callbacks = addon.callbacks[event]
	if not callbacks then return end
	if name then
		callbacks[name] = nil
	end
end
function addon:FireCallback(event)
	local callbacks = addon.callbacks[event]
	if not callbacks then return end
	for name, func in pairs(callbacks) do
		if func then func() end
	end
end

local millFmt = "%.0fm"
local thousandFmt = "%.0fk"
addon.FormatNumber = function(number)
    if tonumber(number) == nil then
        return number
    end
    if number > 1000000 then
        return millFmt:format(number / 1000000)
    elseif number > 1000 then
        return thousandFmt:format(number / 1000)
    end
    return number
end

local precisions = {
	[0] = "%.0f",
	[1] = "%.1f",
	[2] = "%.2f",
	[3] = "%.3f",
}
addon.FormatNumberWithPrecision = function(number, precision)
	if tonumber(number) == nil then
	    return number, nil
	end
	local fmt = precision ~= nil and precisions[precision] or precision[0]
	if number > 1000000 then
	    return fmt:format(number / 1000000), "m"
	elseif number > 1000 then
	    return fmt:format(number / 1000), "k"
	end
	return number, nil
end

local valuePlusPercFmt = "%d (%.1f%%)"
addon.valuePlusPercent = function(value, total)
	local val = value or 0
	local tot = total or 0
	local perc = (tot > 0) and (val / tot * 100) or 0
	return valuePlusPercFmt:format(val, perc)
end

addon.UpdateDisplayEvents = {
	["PlayerAura"] = {},
	["TargetAura"] = {},
	["PetAura"] = {},
	["SpellCooldown"] = {},
	["CombatStart"] = {},
	["CombatEnd"] = {},
	["CombatLogEvent"] = {},
}

function addon:BarDisplayUpdateForEvent(event, ...)
	for bar, enabled in pairs(addon.UpdateDisplayEvents[event] or {}) do
		if bar and enabled and bar.UpdateDisplay then
			bar:UpdateDisplay(event, ...)
		end
	end
end

function addon:BarDisplayAdd(event, bar)
	local events = addon.UpdateDisplayEvents[event]
	events[bar] = true
end

function addon:BarDisplayRemove(event, bar)
	local events = addon.UpdateDisplayEvents[event]
	events[bar] = nil
end

-- UnitBuff for BfA.  Scans buffs by name.
addon.UnitBuff = function(unit, spellName, filter)
	local name, icon, count, dispelType, duration, expires,
	caster, isStealable, shouldConsolidate, spellId, canApplyAura,
	isBossDebuff, castByPlayer, value1, value2, value3

	local i = 1
	name = ""
	while name ~= nil and i < 100 do
		name, icon, count, dispelType, duration, expires,
		caster, isStealable, shouldConsolidate, spellId, canApplyAura,
		isBossDebuff, castByPlayer, value1, value2, value3
			= _G.UnitBuff(unit, i, filter)
			if name == spellName then
				return name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
			end
			i = i + 1
	end
	return nil
end

-- UnitDebuff for BfA.  Scans debuffs by name.
addon.UnitDebuff = function(unit, spellName, filter)
	local name, icon, count, dispelType, duration, expires,
	caster, isStealable, shouldConsolidate, spellId, canApplyAura,
	isBossDebuff, castByPlayer, value1, value2, value3

	local i = 1
	name = ""
	while name ~= nil and i < 100 do
		name, icon, count, dispelType, duration, expires,
		caster, isStealable, shouldConsolidate, spellId, canApplyAura,
		isBossDebuff, castByPlayer, value1, value2, value3
			= _G.UnitDebuff(unit, i, filter)
		if name == spellName then
			return name, icon, count, dispelType, duration, expires,
				caster, isStealable, shouldConsolidate, spellId, canApplyAura,
				isBossDebuff, castByPlayer, value1, value2, value3
		end
		i = i + 1
	end
	return nil
end
