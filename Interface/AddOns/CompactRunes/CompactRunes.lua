local _G = getfenv(0)
local ADDON_NAME, addon = ...

-- Local versions for performance
local string = _G.string
local math = _G.math
local pairs = _G.pairs
local ipairs = _G.ipairs
local table = _G.table
local floor, ceil, min, max, abs = math.floor, math.ceil, math.min, math.max, math.abs
local tconcat, tinsert, tsort = table.concat, table.insert, table.sort
local wipe = _G.wipe
local tostring = _G.tostring
local tonumber = _G.tonumber
local GetTime = _G.GetTime
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellCharges = _G.GetSpellCharges
local UnitHealth = _G.UnitHealth
local GetTotemInfo = _G.GetTotemInfo

-- Use BfA+ version to search by name.
local UnitBuff = addon.UnitBuff
local UnitDebuff = addon.UnitDebuff

local CompactRunes = _G.LibStub("AceAddon-3.0"):NewAddon(addon.addonName, "AceConsole-3.0", "AceEvent-3.0","AceTimer-3.0")
local L = _G.LibStub("AceLocale-3.0"):GetLocale(addon.addonName, true)
local LDB = _G.LibStub("LibDataBroker-1.1")
local LibQTip = _G.LibStub("LibQTip-1.0")
local Icon = _G.LibStub("LibDBIcon-1.0")
local LSM = _G.LibStub:GetLibrary("LibSharedMedia-3.0")

-- Locals for spell data.
local SpellIds = addon.SpellIds
local SpellNames = addon.SpellNames
local SpellIcons = addon.SpellIcons

local MIN_UPDATE_TIME = addon.MIN_UPDATE_TIME

local round = addon.round
local FormatNumber = addon.FormatNumber

addon.Print = function(self, ...) return CompactRunes:Print(...) end

-- Define a simplistic class for combat statistics
local CombatStats = {}
CombatStats.__index = CombatStats

function CombatStats:new()
    local stats = {}
    _G.setmetatable(stats, CombatStats)
    stats:Reset()
    return stats
end

function CombatStats:Reset()
	self.rpSpent = 0
	self.rcProcs = 0
	self.ppProcs = 0
	self.reProcs = 0
	self.meProcs = 0
end

local HEXFMT = "|c%2x%2x%2x%2x"
local function chatColorCode(color)
	local a = 255
	local r = ceil(255 * color.r)
	local g = ceil(255 * color.g)
	local b = ceil(255 * color.b)
	return HEXFMT:format(a, r, g, b)
end

local RuneColor = nil
local RuneCooldownColor = nil
local RuneChatColor = nil
function CompactRunes:UpdateRuneColors()
	RuneColor = self.db.profile.RuneColors["DEFAULT"]
	RuneCooldownColor = self.db.profile.RuneCooldownColors["DEFAULT"]
	RuneChatColor = chatColorCode(self.db.profile.RuneColors["DEFAULT"])
end

-- Local definition of Bar
local Bar = addon.Bar

CompactRunes.blocks = {}
CompactRunes.cdbars = {}
CompactRunes.playerName = UnitName("player")
addon.isDK = false
CompactRunes.TotalStats = CombatStats:new()
CompactRunes.LastFightStats = CombatStats:new()
addon.currentSpec = ""
CompactRunes.currentProcs = {}
addon.tierCount = { ["T15 DPS"] = 0 }
CompactRunes.currentTarget = nil
CompactRunes.targetHostile = false
CompactRunes.targetMaxHealth = 0
CompactRunes.targetHealth = 0
CompactRunes.targetPercent = 0
CompactRunes.altRuneBkg = nil
CompactRunes.enabled = {}
addon.lastrp = 0

addon.depletedRunes = 0
local runeBars = {}
local runes = {
	[1] = {
		timer = 0,
		duration = 10,
		start = 0,
		type = 1,
		ready = true,
	},
	[2] = {
		timer = 0,
		duration = 10,
		start = 0,
		type = 1,
		ready = true,
	},
	[3] = {
		timer = 0,
		duration = 10,
		start = 0,
		type = 1,
		ready = true,
	},
	[4] = {
		timer = 0,
		duration = 10,
		start = 0,
		type = 1,
		ready = true,
	},
	[5] = {
		timer = 0,
		duration = 10,
		start = 0,
		type = 1,
		ready = true,
	},
	[6] = {
		timer = 0,
		duration = 10,
		start = 0,
		type = 1,
		ready = true,
	},
}

local runeOrderings = {
	["Right"] = { 1, 2, 3, 4, 5, 6 },
	["Down"] = { 1, 3, 5, 2, 4, 6 },
	["Left"] = { 2, 4, 6, 1, 3, 5 },
	["Up"] = { 5, 3, 1, 6, 4, 2 },
}

-- Spells which need to use the listed name and not the one from the API.
addon.SpecialSpellNames = {
	["Festering Wound < 5"] = true,
	["Bone Shield <= 6"] = true,
}

-- Procs: Abilities with cooldowns
CompactRunes.AbilityProcsList = {
	["Frost"] = {
		["Breath of Sindragosa"] = true,
		["Empower Rune Weapon"] = true,
		["Glacial Advance"] = true,
		["Horn of Winter"] = true,
		["Obliteration"] = true,
		["Pillar of Frost"] = true,
	},
	["Unholy"] = {
		["Summon Gargoyle"] = true,
		["Dark Transformation"] = true,
		["Apocalypse"] = true,
		["Death and Decay"] = true,
	},
	["Blood"] = {
		["Blood Boil"] = true,
		["Rune Strike"] = true,
		["Death and Decay"] = true,
		["Consumption"] = true,
		["Blooddrinker"] = true,
	},
	["All"] = {
		--["Defile"] = true,
	},
}
CompactRunes.AbilityProcs = {}

CompactRunes.HasRuneCD = {
	["All"] = {
		["Death and Decay"] = true,
		["Defile"] = true,
		["Outbreak"] = true,
		["Army of the Dead"] = true,
		["Asphyxiate"] = true,
		["Asphyxiate (Blood)"] = true,
		["Consumption"] = true,
		["Blooddrinker"] = true,
	}
}
addon.IgnoreRuneCDs = {}

local ItemIds = {
	["Scabbard of Kyanos"] = 118882,
	["Pol's Blinded Eye"] = 113834,
	["Vial of Convulsive Shadows"] = 113969,
	["Tablet of Turnbuckle Teamwork"] = 113905,
	["Sanctus, Sigil of the Unbroken"] = 124637,
	["Thorasus, the Stone Heart of Draenor"] = 124634,
	["Ravaged Seed Pod"] = 139320,
	["Shard of Rokmora"] = 137338,
	["Coagulated Nightwell Residue"] = 137400,
	["Unbridled Fury"] = 139327,
	["Orb of Torment"] = 137538,
	["Giant Ornamental Pearl"] = 137369,
	["Talisman of the Cragshaper"] = 137344,
	["Shivermaw's Jawbone"] = 137440,
	["Wriggling Sinew"] = 139326,
	["Faulty Countermeasure"] = 137539,
	["Gift of Radiance"] = 133647,
	["Horn of Valor"] = 133642,
	["Tiny Oozeling in a Jar"] = 137439,
	["Windscar Whetstone"] = 137486,
	["Kil'jaeden's Burning Wish"] = 144259,
	["Diima's Glacial Aegis"] = 151977,
  ["Jes' Howler"] = 159627,
}
local ItemNames = {}
local ItemIcons = {}
local ReverseItemNames = {}
_G.setmetatable(ItemNames, LookupOrKeyMT)
local function LoadItemNames()
	for k, v in pairs(ItemIds) do
		local name = _G.GetItemInfo(v)
		local icon = _G.GetItemIcon(v)
		ItemNames[k] = name
		ItemIcons[k] = icon
		if name then
			ReverseItemNames[name] = k
		end
	end
end
LoadItemNames()
addon.ItemIds = ItemIds
addon.ItemNames = ItemNames
addon.ItemIcons = ItemIcons
addon.ReverseItemNames = ReverseItemNames

local SpellTypes = {
	["Anti-Magic Zone"] = "talent",
	["Defile"] = "talent",
	["Dark Arbiter"] = "talent",
	["Hungering Rune Weapon"] = "talent",
}
local SpellOverridenByTalent = {
	["Summon Gargoyle"] = "Dark Arbiter",
	["Death and Decay"] = "Defile",
	["Empower Rune Weapon"] = "Hungering Rune Weapon",
}

addon.DynamicSpells = {
	["Summon Gargoyle"] = true,
	["Death and Decay"] = true,
	["Empower Rune Weapon"] = true,
}

function addon.IsSpellKnown(name)
	local type = SpellTypes[name]
	local overrideTalent = SpellOverridenByTalent[name]
	if overrideTalent and addon.HasActiveTalent(overrideTalent) then
		return false, overrideTalent
	end
	if type and type == "talent" then
		return addon.HasActiveTalent(name)
	else
		--CompactRunes:Print("ISK: ".._G.tostring(name).." - ".._G.tostring(SpellIds[name]) .. ", ".._G.tostring(_G.IsSpellKnown(SpellIds[name])))
		return _G.IsSpellKnown(SpellIds[name])
	end
end

local ItemProcs = {
	--[[
	["Brutal Talisman of the Shado-Pan Assault"] = {
		proc = "Surge of Strength",
		procIds = { 138702 },
		icd = 85,
	},
]]--
}
addon.ItemProcs = ItemProcs

local Broker = _G.CreateFrame("Frame")
Broker.obj = LDB:NewDataObject(addon.addonTitle, {
	type = "data source",
	icon = "Interface\\Icons\\Spell_DeathKnight_RuneTap",
	label = addon.addonTitle,
	text = addon.addonTitle,
	barValue = 0,
	barR = 0,
	barG = 0,
	barB = 1,
	OnClick = function(clickedframe, button)
		if button == "RightButton" then
			local optionsFrame = _G.InterfaceOptionsFrame

			if optionsFrame:IsVisible() then
				optionsFrame:Hide()
			else
				CompactRunes:ShowOptions()
			end
		elseif button == "LeftButton" and _G.IsShiftKeyDown() then
			CompactRunes.TotalStats:Reset()
			CompactRunes.LastFightStats:Reset()
			addon:FireCallback("ResetStats")
		end
	end
} )

local GREEN = "|cff00ff00"
local YELLOW = "|cffffff00"
local BLUE = "|cff0198e1"
local ORANGE = "|cffff9933"

local addonHdr = GREEN.."%s %s"
local totalDataHdr = ORANGE..L["Session"]
local lastFightValueHdr = ORANGE..L["Last Fight"]
local numberStringFmt = "%d (%s%s)"

local valuePlusPercent = addon.valuePlusPercent

local function AddStats(tooltip, statstype)
	local stats
	if statstype == "LastFight" then
		stats = CompactRunes.LastFightStats
	else
		stats = CompactRunes.TotalStats
	end

	tooltip:AddSeparator(1)

	local base, unit = addon.FormatNumberWithPrecision(stats.rpSpent, 1)
	if addon.currentSpec == "Unholy" then
		tooltip:AddLine(L["Runic Corruption Procs"],
			numberStringFmt:format(stats.rcProcs, base or 0, unit or ""))
		tooltip:AddLine(L["Pestilent Pustules Procs"],
			valuePlusPercent(stats.ppProcs, 0))
	elseif addon.currentSpec == "Frost" then
		tooltip:AddLine(L["Runic Empowerment Procs"],
			numberStringFmt:format(stats.reProcs, base or 0, unit or ""))
		tooltip:AddLine(SpellNames["Murderous Efficiency"],
			valuePlusPercent(stats.meProcs, 0))
	end

	for name, obj in pairs(addon.modules) do
		if obj and obj.AddStats then
			obj:AddStats(tooltip, statstype)
		end
	end
end

function Broker.obj:OnEnter()
	local tooltip = LibQTip:Acquire("CompactRunesTooltip", 2, "LEFT", "RIGHT")
	self.tooltip = tooltip

	tooltip:AddHeader(addonHdr:format(addon.addonTitle, addon.addonVersion))
	tooltip:AddLine()

	if CompactRunes.isDK then
		tooltip:AddLine(L["Shift + Left-Click to reset"], "", 1, 1, 1)
		tooltip:AddLine()

		tooltip:AddLine(totalDataHdr)
		AddStats(tooltip, "Session")

		tooltip:AddLine()
		tooltip:AddLine(lastFightValueHdr)
		AddStats(tooltip, "LastFight")
	end

	tooltip:SmartAnchorTo(self)
	tooltip:Show()
end

function Broker.obj:OnLeave()
	LibQTip:Release(self.tooltip)
	self.tooltip = nil
end

local frames = {}
addon.frames = frames

CompactRunes.PriorityListDefaults = {
	["Blood"] = {
		"Bone Shield <= 6",
		"Crimson Scourge",
		"Rune Strike",
		"Blood Boil",
		"Death and Decay",
		"Consumption",
		"Blooddrinker",
	},
	["Frost"] = {
		"Killing Machine",
		"Freezing Fog",
		"Dark Succor",
		"Empower Rune Weapon",
		"Breath of Sindragosa",
		"Obliteration",
		"Glacial Advance",
		"Pillar of Frost",
		"Horn of Winter",
	},
	["Unholy"] = {
		"Raise Dead",
		"Sudden Doom",
		"Summon Gargoyle",
		"Dark Transformation",
		"Dark Succor",
		"Necrosis Buff",
		"Festering Wound < 5",
		"Apocalypse",
		"Death and Decay",
	},
}

CompactRunes.DefaultCDBarOrderings = {
	["Blood"] = {
		"Rune Tap",
		"Rune Strike",
		"Icebound Fortitude",
		"Vampiric Blood",
		"Anti-Magic Shell",
		"Dancing Rune Weapon",
		"Death and Decay",
		"Gorefiend's Grasp",
		"Death's Caress",
		"Consumption",
		"Blooddrinker",
		"Blood Mirror",
		"Bonestorm",
		"Mark of Blood",
		"Tombstone",
		"Mind Freeze",
		"Asphyxiate (Blood)",
		"Wraith Walk",
    "Jes' Howler",
	},
	["Frost"] = {
		"Pillar of Frost",
		"Glacial Advance",
		"Obliteration",
		"Horn of Winter",
		"Anti-Magic Shell",
		"Hungering Rune Weapon",
		"Empower Rune Weapon",
		"Remorseless Winter",
		"Breath of Sindragosa",
		"Sindragosa's Fury",
		"Mind Freeze",
		"Icebound Fortitude",
		"Wraith Walk",
		"Blinding Sleet",
		"Kil'jaeden's Burning Wish",
    "Jes' Howler",
	},
	["Unholy"] = {
		"Summon Gargoyle",
		"Dark Arbiter",
		"Dark Transformation",
		"Apocalypse",
		"Anti-Magic Shell",
		"Outbreak",
		"Army of the Dead",
		"Death and Decay",
		"Defile",
		"Mind Freeze",
		"Asphyxiate",
		"Corpse Shield",
		"Blighted Rune Weapon",
		"Soul Reaper",
		"Icebound Fortitude",
		"Wraith Walk",
		"Kil'jaeden's Burning Wish",
    "Jes' Howler",
	},
}

-- These procs are handled differently.
CompactRunes.specialProcs = {
	["Apocalypse"] = true,
	["Blood Boil"] = true,
	["Rune Strike"] = true,
	["Breath of Sindragosa"] = true,
	["Dark Arbiter"] = true,
	["Dark Transformation"] = true,
	["Death and Decay"] = true,
	["Defile"] = true,
	["Festering Wound < 5"] = true,
	["Bone Shield <= 6"] = true,
	["Glacial Advance"] = true,
	["Horn of Winter"] = true,
	["Obliteration"] = true,
	["Pillar of Frost"] = true,
	["Raise Dead"] = true,
	["Summon Gargoyle"] = true,
}

CompactRunes.regenAbilities = {}
CompactRunes.regenAbilitiesBySpec = {
	["Blood"] = {},
	["Unholy"] = {
		[SpellIds["Death Coil"]] = 30,
		[SpellIds["Death Coil Damage"]] = true,
		[SpellIds["Death Strike"]] = true,
	},
	["Frost"] = {
		[SpellIds["Frost Strike MH Damage"]] = true,
		[SpellIds["Death Strike"]] = true,
	},
}

function CompactRunes:MergeLists(list, settings, defaults)
	local uniques = {}
	local added = {}
	for i, v in ipairs(defaults) do
		uniques[v] = true
	end
	if settings then
		for i, v in ipairs(settings) do
			if v and uniques[v] and not added[v] then
				tinsert(list, v)
				added[v] = true
			end
		end
	end
	for i, v in ipairs(defaults) do
		if v and not added[v] then
			tinsert(list, v)
			added[v] = true
		end
	end
end

function CompactRunes:UpdatePriorityListSettings()
	for spec, list in pairs(self.PriorityListDefaults) do
		local list = {}
		self:MergeLists(
			list,
			self.db.profile.priorityList[spec],
			self.PriorityListDefaults[spec])
		self.db.profile.priorityList[spec] = list
	end
end

function CompactRunes:UpdateCDBarOrderings()
	for spec, list in pairs(self.DefaultCDBarOrderings) do
		local list = {}
		self:MergeLists(
			list,
			self.db.profile.cdbars[spec].ordering,
			self.DefaultCDBarOrderings[spec])
		self.db.profile.cdbars[spec].ordering = list
	end
end

function CompactRunes:MigrateSettings()
	local version = self.db.profile.profileVersion
	if version and version < 2 then
		for spec, list in pairs(self.db.profile.priorityList) do
			self.db.profile.priorityList[spec] = {}
		end
	end
	self.db.profile.profileVersion = 2

	if self.db.profile.runeRechargeNums ~= nil then
		if self.db.profile.runeRechargeNums then
			self.db.profile.rechargeTimers = "All"
		end
		self.db.profile.runeRechargeNums = nil
	end
	if self.db.profile.width ~= nil then
		self.db.profile.dimensions["HORIZONTAL"].width = self.db.profile.width
		self.db.profile.width = nil
	end
	if self.db.profile.height ~= nil then
		self.db.profile.dimensions["HORIZONTAL"].height = self.db.profile.height
		self.db.profile.height = nil
	end
	if self.db.profile.spacing ~= nil then
		self.db.profile.dimensions["HORIZONTAL"].spacing = self.db.profile.spacing
		self.db.profile.spacing = nil
	end
	if self.db.profile.runes and self.db.profile.runes.inset ~= nil then
		self.db.profile.runes.inset = nil
		self.db.profile.runes = nil
	end
	if self.db.profile.bars.DarkTransformationBar and
		self.db.profile.bars.DarkTransformationBar.shadowInfusion ~= nil then
		if self.db.profile.bars.DarkTransformationBar.shadowInfusion == false then
			self.db.profile.bars.DarkTransformationBar.showCooldown = "Never"
		end
		self.db.profile.bars.DarkTransformationBar.shadowInfusion = nil
	end
end

function CompactRunes:ResetPriorityList(spec)
	self.db.profile.priorityList[spec] = {}
	self:UpdatePriorityList(spec)
end

function CompactRunes:RemoveDefaults()
	for spec, list in pairs(self.PriorityListDefaults) do
		local matches = true
		local profile = self.db.profile.priorityList[spec]
		for i, v in ipairs(list) do
			if not (v and profile[i] and profile[i] == v) then
				matches = false
			end
		end
		if matches then
			self.db.profile.priorityList[spec] = {}
		end
	end
end

function CompactRunes:SetRuneBackground()
	local setting = self.db.profile.runeBackground

	if setting == nil or tonumber(setting) == nil or setting < 1 or setting > 3 then
		self.db.profile.runeBackground = 1
		setting = 1
	end

	if setting == 3 then
		self.altRuneBkg = self.db.profile.runeBackgrounds.black
	else
		self.altRuneBkg = self.db.profile.runeBackgrounds.transparent
	end
end

function CompactRunes:OnInitialize()
	self:CheckClass()
	if not addon.isDK then return end

	-- Load the settings
	self.db = _G.LibStub("AceDB-3.0"):New(
		"CompactRunesDB", addon.defaults, "Default")
	addon.db = self.db
	addon.profile = self.db.profile

	self:MigrateSettings()
	self:UpdateRuneColors()
	self:UpdatePriorityListSettings()
	self:UpdateCDBarOrderings()

	-- Register for profile callbacks
	self.db.RegisterCallback(self, "OnProfileChanged", "OnProfileChange")
	self.db.RegisterCallback(self, "OnProfileCopied", "OnProfileChange")
	self.db.RegisterCallback(self, "OnProfileReset", "OnProfileChange")
	self.db.RegisterCallback(self, "OnProfileShutdown", "RemoveDefaults")
	self.db.RegisterCallback(self, "OnDatabaseShutdown", "RemoveDefaults")

	LSM:Register("statusbar", "Compact Runes",
		[[Interface\Addons\CompactRunes\CompactRunes]])
	LSM:Register("border", "Compact Runes",
		[[Interface\Addons\CompactRunes\CompactRunesBorder]])
	LSM:Register("border", "Compact Runes Bright",
		[[Interface\Addons\CompactRunes\CompactRunesBrightBorder]])

	Icon:Register("CompactRunesLDB", Broker.obj, self.db.profile.minimap)
	LSM.RegisterCallback(CompactRunes, "LibSharedMedia_Registered")

	for name, obj in pairs(addon.modules) do
		if obj and obj.OnInitialize then
			obj:OnInitialize()
		end
	end
end

function CompactRunes:OnProfileChange()
	addon.db = self.db
	addon.profile = self.db.profile
	self:MigrateSettings()
	self:UpdateRuneColors()
	self:UpdatePriorityListSettings()
	self:UpdateCDBarOrderings()
	self:Reset()
	self:UpdateCDBars()
	addon:FireCallback("ProfileUpdate")
end

function CompactRunes:Reset()
	--self:ResetFonts()
	--self:UpdateTextures()

	self:SetMainFrameBorder()
	local main = frames.main
	if main then
		main:UpdateProfile()
		main:SetWidth(main.GetDesiredWidth())
		main:SetHeight(main.GetDesiredHeight())
		if main.SetDesiredPoint then
			main:SetDesiredPoint()
		end
	end

	self:UpdateRuneColors()
	self:SetRuneBackground()

	for k, v in pairs(addon.bars) do
		if v then
			v.db = self.db.profile.bars[v.name]
			v:Reset()
		end
	end

	self:SetRuneOrder(self.db.profile.runeOrder)

	local procInd = frames.procInd
	if procInd then
		procInd.ResetFonts()
		procInd:SetWidth(procInd:GetDesiredWidth())
		procInd:SetHeight(procInd:GetDesiredHeight())
		procInd:SetDesiredPoint()
	end
end

function CompactRunes:LibSharedMedia_Registered(event, mediatype, key)
	if _G.strlen(self.db.profile.font_face) > 1 and mediatype == "font" then
		if self.db.profile.font_face == key then
			self:ResetFonts()
		end
	end
	if mediatype == "statusbar" then
	    self:UpdateTextures()
	end
end

function CompactRunes:ResetFonts()
	for k, v in pairs(addon.bars) do
		if v then
			v:ResetFonts()
		end
	end

	if frames.procInd then
		frames.procInd.ResetFonts()
	end
end

function CompactRunes:UpdateTextures()
	for k, v in pairs(addon.bars) do
		if v then
			v:UpdateTexture()
		end
	end
end

local function splitWords(str)
  local w = {}
  local function helper(word) table.insert(w, word) return nil end
  str:gsub("(%w+)", helper)
  return w
end

function CompactRunes:ChatCommand(input)
	if not input or input:trim() == "" then
		self:ShowOptions()
	else
		local cmds = splitWords(input)
		if cmds[1] and cmds[1] == "debug" then
			if cmds[2] and cmds[2] == "on" then
				self.db.profile.debug = true
				self:Print("Debugging on.  Use '/crunes debug off' to disable.")
			elseif cmds[2] and cmds[2] == "off" then
				self.db.profile.debug = false
				self:Print("Debugging off.")
			else
				self:Print("Debugging is "..(self.db.profile.debug and "on." or "off."))
			end
		end
	end
end

function CompactRunes:OnEnable()
	if not addon.isDK then return end

	self:CheckTalents()
	self:SetRuneBackground()
	self:Load()
	self:CheckGear()
	addon:LoadSpellNames()
	LoadItemNames()
	addon.SetupSpellAuras()
	addon:HideBlizzardFrames()

	if not self.optionsFrame then
		-- Register Options
		local displayName = addon.addonTitle
		self:GetOptions()
		_G.LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(
			displayName, addon.options)

		self.optionsFrame = {}
		local ACD = _G.LibStub("AceConfigDialog-3.0")
		self.optionsFrame.Main = ACD:AddToBlizOptions(
			displayName, displayName, nil, "core")
		self.optionsFrame.Layout = ACD:AddToBlizOptions(
			displayName, L["Layout"], displayName, "layout")
		self.optionsFrame.Colors = ACD:AddToBlizOptions(
			displayName, L["Colors"], displayName, "colors")
		self.optionsFrame.Procs = ACD:AddToBlizOptions(
			displayName, L["Procs"], displayName, "procs")
		self.optionsFrame.Sounds = ACD:AddToBlizOptions(
			displayName, L["Sounds"], displayName, "sounds")
		--self.optionsFrame.IgnoreRunes = ACD:AddToBlizOptions(
		--	displayName, L["Ignore Rune CDs"], displayName, "ignoreRunes")
		self.optionsFrame.CDBars = ACD:AddToBlizOptions(
			displayName, L["Cooldown Bars"], displayName, "cooldowns")

		-- Add options for modules
		for name, obj in pairs(addon.modules) do
			if obj and obj.AddOptions then
				local name, sectionName, tableName = obj.AddOptions()
				self.optionsFrame[name] = ACD:AddToBlizOptions(
					displayName, sectionName, displayName, tableName)
			end
		end

		ACD:AddToBlizOptions(
			displayName, addon.options.args.profile.name, displayName, "profile")
		-- Register the chat command
		self:RegisterChatCommand("cr", "ChatCommand")
		self:RegisterChatCommand("crunes", "ChatCommand")
		self:RegisterChatCommand("compactrunes", "ChatCommand")
	end

	for name, obj in pairs(addon.modules) do
		if obj and obj.Enable then
			obj:Enable()
		end
	end
end

local function HideBlizzardFrame(frame)
	if frame and frame.Hide and _G.type(frame.Hide) == "function" then
		frame:Hide()
		if frame.HookScript and _G.type(frame.HookScript) == "function" then
			frame:HookScript("OnShow", function(self) self:Hide() end)
		end
	end
end

function addon:HideBlizzardFrames()
	if not addon.db.profile.hideBlizzardFrames then return end
	-- Securely and safely hide and then hook the OnShow to hide itself.
	-- It should last until the UI is reloaded.

	-- Should still hide the runes below the player unit frame.
	HideBlizzardFrame(_G.RuneFrame)

	-- Hide the player resource display
	_G.SetCVar("nameplateShowSelf", "0", true)
end

local WatchedEvents = {
	"RUNE_POWER_UPDATE",
	"PLAYER_REGEN_DISABLED",
	"PLAYER_REGEN_ENABLED",
	"PLAYER_TARGET_CHANGED",
	"PLAYER_TALENT_UPDATE",
	"PLAYER_SPECIALIZATION_CHANGED",
	"COMBAT_LOG_EVENT_UNFILTERED",
	"PLAYER_ENTERING_WORLD",
	"UNIT_LEVEL",
	"SPELL_UPDATE_COOLDOWN",
	"PLAYER_EQUIPMENT_CHANGED",
	"PLAYER_ALIVE",
	"PLAYER_DEAD",
	"COMPANION_UPDATE",
	"PET_BATTLE_OPENING_START",
	"PET_BATTLE_CLOSE",
}

local UnitEvents = {
	["player"] = {
		"UNIT_POWER_FREQUENT",
		"UNIT_MAXPOWER",
		"UNIT_AURA",
		"UNIT_PET",
		"UNIT_ENTERED_VEHICLE",
		"UNIT_EXITED_VEHICLE",
	},
	["target"] = {
		"UNIT_HEALTH",
		"UNIT_MAXHEALTH",
		"UNIT_AURA",
	},
	["pet"] = {
		"UNIT_AURA",
	},
}
local function EventFrame_OnEvent(frame, event, ...)
	if event == "UNIT_ATTACK_POWER" then
		CompactRunes:UNIT_ATTACK_POWER(event, ...)
	elseif event == "UNIT_STATS" then
		CompactRunes:UNIT_STATS(event, ...)
	elseif event == "UNIT_POWER_FREQUENT" then
		CompactRunes:UNIT_POWER_FREQUENT(event, ...)
	elseif event == "UNIT_MAXPOWER" then
		CompactRunes:UNIT_MAXPOWER(event, ...)
	elseif event == "UNIT_HEALTH" then
		CompactRunes:UNIT_HEALTH(event, ...)
	elseif event == "UNIT_MAXHEALTH" then
		CompactRunes:UNIT_MAXHEALTH(event, ...)
	elseif event == "UNIT_AURA" then
		CompactRunes:UNIT_AURA(event, ...)
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		CompactRunes:UNIT_SPELLCAST_SUCCEEDED(event, ...)
	elseif event == "UNIT_PET" then
		CompactRunes:UNIT_PET(event, ...)
	elseif event == "PLAYER_ALIVE" then
		CompactRunes:PLAYER_ALIVE(event, ...)
	elseif event == "PLAYER_DEAD" then
		CompactRunes:PLAYER_DEAD(event, ...)
	elseif event == "UNIT_ENTERED_VEHICLE" then
		CompactRunes:UNIT_ENTERED_VEHICLE(event, ...)
	elseif event == "UNIT_EXITED_VEHICLE" then
		CompactRunes:UNIT_EXITED_VEHICLE(event, ...)
	elseif event == "PLAYER_TOTEM_UPDATE" then
		CompactRunes:PLAYER_TOTEM_UPDATE(event, ...)
	elseif event == "COMPANION_UPDATE" then
		CompactRunes:COMPANION_UPDATE(event, ...)
	elseif event == "PET_BATTLE_OPENING_START" then
		CompactRunes:PET_BATTLE_OPENING_START(event, ...)
	elseif event == "PET_BATTLE_CLOSE" then
		CompactRunes:PET_BATTLE_CLOSE(event, ...)

	end
end
local EventFrames = {}
for unit, events in pairs(UnitEvents) do
	local frame = _G.CreateFrame("Frame", ADDON_NAME.."_EventFrame_"..unit)
	frame:SetScript("OnEvent", EventFrame_OnEvent)
	EventFrames[unit] = frame
end

function CompactRunes:Load()
	if addon.isDK then
		self:CreateDisplay()
		frames.powerBar:UpdateDisplay()
		for i = 1, #WatchedEvents do
			self:RegisterEvent(WatchedEvents[i])
		end
		for unit, events in pairs(UnitEvents) do
			local eventFrame = EventFrames[unit]
			if eventFrame then
				for i, event in ipairs(events) do
					eventFrame:RegisterUnitEvent(event, unit)
				end
			else
				self:Print("Missing event frame for "..tostring(unit).."!")
			end
		end
	end
end

function CompactRunes:Unload()
end

function CompactRunes:OnDisable()
	for i = 1, #WatchedEvents do
		self:UnregisterEvent(WatchedEvents[i])
	end
	for unit, events in pairs(UnitEvents) do
		local eventFrame = EventFrames[unit]
		if eventFrame then
			for i, event in ipairs(events) do
				eventFrame:UnregisterEvent(event, unit)
			end
		end
	end
	for name, obj in pairs(addon.modules) do
		if obj and obj.Disable then
			obj:Disable()
		end
	end
end

function CompactRunes:UpdateCDBars()
	if addon.isDK and addon.currentSpec and addon.currentSpec ~= "" then
		local enabled = self.db.profile.cdbars[addon.currentSpec].enabled
		local bar = self.cdbars[addon.currentSpec]
		if enabled and not bar then
			bar = addon.CooldownBar:Create(addon.currentSpec)
			self.cdbars[addon.currentSpec] = bar
		end
		for k, v in pairs(self.cdbars) do
			if k == addon.currentSpec and enabled then
				v:Enable()
			elseif v and v.Disable then
				v:Disable()
			end
		end
	end
end

function CompactRunes:UpdateAbilityProcsList()
	wipe(self.AbilityProcs)
	for spec, list in pairs(self.AbilityProcsList) do
		if spec == addon.currentSpec or spec == "All" then
			for spell, flag in pairs(list) do
				local known, override = addon.IsSpellKnown(spell)
				if override then
					self.AbilityProcs[override] = flag
				else
					self.AbilityProcs[spell] = flag and known or false
				end
			end
		end
	end
end

function CompactRunes:UpdateRuneCDs()
	wipe(addon.IgnoreRuneCDs)
	for spec, list in pairs(self.HasRuneCD) do
		if spec == addon.currentSpec or spec == "All" then
			for spell, flag in pairs(list) do
				local known, override = addon.IsSpellKnown(spell)
				if known then
					local base = _G.GetSpellBaseCooldown(SpellIds[spell])
					if base and base > 0 then
						local grace = ceil(base / 1000 / 3)
						if grace > 2 then
							addon.IgnoreRuneCDs[spell] = grace
						end
					end
				end
			end
		end
	end
end

function CompactRunes:CheckClass()
	addon.isDK = false
	local class, className = _G.UnitClass("player")
	if className and (className == 'DEATH KNIGHT' or className == 'DEATHKNIGHT') then
		addon.isDK = true
	end
end

function CompactRunes:UpdateBarsForTalents()
	for name, bar in pairs(addon.bars) do
		if bar and bar.OnTalentUpdate and type(bar.OnTalentUpdate) == "function" then
			bar:OnTalentUpdate()
		end
	end
end

function CompactRunes:CheckTalents()
	self:CheckClass()

	if addon.isDK then
		local activeSpecNum = _G.GetSpecialization()
		if activeSpecNum and activeSpecNum > 0 then
			local id, name, desc, texture = _G.GetSpecializationInfo(activeSpecNum)
	    	if id == 250 then
				addon.currentSpec = "Blood"
			elseif id == 251 then
				addon.currentSpec = "Frost"
			elseif id == 252 then
				addon.currentSpec = "Unholy"
			else
				if addon.db.profile.debug then
					local fmt = "Could not detect player spec. [%s,%s,%s,%s]"
					self:Print(fmt:format(_G.tostring(activeSpecNum), _G.tostring(id),
						_G.tostring(name), _G.tostring(texture)))
				end
				addon.currentSpec = addon.currentSpec or "Blood"
			end
		end
		addon.Talents = addon.TalentsBySpec[addon.currentSpec] or {}
	end

	self:CheckSpells()
	self:UpdateBarsForTalents()
	self:UpdateBarLayout()

	for spell, enabled in pairs(addon.DynamicSpells) do
		local name, _, icon = _G.GetSpellInfo(spell)
		if icon then SpellIcons[spell] = icon end
	end
	self:UpdateCDBars()
	self:UpdateAbilityProcsList()
	self:UpdateRuneCDs()
	self:CheckForPets()
	for k, v in pairs(self.currentProcs) do
		if k and v and not addon.IsSpellKnown(k) then
			self.currentProcs[k] = nil
		end
	end
	if frames.powerBar then
		frames.powerBar:UpdateDisplay()
	end

	addon:FireCallback("TalentUpdate")

	if self.db.profile.debug then
		local fmt = "CheckTalents [isDK=%s,spec=%s]"
		self:Print(
			fmt:format(tostring(addon.isDK), addon.currentSpec))
	end
end

function CompactRunes:CheckSpells()
end

local function onUpdateRune(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.showing.timer = self.showing.timer + elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		local profile = CompactRunes.db.profile
		self:SetValue(self.showing.timer)

		local remain = self.showing.duration - self.showing.timer
		if remain >= 0 then
			local almostReadyTime = profile.almostReadyTime
			if almostReadyTime > 0 and almostReadyTime >= remain then
				self:SetAlpha(profile.almostReadyAlpha)
			end
			if profile.rechargeTimers ~= "None" then
				if self.showing.start > 0 and
					(self.status ~= "depleted" or profile.rechargeTimers == "All") then
					self.value:SetText(tostring(round(remain)))
				else
					self.value:SetText("")
				end
			end
		else
			self:SetScript("OnUpdate", nil)
		end
	end
end

local function onUpdateDisease(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
			end

			self:Show()
			self:SetValue(self.timer)
			self.value:SetText(tostring(round(self.timer)))
		else
			self.value:SetText("0")
			self:Hide()
			self:SetScript("OnUpdate", nil)
		end
	end
end

local function onUpdateTimerWithCounter(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
				self:SetScript("OnUpdate", nil)
				self:Hide()
			else
				self:Show()
				self:SetValue(self.timer)
				--if self.hasCounter then
				self.value:SetText(tostring(round(self.timer)))
				--end
			end
		else
			self:Hide()
		end
	end
end

local function onUpdateTimerWithSecondaryCounter(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
				self:SetScript("OnUpdate", nil)
				self:Hide()
			else
				self:Show()
				self:SetValue(self.timer)
				--if self.hasCounter then
				self.secondaryValue:SetText(tostring(round(self.timer)))
				--end
			end
		else
			self:Hide()
		end
	end
end

local function onUpdateBoneShield(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= 0.1 then
		if self.active then
			local profile = addon.db.profile.bars["BoneShieldBar"]
			if self.timer > 0 then
				self:Show()
				if profile.progress == "Time" then
					self:SetValue(self.timer)
				elseif profile.progress == "Charges" then
					self:SetValue(self.count)
				end
			else
				self.timer = 0
				self.active = false
				self:SetScript("OnUpdate", nil)
				self:Hide()
			end
		else
			self:Hide()
		end
		self.lastUpdate = 0
	end
end

local RangeSpells = {
	["Blood"] = SpellNames["Death Strike"],
	["Frost"] = SpellNames["Frost Strike"],
	["Unholy"] = SpellNames["Scourge Strike"],
}
local function onUpdateInd(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		local outOfRange = false
		if _G.UnitExists("target") and not _G.UnitIsDead("target") and
			_G.UnitCanAttack("player", "target") then
			if _G.IsSpellInRange(RangeSpells[addon.currentSpec], "target") == 0 then
				outOfRange = true
			end
		end

		if outOfRange ~= self.outOfRange then
			self.outOfRange = outOfRange
			self:UpdateInd()
		end

		self.lastUpdate = 0
	end
end

local function onUpdateIconTimer(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
				self:SetScript("OnUpdate", nil)
				self:SetDesiredAlpha()
			else
				--self:SetValue(self.timer)
				self.value:SetText(tostring(round(self.timer)))
			end
		else
			self:SetDesiredAlpha()
		end
	end
end

local function onUpdateTimerNoCounter(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
				self:SetScript("OnUpdate", nil)
				self:Hide()
			else
				self:Show()
				self:SetValue(self.timer)
			end
		else
			self:Hide()
		end
	end
end

local function onUpdateIncreasingTimerNoCounter(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer + elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer > self.duration then
				self.timer = 0
				self.active = false
				self:SetScript("OnUpdate", nil)
				self:Hide()
			else
				self:Show()
				self:SetValue(self.timer)
			end
		else
			self.timer = 0
			self.active = false
			self:Hide()
		end
	end
end

local fontFlags = {}
function CompactRunes:GetFontSettings()
	wipe(fontFlags)
	for k, v in pairs(addon.db.profile.fontFlags) do
		if v then tinsert(fontFlags, k) end
	end
	local font = LSM:Fetch("font", addon.db.profile.font_face)
	return font, addon.db.profile.font_size, tconcat(fontFlags, ",")
end
addon.GetFontSettings = CompactRunes.GetFontSettings

function CompactRunes:SetRuneOrder()
	for i = 1, addon.NUMBER_RUNES do
		local barNum = i
		local runeBar = runeBars[barNum]
		if runeBar then
			local bar = runeBar.bar
			bar:ClearAllPoints()
			local inset = addon.GetRuneInset()
			if self.db.profile.runeOrientation == "VERTICAL" then
				bar:SetPoint("BOTTOMLEFT", frames.main, "BOTTOMLEFT",
					3 + -1 * (1 - inset - (addon.GetRuneWidth() +
					 addon.GetRuneSpacing()) * (ceil(i / 2) - 1)),
					2 + inset + (addon.GetRuneHeight() +
					 addon.GetRuneSpacing()) * ((i - 1) % 2))
			else
				bar:SetPoint("TOPLEFT", frames.main, "TOPLEFT",
					2 + inset + (addon.GetRuneWidth() +
					 addon.GetRuneSpacing()) * ((i - 1) % 2),
					- 2 - inset - (addon.GetRuneHeight() +
					 addon.GetRuneSpacing()) * (ceil(i / 2) - 1))
			end
		end
	end
end

function CompactRunes:ShowRechargeNumbers(value)
	for k, v in pairs(addon.bars) do
		if v and v.isRuneBar and v.bar and v.bar.value then
			if value ~= "None" then
				v.bar.value:Show()
			else
				v.bar.value:Hide()
			end
		end
	end
end

function CompactRunes:UpdateTargetMaxHealth()
	self.targetMaxHealth = _G.UnitHealthMax("target") or 0
	self:UpdateTargetHealth()
end

function CompactRunes:UpdateTargetHealth()
	self.targeHealth = UnitHealth("target") or 0
	self.targetPercent = self.targetMaxHealth > 0 and
		self.targeHealth / self.targetMaxHealth or 0
end

function CompactRunes:OrderRunes()
	local newOrder = {}
	for i = 1, #runes do
		newOrder[i] = i
	end
	tsort(newOrder, function(a,b)
		local vala = runes[a].ready and 0 or runes[a].duration - runes[a].timer
		local valb = runes[b].ready and 0 or runes[b].duration - runes[b].timer
		return vala == valb and (a < b) or (vala < valb)
	end)
	return newOrder
end

function CompactRunes:UpdateRuneStatus(runeIndex, barIndex)
	local profile = self.db.profile
	local runeBar = runeBars[barIndex]
	local rune = runes[runeIndex]

	-- if barIndex == 1 then
	-- 	local fmt = "Rune %d -> %d [%s,%s,%s]"
	-- 	self:Print(fmt:format(runeIndex, barIndex, _G.tostring(rune.ready), _G.tostring(rune.duration), _G.tostring(rune.timer)))
	-- end

	local rc, rcc
	runeBar.bar.showing = rune
	runeBar.bar.status = rune.ready and "ready" or "recharging"

	rc = RuneColor
	if profile.runeBackground == 1 then
		rcc = RuneCooldownColor
		rcc.a = profile.runeBackgroundAlpha or rcc.a
	else
		rcc = self.altRuneBkg
	end
	runeBar.bar:SetStatusBarColor(rc.r, rc.g, rc.b, 1)
	runeBar.bar.bg:SetVertexColor(rcc.r, rcc.g, rcc.b, rcc.a)

	runeBar.bar:SetMinMaxValues(0, rune.duration)
	runeBar.bar:SetValue(rune.timer)
	if rune.ready == false then
		runeBar.bar:SetScript("OnUpdate", onUpdateRune)
		runeBar.bar:SetAlpha(profile.rechargeAlpha)
	else
		runeBar.bar:SetScript("OnUpdate", nil)
		runeBar.bar:SetAlpha(1.0)
		if profile.rechargeTimers ~= "None" then
			runeBar.bar.value:SetText("")
		end
	end
end

function CompactRunes:UpdateRuneCooldown(index, isEnergized)
	local runeIndex = index
	-- if index > addon.NUMBER_RUNES and not addon.Legion then
	-- 	runeIndex = addon.NUMBER_RUNES
	-- end
	local profile = self.db.profile
	local start, duration, ready = _G.GetRuneCooldown(runeIndex)
	start = start or 0
	duration = duration or 0
	local rune = runes[runeIndex]
	if not rune then return end
	-- TODO: Deal with the energized runes.
	rune.ready = ready or isEnergized == true
	local time = GetTime()

	if profile.debug then
		local remain = start > 0 and (start + duration - time) or -10
		local fmt = "Rune CD [%s,%s,%s,%s,%s, %.1f]"
		self:Print(fmt:format(tostring(index), tostring(start),
			tostring(duration), tostring(ready), tostring(isEnergized), remain or -11))
	end

	rune.start = start
	if rune.ready == false then
		rune.duration = duration
		rune.timer = time - start
	else
		rune.timer = 10
		rune.duration = 10
	end

	-- Updated count of depleted runes
	local depleted = 0
	for i, v in ipairs(runes) do
		if v then
			if not v.ready then
				depleted = depleted + 1
			end
		end
	end
	addon.depletedRunes = depleted
	--local fmt = "Depleted: %s / %s"
	--self:Print(fmt:format(tostring(depleted)))

	if profile.sortRunes then
		local order = self:OrderRunes()
		for i, pos in ipairs(runeOrderings[profile.runeSortOrder]) do
			self:UpdateRuneStatus(order[i], pos)
		end
	else
		self:UpdateRuneStatus(index, index)
	end
end

function CompactRunes:UpdateRunes()
	for i = 1, addon.NUMBER_RUNES do
		self:UpdateRuneCooldown(i)
	end
end

function CompactRunes:CreateProcIndicator()
	local bar = _G.CreateFrame("Frame", "CompactRunes_Proc", frames.main)
	bar.db = self.db.profile
	frames.procInd = bar
	bar.currentProc = nil
	bar.procList = nil
	bar.SetDesiredAlpha = function(bar)
		local profile = addon.db.profile.procIcon.alphas
		bar:SetAlpha(_G.UnitAffectingCombat("player") and profile.combat or profile.ooc)
	end
	bar.SetDesiredPoint = function(bar)
		bar:ClearAllPoints()
		local profile = addon.db.profile
		local x, y = profile.procIcon.x, profile.procIcon.y
		if profile.procIcon.userPlaced and x ~= nil and y ~= nil then
	    	bar:SetPoint("CENTER", _G.UIParent, "CENTER", x, y)
		else
	    	bar:SetPoint("BOTTOM", frames.main, "TOP", 0,
				addon.GetRuneSpacing() * 7 + addon.GetBarHeight() + 2)
		end
	end
	bar:SetDesiredPoint()
	bar:SetScale(1)
	bar.GetDesiredHeight = function()
		local scale = addon.db.profile.procIcon.scale
		return ceil(scale*(frames.main:GetWidth()*frames.main:GetHeight()*0.233)^0.5)
	end
	bar.GetDesiredWidth = function()
		local scale = addon.db.profile.procIcon.scale
		return ceil(scale*(frames.main:GetWidth()*frames.main:GetHeight()*0.233)^0.5)
	end
	bar.SetDimensions = function(bar)
	    bar:SetWidth(bar:GetDesiredHeight())
	    bar:SetHeight(bar:GetDesiredWidth())
	end
	bar:SetDimensions()
	bar.texture = bar:CreateTexture(nil, "ARTWORK")
    bar.texture:SetAllPoints(bar)
    bar.texture:SetVertexColor(1, 1, 1)
	local font, fh, fflags = self:GetFontSettings()
    bar.value = bar:CreateFontString(nil, "OVERLAY")
    bar.value:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 0, -2)
    bar.value:SetFont(font, fh + 3, fflags)
    bar.value:SetJustifyH("CENTER")
	bar.value:SetJustifyV("CENTER")
    bar.value:SetShadowOffset(1, -1)
    local tc = bar.db.bars.ProcInd.textcolor
    bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
	bar.value:Hide()

	bar.ResetFonts = function()
		local font, fh, fontFlags = self:GetFontSettings()
		bar.value:SetFont(font, fh + 3, fontFlags)
		bar.value:SetText(bar.value:GetText())
	end

	bar.locked = true
	bar.Lock = function(self, locked)
		if locked ~= nil then
			self.locked = locked
		end
		self:EnableMouse(not self.locked)
		self:Configure(not self.locked)
	end
	bar.IsLocked = function(self)
		return self.locked
	end

	bar.configMode = false
	bar.Configure = function(self, config)
		if config ~= nil then
			self.configMode = config
		else
			self.configMode = not self.configMode
		end
		if self.configMode then
			self.texture:SetTexture(SpellIcons["Auto Attack"])
			self:Show()
		else
			CompactRunes:UpdateProcIcon()
		end
	end

    bar:SetMovable(true)
    bar:RegisterForDrag("LeftButton")
    bar:SetScript("OnDragStart",
        function(self, button)
			if not self.locked then
            	self:StartMoving()
			end
        end)
    bar:SetScript("OnDragStop",
        function(self)
            self:StopMovingOrSizing()
			local scale = self:GetEffectiveScale() / _G.UIParent:GetEffectiveScale()
			local x, y = self:GetCenter()
			x, y = x * scale, y * scale
			x = x - _G.GetScreenWidth()/2
			y = y - _G.GetScreenHeight()/2
			x = x / self:GetScale()
			y = y / self:GetScale()
			local procIcon = CompactRunes.db.profile.procIcon
			procIcon.x, procIcon.y = x, y
			procIcon.userPlaced = true
			self:SetUserPlaced(false)
        end)
	bar:Lock()
	self:UpdateProcIcon()
end

function CompactRunes:UpdateProcIcon()
	local procInd = frames.procInd
	if not procInd then return end
	local found = false

	if self.db.profile.procs then
		local procPriority = self.db.profile.priorityList[addon.currentSpec]
		local enabled = self.db.profile.enabled[addon.currentSpec]

		if procPriority and enabled then
			for i, spell in ipairs(procPriority) do
				local s = spell
				local override = SpellOverridenByTalent[spell]
				if override and addon.HasActiveTalent(override) then s = override end
				local count = self.currentProcs[s]
				if enabled[spell] and count then
					found = true
					procInd.texture:SetTexture(SpellIcons[s])
					procInd:Show()
					if count > 1 then
						procInd.value:SetText(tostring(count))
						procInd.value:Show()
					else
						procInd.value:Hide()
					end

					break
				end
			end
		end
	end

	if not found then
		procInd:Hide()
	end
end

function CompactRunes:SetMainFrameBorder()
	local frame = frames.main
	if frame then
		local border = LSM:Fetch("border", self.db.profile.border)
		local backdrop = {
	        bgFile = "Interface\\Buttons\\WHITE8X8",
	        edgeFile = border, tile = false, tileSize = 16, edgeSize = 16,
	        insets = { left = 4, right = 4, top = 4, bottom = 4 }
	    }
		local bdbc = self.db.profile.frame.bdcolor
		local bdc = self.db.profile.frame.color
	    frame:SetBackdrop(backdrop)
	    frame:SetBackdropBorderColor(bdbc.r, bdbc.g, bdbc.b, bdbc.a)
	    frame:SetBackdropColor(bdc.r, bdc.g, bdc.b, bdc.a)

		border = LSM:Fetch("border", self.db.profile.borderInd)
		backdrop = {
	        bgFile = "Interface\\Buttons\\WHITE8X8",
	        edgeFile = border, tile = false, tileSize = 16, edgeSize = 16,
	        insets = { left = 4, right = 4, top = 4, bottom = 4 }
	    }
		local rc = self.db.profile.frame.rccolor
	    frame.ind:SetBackdrop(backdrop)
	    frame.ind:SetBackdropBorderColor(rc.r, rc.g, rc.b, rc.a)
	    frame.ind:SetBackdropColor(0, 0, 0, 0)
	end
end

function CompactRunes:UpdateBarLayout()
	if addon.isDK then
		addon.LayoutManager:DetermineLayout()
	end
end

function CompactRunes:CalculateSize()
	self.sizes = self.sizes or {}
	self.sizes.Display = self.sizes.Display or {}
	self.sizes.Display.width = (addon.GetRuneWidth() + addon.GetRuneSpacing()) * 2 + 9
	self.sizes.Display.height = (addon.GetRuneHeight() + addon.GetRuneSpacing()) * 3 + 9
	self.sizes.hinset = 0
	self.sizes.vinset = 0
end

function CompactRunes:CreateValueBlock(name, parent, setPoint)
	if self.blocks[name] then return end
	local parentFrame = parent or _G.UIParent
	local frame = _G.CreateFrame("Frame", "CompactRunes_ValBlock_"..name, parentFrame)
	self.blocks[name] = frame
	frame.parentFrame = parentFrame
	frame.db = self.db.profile.blocks[name]
	frame.name = name
	frame.lock = true
	frame:SetBackdrop({
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
		})

    frame.value = frame:CreateFontString(nil, "OVERLAY")
    frame.value:SetPoint("CENTER")
    frame.value:SetJustifyH("CENTER")
	frame.value:Show()

	if setPoint and _G.type(setPoint) == "function" then
		frame.SetDesiredPoint = setPoint
	else
		frame.SetDesiredPoint = function(self)
			self:SetPoint("CENTER")
		end
	end

	frame.SetValue = function(self, value) self.value:SetText(value) end

	frame.UpdateColor = function(self)
		local c
		if self.db.background then
			if not c then c = self.db.bgcolor end
			self:SetBackdropColor(c.r, c.g, c.b, c.a)
		else
			if not c then c = self.db.textcolor end
			self.value:SetTextColor(c.r, c.g, c.b, c.a)
		end
	end

	frame.ResetFonts = function(self)
		local font, fh, fflags = CompactRunes:GetFontSettings()
	    self.value:SetFont(font, self.db.fontSize or fh, fflags)
		self.value:SetText(self.value:GetText())
	end

	frame.IsLocked = function(self)
		return self.lock
	end

	frame.Lock = function(self, locked)
		if locked ~= nil then
			self.lock = locked
		end
		self:EnableMouse(not self.lock)
	end

	frame.UpdateLayout = function(self)
		self:SetHeight(self.db.height)
		self:SetWidth(self.db.width)
		self:Lock()
		self:SetDesiredPoint()
		self:ResetFonts()
		if not self.db.background then
			self:SetBackdropColor(0,0,0,0)
		else
			local c = self.db.textcolor
			self.value:SetTextColor(c.r, c.g, c.b, c.a)
		end
		if self.db.enabled then self:Show() else self:Hide() end
	end

    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart",
        function(self, button)
			if not self.lock then
            	self:StartMoving()
			end
        end)
    frame:SetScript("OnDragStop",
        function(self)
            self:StopMovingOrSizing()
			local scale = self:GetEffectiveScale() / _G.UIParent:GetEffectiveScale()
			local x, y = self:GetCenter()
			x, y = x * scale, y * scale
			x = x - _G.GetScreenWidth()/2
			y = y - _G.GetScreenHeight()/2
			x = x / self:GetScale()
			y = y / self:GetScale()
			self.db.x, self.db.y = x, y
			self:SetUserPlaced(false);
        end)

	frame:UpdateColor()
	frame:UpdateLayout()

	return frame
end

function CompactRunes:CreateDisplay()
	local frame = _G.CreateFrame("Frame", "CompactRunes_Display", _G.UIParent)
	frames.main = frame
	addon.mainFrame = frame
	frame.UpdateProfile = function(self)
		self.db = addon.db.profile.frame
	end
	frame:UpdateProfile()
	frame.SetDesiredPoint = function(self)
		self:ClearAllPoints()
		self:SetPoint("CENTER", _G.UIParent, "CENTER", self.db.x, self.db.y)
	end
	frame:SetDesiredPoint()
	frame.GetDesiredWidth = addon.GetMainWidth
	frame.GetDesiredHeight = addon.GetMainHeight
	frame:SetWidth(frame.GetDesiredWidth())
	frame:SetHeight(frame.GetDesiredHeight())

	frame.ind = _G.CreateFrame("Frame", nil,frame)
	frame.ind:SetAllPoints(frame)
	frame.ind:Hide()
	frame.rcActive = false
	frame.outOfRange = false
	frame.UpdateInd = function(self)
		if self.outOfRange then
			local bc = CompactRunes.db.profile.rangeColor
			self.ind:SetBackdropBorderColor(bc.r, bc.g, bc.b, bc.a)
			self.ind:Show()
		elseif self.rcActive and CompactRunes.db.profile.rcProcInd then
			local bc = CompactRunes.db.profile.rcProcColor
			self.ind:SetBackdropBorderColor(bc.r, bc.g, bc.b, bc.a)
			self.ind:Show()
		else
			self.ind:Hide()
		end
	end
	frame.UpdateBackdropColor = function(self)
	local bdc = self.db.color
    self:SetBackdropColor(bdc.r, bdc.g, bdc.b, bdc.a)
	end
	self:SetMainFrameBorder()

	frame.lock = self.db.profile.locked
    frame:SetMovable(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart",
        function(self, button)
			if not self.lock then
            	self:StartMoving()
			end
        end)
    frame:SetScript("OnDragStop",
        function(self)
            self:StopMovingOrSizing()
			local scale = self:GetEffectiveScale() / _G.UIParent:GetEffectiveScale()
			local x, y = self:GetCenter()
			x, y = x * scale, y * scale
			x = x - _G.GetScreenWidth()/2
			y = y - _G.GetScreenHeight()/2
			x = x / self:GetScale()
			y = y / self:GetScale()
			self.db.x, self.db.y = x, y
			self:SetUserPlaced(false);
        end)
    frame:EnableMouse(not frame.lock)

	frames.boneBar = Bar:Create({
		name = "BoneShieldBar",
		fontAdj = 2,
		initTimer = true,
		functions = {
			GetWidth = function(self)
				return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			end,
			GetHeight = function(self)
				return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			end,
			SetPoint = addon.layouts["topbar1-right"],
			SetValuePoint = function(self)
				self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			end,
			UpdateDisplay = function(self)
				if self.active then
					name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
						= UnitBuff("player", SpellNames["Bone Shield"])
					if name then
						local timeLeft = expires - GetTime()
						self.bar.timer = timeLeft
						self.bar.active = true
						if count ~= self.bar.count then
							self.bar.value:SetText(tostring(count))
						end
						self.bar.count = count

						if self.db.progress == "Time" then
							self.bar:SetMinMaxValues(0, duration)
						elseif self.db.progress == "Charges" then
							self.bar:SetMinMaxValues(0, addon.MAX_BONESHIELD_CHARGES)
						else
							self.bar:SetMinMaxValues(0, 1)
							self.bar:SetValue(1)
						end
						self.bar:SetAlpha(1)
						self.bar.value:Show()
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateBoneShield)
					else
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				else
					self.bar:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Blood" and self.db.enabled and
					_G.IsSpellKnown(SpellIds["Marrowrend"])
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					addon:BarDisplayAdd("PlayerAura", self)
					self:UpdateDisplay()
				else
					self.active = false
					addon:BarDisplayRemove("PlayerAura", self)
					self:Hide()
				end
			end,
			UpdateBoneShieldBarMode = function(self)
				if self.db.progress == "Time" then
					self.bar:SetMinMaxValues(0, 1)
					self.bar:SetValue(1)
				elseif self.db.progress == "Charges" then
					self.bar:SetMinMaxValues(0, addon.MAX_BONESHIELD_CHARGES)
					self.bar:SetValue(0)
				elseif self.db.progress == "None" then
					self.bar:SetMinMaxValues(0, 1)
					self.bar:SetValue(1)
				end
			end
		}
	})
	frames.boneBar:OnTalentUpdate()
	frames.boneBar:UpdateBoneShieldBarMode()

	frames.powerBar = Bar:Create({
		name = "RunicPowerBar",
		fontAdj = 2,
		layout = { "bottombar1-full" },
		functions = {
			-- GetWidth = function(self)
			-- 		return self.db.overrideWidth and self.db.width or addon.GetBarWidth()
			-- 	end,
			-- GetHeight = function(self)
			-- 		return self.db.overrideHeight and self.db.height or addon.GetBarHeight()
			-- 		end,
			-- SetPoint = addon.layouts["bottombar1-full"]
		}
	})
	frames.powerBar.UpdateDisplay = function(self)
		if self.db.showNumericValue then
			self.bar.value:Show()
		else
			self.bar.value:Hide()
		end
		self.tickmarks = self.tickmarks or {}
		local profile = CompactRunes.db.profile.rpTicks
		local spec = profile.specs[addon.currentSpec]
		if profile.enabled and spec then
			local cost = spec.cost
			local maxRP = _G.UnitPowerMax("player", 6)
			local numTicks = _G.math.floor(maxRP / cost)
			if (numTicks * cost) / maxRP > 0.9 then numTicks = numTicks - 1 end
			local interval = self:GetWidth() / (maxRP/cost)
			local c = profile.color
			for i = 1, numTicks do
				self.tickmarks[i] = self.tickmarks[i] or self.bar:CreateTexture()
				local tick = self.tickmarks[i]
				tick:SetColorTexture(c.r, c.g, c.b, c.a)
				tick:SetHeight(self:GetHeight())
				tick:SetWidth(profile.width)
				tick:SetPoint("LEFT", self.bar, "LEFT", interval * i, 0)
				tick:SetDrawLayer("OVERLAY")
				tick:Show()
			end
			for i = numTicks + 1, 5 do
				local tick = self.tickmarks[i]
				if tick then tick:Hide() end
			end
		else
			for i = 1, 5 do
				local tick = self.tickmarks[i]
				if tick then tick:Hide() end
			end
		end
	end
	self:UpdateRunicPowerMax()
	self:UpdateRunicPower()
	self:ShowRunicPowerBar()

	frames.bsBar = Bar:Create({
		name = "BloodShieldBar",
		fontAdj = 2,
		initTimer = true,
		setValueToZero = true,
		updateVisibilityOnLock = true,
		layout = { "bottombar2-full" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetBarHeight()
			-- end,
			-- SetPoint = addon.layouts["bottombar2-full"]
			IsEnabled = function(self)
				return addon.currentSpec == "Blood" and self.db.enabled
			end,
		}
	})

	frames.ffBar = Bar:Create({
		name = "FrostFeverBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar1-left" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-left"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end
			IsEnabled = function(self)
				return addon.currentSpec == "Frost" and self.db.enabled
			end,
		}
	})

	frames.bpBar = Bar:Create({
		name = "BloodPlagueBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar1-left" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-left"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end
			IsEnabled = function(self)
				return addon.currentSpec == "Blood" and self.db.enabled
			end,
		}
	})

	frames.vpBar = Bar:Create({
		name = "VirulentPlagueBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar1-left" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-left"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled
			end,
		}
	})

	frames.fwBar = Bar:Create({
		name = "FesteringWoundBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar1-right" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-right"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled
			end,
		}
	})

	frames.ddBar = Bar:Create({
		name = "DeathAndDecayBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "leftbar-full" },
		functions = {
			UpdateDisplay = function(self)
				if self.active then
					local show = false
					name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitBuff("player", SpellNames["Death and Decay Buff"])
					if name then
						self.bar.timer = expires - GetTime()
						self.bar:SetMinMaxValues(0, duration)
						local bc = self.db.color
						local tc = self.db.textcolor
						self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
						self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
						self.bar.active = true
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
						show = true
					else
						if self.db.showCooldown then
							local start, duration, enabled = GetSpellCooldown(SpellIds[self.spellforcd])
							if duration > addon.runeCD then
								self.bar.timer = start + duration - GetTime()
								local bc = self.db.alt_color
								local tc = self.db.alt_textcolor
								self.bar:SetMinMaxValues(0, duration)
								self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
								self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
								self.bar.active = true
								self.bar:Show()
								self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
								show = true
							end
						end
					end
					if not show then
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				end
			end,
			IsEnabled = function(self)
				return self.db.specs[addon.currentSpec] and self.db.enabled
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					self.spellforcd = addon.HasActiveTalent("Defile") and "Defile" or "Death and Decay"
					addon:BarDisplayAdd("PlayerAura", self)
					self:UpdateDisplay()
				else
					self.active = false
					addon:BarDisplayRemove("PlayerAura", self)
					self:Hide()
				end
			end
		}
	})
	frames.ddBar:OnTalentUpdate()

	frames.rtBar = Bar:Create({
		name = "RuneStrikeBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-full", "topbar2-left" },
		functions = {
			UpdateDisplay = function(self)
				if self.active then
					if event == "CombatStart" then
						self.bar:SetAlpha(self.db.alpha)
						return
					end
					local current, max, start, duration = GetSpellCharges(SpellIds["Rune Strike"])
					if current and current >= 0 then
						self.bar.value:SetText(tostring(current))
						self.bar:SetMinMaxValues(0, duration)
						if current >= max then
							self.bar:SetValue(duration)
							self.bar.active = false
							self.bar:SetScript("OnUpdate", nil)
							self:Show()
							self.bar:SetAlpha(_G.UnitAffectingCombat("player") and
								self.db.alpha or addon.db.profile.auxBarOOCAlpha)
						else
							local remaining = GetTime() - start
							self.bar:SetValue(remaining)
							self.bar.active = true
							self.bar.duration = duration
							self.bar.timer = remaining
							self:Show()
							self.bar:SetScript("OnUpdate", onUpdateIncreasingTimerNoCounter)
							self.bar:SetAlpha(self.db.alpha)
						end
					else
						self:Hide()
						self.bar.active = false
						self.bar:SetScript("OnUpdate", nil)
					end
				else
					self:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Blood" and self.db.enabled and addon.HasActiveTalent("Rune Strike")
			end,
			OnTalentUpdate = function(self)
				local events = { "SpellCooldown", "CombatStart", "CombatEnd" }
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					for i, event in ipairs(events) do
						addon:BarDisplayAdd(event, self)
					end
					self:UpdateDisplay()
				else
					self.active = false
					for i, event in ipairs(events) do
						addon:BarDisplayRemove(event, self)
					end
					self:Hide()
				end
			end,
		}
	})
	frames.rtBar:OnTalentUpdate()

	frames.bbBar = Bar:Create({
		name = "BloodBoilBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-full", "topbar2-right" },
		functions = {
			UpdateDisplay = function(self, event)
				if self.active then
					if event == "CombatStart" then
						self.bar:SetAlpha(self.db.alpha)
						return
					end
					local current, max, start, duration = GetSpellCharges(SpellIds["Blood Boil"])
					if current and current >= 0 then
						self.bar.value:SetText(tostring(current))
						self.bar:SetMinMaxValues(0, duration)
						if current >= max then
							self.bar:SetValue(duration)
							self.bar.active = false
							self.bar:SetScript("OnUpdate", nil)
							self:Show()
							self.bar:SetAlpha(_G.UnitAffectingCombat("player") and
								self.db.alpha or addon.db.profile.auxBarOOCAlpha)
						else
							local remaining = GetTime() - start
							self.bar:SetValue(remaining)
							self.bar.active = true
							self.bar.duration = duration
							self.bar.timer = remaining
							self:Show()
							self.bar:SetScript("OnUpdate", onUpdateIncreasingTimerNoCounter)
							self.bar:SetAlpha(self.db.alpha)
						end
					else
						self:Hide()
						self.bar.active = false
						self.bar:SetScript("OnUpdate", nil)
					end
				else
					self:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Blood" and self.db.enabled
			end,
			OnTalentUpdate = function(self)
				local events = { "SpellCooldown", "CombatStart", "CombatEnd" }
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					for i, event in ipairs(events) do
						addon:BarDisplayAdd(event, self)
					end
					self:UpdateDisplay()
				else
					self.active = false
					for i, event in ipairs(events) do
						addon:BarDisplayRemove(event, self)
					end
					self:Hide()
				end
			end
		}
	})
	frames.bbBar:OnTalentUpdate()

	frames.vbBar = Bar:Create({
		name = "VampiricBloodBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "rightbar-full" },
		functions = {
			UpdateDisplay = function(self)
				if self.active then
					local show = false
					name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitBuff("player", SpellNames["Vampiric Blood"])
					if name then
						self.bar.timer = expires - GetTime()
						self.bar:SetMinMaxValues(0, duration)
						local bc = self.db.color
						local tc = self.db.textcolor
						self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
						self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
						self.bar.active = true
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
						show = true
					else
						if self.db.showCooldown then
							local start, duration, enabled = GetSpellCooldown(SpellIds["Vampiric Blood"])
							if duration > 2 then
								self.bar.timer = start + duration - GetTime()
								local bc = self.db.alt_color
								local tc = self.db.alt_textcolor
								self.bar:SetMinMaxValues(0, duration)
								self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
								self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
								self.bar.active = true
								self.bar:Show()
								self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
								show = true
							end
						end
					end
					if not show then
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Blood" and self.db.enabled
			end,
			OnTalentUpdate = function(self)
				local events = { "SpellCooldown", "PlayerAura" }
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					for i, event in ipairs(events) do
						addon:BarDisplayAdd(event, self)
					end
					self:UpdateDisplay()
				else
					self.active = false
					for i, event in ipairs(events) do
						addon:BarDisplayRemove(event, self)
					end
					self:Hide()
				end
			end
		}
	})
	frames.vbBar:OnTalentUpdate()

	frames.dtBar = Bar:Create({
		name = "DarkTransformationBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-full", "topbar2-left" },
		functions = {
			UpdateDisplay = function(self)
				local show = false
				if self.active then
					name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitBuff("pet", SpellNames["Dark Transformation"], "PLAYER")

					if name then
						self.bar.dt = true
						self.bar.timer = expires - GetTime()
						local bc, tc
						if self.bar.dt then
							bc = self.db.color
							tc = self.db.textcolor
						else
							bc = self.db.alt_color
							tc = self.db.alt_textcolor
						end
						self.bar:SetMinMaxValues(0, duration)
						self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
						self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
						self.bar.active = true
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
						show = true
					else
						-- If Shadow Infusion and DT on CD, show an indicator (the CD) to use DC.
						self.bar.dt = false
						if self.showCooldown then
							local start, duration, enabled = GetSpellCooldown(SpellIds["Dark Transformation"])
							if duration > 2 then
								self.bar.timer = start + duration - GetTime()
								local bc = self.db.alt_color
								local tc = self.db.alt_textcolor
								self.bar:SetMinMaxValues(0, duration)
								self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
								self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
								self.bar.active = true
								self.bar:Show()
								self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
								show = true
							end
						end
					end
				end
				if not show then
					self.bar.active = false
					self.bar.timer = 0
					self.bar:SetScript("OnUpdate", nil)
					self.bar:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled
			end,
			OnTalentUpdate = function(self)
				local events = { "SpellCooldown", "PetAura" }
				self.siEnabled = addon.HasActiveTalent("Shadow Infusion") and self.db.showCooldown == "ShadowInfusion"
				self.showCooldown = self.siEnabled or self.db.showCooldown == "Always"
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					for i, event in ipairs(events) do
						addon:BarDisplayAdd(event, self)
					end
					self:UpdateDisplay()
				else
					self.active = false
					for i, event in ipairs(events) do
						addon:BarDisplayRemove(event, self)
					end
					self:Hide()
				end
			end
		}
	})
	frames.dtBar:OnTalentUpdate()

	frames.epBar = Bar:Create({
		name = "EpidemicBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-right", "rightbar-full" },
		functions = {
			UpdateDisplay = function(self)
				if self.active then
					if event == "CombatStart" then
						self.bar:SetAlpha(self.db.alpha)
						return
					end
					local current, max, start, duration = GetSpellCharges(SpellIds["Epidemic"])
					if current and current >= 0 then
						self.bar.value:SetText(tostring(current))
						self.bar:SetMinMaxValues(0, duration)
						if current >= max then
							self.bar:SetValue(duration)
							self.bar.active = false
							self.bar:SetScript("OnUpdate", nil)
							self:Show()
							self.bar:SetAlpha(_G.UnitAffectingCombat("player") and
								self.db.alpha or addon.db.profile.auxBarOOCAlpha)
						else
							local remaining = GetTime() - start
							self.bar:SetValue(remaining)
							self.bar.active = true
							self.bar.duration = duration
							self.bar.timer = remaining
							self:Show()
							self.bar:SetScript("OnUpdate", onUpdateIncreasingTimerNoCounter)
							self.bar:SetAlpha(self.db.alpha)
						end
					else
						self:Hide()
						self.bar.active = false
						self.bar:SetScript("OnUpdate", nil)
					end
				else
					self:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled and addon.HasActiveTalent("Epidemic")
			end,
			OnTalentUpdate = function(self)
				local events = { "SpellCooldown", "CombatStart", "CombatEnd" }
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					for i, event in ipairs(events) do
						addon:BarDisplayAdd(event, self)
					end
					self:UpdateDisplay()
				else
					self.active = false
					for i, event in ipairs(events) do
						addon:BarDisplayRemove(event, self)
					end
					self:Hide()
				end
			end
		}
	})
	frames.epBar:OnTalentUpdate()

	frames.ppBar = Bar:Create({
		name = "PestilentPustulesBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-right", "rightbar-full" },
		functions = {
			UpdateDisplay = function(self, event, ...)
				if self.active then
					if event == "CombatLogEvent" then
						local eventtype = select(3, ...) or ""
						local srcGUID = select(5, ...) or ""
						local updated = false
						if srcGUID == addon.playerGUID and eventtype == "SPELL_AURA_REMOVED_DOSE" then
							local spellName = select(14, ...) or ""
							if spellName == SpellNames["Festering Wound"] then
								self.burst = (self.burst or 0) + 1
								if addon.db.profile.debug then
									local stacks = select(17, ...) or ""
									addon:Print("FW Removed Dose "..tostring(stacks))
								end
								updated = true
							end
						elseif srcGUID == addon.playerGUID and eventtype == "SPELL_ENERGIZE" then
							local spellName = select(14, ...) or ""
							if spellName == SpellNames["Pestilent Pustules"] then
								if addon.db.profile.debug then
									addon:Print("PP Reset")
								end
								self.burst = -1
							end
							updated = true
						elseif srcGUID == addon.playerGUID and eventtype == "SPELL_AURA_APPLIED" then
							local spellName = select(14, ...) or ""
							if spellName == SpellNames["Festering Wound"] then
								local name, _, _, _, _, duration, expires
								= UnitDebuff("target", SpellNames["Festering Wound"], "PLAYER")
								if name then
									self.expires = expires
								end
							end
						elseif srcGUID == addon.playerGUID and eventtype == "SPELL_AURA_REMOVED" then
							local spellName = select(14, ...) or ""
							if spellName == SpellNames["Festering Wound"] then
								if self.expires then
									local time = GetTime()
									local diff = abs(self.expires - time)
									if diff > 0.2 then
										self.burst = (self.burst or 0) + 1
									end
								end
								self.expires = nil
								if addon.db.profile.debug then
									addon:Print("FW Removed")
								end
								updated = true
							end
						end
						if updated then
							local stacks = max(0, self.burst or 0)
							self.bar:SetValue(stacks)
							self.bar.value:SetText(tostring(stacks))
							self:Show()
							self.bar:SetAlpha(self.db.alpha)
						end
					elseif event == "CombatStart" then
						self.bar:SetAlpha(self.db.alpha)
						return
					elseif event == "CombatEnd" then
						self.bar:SetAlpha(_G.UnitAffectingCombat("player") and
							self.db.alpha or addon.db.profile.auxBarOOCAlpha)
						return
					end
				else
					self:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled and addon.HasActiveTalent("Pestilent Pustules")
			end,
			OnTalentUpdate = function(self)
				local events = { "CombatStart", "CombatEnd", "CombatLogEvent" }
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					for i, event in ipairs(events) do
						addon:BarDisplayAdd(event, self)
					end
					self:UpdateDisplay()
					self.bar:SetMinMaxValues(0, addon.PESTILENT_PUSTULES_MAX)
				else
					self.active = false
					for i, event in ipairs(events) do
						addon:BarDisplayRemove(event, self)
					end
					self:Hide()
				end
			end,
			PostInitialize = function(self)
				self.burst = 0
			end,
		}
	})
	frames.ppBar:OnTalentUpdate()

	frames.srBar = Bar:Create({
		name = "SoulReaperBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-right", "rightbar-full" },
		hasSecondaryValue = true,
		secondaryFontAdj = 0,
		functions = {
			SetSecondaryValuePoint = addon.SetSecondaryValuePoints["SettingOrBottom"],
			UpdateDisplay = function(self)
				local show = false
				if self.active then
					local name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitDebuff("target", SpellNames["Soul Reaper"], "PLAYER")

					if name then
						self.bar.timer = expires - GetTime()
						local bc = self.db.color
						local tc = self.db.textcolor
						self.bar:SetMinMaxValues(0, duration)
						self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
						self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
						self.bar.active = true
						local counter = true
						if self.db.primaryValue == "Stacks" then
							local _, _, _, stacks =
								UnitBuff("player", SpellNames["Soul Reaper Buff"], "PLAYER")
							self.bar.value:SetText(tostring(stacks or 0))
							counter = false
						end
						if self.orientation == "VERTICAL" then
							if self.db.secondaryValue == "Stacks" then
								local _, _, _, stacks =
									UnitBuff("player", SpellNames["Soul Reaper Buff"], "PLAYER")
								self.bar.secondaryValue:SetText(tostring(stacks or 0))
							end
							if self.db.secondaryValue == "None" then
								self.bar.secondaryValue:Hide()
							else
								self.bar.secondaryValue:Show()
							end
						else
							self.bar.secondaryValue:Hide()
						end
						self.bar:Show()
						local secondaryTimer = self.orientation == "VERTICAL" and
							self.db.secondaryValue == "Time" and self.db.primaryValue ~= "Time"
						self.bar:SetScript("OnUpdate", secondaryTimer and onUpdateTimerWithSecondaryCounter
							or (counter and onUpdateTimerWithCounter or onUpdateTimerNoCounter))
						show = true
					elseif self.db.showCooldown then
						self.bar.secondaryValue:Hide()
						local start, duration, enabled = GetSpellCooldown(SpellIds["Soul Reaper"])
						if duration > 10 then
							self.bar.timer = start + duration - GetTime()
							local bc = self.db.alt_color
							local tc = self.db.alt_textcolor
							self.bar:SetMinMaxValues(0, duration)
							self.bar:SetStatusBarColor(bc.r, bc.g, bc.b, bc.a)
							self.bar.value:SetTextColor(tc.r, tc.g, tc.b, tc.a)
							self.bar.active = true
							self.bar:Show()
							self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
							show = true
						end
					end
				end
				if not show then
					self.bar.active = false
					self.bar.timer = 0
					self.bar:SetScript("OnUpdate", nil)
					self.bar:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled and addon.HasActiveTalent("Soul Reaper")
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					addon:BarDisplayAdd("TargetAura", self)
					addon:BarDisplayAdd("SpellCooldown", self)
					self:UpdateDisplay()
				else
					self.active = false
					addon:BarDisplayRemove("TargetAura", self)
					addon:BarDisplayRemove("SpellCooldown", self)
					self:Hide()
				end
			end
		}
	})
	frames.srBar:OnTalentUpdate()

	frames.sowBar = Bar:Create({
		name = "SoWBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "leftbar-full" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-right"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end,
			UpdateDisplay = function(self)
				if self.active then
					local name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitDebuff("target", SpellNames["Scourge of Worlds"], "PLAYER")

					if name then
						self.bar.timer = expires - GetTime()
						self.bar:SetMinMaxValues(0, duration)
						self.bar.active = true
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
					else
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Unholy" and self.db.enabled
					--and addon.HasActiveTalent("Scourge of Worlds")
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					addon:BarDisplayAdd("TargetAura", self)
					self:UpdateDisplay()
				else
					self.active = false
					addon:BarDisplayRemove("TargetAura", self)
					self:Hide()
				end
			end
		}
	})
	frames.sowBar:OnTalentUpdate()

	frames.itBar = Bar:Create({
		name = "IcyTalonsBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar1-full", "topbar1-right" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-right"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end,
			UpdateDisplay = function(self)
				if self.active then
					local name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
						= UnitBuff("player", SpellNames["Icy Talons"])

					if name then
						self.bar.timer = expires - GetTime()
						self.bar:SetMinMaxValues(0, duration)
						self.bar.active = true
						self.bar.value:SetText(tostring(count))
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerNoCounter)
					else
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				else
					self:Hide()
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Frost" and self.db.enabled and addon.HasActiveTalent("Icy Talons")
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					addon:BarDisplayAdd("PlayerAura", self)
					self:UpdateDisplay()
				else
					addon:BarDisplayRemove("PlayerAura", self)
					self.active = false
					self:Hide()
				end
			end
		}
	})
	frames.itBar:OnTalentUpdate()

	frames.riBar = Bar:Create({
		name = "RazoriceBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar1-full", "topbar1-right" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar1-right"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end,
			UpdateDisplay = function(self)
				if self.active then
					local name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitDebuff("target", SpellNames["Razorice"], "PLAYER")

					if name then
						self.bar.timer = expires - GetTime()
						self.bar:SetMinMaxValues(0, duration)
						self.bar.value:SetText(tostring(count))
						self.bar.active = true
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerNoCounter)
					else
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Frost" and self.db.enabled and
					addon.HasActiveTalent("Shattering Strikes")
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					addon:BarDisplayAdd("TargetAura", self)
					self:UpdateDisplay()
				else
					self.active = false
					addon:BarDisplayRemove("TargetAura", self)
					self:Hide()
				end
			end
		}
	})
	frames.riBar:OnTalentUpdate()

	frames.rwBar = Bar:Create({
		name = "RemorselessWinterBar",
		fontAdj = 2,
		initTimer = true,
		layout = { "topbar2-full", "topbar2-left" },
		functions = {
			-- GetWidth = function(self)
			-- 	return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
			-- end,
			-- GetHeight = function(self)
			-- 	return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
			-- end,
			-- SetPoint = addon.layouts["topbar2-full"],
			-- SetValuePoint = function(self)
			-- 	self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
			-- end,
			UpdateDisplay = function(self)
				if self.active then
					local name, icon, count, dispelType, duration, expires,
					caster, isStealable, shouldConsolidate, spellId, canApplyAura,
					isBossDebuff, castByPlayer, value1, value2, value3
					= UnitBuff("player", SpellNames["Remorseless Winter"])

					if name then
						self.bar.timer = expires - GetTime()
						self.bar:SetMinMaxValues(0, duration)
						--self.bar.value:SetText(tostring(count))
						self.bar.active = true
						self.bar:Show()
						self.bar:SetScript("OnUpdate", onUpdateTimerWithCounter)
					else
						self.bar.active = false
						self.bar.timer = 0
						self.bar:SetScript("OnUpdate", nil)
						self.bar:Hide()
					end
				end
			end,
			IsEnabled = function(self)
				return addon.currentSpec == "Frost" and self.db.enabled and addon.HasActiveTalent("Gathering Storm")
			end,
			OnTalentUpdate = function(self)
				if self.IsEnabled and self:IsEnabled() then
					self.active = true
					addon:BarDisplayAdd("PlayerAura", self)
					self:UpdateDisplay()
				else
					self.active = false
					addon:BarDisplayRemove("PlayerAura", self)
					self:Hide()
				end
			end
		}
	})
	frames.rwBar:OnTalentUpdate()

	self:UpdateBarLayout()

	self:CreateProcIndicator()
	--self:CreateBlocks()

	-- Create the runes and then update their status
	for i = 1, addon.NUMBER_RUNES do
		runeBars[i] = Bar:Create({
			name = "RuneBar"..i,
			fontAdj = 0,
			setBarColor = false,
			setBkgColor = false,
			hideOnDisable = false,
			movable = false,
			functions = {
				GetWidth = function()
					return addon.GetRuneWidth()
				end,
				GetHeight = function()
					return addon.GetRuneHeight()
				end,
				GetOrientation = function()
					return addon.db.profile.runeOrientation
				end,
				PostInitialize = function(self)
					if addon.db.profile.rechargeTimers == "None" then
						self.bar.value:Hide()
					end
				end,
			}
		})
		runeBars[i].bar.showing = runes[i]
	end
	self:UpdateRunes()
	self:SetRuneOrder(self.db.profile.runeOrder)
	self:SetDisplayAlpha()
	frames.main:Show()
end

function CompactRunes:ShowRunicPowerBar()
	if self.db.profile.bars.RunicPowerBar.enabled then
		frames.powerBar.bar:Show()
		self:RegisterEvent("UNIT_POWER_FREQUENT")
	else
		frames.powerBar.bar:Hide()
		self:UnregisterEvent("UNIT_POWER_FREQUENT")
	end
end

function CompactRunes:RUNE_POWER_UPDATE(event, runeIndex, isEnergized)
	if runeIndex < 1 or runeIndex > addon.NUMBER_RUNES then
		if self.db.profile.debug then
			self:Print("Invalid rune: ".._G.tostring(runeIndex).." isEnergized: ".._G.tostring(isEnergized))
		end
    -- Invalid rune id, just udpate all the runes
    for i = 1, addon.NUMBER_RUNES do
      self:UpdateRuneCooldown(i, false)
    end
    return
	end
	self:UpdateRuneCooldown(runeIndex, isEnergized)
end

function CompactRunes:UNIT_POWER_FREQUENT(event, unit, type)
	if unit == "player" then -- and type == "RUNIC_POWER" then
		self:UpdateRunicPower()
	end
end

function CompactRunes:UpdateRunicPower()
	local rp = _G.UnitPower("player", 6)
	if addon.incombat then
		local spent = addon.lastrp - rp
		if spent > 0 then
			self.LastFightStats.rpSpent = self.LastFightStats.rpSpent + spent
			self.TotalStats.rpSpent = self.TotalStats.rpSpent + spent
		end
		addon.lastrp = rp
	end
	frames.powerBar:SetValue(rp)
end

function CompactRunes:UpdateRunicPowerMax()
	frames.powerBar.bar:SetMinMaxValues(0, _G.UnitPowerMax("player", 6))
end

function CompactRunes:UNIT_MAXPOWER(event)
	self:UpdateRunicPowerMax()
end

function CompactRunes:UNIT_MAXHEALTH(event, unit)
	if unit == "target" then
		self:UpdateTargetMaxHealth()
	end
end

function CompactRunes:UNIT_HEALTH(event, unit)
	if unit == "target" then
		self:UpdateTargetHealth()
	end
end

function CompactRunes:UNIT_LEVEL(event, unit)
	if unit == "player" then
		self:CheckTalents()
	end
end

function CompactRunes.CheckDisplayAlpha()
	CompactRunes:SetDisplayAlpha()
end

function CompactRunes:SetDisplayAlpha(combat)
	local alpha = 0
	local inCombat = combat ~= nil and combat or _G.UnitAffectingCombat("player")
	if _G.UnitInVehicle("player") then
		alpha = self.db.profile.vehicleAlpha
	elseif _G.C_PetBattles.IsInBattle() then
		alpha = self.db.profile.alphas.petBattle
	elseif inCombat then
		alpha = self.db.profile.combatAlpha
	else
		if addon.depletedRunes > 0 and self.db.profile.oocRechargeAlphaEnabled then
			alpha = self.db.profile.oocRechargeAlpha
			-- Start timer to check if runes have recharged and move to OOC Alpha
			_G.C_Timer.After(5, self.CheckDisplayAlpha)
		else
			alpha = self.db.profile.ooc_alpha
		end
	end
	frames.main:SetAlpha(alpha)
	frames.procInd:SetDesiredAlpha()
end

function CompactRunes:SetCDBarAlpha()
	local bar = self.cdbars[addon.currentSpec]
	if bar and bar.SetAlpha then bar:SetAlpha() end
end

function CompactRunes:PLAYER_ALIVE()
	addon:FireCallback("PlayerAlive")
end

function CompactRunes:PLAYER_DEAD()
	addon:FireCallback("PlayerDead")
end

function CompactRunes:PLAYER_REGEN_DISABLED()
	-- Player has entered combat.
	addon.incombat = true
	self:SetDisplayAlpha(true)
	addon.lastrp = _G.UnitPower("player", 6)
	self.LastFightStats:Reset()
	if self.db.profile.rangeInd then
		frames.main:SetScript("OnUpdate", onUpdateInd)
	end
	self:SetCDBarAlpha()
	self:CheckForPets()
	addon:FireCallback("CombatStart")
	addon:BarDisplayUpdateForEvent("CombatStart")
end

function CompactRunes:PLAYER_REGEN_ENABLED()
	-- Player has left combat.
	addon.incombat = false
	self:SetDisplayAlpha()
	if self.db.profile.rangeInd and not self.targetHostile then
		frames.main:SetScript("OnUpdate", nil)
		frames.main.outOfRange = false
		frames.main:UpdateInd()
	end
	self:SetCDBarAlpha()
	addon:FireCallback("CombatEnd")
	addon:BarDisplayUpdateForEvent("CombatEnd")
end

function CompactRunes:PLAYER_TARGET_CHANGED(unit)
	self.targetHostile = _G.UnitExists("target") and
		_G.UnitCanAttack("player", "target") and
		not _G.UnitIsDead("target")
	if self.targetHostile and self.db.profile.rangeInd then
		frames.main:SetScript("OnUpdate", onUpdateInd)
	else
		frames.main:SetScript("OnUpdate", nil)
		frames.main.outOfRange = false
		frames.main:UpdateInd()
	end

	self:UpdateTargetMaxHealth()
	self.currentTarget = _G.UnitGUID("target")

	self:UNIT_AURA("UNIT_AURA", "target")
end

function addon.SetupSpellAuras()
	addon.StandardDiseases = {
		["Blood"] = {
			[SpellNames["Blood Plague"]] = frames.bpBar,
		},
		["Frost"] = {
			[SpellNames["Frost Fever"]] = frames.ffBar,
		},
		["Unholy"] = {
			[SpellNames["Virulent Plague"]] = frames.vpBar,
		},
	}
	addon.petBuffs = {
		SpellNames["Dark Transformation"],
	}
end

function CompactRunes:UNIT_AURA(event, unit)
	local name, icon, count, dispelType, duration, expires,
		caster, isStealable, shouldConsolidate, spellId, canApplyAura,
		isBossDebuff, castByPlayer, value1, value2, value3

	if unit == "target" then
		local diseases = addon.StandardDiseases[addon.currentSpec]
		for spell, bar in pairs(diseases) do
			name, icon, count, dispelType, duration, expires,
			caster, isStealable, shouldConsolidate, spellId, canApplyAura,
			isBossDebuff, castByPlayer, value1, value2, value3
			= UnitDebuff("target", spell, "PLAYER")

			if name and bar.db.enabled then
				bar.bar.active = true
				local timeLeft = expires - GetTime()
				bar.bar:SetMinMaxValues(0, duration)
				bar.bar.timer = timeLeft
				bar.bar:Show()
				bar.bar:SetScript("OnUpdate", onUpdateDisease)
			else
				bar.bar.active = false
				bar.bar.timer = 0
				bar.bar:SetScript("OnUpdate", nil)
				bar.bar:Hide()
			end
		end

		if addon.currentSpec == "Unholy" then
			-- TODO: Function call taking spell name, bar, possibly the onUpdate.
			name, icon, count, dispelType, duration, expires,
			caster, isStealable, shouldConsolidate, spellId, canApplyAura,
			isBossDebuff, castByPlayer, value1, value2, value3
			= UnitDebuff("target", SpellNames["Festering Wound"], "PLAYER")
			local bar = frames.fwBar
			local fwProc = (count == nil or count < 5) and 1 or nil
			local changed = fwProc ~= self.currentProcs["Festering Wound < 5"]
			if changed then
				self.currentProcs["Festering Wound < 5"] = fwProc
				self:UpdateProcIcon()
			end
			if name and bar.db.enabled then
				bar.bar.active = true
				local timeLeft = expires - GetTime()
				bar.bar:SetMinMaxValues(0, duration)
				bar.bar.timer = timeLeft
				bar.bar:Show()
				bar.bar:SetScript("OnUpdate", onUpdateTimerNoCounter)
				bar.bar.value:SetText(tostring(count))
			else
				bar.bar.active = false
				bar.bar.timer = 0
				bar.bar:SetScript("OnUpdate", nil)
				bar.bar:Hide()
			end
		end

		addon:BarDisplayUpdateForEvent("TargetAura")

	elseif unit == "player" then
		addon:BarDisplayUpdateForEvent("PlayerAura")

		if self.db.profile.bars.BloodShieldBar.enabled then
			local bar = frames.bsBar
			name, icon, count, dispelType, duration, expires,
			caster, isStealable, shouldConsolidate, spellId, canApplyAura,
			isBossDebuff, castByPlayer, value1, value2, value3
				= UnitBuff("player", SpellNames["Blood Shield"])
			if name then
				bar.bar.timer = expires - GetTime()
				bar.bar:SetMinMaxValues(0, duration)
				bar.bar.value:SetText(FormatNumber(value3 or 0))
				bar.bar.active = true
				bar.bar:Show()
				bar.bar:SetScript("OnUpdate", onUpdateTimerNoCounter)
			else
				bar.bar.active = false
				bar.bar.timer = 0
				bar.bar:SetScript("OnUpdate", nil)
				bar.bar:Hide()
			end
		end

		if self.db.profile.procs then
			name, icon, count, dispelType, duration, expires,
			caster, isStealable, shouldConsolidate, spellId, canApplyAura,
			isBossDebuff, castByPlayer, value1, value2, value3
			= UnitBuff("player", SpellNames["Bone Shield"], "PLAYER")
			local bsProc = (count == nil or count <= 6) and (count or 1) or nil
			local changed = bsProc ~= self.currentProcs["Bone Shield <= 6"]
			if changed then
				self.currentProcs["Bone Shield <= 6"] = bsProc
			end

			local procInd = frames.procInd
			local procPriority = self.db.profile.priorityList[addon.currentSpec]
			local enabled = self.db.profile.enabled[addon.currentSpec]
			if procPriority and enabled then
				for i, spell in ipairs(procPriority) do
					if not self.specialProcs[spell] then
						name, icon, count, dispelType, duration, expires,
						caster, isStealable, shouldConsolidate, spellId, canApplyAura,
						isBossDebuff, castByPlayer, value1, value2, value3
						= UnitBuff("player", SpellNames[spell])
						if name then
							self.currentProcs[spell] = (count or 1)
						else
							self.currentProcs[spell] = nil
						end
					end
				end
			end
			self:UpdateProcIcon()
		end
	elseif unit == "pet" then
		addon:BarDisplayUpdateForEvent("PetAura")

	end
end

function CompactRunes:PLAYER_SPECIALIZATION_CHANGED(event)
	self:CheckTalents()
end

function CompactRunes:PLAYER_TALENT_UPDATE(event)
	self:CheckTalents()
end

function CompactRunes:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellId)
end

function CompactRunes:COMBAT_LOG_EVENT_UNFILTERED(...)
	local event = "COMBAT_LOG_EVENT_UNFILTERED"
	local timestamp, eventtype, hideCaster,
	srcGUID, srcName, srcFlags, srcRaidFlags,
	destGUID, destName, destFlags, destRaidFlags,
	param9, param10, param11, param12, param13, param14,
	param15, param16, param17, param18, param19, param20 = CombatLogGetCurrentEventInfo()

	if destGUID == addon.playerGUID then
		if eventtype == "SPELL_AURA_APPLIED" then
			if param9 == SpellIds["Runic Corruption"] then
				self.LastFightStats.rcProcs = self.LastFightStats.rcProcs + 1
				self.TotalStats.rcProcs = self.TotalStats.rcProcs + 1
				if frames.main then
					frames.main.rcActive = true
					frames.main:UpdateInd()
				end
			end
		elseif eventtype == "SPELL_AURA_REMOVED" then
			if param9 == SpellIds["Runic Corruption"] then
				if frames.main then
					frames.main.rcActive = false
					frames.main:UpdateInd()
				end
			end
		end
	end
	if srcGUID == addon.playerGUID then
		if eventtype == "SPELL_ENERGIZE" then
			if param10 == SpellNames["Runic Empowerment"] then
				self.LastFightStats.reProcs = self.LastFightStats.reProcs + 1
				self.TotalStats.reProcs = self.TotalStats.reProcs + 1
			elseif param10 == SpellNames["Pestilent Pustules"] then
				self.LastFightStats.ppProcs = self.LastFightStats.ppProcs + 1
				self.TotalStats.ppProcs = self.TotalStats.ppProcs + 1
				if self.db.profile.debug then
					local fmt = "Pestilent Pustules %s %s %s"
					self:Print(fmt:format(tostring(param11), tostring(param12), tostring(param13)))
				end
			elseif param10 == SpellNames["Murderous Efficiency"] then
				self.LastFightStats.meProcs = self.LastFightStats.meProcs + 1
				self.TotalStats.meProcs = self.TotalStats.meProcs + 1
			end
			if self.db.profile.debug then
				local fmt = "Energize: %s %s %s %s"
				self:Print(fmt:format(tostring(param10), tostring(param11), tostring(param12), tostring(param13)))
			end
		end
	end
	addon:BarDisplayUpdateForEvent("CombatLogEvent", ...)
end

function CompactRunes:SPELL_UPDATE_COOLDOWN(event)
	local changed = false
	local ignoreRuneCDs = self.db.profile.ignoreRuneCDs["Procs"]

	addon:BarDisplayUpdateForEvent("SpellCooldown")

	--local enabled = self.db.profile.enabled[addon.currentSpec]
	for k, v in pairs(self.AbilityProcs) do
		if k and v then
			local id = SpellIds[k]
			local start, duration, enabled =
				GetSpellCooldown(id)
			local charges = GetSpellCharges(id)
			local ready = (duration < 2)
			local ignore = false
			if not ready and ignoreRuneCDs then
				local grace = addon.IgnoreRuneCDs[k]
				if grace and grace > 0 and duration <= grace then
					ignore = true
				end
			end
			if not ignore then
				local newValue = ready and (charges or 1) or nil
				if self.currentProcs[k] ~= newValue then
					changed = true
				end
				self.currentProcs[k] = newValue
			end
		end
	end

	if changed then
		self:UpdateProcIcon()
	end
end

function CompactRunes:CheckForPets()
	if addon.currentSpec == "Unholy" and not _G.IsMounted() and
		(not _G.UnitExists("pet") or (not GetTotemInfo(4) and addon.HasActiveTalent("All Will Serve"))) then
		-- Ghoul or Skulker is missing.
		if not self.currentProcs["Raise Dead"] then
			self.currentProcs["Raise Dead"] = 1
			self:UpdateProcIcon()
		end
	else
		if self.currentProcs["Raise Dead"] then
			self.currentProcs["Raise Dead"] = nil
			self:UpdateProcIcon()
		end
	end
end

function CompactRunes:PLAYER_TOTEM_UPDATE(event, unit)
	if unit and unit == "player" then
		self:CheckForPets()
	end
end

function CompactRunes:UNIT_PET(event, unit)
	if unit and unit == "player" then
		self:CheckForPets()
	end
end

function CompactRunes:COMPANION_UPDATE(event, unit)
	self:CheckForPets()
end

function CompactRunes:PLAYER_ENTERING_WORLD(event)
	for i = 1, addon.NUMBER_RUNES do
		self:UpdateRuneCooldown(i)
	end
	self:UpdateRunicPower()
	addon.playerGUID = _G.UnitGUID("player") or ""
	self:UNIT_AURA("PLAYER_ENTERING_WORLD", "player")
end

local TierSlotIds = {
	["Head"] = _G.GetInventorySlotInfo("HeadSlot"),
	["Shoulder"] = _G.GetInventorySlotInfo("ShoulderSlot"),
	["Chest"] = _G.GetInventorySlotInfo("ChestSlot"),
	["Legs"] = _G.GetInventorySlotInfo("LegsSlot"),
	["Hands"] = _G.GetInventorySlotInfo("HandsSlot"),
}

local TierIds = {
	["T15 DPS"] = {
		["Head"] = {
			[95827] = true,
			[95227] = true,
			[96571] = true,
			},
		["Shoulder"] = {
			[95829] = true,
			[95229] = true,
			[96573] = true,
			},
		["Chest"] = {
			[95825] = true,
			[95225] = true,
			[96569] = true,
			},
		["Legs"] = {
			[95828] = true,
			[95228] = true,
			[96572] = true,
			},
		["Hands"] = {
			[95826] = true,
			[95226] = true,
			[96570] = true,
		},
	},
	["T16 DPS"] = {
		["Head"] = {
			[99057] = true,
			[99194] = true,
			[99337] = true,
			},
		["Shoulder"] = {
			[99059] = true,
			[99187] = true,
			[99339] = true,
			},
		["Chest"] = {
			[99066] = true,
			[99192] = true,
			[99355] = true,
			},
		["Legs"] = {
			[99058] = true,
			[99186] = true,
			[99338] = true,
			},
		["Hands"] = {
			[99067] = true,
			[99193] = true,
			[99336] = true,
		},
	},
	["T18"] = {
		["Head"] = {
			[124332] = true,
			},
		["Shoulder"] = {
			[124344] = true,
			},
		["Chest"] = {
			[124317] = true,
			},
		["Legs"] = {
			[124338] = true,
			},
		["Hands"] = {
			[124327] = true,
		},
	},
}

local TierSlots = {}
for k, v in pairs(TierSlotIds) do
	TierSlots[v] = true
end

local TrackedItemSlotIds = {
	["Trinket1"] = _G.GetInventorySlotInfo("Trinket0Slot"),
	["Trinket2"] = _G.GetInventorySlotInfo("Trinket1Slot"),
}
local TrackedItemSlots = {}
for k, v in pairs(TrackedItemSlotIds) do
	TrackedItemSlots[v] = true
end

local GearChangeTimer = nil
function CompactRunes:CheckGear()
	GearChangeTimer = nil
	local count = 0
	local changed = false

	for tier, ids in pairs(TierIds) do
		count = 0
		for slot, slotid in pairs(TierSlotIds) do
			local id = _G.GetInventoryItemID("player", slotid)
			if ids[slot][id] then
				count = count + 1
			end
		end

		if count ~= addon.tierCount[tier] then
			addon.tierCount[tier] = count
			if self.db.profile.debug and not _G.InCombatLockdown() then
				local fmt = "%s Detected: %d/5"
				self:Print(fmt:format(tier, addon.tierCount[tier]))
			end
			changed = true
		end
	end

	if changed then self:UpdateTierBonus() end
	for name, bar in pairs(self.cdbars) do
		if bar then bar:Update() end
	end

	addon:FireCallback("GearUpdate")
end

function CompactRunes:UpdateTierBonus()
end

function CompactRunes:PLAYER_EQUIPMENT_CHANGED(event, slot, hasItem)
	if (TierSlots[slot] or TrackedItemSlots[slot]) and not GearChangeTimer then
		GearChangeTimer = self:ScheduleTimer("CheckGear", 1.5)
	end
end

function CompactRunes:UNIT_ENTERED_VEHICLE(event, unit)
	self:SetDisplayAlpha()
	self:SetCDBarAlpha()
end

function CompactRunes:UNIT_EXITED_VEHICLE(event, unit)
	self:SetDisplayAlpha()
	self:SetCDBarAlpha()
end

function CompactRunes:PET_BATTLE_OPENING_START(event, unit)
	self:SetDisplayAlpha()
	self:SetCDBarAlpha()
end

function CompactRunes:PET_BATTLE_CLOSE(event, unit)
	self:SetDisplayAlpha()
	self:SetCDBarAlpha()
end
