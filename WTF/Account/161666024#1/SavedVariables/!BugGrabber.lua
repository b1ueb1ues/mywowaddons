
BugGrabberDB = {
	["session"] = 1418,
	["lastSanitation"] = 3,
	["errors"] = {
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] 插件 'TitanLocation' 尝试调用保护功能 'UseQuestLogSpecialItem()'。",
			["time"] = "2018/09/14 18:10:27",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `UseQuestLogSpecialItem'\n...ObjectiveTracker\\Blizzard_ObjectiveTrackerShared.lua:95: in function <...ObjectiveTracker\\Blizzard_ObjectiveTrackerShared.lua:88>",
			["session"] = 1157,
			["counter"] = 1,
		}, -- [1]
		{
			["message"] = "[string \"local a,ar,k =select(2,UnitArmor(\"player\")),C_PaperDollInfo.Get...\"]:1: unexpected symbol near '�'",
			["time"] = "2018/09/14 20:07:38",
			["locals"] = "(*temporary) = \"local a,ar,k =select(2,UnitArmor(\"player\")),C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(select(2,UnitArmor(\"player\")))  if ar then k = a/ar-a print(k) end\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2158: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4734: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4396: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4432: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1158,
			["counter"] = 7,
		}, -- [2]
		{
			["message"] = "[string \"local a,ar,k =select(2,UnitArmor(\"player\")),C_PaperDollInfo.Get...\"]:1: unexpected symbol near 'if'",
			["time"] = "2018/09/14 20:09:25",
			["locals"] = "(*temporary) = \"local a,ar,k =select(2,UnitArmor(\"player\")),C_PaperDollInfo.GetArmorEffectivenessAgainstTarget(select(2,UnitArmor(\"player\"))),if ar then k = a/ar-a print(k) end\"\n",
			["stack"] = "[C]: in function `RunScript'\nInterface\\FrameXML\\ChatFrame.lua:2158: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4734: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4396: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:2884: in function <Interface\\FrameXML\\ChatFrame.lua:2877>\n[C]: ?\n[C]: in function `UseAction'\nInterface\\FrameXML\\SecureTemplates.lua:345: in function `handler'\nInterface\\FrameXML\\SecureTemplates.lua:623: in function <Interface\\FrameXML\\SecureTemplates.lua:571>\n[C]: ?\nInterface\\FrameXML\\SecureHandlers.lua:266: in function <Interface\\FrameXML\\SecureHandlers.lua:263>\n[C]: ?\nInterface\\FrameXML\\SecureHandlers.lua:296: in function <Interface\\FrameXML\\SecureHandlers.lua:279>\n(tail call): ?",
			["session"] = 1158,
			["counter"] = 2,
		}, -- [3]
		{
			["message"] = "Interface\\FrameXML\\MapUtil.lua:11: Usage: local info = C_Map.GetMapInfo(uiMapID)",
			["time"] = "2018/09/14 18:14:45",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetMapInfo'\nInterface\\FrameXML\\MapUtil.lua:11: in function `GetMapParentInfo'\n...erface\\AddOns\\CompactRaid\\Modules\\RaidDebuff\\API.lua:307: in function `GetZoneDebuffs'\n...rface\\AddOns\\CompactRaid\\Modules\\RaidDebuff\\Core.lua:65: in function `func'\n...face\\AddOns\\CompactRaid\\Includes\\LibAddonManager-1.27.nil.lua:431: in function <...face\\AddOns\\CompactRaid\\Includes\\LibAddonManager.lua:418>",
			["session"] = 1158,
			["counter"] = 10,
		}, -- [4]
		{
			["message"] = "...\\AddOns\\CompactRaid\\Includes\\LibPlayerSpells-1.0-1.51.nil.lua:403: attempt to perform arithmetic on local 'endTime' (a boolean value)",
			["time"] = "2018/09/14 18:47:05",
			["locals"] = "spell = \"Cast-3-3910-1220-4896-55016-00029B91A7\"\nfunc = <function> defined =[C]:-1\n_ = \"氮气推进器\"\n_ = \"氮气推进器\"\n_ = 136243\n_ = 133586179\nstartTime = 133591179\nendTime = true\n(*temporary) = <table> {\n}\n(*temporary) = true\n(*temporary) = \"attempt to perform arithmetic on local 'endTime' (a boolean value)\"\ncastTimeRecords = <table> {\n}\n",
			["stack"] = "...\\AddOns\\CompactRaid\\Includes\\LibPlayerSpells-1.0-1.51.nil.lua:403: in function <...\\AddOns\\CompactRaid\\Includes\\LibPlayerSpells-1.0.lua:400>\n...\\AddOns\\CompactRaid\\Includes\\LibPlayerSpells-1.0-1.51.nil.lua:569: in function <...\\AddOns\\CompactRaid\\Includes\\LibPlayerSpells-1.0.lua:536>",
			["session"] = 1159,
			["counter"] = 4,
		}, -- [5]
		{
			["message"] = "Error loading Interface\\AddOns\\Kui_Nameplates\\plugins/personal-anchor.lua",
			["session"] = 1181,
			["time"] = "2018/09/17 22:17:38",
			["counter"] = 4,
		}, -- [6]
		{
			["message"] = "Interface\\FrameXML\\LFGList.lua:3154: Usage: GetActivityInfo(activityID)",
			["time"] = "2018/09/20 11:41:15",
			["locals"] = "(*temporary) = nil\n",
			["stack"] = "[C]: in function `GetActivityInfo'\nInterface\\FrameXML\\LFGList.lua:3154: in function `LFGListUtil_SetSearchEntryTooltip'\nInterface\\FrameXML\\LFGList.lua:2216: in function <Interface\\FrameXML\\LFGList.lua:2213>",
			["session"] = 1205,
			["counter"] = 1,
		}, -- [7]
		{
			["message"] = "[string \"--[[ Error in 'Stagger' ]] return function(...\"]:13: attempt to perform arithmetic on field 'maxValue' (a nil value)",
			["time"] = "2018/09/20 23:53:08",
			["stack"] = "[C]: in function `xpcall'\nInterface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:3242: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3144>",
			["session"] = 1209,
			["counter"] = 62,
		}, -- [8]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'Auctionator' 尝试调用保护功能 'OverrideActionBarButton5:Show()'。",
			["time"] = "2018/09/23 22:20:28",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `Show'\nInterface\\FrameXML\\ActionButton.lua:364: in function `ActionButton_Update'\nInterface\\FrameXML\\ActionButton.lua:720: in function `ActionButton_OnEvent'\nInterface\\FrameXML\\ActionButton.lua:207: in function <Interface\\FrameXML\\ActionButton.lua:204>",
			["session"] = 1225,
			["counter"] = 1,
		}, -- [9]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] 插件 'oRA3' 尝试调用保护功能 'FocusUnit()'。",
			["time"] = "2018/10/09 21:43:52",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `FocusUnit'\nInterface\\FrameXML\\ChatFrame.lua:1460: in function `?'\nInterface\\FrameXML\\ChatFrame.lua:4714: in function `ChatEdit_ParseText'\nInterface\\FrameXML\\ChatFrame.lua:4396: in function `ChatEdit_SendText'\nInterface\\FrameXML\\ChatFrame.lua:4432: in function `ChatEdit_OnEnterPressed'\n[string \"*:OnEnterPressed\"]:1: in function <[string \"*:OnEnterPressed\"]:1>",
			["session"] = 1290,
			["counter"] = 1,
		}, -- [10]
		{
			["message"] = "Interface\\AddOns\\MythicPlusTimer\\CMTimer.lua:294: attempt to index field '?' (a nil value)",
			["time"] = "2018/10/11 00:28:09",
			["stack"] = "Interface\\AddOns\\MythicPlusTimer\\CMTimer.lua:294: in function `OnComplete'\nInterface\\AddOns\\MythicPlusTimer\\Core.lua:144: in function `?'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:145: in function <...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:145>\n[string \"safecall Dispatcher[1]\"]:4: in function <[string \"safecall Dispatcher[1]\"]:4>\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:13: in function `?'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:90: in function `Fire'\nInterface\\AddOns\\Ace3\\AceEvent-3.0\\AceEvent-3.0-4.lua:120: in function <Interface\\AddOns\\Ace3\\AceEvent-3.0\\AceEvent-3.0.lua:119>",
			["session"] = 1298,
			["counter"] = 1,
		}, -- [11]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'TidyPlates' 尝试调用保护功能 'MultiBarBottomLeft:SetShown()'。",
			["time"] = "2018/10/12 21:47:00",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `SetShown'\nInterface\\FrameXML\\MultiActionBars.lua:36: in function <Interface\\FrameXML\\MultiActionBars.lua:34>\nInterface\\FrameXML\\MultiActionBars.lua:57: in function `MultiActionBar_Update'\nInterface\\FrameXML\\InterfaceOptionsPanels.lua:1184: in function `setFunc'\nInterface\\FrameXML\\InterfaceOptionsPanels.lua:87: in function <Interface\\FrameXML\\InterfaceOptionsPanels.lua:83>\n[C]: in function `pcall'\nInterface\\FrameXML\\InterfaceOptionsFrame.lua:217: in function <Interface\\FrameXML\\InterfaceOptionsFrame.lua:216>\n[C]: in function `securecall'\nInterface\\FrameXML\\InterfaceOptionsFrame.lua:252: in function <Interface\\FrameXML\\InterfaceOptionsFrame.lua:248>\n[C]: in function `Click'\nInterface\\FrameXML\\UIParent.lua:3959: in function `ToggleGameMenu'\n[string \"TOGGLEGAMEMENU\"]:1: in function <[string \"TOGGLEGAMEMENU\"]:1>",
			["session"] = 1302,
			["counter"] = 1,
		}, -- [12]
		{
			["message"] = "[ADDON_ACTION_FORBIDDEN] 插件 'WorldQuestTracker' 尝试调用保护功能 'UseQuestLogSpecialItem()'。",
			["time"] = "2018/10/12 22:10:25",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `UseQuestLogSpecialItem'\n...ObjectiveTracker\\Blizzard_ObjectiveTrackerShared.lua:95: in function <...ObjectiveTracker\\Blizzard_ObjectiveTrackerShared.lua:88>",
			["session"] = 1302,
			["counter"] = 1,
		}, -- [13]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'CompactRaid' 尝试调用保护功能 'UNKNOWN()'。",
			["time"] = "2018/10/16 21:38:09",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: ?\n[C]: ?\n[C]: ?\n...\\AddOns\\CompactRaid\\OptionFrames\\DisableBlizzard.lua:69: in function <...\\AddOns\\CompactRaid\\OptionFrames\\DisableBlizzard.lua:68>",
			["session"] = 1317,
			["counter"] = 1,
		}, -- [14]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'Auctionator' 尝试调用保护功能 'MainMenuBar:ClearAllPoints()'。",
			["time"] = "2018/10/19 21:51:22",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `ClearAllPoints'\nInterface\\FrameXML\\MainMenuBar.lua:43: in function `SetPositionForStatusBars'\nInterface\\FrameXML\\MainMenuBar.lua:8: in function `OnStatusBarsUpdated'\nInterface\\FrameXML\\StatusTrackingManager.lua:179: in function `LayoutBars'\nInterface\\FrameXML\\StatusTrackingManager.lua:84: in function <Interface\\FrameXML\\StatusTrackingManager.lua:75>\n[C]: in function `UpdateBarsShown'\nInterface\\FrameXML\\StatusTrackingManager.lua:206: in function <Interface\\FrameXML\\StatusTrackingManager.lua:202>",
			["session"] = 1324,
			["counter"] = 1,
		}, -- [15]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'Titan' 尝试调用保护功能 'MultiBarBottomLeft:SetShown()'。",
			["time"] = "2018/10/23 23:00:23",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `SetShown'\nInterface\\FrameXML\\MultiActionBars.lua:36: in function <Interface\\FrameXML\\MultiActionBars.lua:34>\nInterface\\FrameXML\\MultiActionBars.lua:57: in function `MultiActionBar_Update'\nInterface\\FrameXML\\InterfaceOptionsPanels.lua:1184: in function `setFunc'\nInterface\\FrameXML\\InterfaceOptionsPanels.lua:87: in function <Interface\\FrameXML\\InterfaceOptionsPanels.lua:83>\n[C]: in function `pcall'\nInterface\\FrameXML\\InterfaceOptionsFrame.lua:217: in function <Interface\\FrameXML\\InterfaceOptionsFrame.lua:216>\n[C]: in function `securecall'\nInterface\\FrameXML\\InterfaceOptionsFrame.lua:252: in function <Interface\\FrameXML\\InterfaceOptionsFrame.lua:248>\n[C]: in function `Click'\nInterface\\FrameXML\\UIParent.lua:3959: in function `ToggleGameMenu'\n[string \"TOGGLEGAMEMENU\"]:1: in function <[string \"TOGGLEGAMEMENU\"]:1>",
			["session"] = 1339,
			["counter"] = 1,
		}, -- [16]
		{
			["message"] = "...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:214: attempt to index a nil value",
			["time"] = "2018/09/14 18:55:18",
			["locals"] = "(*temporary) = <function> defined =[C]:-1\n(*temporary) = nil\n(*temporary) = 4\n(*temporary) = \"attempt to index a nil value\"\nsimulationCurrent = 28\nstrtrim = <function> defined =[C]:-1\ngetProgressInfo = <function> defined @Interface\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:188\n",
			["stack"] = "...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:214: in function <...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:212>\n...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:220: in function <...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:217>\n...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:567: in function <...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:557>\n...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:712: in function <...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:708>",
			["session"] = 1346,
			["counter"] = 1336,
		}, -- [17]
		{
			["message"] = "Interface\\AddOns\\BigWigs_Core\\BossPrototype.lua:1590: attempt to index global 'CL' (a nil value)",
			["time"] = "2018/09/20 00:26:33",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\BigWigs_Core\\BossPrototype.lua:1590: in function `PersonalMessage'\nInterface\\AddOns\\LittleWigs\\BfA\\TolDagor\\Korgus.lua:87: in function `func'\nInterface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0-17.lua:57: in function <Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:50>",
			["session"] = 1346,
			["counter"] = 487,
		}, -- [18]
		{
			["message"] = "...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:140: bad argument #2 to 'strsplit' (string expected, got nil)",
			["time"] = "2018/09/14 17:10:28",
			["locals"] = "(*temporary) = \"-\"\n(*temporary) = nil\n(*temporary) = \"string expected, got nil\"\n",
			["stack"] = "[C]: ?\n...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:140: in function <...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:139>\n...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress-0.3e for Patch 7.1.0.lua:474: in function <...ace\\AddOns\\MythicPlusProgress\\MythicPlusProgress.lua:470>\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?\n[C]: ?",
			["session"] = 1348,
			["counter"] = 23,
		}, -- [19]
		{
			["message"] = "Interface\\AddOns\\OmniCC\\effects\\none-无.lua:5: attempt to index field 'FX' (a nil value)",
			["time"] = "2018/10/27 23:01:41",
			["locals"] = "Addon = OmniCC {\n 0 = <userdata>\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:51\n Timer = <table> {\n }\n CreateHiddenFrame = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:79\n}\nL = <table> {\n MMSSFormat = \"%d:%02d\"\n Flare = \"耀斑\"\n PulseTip = \"结束冷却的图标将发生搏动。\"\n Pulse = \"搏动\"\n ActivateTip = \"模仿系统自带的，技能被“触发”的效果\n（如CTM时代术士燃放灵魂碎片之后灵魂之火按钮的效果）。\"\n AlertTip = \"结束冷却的图标在屏幕中央搏动。\"\n ConfigMissing = \"%s无法被载入，因为该插件%s\"\n TenthsFormat = \"%0.1f\"\n HourFormat = \"%dh\"\n DayFormat = \"%dd\"\n SecondsFormat = \"%d\"\n Version = \"你正在使用|cffFCF75EOmniCC 版本(%s)|r\"\n MinuteFormat = \"%dm\"\n Shine = \"闪亮\"\n Activate = \"激活\"\n Alert = \"警报\"\n None = \"无\"\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'FX' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\OmniCC\\effects\\none-无.lua:5: in main chunk",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [20]
		{
			["message"] = "Interface\\AddOns\\OmniCC\\effects\\alert.lua:42: attempt to index field 'FX' (a nil value)",
			["time"] = "2018/10/27 23:01:41",
			["locals"] = "Addon = OmniCC {\n 0 = <userdata>\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:51\n Timer = <table> {\n }\n CreateHiddenFrame = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:79\n}\nL = <table> {\n MMSSFormat = \"%d:%02d\"\n Flare = \"耀斑\"\n PulseTip = \"结束冷却的图标将发生搏动。\"\n Pulse = \"搏动\"\n ActivateTip = \"模仿系统自带的，技能被“触发”的效果\n（如CTM时代术士燃放灵魂碎片之后灵魂之火按钮的效果）。\"\n AlertTip = \"结束冷却的图标在屏幕中央搏动。\"\n ConfigMissing = \"%s无法被载入，因为该插件%s\"\n TenthsFormat = \"%0.1f\"\n HourFormat = \"%dh\"\n DayFormat = \"%dd\"\n SecondsFormat = \"%d\"\n Version = \"你正在使用|cffFCF75EOmniCC 版本(%s)|r\"\n MinuteFormat = \"%dm\"\n Shine = \"闪亮\"\n Activate = \"激活\"\n Alert = \"警报\"\n None = \"无\"\n}\nFrame = <unnamed> {\n 0 = <userdata>\n}\nIcon = <unnamed> {\n 0 = <userdata>\n}\nAnims = <unnamed> {\n 0 = <userdata>\n}\nnewAnim = <function> defined @Interface\\AddOns\\OmniCC\\effects\\alert.lua:22\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = 2\n(*temporary) = 0.7\n(*temporary) = 0\n(*temporary) = \"attempt to index field 'FX' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\OmniCC\\effects\\alert.lua:42: in main chunk",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [21]
		{
			["message"] = "Interface\\AddOns\\OmniCC\\effects\\flare.lua:6: attempt to index field 'FX' (a nil value)",
			["time"] = "2018/10/27 23:01:41",
			["locals"] = "AddonName = \"OmniCC\"\nAddon = OmniCC {\n 0 = <userdata>\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:51\n Timer = <table> {\n }\n CreateHiddenFrame = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:79\n}\nL = <table> {\n MMSSFormat = \"%d:%02d\"\n Flare = \"耀斑\"\n PulseTip = \"结束冷却的图标将发生搏动。\"\n Pulse = \"搏动\"\n ActivateTip = \"模仿系统自带的，技能被“触发”的效果\n（如CTM时代术士燃放灵魂碎片之后灵魂之火按钮的效果）。\"\n AlertTip = \"结束冷却的图标在屏幕中央搏动。\"\n ConfigMissing = \"%s无法被载入，因为该插件%s\"\n TenthsFormat = \"%0.1f\"\n HourFormat = \"%dh\"\n DayFormat = \"%dd\"\n SecondsFormat = \"%d\"\n Version = \"你正在使用|cffFCF75EOmniCC 版本(%s)|r\"\n MinuteFormat = \"%dm\"\n Shine = \"闪亮\"\n Activate = \"激活\"\n Alert = \"警报\"\n None = \"无\"\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'FX' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\OmniCC\\effects\\flare.lua:6: in main chunk",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [22]
		{
			["message"] = "Interface\\AddOns\\OmniCC\\effects\\pulse.lua:7: attempt to index field 'FX' (a nil value)",
			["time"] = "2018/10/27 23:01:41",
			["locals"] = "Addon = OmniCC {\n 0 = <userdata>\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:51\n Timer = <table> {\n }\n CreateHiddenFrame = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:79\n}\nL = <table> {\n MMSSFormat = \"%d:%02d\"\n Flare = \"耀斑\"\n PulseTip = \"结束冷却的图标将发生搏动。\"\n Pulse = \"搏动\"\n ActivateTip = \"模仿系统自带的，技能被“触发”的效果\n（如CTM时代术士燃放灵魂碎片之后灵魂之火按钮的效果）。\"\n AlertTip = \"结束冷却的图标在屏幕中央搏动。\"\n ConfigMissing = \"%s无法被载入，因为该插件%s\"\n TenthsFormat = \"%0.1f\"\n HourFormat = \"%dh\"\n DayFormat = \"%dd\"\n SecondsFormat = \"%d\"\n Version = \"你正在使用|cffFCF75EOmniCC 版本(%s)|r\"\n MinuteFormat = \"%dm\"\n Shine = \"闪亮\"\n Activate = \"激活\"\n Alert = \"警报\"\n None = \"无\"\n}\nPULSE_SCALE = 2.5\nPULSE_DURATION = 0.6\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'FX' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\OmniCC\\effects\\pulse.lua:7: in main chunk",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [23]
		{
			["message"] = "Interface\\AddOns\\OmniCC\\effects\\shine.lua:9: attempt to index field 'FX' (a nil value)",
			["time"] = "2018/10/27 23:01:41",
			["locals"] = "Addon = OmniCC {\n 0 = <userdata>\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:51\n Timer = <table> {\n }\n CreateHiddenFrame = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:79\n}\nL = <table> {\n MMSSFormat = \"%d:%02d\"\n Flare = \"耀斑\"\n PulseTip = \"结束冷却的图标将发生搏动。\"\n Pulse = \"搏动\"\n ActivateTip = \"模仿系统自带的，技能被“触发”的效果\n（如CTM时代术士燃放灵魂碎片之后灵魂之火按钮的效果）。\"\n AlertTip = \"结束冷却的图标在屏幕中央搏动。\"\n ConfigMissing = \"%s无法被载入，因为该插件%s\"\n TenthsFormat = \"%0.1f\"\n HourFormat = \"%dh\"\n DayFormat = \"%dd\"\n SecondsFormat = \"%d\"\n Version = \"你正在使用|cffFCF75EOmniCC 版本(%s)|r\"\n MinuteFormat = \"%dm\"\n Shine = \"闪亮\"\n Activate = \"激活\"\n Alert = \"警报\"\n None = \"无\"\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'FX' (a nil value)\"\n",
			["stack"] = "Interface\\AddOns\\OmniCC\\effects\\shine.lua:9: in main chunk",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [24]
		{
			["message"] = "Interface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:2707: attempt to call field 'ClearAuraEnvironment' (a nil value)",
			["time"] = "2018/10/27 23:01:59",
			["locals"] = "data = <table> {\n backdropColor = <table> {\n }\n controlledChildren = <table> {\n }\n borderBackdrop = \"Blizzard Tooltip\"\n xOffset = 334.10723876953\n border = false\n yOffset = -321.38095092773\n regionType = \"group\"\n borderSize = 16\n borderColor = <table> {\n }\n expanded = false\n triggers = <table> {\n }\n borderOffset = 5\n internalVersion = 9\n animation = <table> {\n }\n id = \"玄牛雕像\"\n borderEdge = \"None\"\n frameStrata = 1\n anchorFrameType = \"SCREEN\"\n actions = <table> {\n }\n borderInset = 11\n selfPoint = \"BOTTOMLEFT\"\n scale = 1\n conditions = <table> {\n }\n load = <table> {\n }\n anchorPoint = \"CENTER\"\n}\nid = \"玄牛雕像\"\n(*temporary) = nil\n(*temporary) = \"玄牛雕像\"\n(*temporary) = \"attempt to call field 'ClearAuraEnvironment' (a nil value)\"\ndb = <table> {\n dynamicIconCache = <table> {\n }\n displays = <table> {\n }\n login_squelch_time = 10\n registered = <table> {\n }\n frame = <table> {\n }\n editor_theme = \"Monokai\"\n}\nWeakAuras = <table> {\n SetAuraVisibility = <function> defined @Interface\\AddOns\\WeakAuras\\BuffTrigger.lua:299\n GetRuneCooldown = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:1430\n frame_strata_types = <table> {\n }\n ScheduleCooldownScan = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:2613\n combat_event_type = <table> {\n }\n regions = <table> {\n }\n frameLevels = <table> {\n }\n CheckItemSlotCooldowns = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:1830\n form_types = <table> {\n }\n EnsureClone = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2882\n debug = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:262\n CanShowNameInfo = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3614\n tooltip_count = <table> {\n }\n pet_spec_types = <table> {\n }\n regionOptions = <table> {\n }\n IsRegisteredForCustomTextUpdates = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3913\n CreateEncounterTable = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:1366\n animations = <table> {\n }\n TenchInit = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:2442\n regionTypes = <table> {\n }\n absorb_modes = <table> {\n }\n miss_types = <table> {\n }\n GetGCDInfo = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:1487\n faction_group = <table> {\n }\n OpenOptions = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:68\n autoeventend_types = <table> {\n }\n CanGroupShowWithZero = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3486\n talent_types = <table> {\n }\n GetSpellCooldown = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:1438\n circular_group_constant_factor_types = <table> {\n }\n GetAuraTooltipInfo = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3735\n events = <table> {\n }\n FinishLoadUnload = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:1716\n GetHSVTransition = <function> defined @Interface\\AddOns\\WeakAuras\\Prototypes.lua:119\n AddManyFromAddons = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:1957\n WatchForMounts = <function> defined @Interface\\AddOns\\WeakAuras\\GenericTrigger.lua:2514\n spec_types_3 = <table> {\n }\n IsImporting = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:1245\n FixGroupChildrenOrderForGroup = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3942\n blend_types = <table> {\n }\n GetFrameLevelFor = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:3966\n text_automatic_width = <table> {\n }\n GetPolarCoordinates = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\DynamicGroup.lua:42\n GetDynamicIconCache = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:4054\n custom_trigger_types = <table> {\n }\n group_types = <table> {\n }\n CollapseAllClones = <function> defined @Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2899\n partyUnits = <table> {\n }\n TimerTick = <function> defined @Interface\\AddOns\\WeakAuras\\RegionTypes\\RegionPrototype.lua:394\n IsSpellInRange = <function> defined @Interface\\AddOns\\WeakAuras\\Prototypes.lua:22\n SetDynamicIconCache = <function> defined @Interface",
			["stack"] = "Interface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:2707: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2698>\nInterface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:2786: in function `Add'\nInterface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:2588: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:2567>\nInterface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:2580: in function `load'\nInterface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:2594: in function `AddMany'\nInterface\\AddOns\\WeakAuras\\WeakAuras-2.7.7.lua:1200: in function <Interface\\AddOns\\WeakAuras\\WeakAuras.lua:1169>",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [25]
		{
			["message"] = "Interface\\AddOns\\OmniCC_Config\\panels\\general-综合.lua:156: attempt to index field 'Display' (a nil value)",
			["time"] = "2018/10/27 23:11:44",
			["locals"] = "_ = OmniCCOptions_General显示文字的最小字号 {\n 0 = <userdata>\n type = 3\n High = OmniCCOptions_General显示文字的最小字号High {\n }\n Low = OmniCCOptions_General显示文字的最小字号Low {\n }\n GetSavedValue = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:159\n Thumb = OmniCCOptions_General显示文字的最小字号Thumb {\n }\n tooltip = \"确定多大的框架能显示文字。\n该值越小，可以展示的东西越小。\n该值越大，可以展示的东西越大。\n\n一些基准:\n100 - 动作按钮的大小\n80  - 职业或宠物动作按钮的大小\n55  - 暴雪目标增益框架的大小\"\n SetSavedValue = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:154\n Text = OmniCCOptions_General显示文字的最小字号Text {\n }\n valText = <unnamed> {\n }\n}\nvalue = 50\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"base\"\n(*temporary) = \"attempt to index field 'Display' (a nil value)\"\nparent = OmniCCOptions_General {\n 0 = <userdata>\n AddWidgets = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:14\n CreateTenthsSlider = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:222\n buttons = <table> {\n }\n CreateEnableTextCheckbox = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:83\n sliders = <table> {\n }\n CreateFinishEffectPicker = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:269\n NewSlider = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:119\n CreateMMSSSlider = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:189\n CreateMinEffectDurationSlider = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:168\n CreateScaleTextCheckbox = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:101\n NewCheckbox = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:74\n GetGroupSets = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:70\n CreateMinSizeSlider = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:150\n CreateMinDurationSlider = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:129\n UpdateValues = <function> defined @Interface\\AddOns\\OmniCC_Config\\panels\\general.lua:50\n}\nOmniCC = OmniCC {\n 0 = <userdata>\n countdownForCooldowns = \"0\"\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n ShowOptionsMenu = <function> defined @Interface\\AddOns\\OmniCC_Config\\mainPanel.lua:338\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n sets = <table> {\n }\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_",
			["stack"] = "Interface\\AddOns\\OmniCC_Config\\panels\\general-综合.lua:156: in function `SetSavedValue'\nInterface\\AddOns\\OmniCC_Config\\widgets\\slider.lua:55: in function <Interface\\AddOns\\OmniCC_Config\\widgets\\slider.lua:50>\n[C]: in function `SetValue'\nInterface\\AddOns\\OmniCC_Config\\widgets\\slider.lua:96: in function `UpdateValue'\nInterface\\AddOns\\OmniCC_Config\\panels\\general-综合.lua:59: in function `UpdateValues'\nInterface\\AddOns\\OmniCC_Config\\panels\\general-综合.lua:300: in main chunk\n[C]: in function `LoadAddOn'\nInterface\\AddOns\\OmniCC\\main.lua:16: in function <Interface\\AddOns\\OmniCC\\main.lua:15>\n[C]: in function `Show'\nInterface\\FrameXML\\UIParent.lua:2614: in function `SetUIPanel'\nInterface\\FrameXML\\UIParent.lua:2420: in function `ShowUIPanel'\nInterface\\FrameXML\\UIParent.lua:2320: in function <Interface\\FrameXML\\UIParent.lua:2316>\n[C]: in function `SetAttribute'\nInterface\\FrameXML\\UIParent.lua:3141: in function <Interface\\FrameXML\\UIParent.lua:3129>\n[C]: in function `ShowUIPanel'\nInterface\\FrameXML\\UIParent.lua:3162: in function `ShowOptionsPanel'\n[string \"*:OnClick\"]:2: in function <[string \"*:OnClick\"]:1>",
			["session"] = 1349,
			["counter"] = 1,
		}, -- [26]
		{
			["message"] = "Interface\\AddOns\\OmniCC_Config\\panels\\general-综合.lua:283: attempt to index field 'FX' (a nil value)",
			["time"] = "2018/10/27 23:11:49",
			["locals"] = "t = <table> {\n}\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index field 'FX' (a nil value)\"\nOmniCC = OmniCC {\n 0 = <userdata>\n countdownForCooldowns = \"0\"\n ADDON_LOADED = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:43\n StartupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:24\n PLAYER_LOGIN = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:55\n UpdateCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:222\n GetGroupSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:47\n GetVersion = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:103\n StartupGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:54\n GetCooldownSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:16\n New = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:73\n ShowOptionsMenu = <function> defined @Interface\\AddOns\\OmniCC_Config\\mainPanel.lua:338\n GetCooldownGroupID = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:23\n Startup = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:8\n WatchCooldowns = <function> defined @Interface\\AddOns\\OmniCC\\core\\cooldown.lua:210\n UpdateGroups = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:85\n sets = <table> {\n }\n AddGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:63\n UpgradeSettings = <function> defined @Interface\\AddOns\\OmniCC\\settings\\settings.lua:42\n GetButtonIcon = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:87\n GetGroupIndex = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:53\n PLAYER_LOGOUT = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:63\n RemoveGroup = <function> defined @Interface\\AddOns\\OmniCC\\settings\\groups.lua:73\n SetupCommands = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:26\n PLAYER_ENTERING_WORLD = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:51\n Timer = <table> {\n }\n CreateHiddenFrame = <function> defined @Interface\\AddOns\\OmniCC\\main.lua:79\n}\n",
			["stack"] = "Interface\\AddOns\\OmniCC_Config\\panels\\general-综合.lua:283: in function `GetItems'\nInterface\\AddOns\\OmniCC_Config\\widgets\\dropdown.lua:338: in function `ShowMenu'\nInterface\\AddOns\\OmniCC_Config\\widgets\\dropdown.lua:211: in function <Interface\\AddOns\\OmniCC_Config\\widgets\\dropdown.lua:203>",
			["session"] = 1349,
			["counter"] = 3,
		}, -- [27]
		{
			["message"] = "Interface\\AddOns\\OmniCC\\core\\cooldown.lua:188: attempt to index upvalue 'Display' (a nil value)",
			["time"] = "2018/10/27 23:01:45",
			["locals"] = "state = <table> {\n visible = true\n priority = 1\n settings = <table> {\n }\n kind = \"default\"\n start = 171237.613\n duration = 1\n cooldown = <unnamed> {\n }\n show = true\n}\noldDisplay = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"attempt to index upvalue 'Display' (a nil value)\"\nDisplay = nil\n",
			["stack"] = "Interface\\AddOns\\OmniCC\\core\\cooldown.lua:188: in function <Interface\\AddOns\\OmniCC\\core\\cooldown.lua:184>\nInterface\\AddOns\\OmniCC\\core\\cooldown.lua:78: in function <Interface\\AddOns\\OmniCC\\core\\cooldown.lua:58>\n[C]: in function `SetCooldown'\n[string \"*:OnLoad\"]:1: in function <[string \"*:OnLoad\"]:1>",
			["session"] = 1349,
			["counter"] = 25477,
		}, -- [28]
		{
			["message"] = "Interface\\AddOns\\MythicPlusTimer\\CMTimer.lua:299: attempt to index field '?' (a nil value)",
			["time"] = "2018/10/28 22:36:33",
			["stack"] = "Interface\\AddOns\\MythicPlusTimer\\CMTimer.lua:299: in function `OnComplete'\nInterface\\AddOns\\MythicPlusTimer\\Core.lua:178: in function `?'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:145: in function <...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:145>\n[string \"safecall Dispatcher[1]\"]:4: in function <[string \"safecall Dispatcher[1]\"]:4>\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:13: in function `?'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:90: in function `Fire'\nInterface\\AddOns\\Ace3\\AceEvent-3.0\\AceEvent-3.0-4.lua:120: in function <Interface\\AddOns\\Ace3\\AceEvent-3.0\\AceEvent-3.0.lua:119>",
			["session"] = 1353,
			["counter"] = 1,
		}, -- [29]
		{
			["message"] = "Interface\\AddOns\\AngryKeystones\\Splits.lua:135: bad argument #1 to 'pairs' (table expected, got nil)",
			["time"] = "2018/10/11 00:28:09",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"table expected, got nil\"\n = <function> defined =[C]:-1\n",
			["stack"] = "[C]: in function `pairs'\nInterface\\AddOns\\AngryKeystones\\Splits.lua:135: in function `?'\nInterface\\AddOns\\AngryKeystones\\Core.lua:10: in function <Interface\\AddOns\\AngryKeystones\\Core.lua:6>",
			["session"] = 1353,
			["counter"] = 2,
		}, -- [30]
		{
			["message"] = "Interface\\FrameXML\\UnitPopup.lua:988: bad argument #1 to 'CanReportPlayer' (Usage: local canReport = C_ChatInfo.CanReportPlayer(playerLocation))",
			["time"] = "2018/10/31 23:03:35",
			["locals"] = "(*temporary) = <table> {\n IsBattleNetGUID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:63\n SetGUID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:47\n IsCommunityData = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:129\n IsBattlefieldScoreIndex = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:99\n SetUnit = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:71\n IsGUID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:59\n chatLineID = \"21805\"\n IsChatLineID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:87\n Clear = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:144\n IsValid = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:51\n SetVoiceID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:107\n IsVoiceID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:113\n GetBattlefieldScoreIndex = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:103\n IsUnit = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:75\n SetCommunityInvitation = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:133\n GetVoiceID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:117\n IsCommunityInvitation = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:139\n GetChatLineID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:91\n ClearAndSetField = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:158\n GetGUID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:67\n GetUnit = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:79\n SetChatLineID = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:83\n SetBattlefieldScoreIndex = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:95\n SetCommunityData = <function> defined @Interface\\FrameXML\\ObjectAPI\\PlayerLocation.lua:121\n}\n",
			["stack"] = "[C]: in function `CanReportPlayer'\nInterface\\FrameXML\\UnitPopup.lua:988: in function `UnitPopup_HideButtons'\nInterface\\FrameXML\\UnitPopup.lua:306: in function `UnitPopup_ShowMenu'\nInterface\\FrameXML\\FriendsFrame.lua:227: in function `initFunction'\nInterface\\FrameXML\\UIDropDownMenu.lua:77: in function `UIDropDownMenu_Initialize'\nInterface\\FrameXML\\UIDropDownMenu.lua:1085: in function <Interface\\FrameXML\\UIDropDownMenu.lua:950>\n[C]: in function `ToggleDropDownMenu'\nInterface\\FrameXML\\FriendsFrame.lua:198: in function `FriendsFrame_ShowDropdown'\nInterface\\FrameXML\\ItemRef.lua:60: in function <Interface\\FrameXML\\ItemRef.lua:1>\n[C]: ?\n...ace\\AddOns\\Blizzard_CombatLog\\Blizzard_CombatLog.lua:3510: in function `SetItemRef'\nInterface\\FrameXML\\ChatFrame.lua:3630: in function <Interface\\FrameXML\\ChatFrame.lua:3629>\n[C]: ?\n[C]: ?\n[C]: in function `ChatFrame_OnHyperlinkShow'\n[string \"*:OnHyperlinkClick\"]:1: in function <[string \"*:OnHyperlinkClick\"]:1>",
			["session"] = 1360,
			["counter"] = 15,
		}, -- [31]
		{
			["message"] = "Interface\\AddOns\\ExRT\\BossWatcher.lua:3227: attempt to perform arithmetic on field 'encounterStart' (a nil value)",
			["time"] = "2018/11/02 21:12:02",
			["locals"] = "self = <unnamed> {\n 0 = <userdata>\n PushedTexture = <unnamed> {\n }\n HighlightTexture = <unnamed> {\n }\n tooltipText = \"选择战斗\"\n}\nfightsList = <table> {\n 1 = <table> {\n }\n 2 = <table> {\n }\n 3 = <table> {\n }\n 4 = <table> {\n }\n 5 = <table> {\n }\n 6 = <table> {\n }\n 7 = <table> {\n }\n}\n(for index) = 7\n(for limit) = 7\n(for step) = 1\ni = 7\ncolorCode = \"\"\nfightData = <table> {\n}\n(*temporary) = 683074.665\n(*temporary) = nil\n(*temporary) = <table> {\n notCheckable = true\n text = \"6. 米斯拉克斯: 20:20 - 20:27 (6m57s)\"\n func = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:3231\n}\n(*temporary) = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:3231\n(*temporary) = \". \"\n(*temporary) = \"\"\n(*temporary) = \"米斯拉克斯\"\n(*temporary) = \": 20:20 - \"\n(*temporary) = \"20:27\"\n(*temporary) = \" (6m57s)\"\n(*temporary) = \"\"\n(*temporary) = 6\n(*temporary) = 57.790999999968\n(*temporary) = \"attempt to perform arithmetic on field 'encounterStart' (a nil value)\"\nL = <table> {\n}\nmodule = <table> {\n options = ExRTOptionsFrameBossWatcher {\n }\n miniMapMenu = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:404\n Enable = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:362\n CLEU = <unnamed> {\n }\n ClearData = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:2817\n name = \"BossWatcher\"\n slash = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:2793\n db = <table> {\n }\n timer = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:1384\n main = <unnamed> {\n }\n Disable = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:379\n}\nGetTime = <function> defined =[C]:-1\ndate = <function> defined =[C]:-1\nformat = <function> defined =[C]:-1\nBWInterfaceFrame = <unnamed> {\n 0 = <userdata>\n nowFightIDShort = \"683059.085-2.219000000041\"\n nowFightID = \"683059.085,1,2,3\"\n GraphFrame = <unnamed> {\n }\n phaseButton = <unnamed> {\n }\n border = <unnamed> {\n }\n backToInterface = <unnamed> {\n }\n tab = <unnamed> {\n }\n bossButtonDropDown = GExRTBWInterfaceFrameBossButtonDropDown {\n }\n HeaderText = <unnamed> {\n }\n report = <unnamed> {\n }\n bossButton = <unnamed> {\n }\n DecorationLine = <unnamed> {\n }\n timeLineFrame = <unnamed> {\n }\n buttonClose = <unnamed> {\n }\n}\nCloseDropDownMenus_fix = <function> defined @Interface\\AddOns\\ExRT\\BossWatcher.lua:2964\n",
			["stack"] = "Interface\\AddOns\\ExRT\\BossWatcher.lua:3227: in function <Interface\\AddOns\\ExRT\\BossWatcher.lua:3212>",
			["session"] = 1365,
			["counter"] = 7,
		}, -- [32]
		{
			["message"] = "Frame CmTimer is not movable",
			["time"] = "2018/11/02 22:47:36",
			["locals"] = "InCombatSkipped",
			["stack"] = "[C]: ?",
			["session"] = 1366,
			["counter"] = 1,
		}, -- [33]
		{
			["message"] = "Interface\\AddOns\\MeetingStone\\Logic\\App.lua:73: Cannot register panel (same name)",
			["time"] = "2018/10/15 22:54:15",
			["stack"] = "[C]: in function `error'\n...\\MeetingStone\\Libs\\NetEaseGUI-2.0-2\\Embed\\TabPanel.lua:76: in function `RegisterPanel'\nInterface\\AddOns\\MeetingStone\\Logic\\App.lua:73: in function `?'\n...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:119: in function <...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[C]: ?\n...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function `FireServer'\n...ngStone\\Libs\\NetEaseSocket-2.0-2\\SocketHandler-2.0-20.lua:135: in function `?'\n...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:119: in function <...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:119>\n[C]: ?\n...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:29: in function <...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:25>\n...edia-3.0\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:64: in function `Fire'\n...SocketMiddleware-2.0\\NetEaseSocketMiddleware-2.0-1.lua:34: in function `DealPacket'\n...SocketMiddleware-2.0\\NetEaseSocketMiddleware-2.0-1.lua:27: in function `?'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:145: in function <...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:145>\n[string \"safecall Dispatcher[4]\"]:4: in function <[string \"safecall Dispatcher[4]\"]:4>\n[C]: ?\n[string \"safecall Dispatcher[4]\"]:13: in function `?'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:90: in function `Fire'\nInterface\\AddOns\\Ace3\\AceComm-3.0\\AceComm-3.0-12.lua:264: in function <Interface\\AddOns\\Ace3\\AceComm-3.0\\AceComm-3.0.lua:246>",
			["session"] = 1376,
			["counter"] = 2,
		}, -- [34]
		{
			["message"] = "Interface\\AddOns\\Auctionator\\Auctionator-5.0.5.lua:5058: bad argument #1 to 'strlen' (string expected, got nil)",
			["time"] = "2018/09/19 20:35:52",
			["locals"] = "(*temporary) = nil\n(*temporary) = \"string expected, got nil\"\n",
			["stack"] = "[C]: in function `strlen'\nInterface\\AddOns\\Auctionator\\Auctionator-5.0.5.lua:5058: in function `Atr_Item_Autocomplete'\n[string \"*:OnCharComposition\"]:1: in function <[string \"*:OnCharComposition\"]:1>",
			["session"] = 1390,
			["counter"] = 6,
		}, -- [35]
		{
			["message"] = "Couldn't open Interface\\AddOns\\Buffet\\Buffet.toc",
			["time"] = "2018/11/08 21:19:00",
			["session"] = 1393,
			["counter"] = 4,
		}, -- [36]
		{
			["message"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\AltNames.lua:1070: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2018/11/09 20:20:37",
			["stack"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\AltNames.lua:1070: in function `init'\nInterface\\AddOns\\Prat-3.0-3.6.17\\addon\\modules.lua:150: in function <Interface\\AddOns\\Prat-3.0\\addon\\modules.lua:143>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:529: in function `InitializeAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:644: in function <Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:636>",
			["session"] = 1394,
			["counter"] = 1,
		}, -- [37]
		{
			["message"] = "Interface\\FrameXML\\ChatFrame.lua:2659: Attempt to register unknown event \"CHAT_MSG_PARTY_GUIDE\"",
			["time"] = "2018/11/09 20:20:51",
			["locals"] = "(*temporary) = ChatFrame1 {\n SetJustifyV = <function> defined =[C]:-1\n RefreshIfNecessary = <function> defined =[C]:-1\n OnPostShow = <function> defined =[C]:-1\n CalculateLineAlphaValueFromTimestamp = <function> defined =[C]:-1\n isLayoutDirty = true\n tellTimer = 454.49\n isDisplayDirty = true\n GetFading = <function> defined =[C]:-1\n IsTextCopyable = <function> defined =[C]:-1\n shouldFadeAfterInactivity = true\n SetIndentedWordWrap = <function> defined =[C]:-1\n GetJustifyV = <function> defined =[C]:-1\n SetFont = <function> defined =[C]:-1\n GetMaxLines = <function> defined =[C]:-1\n GetIndentedWordWrap = <function> defined =[C]:-1\n buttonSide = \"left\"\n GetFont = <function> defined =[C]:-1\n onScrollChangedCallback = <function> defined =[C]:-1\n CalculateSelectingCharacterIndicesForVisibleLine = <function> defined =[C]:-1\n PageUp = <function> defined =[C]:-1\n RefreshDisplay = <function> defined =[C]:-1\n SetFontObject = <function> defined =[C]:-1\n textIsCopyable = false\n SetOnScrollChangedCallback = <function> defined =[C]:-1\n CalculateNumVisibleLines = <function> defined =[C]:-1\n overrideFadeTimestamp = 0\n MarkDisplayDirty = <function> defined =[C]:-1\n GetMessageInfo = <function> defined =[C]:-1\n GetOnScrollChangedCallback = <function> defined =[C]:-1\n AtTop = <function> defined =[C]:-1\n GetFontObject = <function> defined =[C]:-1\n resizeBottom = ChatFrame1ResizeBottom {\n }\n fontStringPool = <table> {\n }\n CanEffectivelyFade = <function> defined =[C]:-1\n OnPreSizeChanged = <function> defined =[C]:-1\n OnPostMouseUp = <function> defined =[C]:-1\n selected = true\n GetSpacing = <function> defined =[C]:-1\n OnPreLoad = <function> defined =[C]:-1\n SetSpacing = <function> defined =[C]:-1\n name = \"综合\"\n CalculateLineSpacing = <function> defined =[C]:-1\n AddMessage = <function> defined @Interface\\AddOns\\PhanxChat\\Core.lua:127\n InitializeFontableFrame = <function> defined =[C]:-1\n GetShadowColor = <function> defined =[C]:-1\n isUninteractable = false\n SetOnTextCopiedCallback = <function> defined =[C]:-1\n AcquireFontString = <function> defined =[C]:-1\n TransformMessages = <function> defined =[C]:-1\n SetShadowColor = <function> defined =[C]:-1\n buttonFrame = ChatFrame1ButtonFrame {\n }\n HasFontObject = <function> defined =[C]:-1\n isDocked = 1\n resizeTop = ChatFrame1ResizeTop {\n }\n GetOnTextCopiedCallback = <function> defined =[C]:-1\n SetFading = <function> defined =[C]:-1\n OnPostHide = <function> defined =[C]:-1\n resizeLeft = ChatFrame1ResizeLeft {\n }\n resizeRight = ChatFrame1ResizeRight {\n }\n isInitialized = 1\n ScrollByAmount = <function> defined =[C]:-1\n GetInsertMode = <function> defined =[C]:-1\n SetTimeVisible = <function> defined =[C]:-1\n hasOwnFontObject = true\n Clear = <function> defined =[C]:-1\n oldAlpha = 0.15686275064945\n channelList = <table> {\n }\n GetTimeVisible = <function> defined =[C]:-1\n MarkLayoutDirty = <function> defined =[C]:-1\n SetTextCopyable = <function> defined =[C]:-1\n BackFillMessage = <function> defined =[C]:-1\n UnpackageEntry = <function> defined =[C]:-1\n ScrollBar = <unnamed> {\n }\n SetShadowOffset = <function> defined =[C]:-1\n messageTypeList = <table> {\n }\n timeVisibleSecs = 60\n PackageEntry = <function> defined =[C]:-1\n resizeTopRight = ChatFrame1ResizeTopRight {\n }\n MakeFontObjectCustom = <function> defined =[C]:-1\n fontObject = table: 000002665BE0D9D0 {\n }\n SetInsertMode = <function> defined =[C]:-1\n ScrollDown = <function> defined =[C]:-1\n zoneChannelList = <table> {\n }\n SetScrollOffset = <function> defined =[C]:-1\n onDisplayRefreshedCallback = <function> defined =[C]:-1\n insertMode = 2\n resizeBottomLeft = ChatFrame1ResizeBottomLeft {\n }\n ResetSelectingText = <function> defined =[C]:-1\n tab = ChatFrame1Tab {\n }\n PageDown = <function> defined =[C]:-1\n resizeTopLeft = ChatFrame1ResizeTopLeft {\n }\n GetTextColor = <function> defined =[C]:-1\n GatherSelectedText = <function> defined =[C]:-1\n ResetAllFadeTimes = <function> defined =[C]:-1\n SetMaxLines = <function> defined =[C]:-1\n GetNumVisibleLines = <function> defined =[C]:-1\n ScrollUp = <function> defined =[C]:-1\n 0 = <userdata>\n fadeDurationSecs = 3\n IsSelectingT",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\FrameXML\\ChatFrame.lua:2659: in function `ChatFrame_RegisterForMessages'\nInterface\\FrameXML\\ChatFrame.lua:2951: in function `ChatFrame_ConfigEventHandler'\nInterface\\FrameXML\\ChatFrame.lua:2892: in function `ChatFrame_OnEvent'\n[string \"*:OnEvent\"]:1: in function <[string \"*:OnEvent\"]:1>",
			["session"] = 1394,
			["counter"] = 2,
		}, -- [38]
		{
			["message"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\Buttons.lua:602: attempt to index local 'upButton' (a nil value)",
			["time"] = "2018/11/09 20:20:55",
			["stack"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\Buttons.lua:602: in function `ShowButtons'\nInterface\\AddOns\\Prat-3.0-3.6.17\\modules\\Buttons.lua:472: in function `ApplyAllSettings'\nInterface\\AddOns\\Prat-3.0-3.6.17\\modules\\Buttons.lua:460: in function `OnModuleEnable'\nInterface\\AddOns\\Prat-3.0-3.6.17\\addon\\modules.lua:182: in function <Interface\\AddOns\\Prat-3.0\\addon\\modules.lua:174>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:571: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:446: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:565: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:1192: in function <Interface\\FrameXML\\UIParent.lua:1090>",
			["session"] = 1394,
			["counter"] = 1,
		}, -- [39]
		{
			["message"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\ChannelSticky.lua:372: attempt to call global 'TEXT' (a nil value)",
			["time"] = "2018/11/09 20:20:55",
			["stack"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\ChannelSticky.lua:372: in function `BuildChannelList'\nInterface\\AddOns\\Prat-3.0-3.6.17\\modules\\ChannelSticky.lua:271: in function `OnModuleEnable'\nInterface\\AddOns\\Prat-3.0-3.6.17\\addon\\modules.lua:182: in function <Interface\\AddOns\\Prat-3.0\\addon\\modules.lua:174>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:571: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:446: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:565: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:1192: in function <Interface\\FrameXML\\UIParent.lua:1090>",
			["session"] = 1394,
			["counter"] = 1,
		}, -- [40]
		{
			["message"] = "Interface\\AddOns\\Ace3\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: Attempt to register unknown event \"PARTY_MEMBERS_CHANGED\"",
			["time"] = "2018/11/09 20:20:55",
			["stack"] = "[C]: in function `RegisterEvent'\nInterface\\AddOns\\Ace3\\AceEvent-3.0\\AceEvent-3.0-4.lua:33: in function `OnUsed'\n...Ons\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0-7.lua:168: in function `RegisterEvent'\nInterface\\AddOns\\Prat-3.0-3.6.17\\modules\\PlayerNames.lua:979: in function `OnModuleEnable'\nInterface\\AddOns\\Prat-3.0-3.6.17\\addon\\modules.lua:182: in function <Interface\\AddOns\\Prat-3.0\\addon\\modules.lua:174>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:571: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:446: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:565: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:1192: in function <Interface\\FrameXML\\UIParent.lua:1090>",
			["session"] = 1394,
			["counter"] = 1,
		}, -- [41]
		{
			["message"] = "...ddOns\\Prat-3.0-3.6.17_Libraries\\LibSink-2.0\\LibSink-2.0-90103.lua:253: table index is nil",
			["time"] = "2018/11/09 20:21:22",
			["locals"] = "(for index) = 15\n(for limit) = 15\n(for step) = 2\ni = 15\nid = false\nname = nil\n(*temporary) = <table> {\n (null) = \"本地防务\"\n 2 = false\n 集合石 = 1\n b1ueb1ues = 5\n 4 = true\n 交易 = 3\n}\n(*temporary) = \"table index is nil\"\nwipe = <function> defined =[C]:-1\nsink = <table> {\n SetSinkStorage = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:665\n RegisterSink = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:627\n handlers = <table> {\n }\n SetSinkOverride = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:672\n channelMapping = <table> {\n }\n embeds = <table> {\n }\n Embed = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:706\n stickyAddons = <table> {\n }\n registeredScrollAreaFunctions = <table> {\n }\n GetSinkAce3OptionsDataTable = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:508\n registeredSinks = <table> {\n }\n override = <table> {\n }\n channelMappingIds = <table> {\n }\n storageForAddon = <table> {\n }\n msbt_registered_fonts = <table> {\n }\n frame = <unnamed> {\n }\n Pour = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:368\n GetSinkAce2OptionsDataTable = <function> defined @Interface\\AddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:444\n}\nselect = <function> defined =[C]:-1\nnext = <function> defined =[C]:-1\n",
			["stack"] = "...ddOns\\Prat-3.0-3.6.17_Libraries\\LibSink-2.0\\LibSink-2.0-90103.lua:253: in function <...ddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:249>\n...ddOns\\Prat-3.0-3.6.17_Libraries\\LibSink-2.0\\LibSink-2.0-90103.lua:262: in function <...ddOns\\Prat-3.0_Libraries\\LibSink-2.0\\LibSink-2.0.lua:262>",
			["session"] = 1394,
			["counter"] = 1,
		}, -- [42]
		{
			["message"] = "Interface\\AddOns\\Prat-3.0-3.6.17\\modules\\CopyChat.lua:800: Usage: PlaySound(soundKitID, optional[\"SFX\",\"Music\",\"Ambience\", \"Dialog\" or \"Master\"], [forceNoDuplicates, runFinishCallback])",
			["time"] = "2018/11/09 20:21:23",
			["locals"] = "(*temporary) = \"igChatBottom\"\n",
			["stack"] = "[C]: in function `PlaySound'\nInterface\\AddOns\\Prat-3.0-3.6.17\\modules\\CopyChat.lua:800: in function <Interface\\AddOns\\Prat-3.0\\modules\\CopyChat.lua:799>",
			["session"] = 1394,
			["counter"] = 1,
		}, -- [43]
		{
			["message"] = "Interface\\FrameXML\\FloatingChatFrame.lua:1115: bad argument #1 to 'max' (number expected, got nil)",
			["time"] = "2018/11/09 20:21:19",
			["locals"] = "(*temporary) = nil\n(*temporary) = 0.25\n(*temporary) = \"number expected, got nil\"\n",
			["stack"] = "[C]: in function `max'\nInterface\\FrameXML\\FloatingChatFrame.lua:1115: in function `FCF_FadeInChatFrame'\nInterface\\FrameXML\\FloatingChatFrame.lua:1201: in function `FCF_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 1394,
			["counter"] = 2,
		}, -- [44]
		{
			["message"] = "Interface\\FrameXML\\FloatingChatFrame.lua:1147: bad argument #2 to 'max' (number expected, got nil)",
			["time"] = "2018/11/09 20:21:20",
			["locals"] = "(*temporary) = 1\n(*temporary) = nil\n(*temporary) = \"number expected, got nil\"\n",
			["stack"] = "[C]: in function `max'\nInterface\\FrameXML\\FloatingChatFrame.lua:1147: in function `FCF_FadeOutChatFrame'\nInterface\\FrameXML\\FloatingChatFrame.lua:1210: in function `FCF_OnUpdate'\n[string \"*:OnUpdate\"]:1: in function <[string \"*:OnUpdate\"]:1>",
			["session"] = 1394,
			["counter"] = 2,
		}, -- [45]
		{
			["message"] = "[ADDON_ACTION_BLOCKED] 插件 'MeetingStone' 尝试调用保护功能 'SetBinding()'。",
			["time"] = "2018/11/10 22:10:46",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519: in function <Interface\\AddOns\\!BugGrabber\\BugGrabber.lua:519>\n[C]: in function `SetBinding'\n...ace\\AddOns\\Blizzard_BindingUI\\Blizzard_BindingUI.lua:353: in function <...ace\\AddOns\\Blizzard_BindingUI\\Blizzard_BindingUI.lua:349>\n...ace\\AddOns\\Blizzard_BindingUI\\Blizzard_BindingUI.lua:390: in function <...ace\\AddOns\\Blizzard_BindingUI\\Blizzard_BindingUI.lua:376>\n(tail call): ?",
			["session"] = 1398,
			["counter"] = 1,
		}, -- [46]
		{
			["message"] = "...ns\\Blizzard_MapCanvas\\MapCanvas_DataProviderBase.lua:11: assertion failed!",
			["time"] = "2018/09/14 18:05:54",
			["stack"] = "[C]: in function `assert'\n...ns\\Blizzard_MapCanvas\\MapCanvas_DataProviderBase.lua:11: in function `OnRemoved'\n...ace\\AddOns\\Blizzard_MapCanvas\\Blizzard_MapCanvas.lua:87: in function `RemoveDataProvider'\nInterface\\AddOns\\HandyNotes\\HandyNotes-v1.5.3.lua:636: in function <Interface\\AddOns\\HandyNotes\\HandyNotes.lua:630>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:593: in function <Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:586>\n(tail call): ?\nInterface\\AddOns\\HandyNotes\\HandyNotes-v1.5.3.lua:619: in function <Interface\\AddOns\\HandyNotes\\HandyNotes.lua:617>\n(tail call): ?\n[C]: ?\n[string \"safecall Dispatcher[1]\"]:9: in function <[string \"safecall Dispatcher[1]\"]:5>\n(tail call): ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:558: in function `EnableAddon'\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:651: in function <Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:636>\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:446: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:565: in function `TimeManager_LoadUI'\nInterface\\FrameXML\\UIParent.lua:1192: in function <Interface\\FrameXML\\UIParent.lua:1090>",
			["session"] = 1400,
			["counter"] = 241,
		}, -- [47]
		{
			["message"] = "Interface\\FrameXML\\PetActionBarFrame.lua:246: attempt to perform arithmetic on a nil value",
			["time"] = "2018/11/13 20:38:01",
			["locals"] = "InCombatSkipped",
			["stack"] = "Interface\\FrameXML\\PetActionBarFrame.lua:246: in function `PetActionBar_UpdatePositionValues'\nInterface\\FrameXML\\UIParent.lua:3008: in function `UIParentManageFramePositions'\nInterface\\FrameXML\\UIParent.lua:2329: in function <Interface\\FrameXML\\UIParent.lua:2316>\n[C]: in function `SetAttribute'\nInterface\\FrameXML\\UIParent.lua:3118: in function <Interface\\FrameXML\\UIParent.lua:3116>\n[C]: in function `UIParent_ManageFramePositions'\nInterface\\FrameXML\\MainMenuBar.lua:172: in function <Interface\\FrameXML\\MainMenuBar.lua:149>\n[C]: in function `MainMenuBarVehicleLeaveButton_Update'\nInterface\\FrameXML\\MainMenuBar.lua:146: in function <Interface\\FrameXML\\MainMenuBar.lua:145>",
			["session"] = 1404,
			["counter"] = 2,
		}, -- [48]
		{
			["message"] = "Usage: local spellID = C_SpecializationInfo.GetSpellsDisplay(specializationID)",
			["time"] = "2018/09/21 13:32:17",
			["locals"] = "(*temporary) = \"Usage: local spellID = C_SpecializationInfo.GetSpellsDisplay(specializationID)\"\n",
			["stack"] = "[C]: in function `GetSpellsDisplay'\n...rface\\AddOns\\Blizzard_TalentUI\\Blizzard_TalentUI.lua:1247: in function `PlayerTalentFrame_UpdateSpecFrame'\n...rface\\AddOns\\Blizzard_TalentUI\\Blizzard_TalentUI.lua:417: in function `PlayerTalentFrame_Refresh'\n...rface\\AddOns\\Blizzard_TalentUI\\Blizzard_TalentUI.lua:306: in function <...rface\\AddOns\\Blizzard_TalentUI\\Blizzard_TalentUI.lua:299>",
			["session"] = 1404,
			["counter"] = 4,
		}, -- [49]
		{
			["message"] = "...face\\AddOns\\Blizzard_GuildControlUI\\Localization.lua:4: attempt to index global 'GuildControlUIRankSettingsFrameRosterLabel' (a nil value)",
			["time"] = "2018/09/14 17:47:28",
			["locals"] = "(*temporary) = nil\n(*temporary) = nil\n(*temporary) = \"TOPLEFT\"\n(*temporary) = GuildControlUIRankSettingsFrameBankBg {\n 0 = <userdata>\n}\n(*temporary) = 7\n(*temporary) = -4\n(*temporary) = \"attempt to index global 'GuildControlUIRankSettingsFrameRosterLabel' (a nil value)\"\n",
			["stack"] = "...face\\AddOns\\Blizzard_GuildControlUI\\Localization.lua:4: in main chunk\n[C]: in function `LoadAddOn'\nInterface\\FrameXML\\UIParent.lua:446: in function `UIParentLoadAddOn'\nInterface\\FrameXML\\UIParent.lua:692: in function `Communities_LoadUI'\nInterface\\FrameXML\\UIParent.lua:926: in function `ToggleCommunitiesFrame'\nInterface\\FrameXML\\UIParent.lua:813: in function <Interface\\FrameXML\\UIParent.lua:792>",
			["session"] = 1417,
			["counter"] = 86,
		}, -- [50]
		{
			["message"] = "Interface\\AddOns\\ItemLevelDisplay\\RelNotes.lua:3: Usage: GetAddon(name): 'name' - Cannot find an AceAddon 'ItemLevelDisplay'.",
			["time"] = "2018/09/14 18:05:51",
			["locals"] = "(*temporary) = \"Usage: GetAddon(name): 'name' - Cannot find an AceAddon 'ItemLevelDisplay'.\"\n",
			["stack"] = "[C]: ?\nInterface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0-12.lua:186: in function `GetAddon'\nInterface\\AddOns\\ItemLevelDisplay\\RelNotes.lua:3: in main chunk",
			["session"] = 1418,
			["counter"] = 262,
		}, -- [51]
		{
			["message"] = "Interface\\AddOns\\ItemLevelDisplay\\Bags.lua:38: attempt to index local 'addon' (a nil value)",
			["time"] = "2018/09/14 18:05:51",
			["locals"] = "me = \"ILD-Blizzard\"\nns = <table> {\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:325\n RegisterChatCommand = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:85\n print = <function> defined @Interface\\AddOns\\ItemLevelDisplay\\Bags.lua:27\n EnableModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:363\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:241\n IterateEmbeds = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:473\n SecureHook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:336\n defaultModuleLibraries = <table> {\n }\n TimeLeft = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:172\n UnregisterChatCommand = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:111\n RawHookScript = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:395\n ScheduleRepeatingTimer = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:129\n CancelAllTimers = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:160\n Printf = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:69\n GetName = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:310\n name = \"ILD-Blizzard\"\n IsEnabled = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:482\n orderedModules = <table> {\n }\n ScheduleTimer = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:94\n DisableModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:381\n RegisterMessage = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n GetArgs = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:144\n Print = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:54\n IsHooked = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:493\n CancelTimer = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:147\n hooks = <table> {\n }\n IsModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:499\n UnregisterAllEvents = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:418\n SendMessage = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:85\n UnregisterMessage = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n SetEnabledState = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:455\n Hook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:274\n enabledState = true\n defaultModuleState = true\n RegisterEvent = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n UnregisterAllMessages = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n HookScript = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:366\n UnhookAll = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:477\n Unhook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:418\n IterateModules = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:468\n SecureHookScript = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:410\n RawHook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:266\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:440\n UnregisterEvent = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:",
			["stack"] = "Interface\\AddOns\\ItemLevelDisplay\\Bags.lua:38: in main chunk",
			["session"] = 1418,
			["counter"] = 262,
		}, -- [52]
		{
			["message"] = "Interface\\AddOns\\ILD-Blizzard\\core.lua:4: attempt to index local 'module' (a nil value)",
			["time"] = "2018/09/14 18:05:51",
			["locals"] = "me = \"ILD-Blizzard\"\nns = <table> {\n SetDefaultModuleLibraries = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:398\n Enable = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:325\n RegisterChatCommand = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:85\n print = <function> defined @Interface\\AddOns\\ItemLevelDisplay\\Bags.lua:27\n EnableModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:363\n modules = <table> {\n }\n GetModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:241\n IterateEmbeds = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:473\n SecureHook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:336\n defaultModuleLibraries = <table> {\n }\n TimeLeft = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:172\n UnregisterChatCommand = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:111\n RawHookScript = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:395\n ScheduleRepeatingTimer = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:129\n CancelAllTimers = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:160\n Printf = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:69\n GetName = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:310\n name = \"ILD-Blizzard\"\n IsEnabled = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:482\n orderedModules = <table> {\n }\n ScheduleTimer = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:94\n DisableModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:381\n RegisterMessage = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n GetArgs = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:144\n Print = <function> defined @Interface\\AddOns\\Ace3\\AceConsole-3.0\\AceConsole-3.0.lua:54\n IsHooked = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:493\n CancelTimer = <function> defined @Interface\\AddOns\\Ace3\\AceTimer-3.0\\AceTimer-3.0.lua:147\n hooks = <table> {\n }\n IsModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:499\n UnregisterAllEvents = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n SetDefaultModuleState = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:418\n SendMessage = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:85\n UnregisterMessage = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:179\n SetEnabledState = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:455\n Hook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:274\n enabledState = true\n defaultModuleState = true\n RegisterEvent = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:116\n UnregisterAllMessages = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:200\n HookScript = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:366\n UnhookAll = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:477\n Unhook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:418\n IterateModules = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:468\n SecureHookScript = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:410\n RawHook = <function> defined @Interface\\AddOns\\Ace3\\AceHook-3.0\\AceHook-3.0.lua:313\n NewModule = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:266\n SetDefaultModulePrototype = <function> defined @Interface\\AddOns\\Ace3\\AceAddon-3.0\\AceAddon-3.0.lua:440\n UnregisterEvent = <function> defined @Interface\\AddOns\\Ace3\\CallbackHandler-1.0\\CallbackHandler-1.0.lua:",
			["stack"] = "Interface\\AddOns\\ILD-Blizzard\\core.lua:4: in main chunk",
			["session"] = 1418,
			["counter"] = 262,
		}, -- [53]
		{
			["message"] = "Interface\\AddOns\\ItemLevelDisplay\\ItemLevelDisplay-2.1.2 70200.lua:528: unexpected symbol near 'if'",
			["time"] = "2018/09/14 18:05:51",
			["locals"] = "",
			["stack"] = "",
			["session"] = 1418,
			["counter"] = 806,
		}, -- [54]
		{
			["message"] = "(null)",
			["time"] = "2018/09/14 17:47:28",
			["session"] = 1418,
			["counter"] = 1358,
		}, -- [55]
	},
}
