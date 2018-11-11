local _G = getfenv(0)
local CompactRunes = LibStub("AceAddon-3.0"):GetAddon("Compact Runes")
local ADDON_NAME, addon = ...
local L = LibStub("AceLocale-3.0"):GetLocale(addon.addonName)
local LSM = _G.LibStub:GetLibrary("LibSharedMedia-3.0")

local GetTime = _G.GetTime
local ceil = _G.math.ceil
local floor = _G.math.floor
local round = addon.round
local pairs = _G.pairs
local tostring = _G.tostring
local SpellIds = addon.SpellIds
local SpellNames = addon.SpellNames

-- Use BfA+ version to search by name.
local UnitBuff = addon.UnitBuff

local BlockDisplay = {}

local module = {}
module.display = {}
module.name = "Tier 18 Frost 2P"
module.displayName = "Tier 18 Frost 2P"
module.frames = {
	["oblit"] = {
		name = "T18Frost2POblit",
		spell = "Obliteration",
	},
	["frozen"] = {
		name = "T18Frost2PFW",
		spell = "Frozen Wake",
	},
}

module.tracking = {}
addon:RegisterModule(module.name, module)

local MIN_UPDATE_TIME = addon.MIN_UPDATE_TIME

function module:SetProfile()
	for var, config in pairs(self.frames) do
		local block = self.display[var]
		if block and block.SetProfile then block:SetProfile() end
	end
end

function module:OnInitialize()
	if addon.isDK then
		addon:RegisterCallback("TalentUpdate", module.name, module.TalentUpdate)
		addon:RegisterCallback("GearUpdate", module.name, module.GearUpdate)
	end
	addon:RegisterCallback("ProfileUpdate", module.name, module.ProfileUpdate)
end

function module:Enable()
	self:Toggle()
end

function module:Disable()
	self:OnDisable()
end

function module:Toggle()
	if not addon.isDK then return end
	local t18count = addon.tierCount["T18"] or 0
	local enabled = false
	for var, config in pairs(self.frames) do
		if addon.profile.blocks[config.name].enabled then enabled = true end
	end
	if enabled and addon.currentSpec == "Frost" and t18count >= 2 then
		self:OnEnable()
	else
		self:OnDisable()
	end
end

function module:OnEnable()
	self.enabled = true
	self.eventFrame = self.eventFrame or _G.CreateFrame("frame")
	self.eventFrame:SetScript("OnEvent", self.EventHandler)
	self.eventFrame:RegisterUnitEvent("UNIT_AURA", "player")
	self:CreateDisplay()
	addon:RegisterCallback("CombatStart", module.name, module.CombatStart)
	addon:RegisterCallback("CombatEnd", module.name, module.CombatEnd)
	for name, display in pairs(self.display) do
		if name and display then
			if display then
				display:Show()
				display:SetAlpha()
			end
		end
	end
	if addon.db.profile.debug then
		addon:Print("T18 Frost 2P module loaded.")
	end
end

function module:OnDisable()
	if self.eventFrame then
		self.eventFrame:UnregisterAllEvents()
		self.eventFrame:SetScript("OnEvent", nil)
	end
	for name, display in pairs(module.display) do
		if display then
			display:Hide()
		end
	end
	addon:UnregisterCallback("CombatStart", module.name)
	addon:UnregisterCallback("CombatEnd", module.name)
	self.enabled = false
	if addon.db.profile.debug then
		addon:Print("T18 Frost 2P module unloaded.")
	end
end

function module:CreateDisplay()
	self.tracking = {}
	for name, config in pairs(self.frames) do
		if not self.display[name] then
			self.display[name] = BlockDisplay:Create(config.name, _G.UIParent, 
				{ spell = config.spell })
		end
		if addon.profile.blocks[config.name].enabled then
			self.tracking[config.spell] = self.display[name]
			self.display[name]:Show()
		else
			self.display[name]:Hide()
		end
	end
end

function module:UpdateDisplay()
end

function module.CombatStart()
	for name, display in pairs(module.display) do
		if display then
			display:Show()
			display:SetAlpha()
		end
	end
end

function module.CombatEnd()
	for name, display in pairs(module.display) do
		if display then
			display:SetAlpha()
			display.frame.active = false
			display.value:Hide()
			display.frame:SetScript("OnUpdate", nil)
		end
	end
end

function module.TalentUpdate()
	module:Toggle()
end

function module.ProfileUpdate()
	module:SetProfile()
end

function module.GearUpdate()
	module:Toggle()
end

function module.OnUpdate(self, elapsed)
	self.lastUpdate = (self.lastUpdate or 0) + elapsed
	self.timer = self.timer - elapsed
	if self.lastUpdate >= MIN_UPDATE_TIME then
		self.lastUpdate = 0
		if self.active then
			if self.timer < 0 then
				self.timer = 0
				self.active = false
			end

			self.obj.value:SetText(tostring(round(self.timer)))
			--self.obj.value:Show()
		else
			self.obj.value:SetText("0")
			--self.obj.value:Hide()
			self:SetScript("OnUpdate", nil)
		end
	end
end

function module:UpdateAuras()
	local name, icon, count, dispelType, duration, expires, 
	caster, isStealable, shouldConsolidate, spellId, canApplyAura, 
	isBossDebuff, castByPlayer, value1, value2, value3 

	for spell, block in pairs(self.tracking) do
		name, icon, count, dispelType, duration, expires, 
		caster, isStealable, shouldConsolidate, spellId, canApplyAura, 
		isBossDebuff, castByPlayer, value1, value2, value3 
			= UnitBuff("player", SpellNames[spell])
		if name then
			block.frame.cd:SetCooldown(expires - duration, duration)
			block.frame.timer = expires - GetTime()
			block.frame.active = true
			block.frame:SetScript("OnUpdate", module.OnUpdate)
			block.value:Show()
			block:SetAlpha()
		else
			block.frame.cd:SetCooldown(0,0)
			block.frame.timer = 0
			block.frame.active = false
			block.frame:SetScript("OnUpdate", nil)
			block.value:Hide()
			block:SetAlpha()
		end
	end
end

function module.EventHandler(frame, event, ...)
	if event == "UNIT_AURA" then
		module:UpdateAuras()
	end
end

function module:GetOptions()
	return "t18Frost2POpts", self:GetModuleOptions()
end

function module:AddOptions()
	return "T18 Frost 2P", L["T18 Frost 2P"], "t18Frost2POpts"
end

function module:GetModuleOptions()
	local options = {
		order = 3,
		type = "group",
		inline = true,
		name = L["T18 Frost 2P"],
		args = {
			description = {
				order = 1,
				type = "description",
				name = L["T18Frost2P_Desc"],
			},
		},
	}
	local i = 0
	for frameVar, config in pairs(self.frames) do
		i = i + 1
		options.args[config.name] = {
			order = i,
			type = "group",
			name = SpellNames[config.spell],
			args = {
				generalOptions = {
					order = 2,
					type = "header",
					name = L["General Options"],
				},
				enable = {
					name = L["Enabled"],
					desc = L["Enabled"],
					type = "toggle",
					order = 10,
					set = function(info, val)
						addon.profile.blocks[config.name].enabled = val
						self:Toggle()
					end,
					get = function(info)
						return addon.profile.blocks[config.name].enabled
					end,
				},
		    displayAlphas = {
					order = 50,
					type = "header",
					name = L["Display Alpha"],
		    },
				oocAlpha = {
					order = 52,
					name = L["Out of Combat"],
					desc = L["Out of Combat"],
					type = "range",
					min = 0,
					max = 1,
					step = 0.05,
					set = function(info, val)
						addon.profile.blocks[config.name].oocAlpha = val
						if self.display[frameVar] and not _G.InCombatLockdown() then
							self.display[frameVar]:SetAlpha()
						end
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].oocAlpha
					end,					
				},
				combatAlpha = {
					order = 54,
					name = L["In Combat"],
					desc = L["In Combat"],
					type = "range",
					min = 0,
					max = 1,
					step = 0.05,
					set = function(info, val)
						addon.profile.blocks[config.name].combatAlpha = val
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].combatAlpha
					end,					
				},
				activeAlpha = {
					order = 55,
					name = L["Active"],
					desc = L["Active"],
					type = "range",
					min = 0,
					max = 1,
					step = 0.05,
					set = function(info, val)
						addon.profile.blocks[config.name].activeAlpha = val
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].activeAlpha
					end,					
				},
		    layoutHdr = {
		        order = 100,
		        type = "header",
		        name = L["Layout"],
		    },
				xoffset = {
					order = 110,
					name = L["X Offset"],
					desc = L["XOffset_Desc"],	
					type = "range",
					softMin = -floor(_G.GetScreenWidth()),
					softMax = floor(_G.GetScreenWidth()),
					bigStep = 1,
					set = function(info, val)
						addon.profile.blocks[config.name].x = val
						if self.display[frameVar] then
							self.display[frameVar]:UpdateLayout()
						end
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].x
					end,
				},
				yoffset = {
					order = 120,
					name = L["Y Offset"],
					desc = L["YOffset_Desc"],	
					type = "range",
					softMin = -floor(_G.GetScreenHeight()),
					softMax = floor(_G.GetScreenHeight()),
					bigStep = 1,
					set = function(info, val)
						addon.profile.blocks[config.name].y = val
						if self.display[frameVar] then
							self.display[frameVar]:UpdateLayout()
						end
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].y
					end,
				},
				dimensions = {
					order = 200,
					type = "header",
					name = L["Dimensions"],
				},
				width = {
					order = 220,
					name = L["Width"],
					desc = L["BarWidth_Desc"],	
					type = "range",
					min = 10,
					max = 100,
					step = 1,
					set = function(info, val)
						addon.profile.blocks[config.name].width = val
						if self.display[frameVar] then self.display[frameVar]:UpdateLayout() end
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].width
					end,
				},
				height = {
					order = 230,
					name = L["Height"],
					desc = L["BarHeight_Desc"],
					type = "range",
					min = 10,
					max = 100,
					step = 1,
					set = function(info, val)
						addon.profile.blocks[config.name].height = val
						if self.display[frameVar] then self.display[frameVar]:UpdateLayout() end
					end,
					get = function(info, val)
						return addon.profile.blocks[config.name].height
					end,
				},
				fontSize = {
					order = 310,
					name = L["Font size"],
					desc = L["Font size"],
					type = "range",
					min = 8,
					max = 30,
					step = 1,
					set = function(info, val) 
						addon.profile.blocks[config.name].fontSize = val
						if self.display[frameVar] then self.display[frameVar]:ResetFonts() end
					end,
					get = function(info,val) return addon.profile.blocks[config.name].fontSize end,
				},
			},
		}
	end

	return options
end

BlockDisplay.__index = BlockDisplay

function BlockDisplay:Create(name, parent, config)
	local object = _G.setmetatable({}, BlockDisplay)
	object.name = name
	object.parent = parent
	object:SetProfile()
	--object.db = addon.db.profile.blocks[name]
	object.config = config
	object:Initialize()
	return object
end

function BlockDisplay:Initialize()
	local baseName = "CompactRunes"
	self.varName = self.name:gsub(" ", "")
	local frameName = baseName.."_"..self.name.."_Block"
	local frame = _G.CreateFrame("Frame", 
		frameName, self.parent)
	self.frame = frame
	frame.obj = self
	frame.parentFrame = self.parent

	frame.texture = frame:CreateTexture(nil, "ARTWORK")
	frame.texture:SetAllPoints(frame)
	frame.texture:SetVertexColor(1, 1, 1)
	frame.texture:SetTexture(addon.SpellIcons[self.config.spell])

	frame.cd = _G.CreateFrame("Cooldown", frameName.."_CD", frame,
		"CooldownFrameTemplate")
	frame.cd:SetAllPoints()
	frame.active = false
	frame.timer = 0
	frame.cd:SetAlpha(0.9)
	frame.cd:SetReverse(true)
	frame.cd:SetSwipeColor(0, 0, 0, 0.6)

	self.value = frame.cd:CreateFontString(nil, "OVERLAY")
	self.value:SetPoint("CENTER")
	self.value:SetJustifyH("CENTER")
	self.value:Show()

	frame:SetMovable(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart",
		function(self, button)
			if not addon.profile.locked then
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
			self.obj.db.x, self.obj.db.y = x, y
			self:SetUserPlaced(false);
		end)
	frame:EnableMouse(self.db.attached and not addon.profile.locked)
	self:UpdateLayout()
	self:ResetFonts()
end

function BlockDisplay:SetProfile()
	self.db = addon.db.profile.blocks[self.name]
end

function BlockDisplay:UpdateColor()
	local c = self.db.bkgcolor
	self.frame:SetBackdropColor(c.r, c.g, c.b, c.a)
end

function BlockDisplay:UpdateLayout()
	local frame = self.frame
	frame:EnableMouse(not self.db.attached and not addon.profile.locked)
	frame:SetWidth(self.db.width)
	frame:SetHeight(self.db.height)

	frame:ClearAllPoints()
	frame:SetPoint("CENTER", _G.UIParent, "CENTER", self.db.x, self.db.y)

	self:SetAlpha()

--[[
	if self.db.background then
		frame:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8X8", 
			edgeFile = "",
			tile = true, tileSize = 16, edgeSize = 16,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
			})
		self:UpdateColor()
	else
		frame:SetBackdrop(nil)
	end
]]--
end

function BlockDisplay:SetTextColor()
	local c = self.db.textcolor
	self.value:SetTextColor(c.r, c.g, c.b, c.a)
end

function BlockDisplay:ResetFonts()
	local font, fh, fflags = addon:GetFontSettings()
	if self.value then
		self.value:SetFont(font, self.db.fontSize or fh, fflags)
		self.value:SetText(self.value:GetText())
		local c = self.db.textcolor
		self.value:SetTextColor(c.r, c.g, c.b, c.a)
	end
end

function BlockDisplay:Show()
	self.frame:Show()
end

function BlockDisplay:Hide()
	self.frame:Hide()
end

function BlockDisplay:SetAlpha()
	if not module.enabled then return end

	local alpha = 0
	local active = self.frame.active

	if _G.UnitAffectingCombat("player") then
		alpha = active and self.db.activeAlpha or self.db.combatAlpha
	else
		alpha = self.db.oocAlpha
	end

	self.frame:SetAlpha(alpha)
end
