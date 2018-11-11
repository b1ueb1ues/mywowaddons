local _G = getfenv(0)
local ADDON_NAME, addon = ...

local function GetRuneWidth()
	local profile = addon.db.profile
	local dimensions = profile.dimensions[profile.runeOrientation]
	return dimensions.width
end
addon.GetRuneWidth = GetRuneWidth

local function GetRuneHeight()
	local profile = addon.db.profile
	local dimensions = profile.dimensions[profile.runeOrientation]
	return dimensions.height
end
addon.GetRuneHeight = GetRuneHeight

local function GetRuneSpacing()
	local profile = addon.db.profile
	local dimensions = profile.dimensions[profile.runeOrientation]
	return dimensions.spacing
end
addon.GetRuneSpacing = GetRuneSpacing

local function GetRuneInset()
	local profile = addon.db.profile
	local dimensions = profile.dimensions[profile.runeOrientation]
	return dimensions.inset
end
addon.GetRuneInset = GetRuneInset

local function GetBarSpacing()
	local profile = addon.db.profile
	local dimensions = profile.dimensions[profile.runeOrientation]
	return dimensions.barSpacing
end
addon.GetBarSpacing = GetBarSpacing

local function GetHalfBarHeight()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return GetRuneWidth()
	else
		return GetRuneHeight()
	end
end
addon.GetHalfBarHeight = GetHalfBarHeight

local function GetHalfBarWidth()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return (GetRuneWidth() * 3 + GetRuneSpacing()) / 2 
	else
		return GetRuneWidth()
	end
end
addon.GetHalfBarWidth = GetHalfBarWidth

local function GetBarHeight()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return GetRuneWidth()
	else
		return GetRuneHeight()
	end
end
addon.GetBarHeight = GetBarHeight

local function GetBarWidth()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return GetRuneWidth() * 3 + GetRuneSpacing() * 2
	else
		return GetRuneWidth() * 2 + GetRuneSpacing()
	end
end
addon.GetBarWidth = GetBarWidth

local function GetMainWidth()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return (GetRuneWidth() + GetRuneSpacing()) * 3 + GetRuneInset() * 2
	else
		return (GetRuneWidth() + GetRuneSpacing()) * 2 + GetRuneInset() * 2
	end
end
addon.GetMainWidth = GetMainWidth

local function GetMainHeight()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return (GetRuneHeight() + GetRuneSpacing()) * 2 + GetRuneInset() * 2
	else
		return (GetRuneHeight() + GetRuneSpacing()) * 3 + GetRuneInset() * 2
	end
end
addon.GetMainHeight = GetMainHeight

local function GetSidebarWidth()
	local profile = addon.db.profile
	if profile.runeOrientation == "VERTICAL" then
		return GetRuneWidth() - 2
	else
		return GetRuneHeight() - 2
	end
end
addon.GetSidebarWidth = GetSidebarWidth

addon.SetSecondaryValuePoints = {
	["SettingOrRight"] = function(self)
		if self.bar.secondaryValue then
			local pos = self.db.secondaryValuePos or "RIGHT"
			self.bar.secondaryValue:SetPoint(pos)
			self.bar.secondaryValue:SetJustifyH(pos)
			self.bar.secondaryValue:Show()
		end
	end,
	["SettingOrRightBottom"] = function(self)
		if self.bar.secondaryValue then
			if self.bar:GetOrientation() == "VERTICAL" then
				local pos = self.db.secondaryValuePos or "BOTTOM"
				self.bar.secondaryValue:SetPoint(pos)
				self.bar.secondaryValue:SetJustifyH("CENTER")
				self.bar.secondaryValue:Show()
			else
				local pos = self.db.secondaryValuePos or "RIGHT"
				self.bar.secondaryValue:SetPoint(pos)
				self.bar.secondaryValue:SetJustifyH(pos)
			end
		end
	end,
	["SettingOrBottom"] = function(self)
		if self.bar.secondaryValue then
			if self.orientation == "VERTICAL" then
				local pos = self.db.secondaryValuePos or "BOTTOM"
				self.bar.secondaryValue:SetPoint(pos)
				self.bar.secondaryValue:SetJustifyH("CENTER")
				self.bar.secondaryValue:Show()
			else
				self.bar.secondaryValue:Hide()
			end
		end
	end,
}

addon.layouts = {
	["rightbar-full"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local xOffset = GetBarSpacing() - 3
			self.bar:SetPoint("LEFT", addon.frames.main, "RIGHT", xOffset, 0)
		end
	end,
	["leftbar-full"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local xOffset = -1 * (GetBarSpacing() - 3)
			self.bar:SetPoint("RIGHT", addon.frames.main, "LEFT", xOffset, 0)
		end
	end,
	["topbar1-full"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			self.bar:SetPoint("BOTTOM", addon.frames.main, "TOP", 0, 0)
		end
	end,
	["topbar1-left"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local db = addon.db.profile
			self.bar:SetPoint("BOTTOMLEFT", addon.frames.main, "TOPLEFT", 2 + GetRuneInset(), 0)
		end
	end,
	["topbar1-right"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local db = addon.db.profile
			self.bar:SetPoint("BOTTOMRIGHT", addon.frames.main, "TOPRIGHT", 
				-2 + -1 * GetRuneInset(), 0)
		end
	end,
	["topbar2-full"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local yOffset = GetRuneSpacing() * 2 + GetBarHeight() + 2
			self.bar:SetPoint("BOTTOM", addon.frames.main, "TOP", 0, yOffset)
		end
	end,
	["topbar2-left"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local yOffset = GetRuneSpacing() * 2 + GetBarHeight() + 2
			self.bar:SetPoint("BOTTOMLEFT", addon.frames.main, "TOPLEFT", 
				2 + GetRuneInset(), yOffset)
		end
	end,
	["topbar2-right"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			local yOffset = GetRuneSpacing() * 2 + GetBarHeight() + 2
			self.bar:SetPoint("BOTTOMRIGHT", addon.frames.main, "TOPRIGHT", 
				-2 + -1 * GetRuneInset(), yOffset)
		end
	end,
	["bottombar1-full"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			self.bar:SetPoint("TOP", addon.frames.main, "BOTTOM", 0, -2)
		end
	end,
	["bottombar2-full"] = function(self)
		if not addon.layouts["userplaced"](self) then
			self.bar:ClearAllPoints()
			self.bar:SetPoint("TOP", addon.frames.main, "BOTTOM", 0, -2 - GetBarHeight() - 6)
		end
	end,
	["userplaced"] = function(self)
		local x, y = self.db.x, self.db.y
		if not (self.db.userPlaced and x ~= nil and y ~= nil) then return false end
		self.bar:ClearAllPoints()
		self.bar:SetPoint("CENTER", _G.UIParent, "CENTER", x, y)
		return true
	end,
}
