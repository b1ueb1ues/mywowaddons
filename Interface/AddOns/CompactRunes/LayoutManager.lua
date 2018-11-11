local _G = getfenv(0)
local ADDON_NAME, addon = ...

local LSM = _G.LibStub:GetLibrary("LibSharedMedia-3.0")

local LayoutManager = {}

local BarWidths = {
	["full"] = function(self)
		return self.db.overrideWidth and self.db.width or addon.GetBarWidth()
	end,
	["half"] = function(self)
		return self.db.overrideWidth and self.db.width or addon.GetHalfBarWidth()
	end,
	["side"] = function(self)
		return self.db.overrideWidth and self.db.width or addon.GetSidebarWidth()
	end,
}

local BarHeights = {
	["full"] = function(self)
		return self.db.overrideHeight and self.db.height or addon.GetBarHeight()
	end,
	["half"] = function(self)
		return self.db.overrideHeight and self.db.height or addon.GetHalfBarHeight()
	end,
	["side"] = function(self)
		return self.db.overrideHeight and self.db.height or addon.GetMainHeight()
	end,
}

local SetValuePoints = {
	["Center"] = function(self)
		self.bar.value:SetPoint("CENTER")
	end,
	["TopCenter"] = function(self)
		self.bar.value:SetPoint("CENTER", self.bar, "TOP", 0, 0)
	end,
}

local Orientations = {
	["vertical"] = function(self)
		return "VERTICAL"
	end,
	["horizontal"] = function(self)
		return "HORIZONTAL"
	end,
}

local layouts = {
	-- Top bars
	["topbar1-full"] = {
		grouping = "topbar1",
		exclusive = true,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["half"],
			GetHeight = BarHeights["half"],
			SetPoint = addon.layouts["topbar1-full"],
			SetValuePoint = SetValuePoints["TopCenter"],
		},
	},
	["topbar1-right"] = {
		grouping = "topbar1",
		exclusive = false,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["half"],
			GetHeight = BarHeights["half"],
			SetPoint = addon.layouts["topbar1-right"],
			SetValuePoint = SetValuePoints["TopCenter"],
		},
	},
	["topbar1-left"] = {
		grouping = "topbar1",
		exclusive = false,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["half"],
			GetHeight = BarHeights["half"],
			SetPoint = addon.layouts["topbar1-left"],
			SetValuePoint = SetValuePoints["TopCenter"],
		},
	},
	["topbar2-full"] = {
		grouping = "topbar2",
		exclusive = true,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["half"],
			GetHeight = BarHeights["half"],
			SetPoint = addon.layouts["topbar2-full"],
			SetValuePoint = SetValuePoints["TopCenter"],
		},
	},
	["topbar2-right"] = {
		grouping = "topbar2",
		exclusive = false,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["half"],
			GetHeight = BarHeights["half"],
			SetPoint = addon.layouts["topbar2-right"],
			SetValuePoint = SetValuePoints["TopCenter"],
		},
	},
	["topbar2-left"] = {
		grouping = "topbar2",
		exclusive = false,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["half"],
			GetHeight = BarHeights["half"],
			SetPoint = addon.layouts["topbar2-left"],
			SetValuePoint = SetValuePoints["TopCenter"],
		},
	},
	--- Bottom bars
	["bottombar1-full"] = {
		grouping = "bottombar1",
		exclusive = true,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["full"],
			GetHeight = BarHeights["full"],
			SetPoint = addon.layouts["bottombar1-full"],
			SetValuePoint = SetValuePoints["Center"],
		},
	},
	["bottombar2-full"] = {
		grouping = "bottombar2",
		exclusive = true,
		functions = {
			GetOrientation = Orientations["horizontal"],
			GetWidth = BarWidths["full"],
			GetHeight = BarHeights["full"],
			SetPoint = addon.layouts["bottombar2-full"],
			SetValuePoint = SetValuePoints["Center"],
		},
	},
	-- Sidebars, vertical
	["rightbar-full"] = {
		grouping = "rightbar",
		exclusive = true,
		functions = {
			GetOrientation = Orientations["vertical"],
			GetWidth = BarWidths["side"],
			GetHeight = BarHeights["side"],
			SetPoint = addon.layouts["rightbar-full"],
			SetValuePoint = SetValuePoints["Center"],
		},
	},
	["leftbar-full"] = {
		grouping = "leftbar",
		exclusive = true,
		functions = {
			GetOrientation = Orientations["vertical"],
			GetWidth = BarWidths["side"],
			GetHeight = BarHeights["side"],
			SetPoint = addon.layouts["leftbar-full"],
			SetValuePoint = SetValuePoints["Center"],
		},
	},
}

-- Define a generic class for the bars
LayoutManager.__index = LayoutManager
addon.LayoutManager = LayoutManager

local registeredLayouts = {}
local assignedLayouts = {}

function LayoutManager:RegisterLayout(bar, options)
	_G.table.insert(registeredLayouts, { 
		bar = bar, 
		options = options,
	})
	self:DetermineLayout()
end

function LayoutManager:GetLayoutForBar(bar)
	return layouts[assignedLayouts[bar]]
end

function LayoutManager:DetermineLayout()
	local active = {}
	for i, items in _G.ipairs(registeredLayouts) do
		if items.bar and items.bar.IsEnabled and items.bar:IsEnabled() then
			_G.table.insert(active, items)
		end
	end
	
	local groupings = {}
	for i, items in _G.ipairs(active) do
		local options = items.options or {}
		local first = options[1] or ""
		local data = layouts[first] or {}
		local group = data.grouping
		if group then
			groupings[group] = (groupings[group] or 0) + 1
		end
	end
	
	local assignments = {}
	for i, items in _G.ipairs(active) do
		local bar, options = items.bar, items.options
		
		for i, option in _G.ipairs(options) do
			local group = layouts[option].grouping or ""
			local count = groupings[group] or 0
			local exclusive = count > 1 and layouts[option].exclusive
			if not exclusive and not assignments[option] then
				assignments[option] = bar
				break
			end
		end
	end
	
	_G.wipe(assignedLayouts)
	-- Add the enabled bars assignments.
	for option, bar in _G.pairs(assignments) do
		if addon.db.profile.debug then
			print("Layout:", option, "->", bar.name)
		end
		assignedLayouts[bar] = option
		local data = layouts[option]
		if data then
			bar:UpdateLayoutFunctions(data.functions)
		end
	end
	-- For any other registered bar just use the first option given.
	for i, items in _G.ipairs(registeredLayouts) do
		local bar, options = items.bar, items.options
		if not assignedLayouts[bar] then
			local first = options[1]
			assignedLayouts[bar] = first
			local data = layouts[first]
			if data then
				bar:UpdateLayoutFunctions(data.functions)
			end
		end
	end
end
