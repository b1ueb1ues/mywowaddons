local _G = getfenv(0)
local ADDON_NAME, addon = ...

addon.defaultSoundChannel = "Master"

addon.MIN_UPDATE_TIME = 0.05

addon.NUMBER_RUNES = 6
addon.MAX_BONESHIELD_CHARGES = 10
addon.runeCD = 10
addon.gcd = 1.5
addon.PESTILENT_PUSTULES_MAX = 8
