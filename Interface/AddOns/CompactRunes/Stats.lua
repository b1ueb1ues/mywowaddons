local _G = getfenv(0)
local ADDON_NAME, addon = ...

-- Define a simplistic class for statistics
local Stats = {}
addon.Stats = Stats

Stats.__index = Stats

function Stats:new(base)
    local stats = {}
    _G.setmetatable(stats, {__index = self or Stats})
    stats:Reset()
    return stats
end

function Stats:Reset()
end
