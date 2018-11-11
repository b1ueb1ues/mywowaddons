--[[
	Titan Skills
	Localization File
	Version 1.6.1
	
	Revision: $Id: Localize.lua 7 2012-12-23 12:19:36 PST Kjasi $
]]

--== enUS & enGB ==--
-- Passed Vars: Color, Skill Name, Current Skill Level, Modifications (+3), Color, Max Skill Level, Skinning Notes, Training Notice
TITANSKILLS_FORMAT_DISPLAY = "%s%s (%s%s%s/%s)%s%s"
TITANSKILLS_FORMAT_DISPLAY_SINGLE = "%s%s (%s%s%s)%s%s"
-- Passed Var: Highest Skinnable Mob Level
TITANSKILLS_FORMAT_SKINMOBLEVEL = " (%sLevel %i%s)"		-- color code, level, color code

-- Coloring Menu
TITANSKILLS_COLORING = "Coloring"
TITANSKILLS_COLORING_NONE = "None"
TITANSKILLS_COLORING_STANDARD = "Standard"
TITANSKILLS_COLORING_BYPLEVEL = "By Player Level"
TITANSKILLS_COLORING_BYMAXIMUM = "By Maximum Skill"

TITANSKILLS_NOSKILLS = "You have no skills to track."
TITANSKILLS_GETTRAINING = "Train!"
TITANSKILLS_GETTRAININGLEVELUP = "Level to %i!"		-- Level number is passed. Example: Level to 20!