local _G = getfenv(0)
local ADDON_NAME, addon = ...
local LibStub = _G.LibStub
local CompactRunes = LibStub("AceAddon-3.0"):GetAddon(addon.addonName)
local L = LibStub("AceLocale-3.0"):GetLocale(addon.addonName)

local SpellIds = addon.SpellIds
local SpellNames = addon.SpellNames

-- Locals for performance
local pairs = _G.pairs
local ipairs = _G.ipairs
local GetTime = _G.GetTime
local tostring = _G.tostring
local abs = _G.math.abs

-- Use BfA+ version to search by name.
local UnitBuff = addon.UnitBuff

local KMTracker = {}
addon:RegisterModule("KMTracker", KMTracker)
KMTracker.enabled = false

-- Stats
local Stats = addon.Stats
local KMStats = Stats:new()
function KMStats:Reset()
	self.autoattacks = 0
	self.kmprocs = 0
	self.kmoverriden = 0
	self.kmexpired = 0
	self.kmoblit = 0
	self.kmfs = 0
end
local LastFight = KMStats:new()
local TotalStats = KMStats:new()

local killingMachine = nil
local kmExpires = nil
local kmLastAbility = nil

local UnitEvents = {
	["player"] = {"UNIT_SPELLCAST_SUCCEEDED"},
}

local function EventFrame_OnEvent(frame, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		KMTracker:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
	elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
		KMTracker:UNIT_SPELLCAST_SUCCEEDED(event, ...)
	end
end
local EventFrame = _G.CreateFrame("Frame", ADDON_NAME.."_KM_EventFrame")
local EventFrames = {}

function KMTracker:OnInitialize()
end

function KMTracker:Enable()
	addon:RegisterCallback("TalentUpdate", "KMTracker", KMTracker.ToggleTracking)
	addon:RegisterCallback("ResetStats", "KMTracker", KMTracker.ResetStats)
	addon:RegisterCallback("CombatStart", "KMTracker", KMTracker.CombatStart)
	self:ToggleTracking()
end

function KMTracker:Disable()
	addon:UnregisterCallback("TalentUpdate", "KMTracker")
	addon:UnregisterCallback("ResetStats", "KMTracker")
	addon:UnregisterCallback("CombatStart", "KMTracker")
	self:OnDisable()
end

function KMTracker:OnEnable()
	--if self.enabled then return end
	for unit, events in _G.pairs(UnitEvents) do
		local frame = EventFrames[unit] or _G.CreateFrame("Frame",
				ADDON_NAME.."_KM_EventFrame_"..unit)
		if frame then
			frame:SetScript("OnEvent", EventFrame_OnEvent)
			EventFrames[unit] = frame
			for i, event in _G.ipairs(events) do
				frame:RegisterUnitEvent(event, unit)
			end
		else
			addon:Print("Missing event frame for "..tostring(unit).."!")
		end
	end
	EventFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	EventFrame:SetScript("OnEvent", EventFrame_OnEvent)
	self.enabled = true
end

function KMTracker:OnDisable()
	for unit, events in pairs(UnitEvents) do
		local eventFrame = EventFrames[unit]
		for i, event in ipairs(events) do
			if eventFrame then
				eventFrame:UnregisterEvent(event, unit)
			end
		end
	end
	EventFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	EventFrame:SetScript("OnEvent", nil)
	self.enabled = false
end

function KMTracker:GetOptions()
	return "kmTrackerOpts", self:GetModuleOptions()
end

function KMTracker:AddOptions()
	return "KMTracker", L["KM Stats"], "kmTrackerOpts"
end

function KMTracker:GetModuleOptions()
	local kmTrackerOpts = {
		order = 2,
		type = "group",
		name = L["Killing Machine Statistics"],
		desc = L["Killing Machine Statistics"],
		args = {
			description = {
				order = 1,
				type = "description",
				name = L["TrackKM_Desc"],
			},
			generalOptions = {
				order = 2,
				type = "header",
				name = L["General Options"],
			},
			kmStats = {
				name = L["KM Stats"],
				desc = L["KMStats_Desc"],
				type = "toggle",
				order = 10,
				set = function(info, val)
					addon.db.profile.kmStats = val
					self:ToggleTracking()
				end,
				get = function(info)
					return addon.db.profile.kmStats
				end,
			},
		},
	}
	return kmTrackerOpts
end

function KMTracker:ToggleTracking()
	if addon.db.profile.kmStats and addon.currentSpec == "Frost" then
		KMTracker:OnEnable()
	else
		KMTracker:OnDisable()
	end
end

function KMTracker:UNIT_SPELLCAST_SUCCEEDED(event, unit, castGUID, spellId)
	if unit == "player" and killingMachine then
		if spellId == SpellIds["Frost Strike"] then
			TotalStats.kmfs = TotalStats.kmfs + 1
			LastFight.kmfs = LastFight.kmfs + 1
			kmLastAbility = _G.GetTime()
		end
		if spellId == SpellIds["Obliterate"] then
			TotalStats.kmoblit = TotalStats.kmoblit + 1
			LastFight.kmoblit = LastFight.kmoblit + 1
			kmLastAbility = _G.GetTime()
		end
	end
end

function KMTracker:COMBAT_LOG_EVENT_UNFILTERED(...)
	local event = "COMBAT_LOG_EVENT_UNFILTERED"
	local timestamp, eventtype, hideCaster,
	srcGUID, srcName, srcFlags, srcRaidFlags,
	destGUID, destName, destFlags, destRaidFlags,
	param9, param10, param11, param12, param13, param14,
	param15, param16, param17, param18, param19, param20 = CombatLogGetCurrentEventInfo()

	if destGUID == addon.playerGUID then
		if param9 and param9 == SpellIds["Killing Machine"] then
			if eventtype ~= "SPELL_AURA_REMOVED" then
				-- Save the expiration time to later check expiration vs use
				local name, icon, count, dispelType, duration, expires =
					UnitBuff("player", SpellNames["Killing Machine"], "PLAYER")
				kmExpires = expires
			end
			if eventtype == "SPELL_AURA_APPLIED" then
				TotalStats.kmprocs = TotalStats.kmprocs + 1
				LastFight.kmprocs = LastFight.kmprocs + 1
				killingMachine = true
			elseif eventtype == "SPELL_AURA_REFRESH" then
				TotalStats.kmprocs = TotalStats.kmprocs + 1
				LastFight.kmprocs = LastFight.kmprocs + 1
				TotalStats.kmoverriden = TotalStats.kmoverriden + 1
				LastFight.kmoverriden = LastFight.kmoverriden + 1
				killingMachine = true
			elseif eventtype == "SPELL_AURA_REMOVED" then
				-- Make a reasonable guess for a true expiration versus KM usage
				local now = GetTime()
				local timeSinceExpire = abs(now - (self.kmExpires or 0))
				local timeSinceLastAbility = abs(now - (self.kmLastAbility or 0))
				--local fmt = "KM Removed [expire: %.3f, ability: %.3f]"
				--self:Print(fmt:format(timeSinceExpire, timeSinceLastAbility))
				if timeSinceExpire < 0.5 and timeSinceLastAbility > 0.5 then
					TotalStats.kmexpired = TotalStats.kmexpired + 1
					LastFight.kmexpired = LastFight.kmexpired + 1
				end
				killingMachine = false
				kmExpires = nil
			end
		end

	end
	if srcGUID == addon.playerGUID then
		if eventtype == "SWING_DAMAGE" then
			TotalStats.autoattacks = TotalStats.autoattacks + 1
			LastFight.autoattacks = LastFight.autoattacks + 1
		end
	end
end

local valuePlusPercent = addon.valuePlusPercent
local kmProcTitle, kmOverwrittenTitle, kmExpiredTitle, kmFSTitle, kmOblitTitle
function KMTracker:AddStats(tooltip, statstype)
	local stats
	if statstype == "LastFight" then
		stats = LastFight
	else
		stats = TotalStats
	end
	if addon.db.profile.kmStats and addon.currentSpec == "Frost" then
		local usedProcs = stats.kmprocs - stats.kmoverriden
		tooltip:AddLine(SpellNames["Killing Machine"])

		kmProcTitle = kmProcTitle or "    " .. L["Procs"]
		kmOverwrittenTitle = kmOverwrittenTitle or "    " .. L["Overwritten"]
		kmExpiredTitle = kmExpiredTitle or "    " .. L["Expired"]
		kmFSTitle = kmFSTitle or "    "..SpellNames["Frost Strike"]
		kmOblitTitle = kmOblitTitle or "    "..SpellNames["Obliterate"]

		tooltip:AddLine(kmProcTitle,
			valuePlusPercent(stats.kmprocs, stats.autoattacks))
		tooltip:AddLine(kmOverwrittenTitle,
			valuePlusPercent(stats.kmoverriden, stats.kmprocs))
		tooltip:AddLine(kmFSTitle,
			valuePlusPercent(stats.kmfs, usedProcs))
		tooltip:AddLine(kmOblitTitle,
			valuePlusPercent(stats.kmoblit, usedProcs))
		tooltip:AddLine(kmExpiredTitle,
			valuePlusPercent(stats.kmexpired, stats.kmprocs))
	end
end

function KMTracker:ResetStats()
	TotalStats:Reset()
	LastFight:Reset()
end

function KMTracker:CombatStart()
	LastFight:Reset()
end
