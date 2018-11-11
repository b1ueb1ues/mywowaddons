local _G = getfenv(0)
local ADDON_NAME, addon = ...

local ipairs = _G.ipairs
local pairs = _G.pairs
local floor = _G.math.floor
local select = _G.select
local tostring = _G.tostring
local tsort = _G.table.sort
local tinsert = _G.table.insert

local SpellNames = addon.SpellNames
local ItemNames = addon.ItemNames

local CompactRunes = LibStub("AceAddon-3.0"):GetAddon(addon.addonName)
local L = LibStub("AceLocale-3.0"):GetLocale(addon.addonName)
local LSM = _G.LibStub:GetLibrary("LibSharedMedia-3.0")
local Icon = _G.LibStub("LibDBIcon-1.0")

local function GetOptionsBarList()
	return {
		-- General
		["Proc Icon"] = {
			["frame"] = addon.frames.procInd,
			["profile"] = addon.db.profile.procIcon,
			["setColor"] = false,
		},
		["Runic Power Bar"] = {
			["frame"] = addon.frames.powerBar,
			["profile"] = addon.db.profile.bars["RunicPowerBar"],
			["barProfileName"] = "RunicPowerBar",
		},
		["Death and Decay Bar"] = {
			["frame"] = addon.frames.ddBar,
			["profile"] = addon.db.profile.bars["DeathAndDecayBar"],
			["barProfileName"] = "DeathAndDecayBar",
		},
		-- Diseases
		["Frost Fever Bar"] = {
			["frame"] = addon.frames.ffBar,
			["profile"] = addon.db.profile.bars["FrostFeverBar"],
			["barProfileName"] = "FrostFeverBar",
		},
		["Blood Plague Bar"] = {
			["frame"] = addon.frames.bpBar,
			["profile"] = addon.db.profile.bars["BloodPlagueBar"],
			["barProfileName"] = "BloodPlagueBar",
		},
		["Virulent Plague Bar"] = {
			["frame"] = addon.frames.vpBar,
			["profile"] = addon.db.profile.bars["VirulentPlagueBar"],
			["barProfileName"] = "VirulentPlagueBar",
		},
		-- Blood spec
		["Blood Shield Bar"] = {
			["frame"] = addon.frames.bsBar,
			["profile"] = addon.db.profile.bars["BloodShieldBar"],
			["barProfileName"] = "BloodShieldBar",
		},
		["Rune Strike Bar"] = {
			["frame"] = addon.frames.rtBar,
			["profile"] = addon.db.profile.bars["RuneStrikeBar"],
			["barProfileName"] = "RuneStrikeBar",
		},
		["Blood Boil Bar"] = {
			["frame"] = addon.frames.bbBar,
			["profile"] = addon.db.profile.bars["BloodBoilBar"],
			["barProfileName"] = "BloodBoilBar",
		},
		["Bone Shield Bar"] = {
			["frame"] = addon.frames.boneBar,
			["profile"] = addon.db.profile.bars["BoneShieldBar"],
			["barProfileName"] = "BoneShieldBar",
		},
		["Vampiric Blood Bar"] = {
			["frame"] = addon.frames.boneBar,
			["profile"] = addon.db.profile.bars["VampiricBloodBar"],
			["barProfileName"] = "VampiricBloodBar",
		},
		-- Unholy
		["Festering Wound Bar"] = {
			["frame"] = addon.frames.fwBar,
			["profile"] = addon.db.profile.bars["FesteringWoundBar"],
			["barProfileName"] = "FesteringWoundBar",
		},
		["Dark Transformation Bar"] = {
			["frame"] = addon.frames.dtBar,
			["profile"] = addon.db.profile.bars["DarkTransformationBar"],
			["barProfileName"] = "DarkTransformationBar",
		},
		["Epidemic Bar"] = {
			["frame"] = addon.frames.epBar,
			["profile"] = addon.db.profile.bars["EpidemicBar"],
			["barProfileName"] = "EpidemicBar",
		},
		["Soul Reaper Bar"] = {
			["frame"] = addon.frames.srBar,
			["profile"] = addon.db.profile.bars["SoulReaperBar"],
			["barProfileName"] = "SoulReaperBar",
		},
		["Pestilent Pustules Bar"] = {
			["frame"] = addon.frames.ppBar,
			["profile"] = addon.db.profile.bars["PestilentPustulesBar"],
			["barProfileName"] = "PestilentPustulesBar",
		},
		["Scourge of Worlds Bar"] = {
			["frame"] = addon.frames.sowBar,
			["profile"] = addon.db.profile.bars["SoWBar"],
			["barProfileName"] = "SoWBar",
		},
		-- Frost
		["Icy Talons Bar"] = {
			["frame"] = addon.frames.itBar,
			["profile"] = addon.db.profile.bars["IcyTalonsBar"],
			["barProfileName"] = "IcyTalonsBar",
		},
		["Razorice Bar"] = {
			["frame"] = addon.frames.riBar,
			["profile"] = addon.db.profile.bars["RazoriceBar"],
			["barProfileName"] = "RazoriceBar",
		},
		["Remorseless Winter Bar"] = {
			["frame"] = addon.frames.rwBar,
			["profile"] = addon.db.profile.bars["RemorselessWinterBar"],
			["barProfileName"] = "RemorselessWinterBar",
		},
	}
end

function CompactRunes:GetOptions()
	if not addon.options then
		addon.options = {
			type = "group",
			name = addon.addonTitle,
			args = {
				core = self:GetGeneralOptions(),
				cooldowns = self:GetCooldownOptions(),
				layout = self:GetLayoutOptions(),
				colors = self:GetColorsOptions(),
				procs = self:GetProcsOptions(),
				sounds = self:GetSoundOptions(),
				--ignoreRunes = self:GetIgnoreRuneCDOptions(),
			}
		}
		addon.options.args.profile =
			_G.LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)

		-- Add additional options for modules
		for name, obj in pairs(addon.modules) do
			if obj and obj.GetOptions then
				local name, opts = obj:GetOptions()
				addon.options.args[name] = opts
			end
		end
	end
	return addon.options
end

function CompactRunes:ShowOptions()
	-- Call it twice to ensure it opens to the settings.
	_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame.Main)
	_G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrame.Main)
end

function CompactRunes:GetBasicOptions()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["General Options"],
		},
		locked = {
			name = L["Lock"],
			desc = L["LockDesc"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.locked = val
				if addon.frames.main then
					addon.frames.main.lock = val
					addon.frames.main:EnableMouse(not val)
				end
				for name, bar in pairs(self.cdbars) do
					if bar then bar:Lock(val) end
				end
				addon:FireCallback("FrameLock")
			end,
			get = function(info)
				return self.db.profile.locked
			end,
		},
		hideBlizzard = {
			name = L["Hide Blizzard Runes"],
			desc = L["HideBlizzardDesc"],
			type = "toggle",
			order = 20,
			set = function(info, val)
				self.db.profile.hideBlizzardFrames = val
				addon:HideBlizzardFrames()
			end,
			get = function(info)
				return self.db.profile.hideBlizzardFrames
			end,
		},
		minimap = {
			order = 30,
			name = L["Minimap Button"],
			desc = L["Toggle the minimap button"],
			type = "toggle",
			set = function(info,val)
				-- Reverse the value since the stored value is to hide it
				self.db.profile.minimap.hide = not val
				if self.db.profile.minimap.hide then
					Icon:Hide("CompactRunesLDB")
				else
					Icon:Show("CompactRunesLDB")
				end
			end,
			get = function(info)
				-- Reverse the value since the stored value is to hide it
				return not self.db.profile.minimap.hide
			end,
		},
	}
	return options
end

function CompactRunes:GetFeaturesOptions()
	local options = {
		commonHdr = {
			order = 1,
			type = "header",
			name = L["All"],
		},
		runicpower = {
			name = L["Runic Power"],
			desc = L["RunicPowerDesc"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.bars.RunicPowerBar.enabled = val
				self:ShowRunicPowerBar()
			end,
			get = function(info)
				return self.db.profile.bars.RunicPowerBar.enabled
			end,
		},
		procs = {
			name = L["Procs"],
			desc = L["ProcsDesc"],
			type = "toggle",
			order = 20,
			set = function(info, val)
			    self.db.profile.procs = val
			end,
			get = function(info)
				return self.db.profile.procs
			end,
		},
		bloodHdr = {
			order = 100,
			type = "header",
			name = L["Blood"],
		},
		bloodPlague = {
			name = SpellNames["Blood Plague"],
			desc = SpellNames["Blood Plague"],
			type = "toggle",
			order = 110,
			set = function(info, val)
				self.db.profile.bars.BloodPlagueBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.BloodPlagueBar.enabled
			end,
		},
		bloodshield = {
			name = SpellNames["Blood Shield"],
			desc = SpellNames["Blood Shield"],
			type = "toggle",
			order = 120,
			set = function(info, val)
				self.db.profile.bars.BloodShieldBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.BloodShieldBar.enabled
			end,
		},
		boneshield = {
			name = SpellNames["Bone Shield"],
			desc = SpellNames["Bone Shield"],
			type = "toggle",
			order = 130,
			set = function(info, val)
				self.db.profile.bars.BoneShieldBar.enabled = val
				addon.frames.boneBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.BoneShieldBar.enabled
			end,
		},
		bloodboil = {
			name = SpellNames["Blood Boil"],
			desc = SpellNames["Blood Boil"],
			type = "toggle",
			order = 140,
			set = function(info, val)
				self.db.profile.bars.BloodBoilBar.enabled = val
				addon.frames.bbBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.BloodBoilBar.enabled
			end,
		},
		runestrike = {
			name = SpellNames["Rune Strike"],
			desc = SpellNames["Rune Strike"],
			type = "toggle",
			order = 150,
			set = function(info, val)
				self.db.profile.bars.RuneStrikeBar.enabled = val
				addon.frames.rtBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.RuneStrikeBar.enabled
			end,
		},
		vampiricBlood = {
			name = SpellNames["Vampiric Blood"],
			desc = SpellNames["Vampiric Blood"],
			type = "toggle",
			order = 160,
			set = function(info, val)
				self.db.profile.bars.VampiricBloodBar.enabled = val
				addon.frames.vbBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.VampiricBloodBar.enabled
			end,
		},
		frostHdr = {
			order = 200,
			type = "header",
			name = L["Frost"],
		},
		frostFever = {
			name = SpellNames["Frost Fever"],
			desc = SpellNames["Frost Fever"],
			type = "toggle",
			order = 210,
			set = function(info, val)
				self.db.profile.bars.FrostFeverBar.enabled = val
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.FrostFeverBar.enabled
			end,
		},
		icyTalons = {
			name = SpellNames["Icy Talons"],
			desc = SpellNames["Icy Talons"],
			type = "toggle",
			order = 220,
			set = function(info, val)
				self.db.profile.bars.IcyTalonsBar.enabled = val
				addon.frames.itBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.IcyTalonsBar.enabled
			end,
		},
		razorice = {
			name = SpellNames["Razorice"],
			desc = SpellNames["Razorice"],
			type = "toggle",
			order = 230,
			set = function(info, val)
				self.db.profile.bars.RazoriceBar.enabled = val
				addon.frames.riBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.RazoriceBar.enabled
			end,
		},
		remorselesswinter = {
			name = SpellNames["Gathering Storm"],
			desc = SpellNames["Gathering Storm"],
			type = "toggle",
			order = 240,
			set = function(info, val)
				self.db.profile.bars.RemorselessWinterBar.enabled = val
				addon.frames.rwBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.RemorselessWinterBar.enabled
			end,
		},
		unholyHdr = {
			order = 300,
			type = "header",
			name = L["Unholy"],
		},
		virulentPlague = {
			name = SpellNames["Virulent Plague"],
			desc = SpellNames["Virulent Plague"],
			type = "toggle",
			order = 310,
			set = function(info, val)
				self.db.profile.bars.VirulentPlagueBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.VirulentPlagueBar.enabled
			end,
		},
		festeringWound = {
			name = SpellNames["Festering Wound"],
			desc = SpellNames["Festering Wound"],
			type = "toggle",
			order = 310,
			set = function(info, val)
				self.db.profile.bars.FesteringWoundBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.FesteringWoundBar.enabled
			end,
		},
		darktrans = {
			name = SpellNames["Dark Transformation"],
			desc = SpellNames["Dark Transformation"],
			type = "toggle",
			order = 320,
			set = function(info, val)
				self.db.profile.bars.DarkTransformationBar.enabled = val
				addon.frames.dtBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.DarkTransformationBar.enabled
			end,
		},
		epidemic = {
			name = SpellNames["Epidemic"],
			desc = SpellNames["Epidemic"],
			type = "toggle",
			order = 340,
			set = function(info, val)
				self.db.profile.bars.EpidemicBar.enabled = val
				addon.frames.epBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.EpidemicBar.enabled
			end,
		},
		soulReaper = {
			name = SpellNames["Soul Reaper"],
			desc = SpellNames["Soul Reaper"],
			type = "toggle",
			order = 350,
			set = function(info, val)
				self.db.profile.bars.SoulReaperBar.enabled = val
				addon.frames.srBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.SoulReaperBar.enabled
			end,
		},
		pestilentPustules = {
			name = SpellNames["Pestilent Pustules"],
			desc = SpellNames["Pestilent Pustules"],
			type = "toggle",
			order = 350,
			set = function(info, val)
				self.db.profile.bars.PestilentPustulesBar.enabled = val
				addon.frames.ppBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.PestilentPustulesBar.enabled
			end,
		},
		scourgeOfWorlds = {
			name = SpellNames["Scourge of Worlds"],
			desc = SpellNames["Scourge of Worlds"],
			type = "toggle",
			order = 350,
			set = function(info, val)
				self.db.profile.bars.SoWBar.enabled = val
				addon.frames.sowBar:OnTalentUpdate()
				self:UpdateBarLayout()
			end,
			get = function(info)
				return self.db.profile.bars.SoWBar.enabled
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForRunes()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Runes"],
		},
		runeOrientation = {
			order = 10,
			name = L["Rune Orientation"],
			desc = L["RuneOrientation_Desc"],
			type = "select",
			values = {
				["HORIZONTAL"] = L["Horizontal"],
				["VERTICAL"] = L["Vertical"],
			},
			set = function(info, val)
				self.db.profile.runeOrientation = val
			end,
			get = function(info)
				return self.db.profile.runeOrientation
			end,
		},
		runeOrderHdr = {
			order = 100,
			type = "header",
			name = L["Rune Order"],
		},
		sortRunes = {
			name = L["Sort Runes"],
			desc = L["SortRunes_Desc"],
			type = "toggle",
			order = 110,
			set = function(info, val)
				self.db.profile.sortRunes = val
			end,
			get = function(info)
				return self.db.profile.sortRunes
			end,
		},
		runeSortOrder = {
			order = 120,
			name = L["Rune Order"],
			desc = L["Rune Order"],
			type = "select",
			values = {
				["Right"] = L["Right"],
				["Down"] = L["Down"],
				["Left"] = L["Left"],
				["Up"] = L["Up"],
			},
			set = function(info, val)
				self.db.profile.runeSortOrder = val
			end,
			get = function(info)
				return self.db.profile.runeSortOrder
			end,
			disabled = function()
				return not self.db.profile.sortRunes
			end,
		},
		refreshingRunes = {
			order = 200,
			type = "header",
			name = L["Recharging Runes"],
		},
		rechargeAlpha = {
			order = 210,
			name = L["Recharge Alpha"],
			desc = L["RechargeAlpha_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.rechargeAlpha = val
				if addon.frames.main and not _G.InCombatLockdown() then
					addon.frames.main:SetAlpha(self.db.profile.rechargeAlpha)
				end
			end,
			get = function(info, val)
				return self.db.profile.rechargeAlpha
			end,
		},
		rechargeTimers = {
			name = L["Recharge Timers"],
			desc = L["RechargeTimerDesc"],
			type = "select",
			values = {
				["None"] = L["None"],
				["Recharging"] = L["Only Recharging"],
				["All"] = L["All"],
			},
			order = 220,
			set = function(info, val)
				self.db.profile.rechargeTimers = val
				self:ShowRechargeNumbers(val)
			end,
			get = function(info)
				return self.db.profile.rechargeTimers
			end,
		},
		almostReady = {
			order = 230,
			name = L["Almost Ready"],
			desc = L["AlmostReady_Desc"],
			type = "range",
			min = 0,
			max = 4,
			step = 0.5,
			set = function(info, val)
				self.db.profile.almostReadyTime = val
			end,
			get = function(info, val)
				return self.db.profile.almostReadyTime
			end,
		},
		almostReadyAlpha = {
			order = 240,
			name = L["Almost Ready Alpha"],
			desc = L["AlmostReadyAlpha_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.almostReadyAlpha = val
			end,
			get = function(info, val)
				return self.db.profile.almostReadyAlpha
			end,
		},
		runeBackgroundHdr = {
			order = 290,
			type = "header",
			name = L["Rune Background"],
		},
		runeBackground = {
			order = 291,
			name = L["Rune Background"],
			desc = L["RuneBackground_Desc"],
			type = "select",
			values = {
				[1] = L["Rune Color"],
				[2] = L["Transparent"],
				[3] = L["Black"],
			},
			set = function(info, val)
				self.db.profile.runeBackground = val
				self:SetRuneBackground()
				self:UpdateRunes()
			end,
			get = function(info)
				return self.db.profile.runeBackground
			end,
		},
		runeBackgroundAlpha = {
			order = 295,
			name = L["Background Alpha"],
			desc = L["RuneBackgroundAlpha_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.runeBackgroundAlpha = val
				self:SetRuneBackground()
				self:UpdateRunes()
			end,
			get = function(info, val)
				return self.db.profile.runeBackgroundAlpha
			end,
			disabled = function()
				return self.db.profile.runeBackground ~= 1
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForDiseases()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Diseases"],
		},
		frostFever = {
			name = SpellNames["Frost Fever"],
			desc = SpellNames["Frost Fever"],
			type = "toggle",
			order = 20,
			set = function(info, val)
				self.db.profile.bars.FrostFeverBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.FrostFeverBar.enabled
			end,
		},
		bloodPlague = {
			name = SpellNames["Blood Plague"],
			desc = SpellNames["Blood Plague"],
			type = "toggle",
			order = 30,
			set = function(info, val)
				self.db.profile.bars.BloodPlagueBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.BloodPlagueBar.enabled
			end,
		},
		virulentPlague = {
			name = SpellNames["Virulent Plague"],
			desc = SpellNames["Virulent Plague"],
			type = "toggle",
			order = 40,
			set = function(info, val)
				self.db.profile.bars.VirulentPlagueBar.enabled = val
			end,
			get = function(info)
				return self.db.profile.bars.VirulentPlagueBar.enabled
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForCooldownBars()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Cooldown Bars"],
		},
		showCDText = {
			order = 20,
			name = L["Numeric Timers"],
			desc = L["NumericTimer_OptDesc"],
			type = "toggle",
			set = function(info, val)
				self.db.profile.showCDText = val
				self:UpdateCDBars()
			end,
			get = function(info)
				return self.db.profile.showCDText
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForProcIcon()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Proc Icon"],
		},
		procs = {
			name = L["Enabled"],
			desc = L["ProcsDesc"],
			type = "toggle",
			order = 10,
			set = function(info, val)
			    self.db.profile.procs = val
			end,
			get = function(info)
				return self.db.profile.procs
			end,
		},
		iconScale = {
			order = 150,
			name = L["Proc Indicator Scale"],
			desc = L["ProcIndScale_Desc"],
			type = "range",
			min = 1,
			max = 2,
			step = 0.01,
			bigStep = 0.05,
			isPercent = true,
			set = function(info, val)
				self.db.profile.procIcon.scale = val
				addon.frames.procInd:SetDimensions()
			end,
			get = function(info, val)
				return self.db.profile.procIcon.scale
			end,
		},
		displayAlphas = {
			order = 200,
			type = "header",
			name = L["Display Alpha"],
		},
		combatAlpha = {
			order = 210,
			name = L["In Combat"],
			desc = L["In Combat"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.procIcon.alphas.combat = val
			end,
			get = function(info, val)
				return self.db.profile.procIcon.alphas.combat
			end,
		},
		oocAlpha = {
			order = 220,
			name = L["Out of Combat"],
			desc = L["Out of Combat"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.procIcon.alphas.ooc = val
				if addon.frames.main then
					self:SetDisplayAlpha()
				end
			end,
			get = function(info, val)
				return self.db.profile.procIcon.alphas.ooc
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForBorderIndicators()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Border Indicators"],
		},
		rangeInd = {
			name = L["Range Indicator"],
			desc = L["RangeInd_Desc"],
			type = "toggle",
			order = 151,
			set = function(info, val)
			    self.db.profile.rangeInd = val
			end,
              get = function(info)
				return self.db.profile.rangeInd
			end,
		},
		rcProcInd = {
			name = SpellNames["Runic Corruption"],
			desc = L["RunicCorruptionInd_Desc"],
			type = "toggle",
			order = 152,
			set = function(info, val)
			    self.db.profile.rcProcInd = val
			end,
              get = function(info)
				return self.db.profile.rcProcInd
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForBoneShield()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = SpellNames["Bone Shield"],
		},
		enabled = {
			name = L["Enabled"],
			desc = SpellNames["Bone Shield"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.bars.BoneShieldBar.enabled = val
				addon.frames.boneBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.BoneShieldBar.enabled
			end,
		},
		progressBar = {
			name = L["Progress Bar"],
			desc = L["BoneShieldProgressDesc"],
			type = "select",
			values = {
				["None"] = L["None"],
				["Time"] = L["Time Remaining"],
				["Charges"] = L["Charges"]
			},
			order = 20,
			set = function(info, val)
				self.db.profile.bars["BoneShieldBar"].progress = val
				addon.frames.boneBar:UpdateBoneShieldBarMode()
			end,
			get = function(info)
				return self.db.profile.bars["BoneShieldBar"].progress
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForRunicPower()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Runic Power Bar"],
		},
		runicpower = {
			name = L["Enabled"],
			desc = L["RunicPowerDesc"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.bars.RunicPowerBar.enabled = val
				self:ShowRunicPowerBar()
			end,
			get = function(info)
				return self.db.profile.bars.RunicPowerBar.enabled
			end,
		},
		rpNumericValue = {
			name = L["Numeric Value"],
			desc = L["NumericValue_Desc"],
			type = "toggle",
			order = 20,
			set = function(info, val)
				self.db.profile.bars.RunicPowerBar.showNumericValue = val
				if addon.frames.powerBar then addon.frames.powerBar:UpdateDisplay() end
			end,
			get = function(info)
				return self.db.profile.bars.RunicPowerBar.showNumericValue
			end,
		},
		tickMarkHdr = {
			order = 100,
			type = "header",
			name = L["Tick Marks"],
		},
		tickEnabled = {
			name = L["Enabled"],
			desc = L["Enabled"],
			type = "toggle",
			order = 110,
			set = function(info, val)
				self.db.profile.rpTicks.enabled = val
				if addon.frames.powerBar then addon.frames.powerBar:UpdateDisplay() end
			end,
			get = function(info)
				return self.db.profile.rpTicks.enabled
			end,
		},
		tickWidth = {
			order = 120,
			name = L["Width"],
			desc = L["Width"],
			type = "range",
			min = 1,
			max = 9,
			step = 1,
			set = function(info, val)
				self.db.profile.rpTicks.width = val
				if addon.frames.powerBar then addon.frames.powerBar:UpdateDisplay() end
			end,
			get = function(info,val) return self.db.profile.rpTicks.width end,
		},
		tickColor = {
			order = 130,
			name = L["Color"],
			desc = L["Color"],
			type = "color",
			hasAlpha = true,
			set = function(info, r, g, b, a)
				local c = self.db.profile.rpTicks.color
				c.r, c.g, c.b, c.a = r, g, b, a
				if addon.frames.powerBar then addon.frames.powerBar:UpdateDisplay() end
			end,
			get = function(info)
				local c = self.db.profile.rpTicks.color
				return c.r, c.g, c.b, c.a
			end,
		},
		tickIncrement = {
				order = 140,
				type = "header",
				name = L["Increment"],
		},
		tickIncrementDesc = {
			order = 141,
			type = "description",
			name = L["TickIncrementDesc"],
		},
	}

	local i = 1
	for k, v in pairs(self.db.profile.rpTicks.specs) do
		options[k.."IncrementTick"] = {
			order = 141+i,
			name = L[k],
			desc = L["Increment"] .. " - " .. L[k],
			type = "range",
			min = 10,
			max = 100,
			step = 1,
			set = function(info, val)
				self.db.profile.rpTicks.specs[k].cost = val
				if addon.frames.powerBar then addon.frames.powerBar:UpdateDisplay() end
			end,
			get = function(info, val)
				return self.db.profile.rpTicks.specs[k].cost
			end,
		}
		i = i + 1
	end

	return options
end

function CompactRunes:GetOptionsForDeathDecay()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = SpellNames["Death and Decay"],
		},
		enabled = {
			name = L["Enabled"],
			desc = SpellNames["Death and Decay"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.bars.DeathAndDecayBar.enabled = val
				addon.frames.ddBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.DeathAndDecayBar.enabled
			end,
		},
		showCD = {
			order = 20,
			name = L["Show on Cooldown"],
			desc = L["Show on Cooldown"],
			type = "toggle",
			set = function(info, val)
				self.db.profile.bars.DeathAndDecayBar.showCooldown = val
			end,
			get = function(info)
				return self.db.profile.bars.DeathAndDecayBar.showCooldown
			end,
		},
		specs = {
			order = 100,
			type = "header",
			name = L["Specializations"],
		},
		bloodSpec = {
			name = L["Blood"],
			desc = L["Blood"],
			type = "toggle",
			order = 110,
			set = function(info, val)
				self.db.profile.bars.DeathAndDecayBar.specs.Blood = val
				addon.frames.ddBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.DeathAndDecayBar.specs.Blood
			end,
		},
		unholySpec = {
			name = L["Unholy"],
			desc = L["Unholy"],
			type = "toggle",
			order = 120,
			set = function(info, val)
				self.db.profile.bars.DeathAndDecayBar.specs.Unholy = val
				addon.frames.ddBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.DeathAndDecayBar.specs.Unholy
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForSoulReaper()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = SpellNames["Soul Reaper"],
		},
		enabled = {
			name = L["Enabled"],
			desc = SpellNames["Soul Reaper"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.bars.SoulReaperBar.enabled = val
				addon.frames.srBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.SoulReaperBar.enabled
			end,
		},
		showCD = {
			order = 20,
			name = L["Show on Cooldown"],
			desc = L["Show on Cooldown"],
			type = "toggle",
			set = function(info, val)
				self.db.profile.bars.SoulReaperBar.showCooldown = val
			end,
			get = function(info)
				return self.db.profile.bars.SoulReaperBar.showCooldown
			end,
		},
		numerics = {
			order = 100,
			type = "header",
			name = L["Numeric Value"],
		},
		primaryValue = {
			order = 110,
			name = L["Primary"],
			desc = L["Primary"],
			type = "select",
			values = {
				["Time"] = L["Time Remaining"],
				["Stacks"] = L["Stacks"],
			},
			set = function(info, val)
				self.db.profile.bars.SoulReaperBar.primaryValue = val
			end,
			get = function(info)
				return self.db.profile.bars.SoulReaperBar.primaryValue
			end,
		},
		secondaryValue = {
			order = 110,
			name = L["Secondary"],
			desc = L["Secondary"],
			type = "select",
			values = {
				["None"] = L["None"],
				["Time"] = L["Time Remaining"],
				["Stacks"] = L["Stacks"],
			},
			set = function(info, val)
				self.db.profile.bars.SoulReaperBar.secondaryValue = val
			end,
			get = function(info)
				return self.db.profile.bars.SoulReaperBar.secondaryValue
			end,
		},

	}
	return options
end

function CompactRunes:GetOptionsForDarkTransformation()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = SpellNames["Dark Transformation"],
		},
		enabled = {
			name = L["Enabled"],
			desc = SpellNames["Dark Transformation"],
			type = "toggle",
			order = 10,
			set = function(info, val)
				self.db.profile.bars.DarkTransformationBar.enabled = val
				addon.frames.dtBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.DarkTransformationBar.enabled
			end,
		},
		showCD = {
			order = 20,
			name = L["Show on Cooldown"],
			desc = L["ShowCooldownDesc"],
			type = "select",
			values = {
				["Never"] = L["Never"],
				["ShadowInfusion"] = SpellNames["Shadow Infusion"],
				["Always"] = L["Always"],
			},
			set = function(info, val)
				self.db.profile.bars.DarkTransformationBar.showCooldown = val
				addon.frames.dtBar:OnTalentUpdate()
			end,
			get = function(info)
				return self.db.profile.bars.DarkTransformationBar.showCooldown
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForDisplayAlpha()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Display Alpha"],
		},
		combatAlpha = {
			order = 10,
			name = L["In Combat"],
			desc = L["In Combat"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.combatAlpha = val
			end,
			get = function(info, val)
				return self.db.profile.combatAlpha
			end,
		},
		oocAlpha = {
			order = 20,
			name = L["Out of Combat"],
			desc = L["Out of Combat"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.ooc_alpha = val
				if addon.frames.main then
					self:SetDisplayAlpha()
				end
			end,
			get = function(info, val)
				return self.db.profile.ooc_alpha
			end,
		},
		vehicleAlpha = {
			order = 30,
			name = L["Vehicle"],
			desc = L["VehicleAlpha_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.vehicleAlpha = val
				if addon.frames.main then
					self:SetDisplayAlpha()
				end
			end,
			get = function(info, val)
				return self.db.profile.vehicleAlpha
			end,
		},
		petBattle = {
			order = 35,
			name = L["Pet Battle"],
			desc = L["PetBattleAlpha_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.alphas.petBattle = val
				if addon.frames.main then
					self:SetDisplayAlpha()
				end
			end,
			get = function(info, val)
				return self.db.profile.alphas.petBattle
			end,
		},
		oocRechargeAlphaEnable = {
			order = 40,
			name = L["OOC Recharge"],
			desc = L["OOCRechargeEnabled_Desc"],
			type = "toggle",
			set = function(info, val)
				self.db.profile.oocRechargeAlphaEnabled = val
			end,
			get = function(info)
				return self.db.profile.oocRechargeAlphaEnabled
			end,
		},
		oocRechargeAlpha = {
			order = 50,
			name = L["OOC Recharge"],
			desc = L["OOCRecharge_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.oocRechargeAlpha = val
				if addon.frames.main then
					self:SetDisplayAlpha()
				end
			end,
			get = function(info, val)
				return self.db.profile.oocRechargeAlpha
			end,
			disabled = function(info, val)
				return not self.db.profile.oocRechargeAlphaEnabled
			end
		},
		backdropAlpha = {
			order = 60,
			name = L["Backdrop Alpha"],
			desc = L["Backdrop Alpha"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
				self.db.profile.frame.color.a = val
				local frame = addon.frames.main
				if frame and frame.UpdateBackdropColor then
					frame:UpdateBackdropColor()
				end
			end,
			get = function(info)
				return self.db.profile.frame.color.a
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForDimensions()
	local options = {
		dimensions = {
			order = 100,
			type = "header",
			name = L["Dimensions"] .. " - " .. L["Horizontal"],
		},
		width = {
			order = 110,
			name = L["Width"],
			desc = L["BarWidth_Desc"],
			type = "range",
			min = 10,
			max = 100,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["HORIZONTAL"].width = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["HORIZONTAL"].width
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "HORIZONTAL"
			end,
		},
		height = {
			order = 120,
			name = L["Height"],
			desc = L["BarHeight_Desc"],
			type = "range",
			min = 5,
			max = 50,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["HORIZONTAL"].height = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["HORIZONTAL"].height
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "HORIZONTAL"
			end,
		},
		spacing = {
			order = 130,
			name = L["Spacing"],
			desc = L["Spacing_OptDesc"],
			type = "range",
			min = 1,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["HORIZONTAL"].spacing = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["HORIZONTAL"].spacing
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "HORIZONTAL"
			end,
		},
		inset = {
			order = 135,
			name = L["Inset"],
			desc = L["Inset_OptDesc"],
			type = "range",
			min = 1,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["HORIZONTAL"].inset = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["HORIZONTAL"].inset
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "HORIZONTAL"
			end,
		},
		barSpacing = {
			order = 137,
			name = L["Bar Spacing"],
			desc = L["BarSpacing_OptDesc"],
			type = "range",
			min = 1,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["HORIZONTAL"].barSpacing = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["HORIZONTAL"].barSpacing
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "HORIZONTAL"
			end,
		},
		vdimensions = {
			order = 200,
			type = "header",
			name = L["Dimensions"] .. " - " .. L["Vertical"],
		},
		vwidth = {
			order = 210,
			name = L["Width"],
			desc = L["BarWidth_Desc"],
			type = "range",
			min = 5,
			max = 100,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["VERTICAL"].width = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["VERTICAL"].width
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "VERTICAL"
			end,
		},
		vheight = {
			order = 220,
			name = L["Height"],
			desc = L["BarHeight_Desc"],
			type = "range",
			min = 5,
			max = 100,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["VERTICAL"].height = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["VERTICAL"].height
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "VERTICAL"
			end,
		},
		vspacing = {
			order = 230,
			name = L["Spacing"],
			desc = L["Spacing_OptDesc"],
			type = "range",
			min = 1,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["VERTICAL"].spacing = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["VERTICAL"].spacing
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "VERTICAL"
			end,
		},
		vinset = {
			order = 235,
			name = L["Inset"],
			desc = L["Inset_OptDesc"],
			type = "range",
			min = 1,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["VERTICAL"].inset = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["VERTICAL"].inset
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "VERTICAL"
			end,
		},
		vbarSpacing = {
			order = 237,
			name = L["Bar Spacing"],
			desc = L["BarSpacing_OptDesc"],
			type = "range",
			min = 1,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.dimensions["VERTICAL"].barSpacing = val
				self:Reset()
			end,
			get = function(info, val)
				return self.db.profile.dimensions["VERTICAL"].barSpacing
			end,
			disabled = function()
				return self.db.profile.runeOrientation ~= "VERTICAL"
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForFonts()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Font"],
		},
		fontSize = {
			order = 10,
			name = L["Font size"],
			desc = L["Font size for the bars."],
			type = "range",
			min = 8,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.font_size = val
				self:ResetFonts()
			end,
			get = function(info,val) return self.db.profile.font_size end,
		},
		fontFace = {
			order = 20,
			type = "select",
			name = L["Font"],
			desc = L["Font to use."],
			values = LSM:HashTable("font"),
			dialogControl = 'LSM30_Font',
			get = function() return self.db.profile.font_face end,
			set = function(info, val)
				self.db.profile.font_face = val
				self:ResetFonts()
			end
		},
		fontOutline = {
			name = L["Outline"],
			desc = L["FontOutlineDesc"],
			type = "toggle",
			order = 30,
			set = function(info, val)
				self.db.profile.fontFlags.OUTLINE = val
				self:ResetFonts()
			end,
			get = function(info)
				return self.db.profile.fontFlags.OUTLINE
			end,
		},
		thickoutline = {
			name = L["Thick Outline"],
			desc = L["FontThickOutline_OptionDesc"],
			type = "toggle",
			order = 40,
			set = function(info, val)
				self.db.profile.fontFlags.THICKOUTLINE = val
				self:ResetFonts()
			end,
			get = function(info)
				return self.db.profile.fontFlags.THICKOUTLINE
			end,
		},
		monochrome = {
			name = L["Monochrome"],
			desc = L["FontMonochromeDesc"],
			type = "toggle",
			order = 50,
			set = function(info, val)
				self.db.profile.fontFlags.MONOCHROME = val
				self:ResetFonts()
			end,
			get = function(info)
				return self.db.profile.fontFlags.MONOCHROME
			end,
		},
	}
	return options
end

function CompactRunes:GetOptionsForTextures()
	local options = {
		header = {
			order = 1,
			type = "header",
			name = L["Textures"],
		},
		bartexture = {
			order = 10,
			name = L["Bar Texture"],
			desc = L["BarTexture_OptionDesc"],
			type = "select",
			values = LSM:HashTable("statusbar"),
			dialogControl = 'LSM30_Statusbar',
			get = function()
				return self.db.profile.texture
			end,
			set = function(info, val)
				self.db.profile.texture = val
				self:UpdateTextures()
			end,
		},
		bordertexture = {
			order = 20,
			name = L["Border"],
			desc = L["Border_OptionDesc"],
			type = "select",
			values = LSM:HashTable("border"),
			dialogControl = 'LSM30_Border',
			get = function()
				return self.db.profile.border
			end,
			set = function(info, val)
				self.db.profile.border = val
				self:SetMainFrameBorder()
			end,
		},
		bordertextureind = {
			order = 30,
			name = L["Border Indicator"],
			desc = L["BorderInd_OptionDesc"],
			type = "select",
			values = LSM:HashTable("border"),
			dialogControl = 'LSM30_Border',
			get = function()
				return self.db.profile.borderInd
			end,
			set = function(info, val)
				self.db.profile.borderInd = val
				self:SetMainFrameBorder()
			end,
		},
	}
	return options
end

function CompactRunes:GetGeneralOptions()
	local core = {
		order = 1,
		name = L["Options"],
		type = "group",
		inline = true,
		args = {
			description = {
				order = 1,
				type = "description",
				name = L["CompactRunes_Desc"],
			},
			generalOpts = {
				order = 10,
				type = "group",
				name = L["General Options"],
				args = self:GetBasicOptions(),
			},
			features = {
				order = 15,
				type = "group",
				name = L["Features"],
				args = self:GetFeaturesOptions(),
			},
			runes = {
				order = 20,
				type = "group",
				name = L["Runes"],
				args = self:GetOptionsForRunes(),
			},
			diseases = {
				order = 30,
				type = "group",
				name = L["Diseases"],
				args = self:GetOptionsForDiseases(),
			},
			procIcon = {
				order = 50,
				type = "group",
				name = L["Proc Icon"],
				args = self:GetOptionsForProcIcon(),
			},
			cooldownBars = {
				order = 60,
				type = "group",
				name = L["Cooldown Bars"],
				args = self:GetOptionsForCooldownBars(),
			},
			borderIndicators = {
				order = 70,
				type = "group",
				name = L["Border Indicators"],
				args = self:GetOptionsForBorderIndicators(),
			},
			boneShield = {
				order = 80,
				type = "group",
				name = SpellNames["Bone Shield"],
				args = self:GetOptionsForBoneShield(),
			},
			runicPower = {
				order = 100,
				type = "group",
				name = L["Runic Power"],
				args = self:GetOptionsForRunicPower(),
			},
			deathAndDecay = {
				order = 110,
				type = "group",
				name = SpellNames["Death and Decay"],
				args = self:GetOptionsForDeathDecay(),
			},
			soulReaper = {
				order = 120,
				type = "group",
				name = SpellNames["Soul Reaper"],
				args = self:GetOptionsForSoulReaper(),
			},
			darkTranformation = {
				order = 130,
				type = "group",
				name = SpellNames["Dark Transformation"],
				args = self:GetOptionsForDarkTransformation(),
			},
			dimensions = {
				order = 1000,
				type = "group",
				name = L["Dimensions"],
				args = self:GetOptionsForDimensions(),
			},
			displayAlpha = {
				order = 1100,
				type = "group",
				name = L["Display Alpha"],
				args = self:GetOptionsForDisplayAlpha(),
			},
			ignoreRuneCDs = {
				order = 1200,
				type = "group",
				name = L["Ignore Rune CDs"],
				args = self:GetIgnoreRuneCDOptions(),
			},
			font = {
				order = 1300,
				type = "group",
				name = L["Font"],
				args = self:GetOptionsForFonts(),
			},
			textures = {
				order = 1400,
				type = "group",
				name = L["Textures"],
				args = self:GetOptionsForTextures(),
			},

		},
	}
	return core
end

function CompactRunes:GetLayoutOptions()
	local layout = {
	    order = 1,
		name = L["Layout"],
		type = "group",
		inline = true,
		args = {
		    description = {
		        order = 1,
		        type = "description",
		        name = L["LayoutDesc"],
		    },
		    layoutHdr = {
		        order = 100,
		        type = "header",
		        name = L["Layout"],
		    },
		}
	}

	layout.args["MainFrame_Layout"] = {
		order = 110,
		type = "group",
		name = L["Main Frame"],
		args = {
			xoffset = {
				order = 10,
				name = L["X Offset"],
				desc = L["XOffset_Desc"],
				type = "range",
				softMin = -floor(_G.GetScreenWidth()),
				softMax = floor(_G.GetScreenWidth()),
				bigStep = 1,
				set = function(info, val)
					self.db.profile.frame.x = val
					if addon.frames and addon.frames.main then
						addon.frames.main:SetDesiredPoint()
					end
				end,
				get = function(info, val)
					return self.db.profile.frame.x
				end,
			},
			yoffset = {
				order = 20,
				name = L["Y Offset"],
				desc = L["YOffset_Desc"],
				type = "range",
				softMin = -floor(_G.GetScreenHeight()),
				softMax = floor(_G.GetScreenHeight()),
				bigStep = 1,
				set = function(info, val)
					self.db.profile.frame.y = val
					if addon.frames and addon.frames.main then
						addon.frames.main:SetDesiredPoint()
					end
				end,
				get = function(info, val)
					return self.db.profile.frame.y
				end,
			},
		},
	}

	-- Keep some bars at the top of the list but sort the rest
	local bars = GetOptionsBarList()
	local barList = { "Proc Icon", "Runic Power Bar" }
	local barTable = {}
	for i, k in ipairs(barList) do
		barTable[k] = true
	end
	local tempList = {}
	for k, v in pairs(bars) do
		if not barTable[k] then
			tinsert(tempList, k)
		end
	end
	tsort(tempList)
	-- Merge the sorted list into barList
	for i, k in ipairs(tempList) do
		tinsert(barList, k)
	end

	for i, k in ipairs(barList) do
		layout.args[k.."_Layout"] = {
			order = 201+i,
			type = "group",
			name = L[k],
			args = self:GetLayoutOptionsForBar(k, bars[k]),
		}
	end

	return layout
end

function CompactRunes:GetLayoutOptionsForBar(name, data)
	local frame = data.frame
	local profile = data.profile
	local layoutOpts = {
		header = {
			order = 100,
			type = "header",
			name = L[name],
		},
		userPlaced = {
			name = L["Override"],
			desc = L["OverrideDesc"],
			type = "toggle",
			order = 110,
			set = function(info, val)
				profile.userPlaced = val
				frame:SetDesiredPoint()
			end,
			get = function(info)
				return profile.userPlaced
			end,
		},
		locked = {
			name = function()
				return frame:IsLocked() and L["Unlock"] or L["Lock"]
			end,
			desc = L["LockDesc"],
			type = "execute",
			order = 120,
			func = function(info, val)
				if frame then
					frame:Lock(not frame:IsLocked())
				end
			end,
			disabled = function()
				return not profile.userPlaced
			end,
		},
		xoffset = {
			order = 140,
			name = L["X Offset"],
			desc = L["XOffset_Desc"],
			type = "range",
			softMin = -floor(_G.GetScreenWidth()),
			softMax = floor(_G.GetScreenWidth()),
			bigStep = 1,
			set = function(info, val)
			    profile.x = val
				if profile.y == nil then profile.y = 0 end
				frame:SetDesiredPoint()
			end,
			get = function(info, val)
			    return profile.x
			end,
			disabled = function()
				return profile.userPlaced == false
			end,
		},
		yoffset = {
			order = 150,
			name = L["Y Offset"],
			desc = L["YOffset_Desc"],
			type = "range",
			softMin = -floor(_G.GetScreenHeight()),
			softMax = floor(_G.GetScreenHeight()),
			bigStep = 1,
			set = function(info, val)
			    profile.y = val
				if profile.x == nil then profile.x = 0 end
				frame:SetDesiredPoint()
			end,
			get = function(info, val)
			    return profile.y
			end,
			disabled = function()
				return profile.userPlaced == false
			end,
		},
		headerHeight = {
			order = 300,
			type = "header",
			name = L["Height"],
		},
		overrideHeight = {
			name = L["Override"],
			desc = L["OverrideDesc"],
			type = "toggle",
			order = 310,
			set = function(info, val)
				profile.overrideHeight = val
				frame:UpdateVisibility()
			end,
			get = function(info)
				return profile.overrideHeight
			end,
		},
		height = {
			order = 320,
			name = L["Height"],
			desc = L["Height"],
			type = "range",
			softMin = 5,
			softMax = 200,
			step = 1,
			set = function(info, val)
				profile.height = val
				frame:UpdateVisibility()
			end,
			get = function(info, val)
				return profile.overrideHeight and profile.height or frame:GetHeight()
			end,
			disabled = function()
				return profile.overrideHeight == false
			end,
		},
		headerWidth = {
			order = 400,
			type = "header",
			name = L["Width"],
		},
		overrideWidth = {
			name = L["Override"],
			desc = L["OverrideDesc"],
			type = "toggle",
			order = 410,
			set = function(info, val)
				profile.overrideWidth = val
				frame:UpdateVisibility()
			end,
			get = function(info)
				return profile.overrideWidth
			end,
		},
		width = {
			order = 420,
			name = L["Width"],
			desc = L["Width"],
			type = "range",
			softMin = 5,
			softMax = 200,
			step = 1,
			set = function(info, val)
				profile.width = val
				frame:UpdateVisibility()
			end,
			get = function(info, val)
				return profile.overrideWidth and profile.width or frame:GetWidth()
			end,
			disabled = function()
				return profile.overrideWidth == false
			end,
		},

	}
	return layoutOpts
end

function CompactRunes:GetProcsOptions()
	local procs = {
	    order = 2,
		name = L["Procs"],
		type = "group",
		inline = true,
		args = {
		    description = {
		        order = 1,
		        type = "description",
		        name = L["ProcsDesc"],
		    },
		    procsHdr = {
		        order = 100,
		        type = "header",
		        name = L["Procs"],
		    },
		},
	}

	local i = 1
	for k, v in pairs(self.db.profile.priorityList) do
		procs.args[k.."List"] = {
			order = 101+i,
			type = "group",
			name = k,
			args = self:GetProcsOptionsForSpec(k),
		}
		i = i + 1
	end

	return procs
end

function CompactRunes:GetProcsOptionsForSpec(spec)
	local procList = {
        priorityList = {
	  	    order = 105,
	  	    type = "group",
	  	    inline = true,
	  	    name = L["Priority List"],
	  	    args = {
			},
		},
		reset = {
			order = 110,
			type = "execute",
			name = L["Reset Order"],
			confirmText = L["ResetOrderDesc"],
			confirm = true,
			func = function() self:ResetPriorityList(spec) end,
		},
	}

	if self.db.profile.priorityList[spec] then
		for k, v in pairs(self.db.profile.priorityList[spec]) do
			--local argName = v:gsub(" ", "_")
			procList.priorityList.args[v] = {
				name = addon.SpecialSpellNames[v] and v or SpellNames[v],
				desc = SpellNames[v],
				type = "toggle",
				order = function()
					local o = 0
					for pr, name in pairs(self.db.profile.priorityList[spec]) do
						if name == v then
							o = pr
						end
					end
					return 110 + (o * 5)
				end,
				set = function(info, val)
				    self.db.profile.enabled[spec][v] = val
				end,
		        get = function(info)
					return self.db.profile.enabled[spec][v]
				end,
			}
			procList.priorityList.args[v.."_Up"] = {
				name = L["Up"],
				desc = L["MoveUp_Desc"],
				type = "execute",
				width = "half",
				order = 111 + (k * 5),
				disabled = function()
					return k == 1
				end,
		        func = function(info)
					-- Swap with the one above it.
					local list = self.db.profile.priorityList[spec]
					local tmp = list[k - 1]

					if tmp then
						list[k - 1] = list[k]
						list[k] = tmp
					end
				end,
			}
			procList.priorityList.args[v.."_Down"] = {
				name = L["Down"],
				desc = L["MoveDown_Desc"],
				type = "execute",
				width = "half",
				order = 112 + (k * 5),
				disabled = function()
					return k >= #self.db.profile.priorityList[spec]
				end,
		        func = function(info)
					-- Swap with the one above it.
					local list = self.db.profile.priorityList[spec]
					local tmp = list[k + 1]
					if tmp then
						list[k + 1] = list[k]
						list[k] = tmp
					end
				end,
			}
		end
	end

	return procList
end

function CompactRunes:GetCooldownOptions()
	local cooldowns = {
		order = 2,
		name = L["Cooldown Bars"],
		type = "group",
		inline = true,
		args = {
			description = {
				order = 1,
				type = "description",
				name = L["CooldownBarsDesc"],
			},
			procsHdr = {
				order = 100,
				type = "header",
				name = L["Cooldown Bars"],
			},
		},
	}

	local i = 1
	for k, v in pairs(self.db.profile.cdbars) do
		if self.db.profile.cdbars[k] then
			cooldowns.args[k.."List"] = {
				order = 101+i,
				type = "group",
				name = k,
				args = self:GetCDOptionsForSpec(k),
			}
			i = i + 1
		end
	end

	return cooldowns
end

function CompactRunes:GetCDOptionsForSpec(spec)
	local options = {
		enabled = {
			order = 105,
			name = L["Enabled"],
			desc = L["Enabled"],
			type = "toggle",
			set = function(info, val)
				self.db.profile.cdbars[spec].enabled = val
				self:UpdateCDBars()
			end,
			get = function(info)
				return self.db.profile.cdbars[spec].enabled
			end,
		},
		dimensions = {
			order = 106,
			name = L["Dimensions"],
			desc = L["Dimensions"],
			type = "range",
			min = 10,
			max = 100,
			step = 1,
			set = function(info, val)
				self.db.profile.cdbars[spec].height = val
				self.db.profile.cdbars[spec].width = val
				local bar = self.cdbars[spec]
				if bar then bar:UpdateDimensions() end
			end,
			get = function(info, val)
				return self.db.profile.cdbars[spec].width
			end,
		},
		maxItemsPerRow = {
			order = 109,
			name = L["Max Items Per Row"],
			desc = L["Max Items Per Row"],
			type = "range",
			min = 2,
			max = 20,
			step = 1,
			set = function(info, val)
				self.db.profile.cdbars[spec].maxItemsPerRow = val
				local bar = self.cdbars[spec]
				if bar then bar:Update() end
			end,
			get = function(info, val)
				return self.db.profile.cdbars[spec].maxItemsPerRow
			end,
		},
		alphaHdr = {
			order = 110,
			type = "header",
			name = L["Display Alpha"],
		},
		oocAlpha = {
			order = 111,
			name = L["Out of Combat"],
			desc = L["Out of Combat"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
			    self.db.profile.cdbars[spec].oocAlpha = val
				if addon.currentSpec == spec then
					local bar = self.cdbars[spec]
					if bar and bar.SetAlpha then bar:SetAlpha() end
				end
			end,
			get = function(info, val)
			    return self.db.profile.cdbars[spec].oocAlpha
			end,
		},
		combatAlpha = {
			order = 112,
			name = L["In Combat"],
			desc = L["In Combat"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
			    self.db.profile.cdbars[spec].combatAlpha = val
				if addon.currentSpec == spec then
					local bar = self.cdbars[spec]
					if bar and bar.SetAlpha then bar:SetAlpha() end
				end
			end,
			get = function(info, val)
			    return self.db.profile.cdbars[spec].combatAlpha
			end,
		},
		vehicleAlpha = {
			order = 115,
			name = L["Vehicle"],
			desc = L["VehicleAlpha_Desc"],
			type = "range",
			min = 0,
			max = 1,
			step = 0.05,
			set = function(info, val)
			    self.db.profile.cdbars[spec].vehicleAlpha = val
				if addon.currentSpec == spec then
					local bar = self.cdbars[spec]
					if bar and bar.SetAlpha then bar:SetAlpha() end
				end
			end,
			get = function(info, val)
			    return self.db.profile.cdbars[spec].vehicleAlpha
			end,
		},
	    layoutHdr = {
	        order = 130,
	        type = "header",
	        name = L["Layout"],
	    },
		xOffset = {
			order = 131,
			name = L["X Offset"],
			desc = L["XOffset_Desc"],
			type = "range",
			softMin = -floor(_G.GetScreenWidth()),
			softMax = floor(_G.GetScreenWidth()),
			bigStep = 1,
			set = function(info, val)
				self.db.profile.cdbars[spec].x = val
				local bar = self.cdbars[spec]
				if bar then bar:Update() end
			end,
			get = function(info, val)
			    return self.db.profile.cdbars[spec].x
			end,
		},
		yOffset = {
			order = 132,
			name = L["Y Offset"],
			desc = L["YOffset_Desc"],
			type = "range",
			softMin = -floor(_G.GetScreenHeight()),
			softMax = floor(_G.GetScreenHeight()),
			bigStep = 1,
			set = function(info, val)
			    self.db.profile.cdbars[spec].y = val
				local bar = self.cdbars[spec]
				if bar then bar:Update() end
			end,
			get = function(info, val)
			    return self.db.profile.cdbars[spec].y
			end,
		},
		fontSize = {
			order = 150,
			name = L["Font size"],
			desc = L["Font size for the bars."],
			type = "range",
			min = 8,
			max = 30,
			step = 1,
			set = function(info, val)
				self.db.profile.cdbars[spec].textFontSize = val
				local bar = self.cdbars[spec]
				if bar then bar:ResetFonts() end
			end,
			get = function(info,val) return self.db.profile.cdbars[spec].textFontSize end,
		},
		fontFace = {
			order = 151,
			type = "select",
			name = L["Font"],
			desc = L["Font to use."],
			values = LSM:HashTable("font"),
			dialogControl = 'LSM30_Font',
			get = function() return self.db.profile.cdbars[spec].fontFace end,
			set = function(info, val)
			    self.db.profile.cdbars[spec].fontFace = val
				local bar = self.cdbars[spec]
				if bar then bar:ResetFonts() end
			end
		},
        ordering = {
	  	    order = 200,
	  	    type = "group",
	  	    inline = true,
	  	    name = L["Cooldowns"],
	  	    args = {
			},
		},
	}
	for i, name in ipairs(self.db.profile.cdbars[spec].ordering) do
		--local argName = v:gsub(" ", "_")
		options.ordering.args[name] = {
			name = SpellNames[name],
			desc = SpellNames[name],
			type = "toggle",
			order = function()
				local o = 0
				for i, v in ipairs(self.db.profile.cdbars[spec].ordering) do
					if v == name then
						o = i
					end
				end
				return 210 + (o * 5)
			end,
			set = function(info, val)
				self.db.profile.cdbars[spec].cds[name].enabled = val
				local bar = self.cdbars[spec]
				if bar then bar:Update() end
			end,
			get = function(info)
				local cds = self.db.profile.cdbars[spec].cds[name]
				if cds then
					return cds.enabled
				else
					self:Print("Could not find CD "..tostring(name))
				end
			end,
		}
		options.ordering.args[name.."_Up"] = {
			name = L["Up"],
			desc = L["MoveUp_Desc"],
			type = "execute",
			width = "half",
			order = 211 + (i * 5),
			disabled = function()
				return i == 1
			end,
	        func = function(info)
				-- Swap with the one above it.
				local list = self.db.profile.cdbars[spec].ordering
				local tmp = list[i - 1]

				if tmp then
					list[i - 1] = list[i]
					list[i] = tmp
				end
				local bar = self.cdbars[spec]
				if bar then
					bar:Swap(i, i - 1)
					bar:Update()
				end
			end,
		}
		options.ordering.args[name.."_Down"] = {
			name = L["Down"],
			desc = L["MoveDown_Desc"],
			type = "execute",
			width = "half",
			order = 212 + (i * 5),
			disabled = function()
				return i >= #self.db.profile.cdbars[spec].ordering
			end,
	        func = function(info)
				-- Swap with the one above it.
				local list = self.db.profile.cdbars[spec].ordering
				local tmp = list[i + 1]
				if tmp then
					list[i + 1] = list[i]
					list[i] = tmp
				end
				local bar = self.cdbars[spec]
				if bar then
					bar:Swap(i, i + 1)
					bar:Update()
				end
			end,
		}
	end

	return options
end

function CompactRunes:GetColorsOptions()
	local colors = {
		order = 1,
		name = L["Colors"],
		type = "group",
		inline = true,
		args = {
			layoutHdr = {
				order = 100,
				type = "header",
				name = L["Colors"],
			},
			runes = {
				order = 200,
				type = "group",
				name = L["Runes"],
				args = {},
			},
		}
	}

	local i = 100
	for runeColor, data in pairs(self.db.profile.RuneColors) do
		colors.args.runes.args[runeColor.."_Header"] = {
	        order = i,
	        type = "header",
	        name = L["Runes"],
		}
		colors.args.runes.args[runeColor.."_Color"] = {
	        order = i + 1,
			name = L["Ready"],
			desc = L["Ready"],
			type = "color",
			hasAlpha = true,
			set = function(info, r, g, b, a)
			    local c = self.db.profile.RuneColors[runeColor]
			    c.r, c.g, c.b, c.a = r, g, b, a
				self:UpdateRuneColors()
				self:UpdateRunes()
			end,
			get = function(info)
		        local c = self.db.profile.RuneColors[runeColor]
			    return c.r, c.g, c.b, c.a
			end,
		}
		colors.args.runes.args[runeColor.."_RechargeColor"] = {
	        order = i + 1,
			name = L["Recharge"],
			desc = L["Recharge"],
			type = "color",
			hasAlpha = true,
			set = function(info, r, g, b, a)
			    local c = self.db.profile.RuneCooldownColors[runeColor]
			    c.r, c.g, c.b, c.a = r, g, b, a
				self:UpdateRuneColors()
				self:UpdateRunes()
			end,
			get = function(info)
		        local c = self.db.profile.RuneCooldownColors[runeColor]
			    return c.r, c.g, c.b, c.a
			end,
		}
		i = i + 5
	end

	local bars = GetOptionsBarList()
	local barList = {}
	for k, v in pairs(bars) do
		if v.setColor ~= false then
			tinsert(barList, k)
		end
	end
	tsort(barList)

	for i, k in ipairs(barList) do
		colors.args[k.."_Colors"] = {
			order = 201+i,
			type = "group",
			name = L[k],
			args = self:GetColorOptionsForBar(k, bars[k]),
		}
	end

	return colors
end

function CompactRunes:GetColorOptionsForBar(name, data)
	local frame = data.frame
	local profile = data.profile
	local barProfileName = data.barProfileName
	local colorOpts = {
		header = {
			order = 100,
			type = "header",
			name = L[name],
		},
		barColor = {
			order = 110,
			name = L["Bar"],
			desc = L["Bar"],
			type = "color",
			hasAlpha = true,
			set = function(info, r, g, b, a)
				local c = profile.color
				c.r, c.g, c.b, c.a = r, g, b, a
				frame:UpdateGraphics()
			end,
			get = function(info)
				local c = profile.color
				return c.r, c.g, c.b, c.a
			end,
		},
		barBgColor = {
			order = 120,
			name = L["Background"],
			desc = L["Background"],
			type = "color",
			hasAlpha = true,
			set = function(info, r, g, b, a)
				local c = profile.bgcolor
				c.r, c.g, c.b, c.a = r, g, b, a
				frame:UpdateGraphics()
			end,
			get = function(info)
				local c = profile.bgcolor
				return c.r, c.g, c.b, c.a
			end,
		},
		textColor = {
			order = 130,
			name = L["Text"],
			desc = L["Text"],
			type = "color",
			hasAlpha = true,
			set = function(info, r, g, b, a)
				local c = profile.textcolor
				c.r, c.g, c.b, c.a = r, g, b, a
				frame:UpdateGraphics()
			end,
			get = function(info)
				local c = profile.textcolor
				return c.r, c.g, c.b, c.a
			end,
		},
		reset = {
			name = L["Reset"],
			desc = L["Reset_OptDesc"],
			type = "execute",
			order = 200,
			func = function(info, val)
				if barProfileName then
					local defaults = addon.defaults.profile.bars[barProfileName]
					if defaults then
						local options = { "color", "bgcolor", "textcolor" }
						for i, opt in ipairs(options) do
							local d = defaults[opt]
							local c = profile[opt]
							c.r, c.g, c.b, c.a = d.r, d.g, d.b, d.a
						end
						frame:UpdateGraphics()
					end
				end
			end,
		},
	}
	return colorOpts
end

function CompactRunes:GetSoundOptions()
	local sounds = {
		order = 1,
		name = L["Sounds"],
		type = "group",
		inline = true,
		args = {
			layoutHdr = {
				order = 100,
				type = "header",
				name = L["Sounds"],
			},
			-- ["Blood Charge"] = {
			-- 	order = 200,
			-- 	type = "group",
			-- 	name = SpellNames["Blood Charge"],
			-- 	args = {},
			-- },
		}
	}
	return sounds
end

function CompactRunes:GetIgnoreRuneCDOptions()
	local ignoreRunes = {
		header = {
			order = 100,
			type = "header",
			name = L["Ignore Rune Cooldowns"],
		},
		description = {
			order = 100,
			type = "description",
			name = L["IgnoreRuneCDs_Desc"],
		},
		procs = {
			order = 120,
			name = L["Procs"],
			desc = L["Procs"],
			type = "toggle",
			get = function()
				return self.db.profile.ignoreRuneCDs["Procs"]
			end,
			set = function(info, val)
				self.db.profile.ignoreRuneCDs["Procs"] = val
			end,
		},
		cdbar = {
			order = 130,
			name = L["Cooldown Bars"],
			desc = L["Cooldown Bars"],
			type = "toggle",
			get = function()
				return self.db.profile.ignoreRuneCDs["CooldownBar"]
			end,
			set = function(info, val)
				self.db.profile.ignoreRuneCDs["CooldownBar"] = val
			end,
		},
	}
	return ignoreRunes
end
