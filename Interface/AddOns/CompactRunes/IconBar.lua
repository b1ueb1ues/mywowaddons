local _G = getfenv(0)
local CompactRunes = LibStub("AceAddon-3.0"):GetAddon("Compact Runes")
local ADDON_NAME, addon = ...

local ipairs = _G.ipairs
local table = _G.table
local wipe = _G.wipe
local tostring = _G.tostring

local IconBar = {}
local bars = {}

IconBar.__index = IconBar
addon.IconBar = IconBar

function IconBar:Create(name)
	if not name then return end
	if bars[name] then return bars[name] end
	local object = _G.setmetatable({}, IconBar)
	object.name = name
	object.db = addon.db.profile.cdbars[name]
	object.count = 0
	object.items = {}
	object.grow = "RIGHT"
	object:Initialize()
	bars[name] = object
	return object
end

function IconBar:Initialize()
	local frame = _G.CreateFrame("Frame", ADDON_NAME.."Bar"..self.name, _G.UIParent)
	self.frame = frame
	self.frame.obj = self

	self.anchorPt = "CENTER"
	if self.grow == "RIGHT" then
		self.anchorPt = "TOPLEFT"
	end

	self.frame.lock = addon.db.profile.locked
	self.frame:SetMovable(true)
	self:UpdateLayout()

	self.frame:RegisterForDrag("LeftButton")
	self.frame:SetScript("OnDragStart",
		function(self, button)
			if not self.lock then
				self:StartMoving()
			end
		end)
	self.frame:SetScript("OnDragStop",
		function(self)
			self:StopMovingOrSizing()
			local scale = self:GetEffectiveScale() / _G.UIParent:GetEffectiveScale()
			--local x, y = self:GetCenter()
			--local w = self:GetWidth()
			--local h = self:GetHeight()
			--x, y = (x - (w / 2)) * scale, (y + (h / 2)) * scale
			local x, y = self:GetLeft(), self:GetTop()
			x, y = x * scale, y * scale
			x = x - _G.GetScreenWidth()/2
			y = y - _G.GetScreenHeight()/2
			x = x / self:GetScale()
			y = y / self:GetScale()
			self.obj.db.x, self.obj.db.y = x, y
			self:SetUserPlaced(false);
		end)
end

local widths = {}
local heights = {}
function IconBar:UpdateLayout()
	self:Lock()
	self.frame:ClearAllPoints()
	self.frame:SetPoint(self.anchorPt, _G.UIParent, "CENTER", 
		self.db.x or 0, self.db.y or 0)

	local prev = self.frame
	local spacing = self.db.spacing or 4
	local maxItemsPerRow = self.db.maxItemsPerRow or 10
	local added = 1
	local row = 1
	local height = 0
	local width = 0
	local totalHeight = 0
	local maxWidth = 0
	wipe(heights)
	wipe(widths)
	for i, frame in _G.ipairs(self.items) do
		if frame.db().enabled and not frame.disabled then
			local h = frame:GetHeight()
			if h > height then height = h end
			if added > maxItemsPerRow then
				heights[row] = height
				widths[row] = width
				totalHeight = totalHeight + height + spacing
				if width > maxWidth then maxWidth = width end
				added = 1
				row = row + 1
				height = 0
				width = 0
			end
			width = width + frame:GetWidth() + spacing
			frame:SetPoint("LEFT", added == 1 and self.frame or prev, 
				added == 1 and "LEFT" or "RIGHT", spacing, 
				added == 1 and (-1 * totalHeight) or 0)
			prev = frame
			added = added + 1
			frame:Show()
		else
			frame:Hide()
		end
	end
	self.frame:SetHeight(height * row + (spacing * (row - 1)))
	self.frame:SetWidth(width)
end

function IconBar:Add(frame, position)
	if position and _G.type(position) == "number" then
		table.insert(self.items, position, frame)
	else
		table.insert(self.items, frame)
	end
	self.count = self.count + 1
	self:UpdateLayout()
end

function IconBar:Remove(index)
	if not index then return end
	local position = nil
	if _G.type(index) == "number" then
		position = index
	else
		for i, frame in _G.ipairs(self.items) do
			if frame == index then
				position = i
				break
			end
		end
	end
	table.remove(self.items, position)
	self.count = self.count - 1
	self:UpdateLayout()
end

function IconBar:Get(position)
	if position and _G.type(position) == "number" then
		return self.items[position]
	end
end

function IconBar:Swap(pos1, pos2)
	local frame = self.items[pos1]
	self.items[pos1] = self.items[pos2]
	self.items[pos2] = frame
end

function IconBar:Show()
	self.frame:Show()
end

function IconBar:Hide()
	self.frame:Hide()
end

function IconBar:Lock(flag)
	if flag ~= nil then
		self.frame.lock = flag
	end
	self.frame:EnableMouse(not self.frame.lock)
end

function IconBar:SetAlpha(alpha)
	self.frame:SetAlpha(alpha)
end
