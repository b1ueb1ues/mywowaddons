local _G = getfenv(0)
local CompactRunes = LibStub("AceAddon-3.0"):GetAddon("Compact Runes")
local ADDON_NAME, addon = ...

local LSM = _G.LibStub:GetLibrary("LibSharedMedia-3.0")
local ipairs = _G.ipairs
local pairs = _G.pairs
local table = _G.table
local wipe = _G.wipe
local tostring = _G.tostring
local ceil = _G.ceil
local GetSpellCooldown = _G.GetSpellCooldown
local GetSpellCharges = _G.GetSpellCharges
local GetItemCooldown = _G.GetItemCooldown
local GetTime = _G.GetTime
local IsEquippedItem = _G.IsEquippedItem
local GetItemInfo = _G.GetItemInfo
local GetInventoryItemID = _G.GetInventoryItemID
local GetInventorySlotInfo = _G.GetInventorySlotInfo
local IconBar = addon.IconBar
local SpellIds = addon.SpellIds
local SpellNames = addon.SpellNames
local SpellIcons = addon.SpellIcons
local ItemIds = addon.ItemIds
local ItemNames = addon.ItemNames
local ItemIcons = addon.ItemIcons
local ItemProcs = addon.ItemProcs
local ReverseItemNames = addon.ReverseItemNames
local MIN_UPDATE_TIME = addon.MIN_UPDATE_TIME
local round = addon.round

-- Use BfA+ version to search by name.
local UnitBuff = addon.UnitBuff

local CooldownBar = {}
local bars = {}

CooldownBar.__index = CooldownBar

addon.CooldownBar = CooldownBar

local ItemProcTypes = {
	["item"] = false,
	["itemicd"] = true,
	["itemstacks"] = true,
	["itemproc"] = true,
}

local ReversedTypes = {
	["itemstacks"] = true,
	["itemproc"] = true,
}

local function Cooldown_OnUpdate(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
			end
			local timeStr = ""
			if self.timer > 99 then
				timeStr = tostring(ceil(self.timer / 60)) .. "m"
			else
				timeStr = tostring(round(self.timer))
			end
			self.text:SetText(timeStr)
			self.text:Show()
		else
			self.text:SetText("0")
			self.text:Hide()
			self:SetScript("OnUpdate", nil)
		end
	end
end

local function EventFrame_onEvent(frame, event, ...)
	if event == "SPELL_UPDATE_COOLDOWN" then
		local bar = frame.obj
		if bar then bar:UpdateCooldowns() end
	elseif event == "UNIT_AURA" then
		local bar = frame.obj
		if not bar then return end

		local name, icon, count, dispelType, duration, expires, 
		caster, isStealable, shouldConsolidate, spellId, canApplyAura, 
		isBossDebuff, castByPlayer, value1, value2, value3 
		for cdname, cdtype in pairs(bar.procs) do
			if cdname then
				local data = ItemProcs[cdname]
				if data then
					name, icon, count, dispelType, duration, expires, 
					caster, isStealable, shouldConsolidate, spellId, 
					canApplyAura, isBossDebuff, castByPlayer, value1, 
					value2, value3 
						= UnitBuff("player", SpellNames[data.proc])
					local active = (name ~= nil)
					local item = bar.cds[cdname]
					if item and active ~= item.state then
						if cdtype == "itemicd" then
							if active == false and item.state == true then
								item.lastProc = GetTime()
								item.cd:SetCooldown(item.lastProc, data.icd or 0)
								if addon.db.profile.showCDText then
									item.cd.timer = data.icd
									item.cd.active = true
									item.cd:SetScript("OnUpdate", Cooldown_OnUpdate)
								end
							end
						elseif cdtype == "itemstacks" then
							if not active then
								item.cd.text:Hide()
								item.texture:SetAlpha(bar.db().inactiveAlpha)
							else
								if count ~= item.count then
									if addon.db.profile.showCDText then
										item.cd.text:Show()
										item.cd.text:SetText(count or 0)
									end
									item.count = count
								end
								item.texture:SetAlpha(bar.db().activeAlpha)
							end
						elseif cdtype == "itemproc" then
							if active == true and item.state == false then
								item.lastProc = GetTime()
								local timer = expires - item.lastProc
								if timer < 0 then timer = 0 end
								item.cd:SetCooldown(item.lastProc, timer, false)
								item.texture:SetAlpha(bar.db().activeAlpha)
								if addon.db.profile.showCDText then
									item.cd.timer = timer
									item.cd.active = true
									item.cd:SetScript("OnUpdate", Cooldown_OnUpdate)
								end
							elseif active == false then
								item.cd.text:Hide()
								item.texture:SetAlpha(bar.db().inactiveAlpha)
							end
						end
						item.state = active
					end
				end
			end
		end
	end
end

function CooldownBar:UpdateCooldowns()
	local start, duration, enabled, current, max
	local ready
	local ignoreRuneCDs = addon.db.profile.ignoreRuneCDs["CooldownBar"]

	for name, cd in pairs(self.cds) do
		if cd.db().enabled and not cd.disabled then
			cd:Show()
			local cdtype = cd.db().type or ""
			local ignore = false
			if ItemProcTypes[cdtype] == false or 
				cdtype == "spell" or cdtype == "spellcharges" then
				if cdtype == "item" then
					start, duration, enabled = GetItemCooldown(ItemIds[name])
				elseif cdtype == "spellcharges" then
					current, max, start, duration = GetSpellCharges(SpellIds[name])
					cd.charges:SetText(tostring(current))
					cd.charges:Show()
					ready = current
				else		
					start, duration, enabled = GetSpellCooldown(SpellIds[name])
					if ignoreRuneCDs and duration and duration > addon.gcd then
						local grace = addon.IgnoreRuneCDs[name]
						if grace and grace > 0 and duration <= grace then
							ignore = true
						end
					end
				end
				if cdtype ~= "spellcharges" then
					-- Duration can be a GCD due to runes.
					ready = (duration <= addon.gcd)
				end

				local finish = start + duration
				if not ignore and finish ~= self.cooldowns[name] then
					self.cooldowns[name] = finish
					if (cdtype ~= "spellcharges" and ready) or 
						(cdtype == "spellcharges" and current == max) then
						cd.cd:SetCooldown(0,0)
						cd.cd.timer = 0
						cd.cd.active = false
						cd.cd:SetScript("OnUpdate", nil)
						cd.cd.text:Hide()
					else
						local remaining = start + duration - GetTime()
						cd.cd:SetCooldown(start, duration)
						if addon.db.profile.showCDText then
							cd.cd.timer = remaining
							cd.cd.active = true
							cd.cd:SetScript("OnUpdate", Cooldown_OnUpdate)
						end
					end
				end
			end
		end
	end
end

function CooldownBar:Create(name)
	if not name then return end
	if bars[name] then return bars[name] end
	local object = _G.setmetatable({}, CooldownBar)
	object.name = name
	object.db = function()
		return addon.db.profile.cdbars[name]
	end
	object.cds = {}
	object.procs = {}
	object.isEnabled = false
	object:Initialize()
	bars[name] = object
	return object
end

function CooldownBar:Initialize()
	self.bar = IconBar:Create(self.name)
	self.cooldowns = {}

	self.eventFrame = _G.CreateFrame("Frame")
	self.eventFrame.obj = self
	self.eventFrame:SetScript("OnEvent", EventFrame_onEvent)
	self.eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")

	for i, name in ipairs(self.db().ordering) do
		local data = self.db().cds[name]
		if not self.cds[name] and data then
			local frameName = ADDON_NAME.."_CDBar_"..self.name.."_"..name
			local frame = _G.CreateFrame("Frame", frameName, self.bar.frame)
			frame:SetHeight(self.db().height)
			frame:SetWidth(self.db().width)
			frame.texture = frame:CreateTexture(nil, "ARTWORK")
		    frame.texture:SetAllPoints(frame)
		    frame.texture:SetVertexColor(1, 1, 1)
			local icon
			if ItemProcTypes[data.type] ~= nil then
				icon = ItemIcons[name]
			else
				icon = SpellIcons[name]
			end
			frame.texture:SetTexture(icon)
			if ReversedTypes[data.type] then
				frame.texture:SetAlpha(self.db().inactiveAlpha)
			end

			frame.cd = _G.CreateFrame("Cooldown", frameName.."_CD", frame,
				"CooldownFrameTemplate")
			frame.cd:SetAllPoints()
			frame.cd.active = false
			frame.cd.timer = 0
			frame.cd:SetAlpha(0.9)
			frame.cd:SetSwipeColor(0, 0, 0, 0.6)

			frame.cd.text = frame.cd:CreateFontString(nil, "OVERLAY")
			frame.cd.text:SetPoint("CENTER", 1, 1)
			frame.cd.text:SetJustifyH("CENTER")
			frame.cd.text:Hide()

			frame.charges = frame:CreateFontString(nil, "OVERLAY")
			frame.charges:SetPoint("BOTTOMRIGHT", 2, 2)
			frame.charges:SetJustifyH("CENTER")
			frame.charges:Hide()

			frame:Show()
			frame.db = function()
				return self.db().cds[name]
			end
			frame.disabled = false
			self.cds[name] = frame
			self.bar:Add(frame)
			frame.state = nil
			frame.lastProc = nil
		end
	end
	self:ResetFonts()
	self:Update()
end

function CooldownBar:Enable()
	self.bar:Show()
	self.eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	self:Update()
	self.isEnabled = true
end

function CooldownBar:Disable()
	self.bar:Hide()
	self.eventFrame:UnregisterAllEvents()
	self.isEnabled = false
end

function CooldownBar:IsEnabled()
	return self.isEnabled
end

function CooldownBar:Swap(pos1, pos2)
	self.bar:Swap(pos1, pos2)
end

function CooldownBar:Lock(flag)
	self.bar:Lock(flag)
end

local WatchedSlots = {
	[1] = GetInventorySlotInfo("Trinket0Slot"),
	[2] = GetInventorySlotInfo("Trinket1Slot"),
	[3] = GetInventorySlotInfo("Finger0Slot"),
	[4] = GetInventorySlotInfo("Finger1Slot"),
}
local equipped = {}
function CooldownBar:Update()
	if addon.db.profile.showCDText then
		for name, frame in pairs(self.cds) do
			if frame and frame.cd then
				-- Prevent Blizzard and other addons from adding a timer overlay.
				frame.cd.noOCC = true
				frame.cd.noCooldownCount = true
				frame.cd:SetHideCountdownNumbers(true)
			end
		end
	end
	self:SetAlpha()
	wipe(equipped)
	for i, slotId in ipairs(WatchedSlots) do
		local id = GetInventoryItemID("player", slotId)
		if id then
			local localizedName = GetItemInfo(id)
			if localizedName then
				local name = ReverseItemNames[localizedName]
				if name then equipped[name] = true end
			end
		end
	end
	for name, frame in pairs(self.cds) do
		if frame then
			local type = frame.db().type
			if ItemProcTypes[type] ~= nil then
				frame.disabled = not equipped[name]
			elseif type == "spell" or type == "spellcharges" then
				frame.disabled = not addon.IsSpellKnown(name)
				if addon.DynamicSpells[name] then
					frame.texture:SetTexture(SpellIcons[name])
				end
			end
		end
	end
	self:UpdateProcs()
	self.bar:UpdateLayout()
end

function CooldownBar:UpdateDimensions()
	for name, frame in pairs(self.cds) do
		if frame then
			frame:SetHeight(self.db().height)
			frame:SetWidth(self.db().width)
		end
	end
	self.bar:UpdateLayout()
end

function CooldownBar:UpdateProcs()
	wipe(self.procs)
	local hasProcs = false
	for name, data in pairs(self.db().cds) do
		if name and data and data.enabled and ItemProcTypes[data.type] == true then
			self.procs[name] = data.type
			hasProcs = true
		end
	end
	if hasProcs then
		self.eventFrame:RegisterUnitEvent("UNIT_AURA", "player")
	else
		self.eventFrame:UnregisterEvent("UNIT_AURA", "player")
	end
end

function CooldownBar:SetAlpha()
	self.bar:SetAlpha(_G.UnitInVehicle("player") and self.db().vehicleAlpha or 
		(_G.UnitAffectingCombat("player") and 
		self.db().combatAlpha or (_G.C_PetBattles.IsInBattle() and addon.db.profile.alphas.petBattle or self.db().oocAlpha)))
end

function CooldownBar:ResetFonts()
	local font, fh, fflags = addon:GetFontSettings()
	local overrideFont = self.db().fontFace
	if overrideFont then font = LSM:Fetch("font", overrideFont) end
   	local tc = self.db().textcolor
	for name, frame in pairs(self.cds) do
		if frame and frame.cd and frame.cd.text then
			local cdtext = frame.cd.text
		    cdtext:SetFont(font, self.db().textFontSize or fh, fflags)
		   	cdtext:SetTextColor(tc.r, tc.g, tc.b, tc.a)
			cdtext:SetText(cdtext:GetText())
		end
		if frame and frame.charges then
			local charges = frame.charges
		    charges:SetFont(font, (self.db().textFontSize or fh) - 3, fflags)
		   	charges:SetTextColor(tc.r, tc.g, tc.b, tc.a)
			charges:SetText(charges:GetText())
		end
	end
end
