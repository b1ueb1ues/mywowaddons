
WeakAurasSaved = {
	["dynamicIconCache"] = {
		["白骨之盾"] = {
			[195181] = 458717,
		},
		["暗影斗篷"] = {
			[31224] = "Interface\\Icons\\Spell_Shadow_NetherCloak",
		},
		["壮胆酒"] = {
			[120954] = "Interface\\Icons\\ability_monk_fortifyingale",
		},
		["复苏之雾"] = {
			[119611] = 627487,
		},
		["轻度醉拳"] = {
			[124275] = "INTERFACE\\ICONS\\priest_icon_chakra_green",
		},
		["铁骨酒"] = {
			[215479] = "Interface\\Icons\\ability_monk_ironskinbrew",
		},
		["锁喉"] = {
			[703] = "Interface\\Icons\\Ability_Rogue_Garrote",
		},
	},
	["displays"] = {
		["BlackOxStatue"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["xOffset"] = 37.6475830078125,
			["stacksFlags"] = "None",
			["yOffset"] = -300.339767456055,
			["anchorPoint"] = "CENTER",
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["rotateText"] = "NONE",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "TOP",
			["barColor"] = {
				1, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["name"] = "",
				["faction"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_name"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["stacks"] = false,
			["texture"] = "ElvUI Norm",
			["textFont"] = "Friz Quadrata TT",
			["zoom"] = 0,
			["spark"] = false,
			["timerFont"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["borderInset"] = 11,
			["displayIcon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["customText"] = "function()\n    if (GetTotemInfo(1)) then\n        if (WA_BOS and WA_BOS.GUID) then\n            local OxHealth, OxHealthMax = tonumber(WA_BOS.Health) or 0, tonumber(WA_BOS.HealthMax) or 0\n            local healthString, perString\n            if (OxHealth >= 1000000) then\n                healthString = (\"%02.2fm\"):format(OxHealth / 1000000)       \n            elseif(OxHealth >= 1000) then\n                healthString = (\"%02.1fk\"):format(OxHealth / 1000)\n            else\n                healthString = OxHealth\n            end\n            \n            perString = (\"%02.1f%%\"):format(OxHealth / OxHealthMax * 100)\n            \n            if (OxHealth == OxHealthMax) then\n                return healthString\n            elseif (OxHealth > 0) then\n                return format(\"%s - %s\", healthString, perString)\n            end\n        else\n            return UNKNOWN\n        end\n    end\n    \n    return ACTION_UNIT_DIED\nend",
			["sparkRotationMode"] = "AUTO",
			["displayTextLeft"] = "%n",
			["triggers"] = {
				{
					["trigger"] = {
						["debuffType"] = "HELPFUL",
						["type"] = "custom",
						["custom_type"] = "event",
						["subeventSuffix"] = "_CAST_START",
						["names"] = {
						},
						["spellIds"] = {
						},
						["event"] = "Health",
						["unit"] = "player",
						["customDuration"] = "function()\n    if (WA_BOS and WA_BOS.GUID) then\n        local ColorGradient = function(a, b, ...)\n            local perc\n            if(b == 0) then\n                perc = 0\n            else\n                perc = a / b\n            end\n            \n            if perc >= 1 then\n                local r, g, b = select(select('#', ...) - 2, ...)\n                return r, g, b\n            elseif perc <= 0 then\n                local r, g, b = ...\n                return r, g, b\n            end\n            \n            local num = select('#', ...) / 3\n            local segment, relperc = math.modf(perc*(num-1))\n            local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)\n            \n            return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc\n        end\n        \n        local r, g, b = ColorGradient(WA_BOS.Health, WA_BOS.HealthMax, 1, 0, 0, 1, 1, 0, RAID_CLASS_COLORS[\"MONK\"].r, RAID_CLASS_COLORS[\"MONK\"].g , RAID_CLASS_COLORS[\"MONK\"].b)\n        \n        WeakAuras[\"regions\"][\"BlackOxStatue\"][\"region\"]:Color(r, g, b)\n        \n        return WA_BOS.Health, WA_BOS.HealthMax, true\n    end\nend",
						["customName"] = "function()\n    return select(2, GetTotemInfo(1))\nend",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED, PLAYER_TOTEM_UPDATE, PLAYER_ENTERING_WORLD, PLAYER_TARGET_CHANGED, UPDATE_MOUSEOVER_UNIT",
						["customIcon"] = "function()\n    return select(5, GetTotemInfo(1))\nend",
						["custom"] = "--****************************************\n--*あれがデネブ、アルタイル、ベガ，君は指さす夏の大三角\n--*Author: snyssss@gmail.com\n--*someone has fixed a bug: bblues@live.cn\n--****************************************\nfunction(event, ...)\n    WA_BOS = WA_BOS or { \n        GUID = nil,\n        Health = 0,  \n        HealthMax = 0\n    }\n    \n    if (event == \"COMBAT_LOG_EVENT_UNFILTERED\") then\n        local playerGUID = UnitGUID(\"player\")\n        local event, sourceGUID, destGUID, spellId = select(2, ...), select(4, ...), select(8, ...), select(12, ...)\n        if (event == \"SPELL_SUMMON\" and sourceGUID == playerGUID and spellId == 115315) then\n            WA_BOS.GUID = destGUID\n            WA_BOS.Health = UnitHealthMax(\"player\") * 0.5\n            WA_BOS.HealthMax = WA_BOS.Health\n        elseif(event == \"UNIT_DIED\" and destGUID == playerGUID) then\n            WA_BOS.GUID = nil\n            WA_BOS.Health = 0\n            WA_BOS.HealthMax = 0\n            return false\n        elseif (destGUID == WA_BOS.GUID) then\n            local amount\n            if (event == \"SWING_DAMAGE\") then\n                amount = select(12, ...)\n            elseif (event == \"SPELL_DAMAGE\") then\n                amount = select(15, ...)\n            elseif (event == \"SPELL_HEAL\") then\n                amount = 0 - select(15, ...)\n            end\n            if (amount) then\n                WA_BOS.Health = WA_BOS.Health - amount\n                if WA_BOS.Health > WA_BOS.HealthMax then\n                    WA_BOS.Health = WA_BOS.HealthMax\n                end\n            end\n        end\n    elseif (event == \"PLAYER_TARGET_CHANGED\") then\n        if GetTotemInfo(1) and not WA_BOS.GUID then\n            local BOS_NAME = select(2, GetTotemInfo(1))\n            local BOS_HMAX = UnitHealthMax(\"player\")\n            local unit\n            if (BOS_NAME == UnitName(\"target\") and BOS_HMAX == UnitHealthMax(\"target\") * 2) then\n                unit = \"target\"\n            elseif (BOS_NAME == UnitName(\"targettarget\") and BOS_HMAX == UnitHealthMax(\"targettarget\") * 2) then\n                unit = \"targettarget\"\n            end\n            if unit then\n                WA_BOS.GUID = UnitGUID(unit)\n                WA_BOS.Health = UnitHealth(unit)\n                WA_BOS.HealthMax = UnitHealthMax(unit)\n            end\n        end\n    elseif (event == \"UPDATE_MOUSEOVER_UNIT\") then\n        if GetTotemInfo(1) and not WA_BOS.GUID then\n            local BOS_NAME = select(2, GetTotemInfo(1))\n            local BOS_HMAX = UnitHealthMax(\"player\")\n            local unit\n            if (BOS_NAME == UnitName(\"mouseover\") and BOS_HMAX == UnitHealthMax(\"mouseover\") * 2) then\n                local playerName = UnitName(\"player\")\n                local BOS_TEXT = format(UNITNAME_SUMMON_TITLE16, playerName)\n                local lines = GameTooltip:NumLines()\n                for i = 1, lines do\n                    if (_G[\"GameTooltipTextLeft\"..i]:GetText() == BOS_TEXT) then\n                        unit = \"mouseover\"\n                        break\n                    end\n                end\n            elseif (BOS_NAME == UnitName(\"mouseovertarget\") and BOS_HMAX == UnitHealthMax(\"mouseovertarget\") * 2) then\n                unit = \"mouseovertarget\"\n            end\n            if unit then\n                WA_BOS.GUID = UnitGUID(unit)\n                WA_BOS.Health = UnitHealth(unit)\n                WA_BOS.HealthMax = UnitHealthMax(unit)    \n            end\n        end\n    end\n    \n    return GetTotemInfo(1)\nend",
						["subeventPrefix"] = "SPELL",
						["genericShowOn"] = "showOnActive",
						["custom_hide"] = "custom",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return not GetTotemInfo(1)\nend    \n\n",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 9,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["backdropInFront"] = false,
			["text"] = true,
			["stickyDuration"] = false,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["height"] = 27.3463916778564,
			["timerFlags"] = "None",
			["auto"] = true,
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["timer"] = true,
			["stacksFont"] = "Friz Quadrata TT",
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customTextUpdate"] = "update",
			["borderOffset"] = 5,
			["border"] = false,
			["borderEdge"] = "None",
			["sparkRotation"] = 0,
			["borderSize"] = 16,
			["width"] = 147.974090576172,
			["icon_side"] = "LEFT",
			["sparkWidth"] = 10,
			["sparkOffsetX"] = 0,
			["sparkHeight"] = 30,
			["id"] = "BlackOxStatue",
			["timerSize"] = 14,
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayTextRight"] = "%c",
			["icon"] = true,
			["sparkHidden"] = "NEVER",
			["borderInFront"] = false,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["textSize"] = 14,
			["useAdjustededMax"] = false,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["uid"] = "H12bL)HABEC",
		},
		["无雕像"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 12,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 141.000305175781,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["use_totemName"] = false,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["use_totemType"] = true,
						["custom_hide"] = "timed",
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["custom_type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["totemName"] = "Black Ox Statue",
						["event"] = "Totem",
						["totemType"] = 1,
						["unevent"] = "auto",
						["custom"] = "function()\n    if (GetTotemInfo(1)) then\n        return false\n    end\n    return true\nend",
						["events"] = "PLAYER_TOTEM_UPDATE",
						["spellIds"] = {
						},
						["check"] = "event",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
					},
					["untrigger"] = {
						["custom"] = "function()\n    if (not GetTotemInfo(1)) then\n        return false\n    end\n    return true\n    \nend\n\n\n",
						["totemType"] = 1,
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = true,
			["text1Point"] = "BOTTOMRIGHT",
			["text2FontFlags"] = "OUTLINE",
			["height"] = 35,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 35,
			["text1Font"] = "Friz Quadrata TT",
			["parent"] = "玄牛雕像",
			["text2Containment"] = "INSIDE",
			["text1Containment"] = "INSIDE",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["xOffset"] = -477.000061035156,
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["glow"] = false,
			["text2FontSize"] = 24,
			["alpha"] = 1,
			["text1"] = "%s",
			["frameStrata"] = 1,
			["zoom"] = 0,
			["text2"] = "%p",
			["auto"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "无雕像",
			["stickyDuration"] = false,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text2Font"] = "Friz Quadrata TT",
			["cooldownTextEnabled"] = true,
			["inverse"] = false,
			["internalVersion"] = 9,
			["displayIcon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
			["stacksPoint"] = "TOP",
			["selfPoint"] = "CENTER",
		},
		["Renewing Mist Counter"] = {
			["outline"] = "OUTLINE",
			["text2Point"] = "BOTTOM",
			["text1FontSize"] = 20,
			["xOffset"] = 361.986999511719,
			["displayText"] = "%s",
			["yOffset"] = 92.8740844726563,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["url"] = "https://wago.io/SJLK6qy4X/1",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["stack_info"] = "count",
						["groupclone"] = false,
						["ownOnly"] = true,
						["name_info"] = "players",
						["names"] = {
							"复苏之雾", -- [1]
						},
						["use_showgcd"] = true,
						["useCount"] = true,
						["spellName"] = 115151,
						["type"] = "aura",
						["buffShowOn"] = "showOnActive",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["subeventPrefix"] = "SPELL",
						["event"] = "Cooldown Progress (Spell)",
						["subeventSuffix"] = "_CAST_START",
						["realSpellName"] = "复苏之雾",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["debuffType"] = "HELPFUL",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnActive",
						["unit"] = "group",
						["use_specific_unit"] = false,
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 115151,
					},
				}, -- [1]
				["activeTriggerMode"] = -10,
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["text2Enabled"] = false,
			["text1Containment"] = "INSIDE",
			["desaturate"] = false,
			["wordWrap"] = "WordWrap",
			["font"] = "2002",
			["text2Font"] = "2002",
			["text2FontFlags"] = "OUTLINE",
			["height"] = 45.172046661377,
			["conditions"] = {
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_petbattle"] = false,
				["talent2"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["use_vehicle"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
						["PALADIN"] = true,
					},
				},
				["spec"] = {
					["single"] = 2,
					["multi"] = {
						[3] = true,
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["use_vehicleUi"] = false,
				["faction"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["automaticWidth"] = "Auto",
			["fixedWidth"] = 200,
			["fontSize"] = 20,
			["text2Containment"] = "INSIDE",
			["stickyDuration"] = false,
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["glow"] = false,
			["anchorFrameType"] = "SCREEN",
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["alpha"] = 1,
			["cooldownTextEnabled"] = false,
			["text2FontSize"] = 12,
			["internalVersion"] = 9,
			["text1"] = "%s",
			["justify"] = "LEFT",
			["zoom"] = 0,
			["text2"] = "%p",
			["auto"] = false,
			["text1FontFlags"] = "OUTLINE",
			["id"] = "Renewing Mist Counter",
			["text1Point"] = "CENTER",
			["frameStrata"] = 1,
			["width"] = 45.1787643432617,
			["text1Font"] = "2002",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["inverse"] = true,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayIcon"] = 1360980,
			["cooldown"] = false,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
		},
		["铁骨酒"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 20,
			["color"] = {
				0.945098039215686, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 70.9016723632813,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_frame"] = "WeakAuras:铁骨酒",
					["glow_action"] = "show",
				},
				["finish"] = {
					["do_glow"] = false,
					["glow_frame"] = "WeakAuras:铁骨酒",
					["glow_action"] = "show",
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["use_charges"] = false,
						["names"] = {
							"铁骨酒", -- [1]
						},
						["buffShowOn"] = "showOnActive",
						["charges_operator"] = "==",
						["type"] = "aura",
						["spellName"] = 119582,
						["unevent"] = "auto",
						["use_showOn"] = true,
						["unit"] = "player",
						["event"] = "Cooldown Progress (Spell)",
						["use_unit"] = true,
						["realSpellName"] = "活血酒",
						["use_spellName"] = true,
						["spellIds"] = {
							215479, -- [1]
						},
						["charges"] = "2",
						["subeventSuffix"] = "_CAST_START",
						["debuffType"] = "HELPFUL",
						["subeventPrefix"] = "SPELL",
						["custom_hide"] = "timed",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 119582,
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["alpha"] = 1,
			["useTooltip"] = false,
			["glow"] = false,
			["stickyDuration"] = false,
			["discrete_rotation"] = 0,
			["text1Point"] = "CENTER",
			["progressPrecision"] = 0,
			["text2FontFlags"] = "OUTLINE",
			["height"] = 33.6275405883789,
			["rotate"] = true,
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["single"] = 4,
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
						["MAGE"] = true,
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["single"] = "Troll",
					["multi"] = {
						["Troll"] = true,
					},
				},
				["use_class"] = true,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["xOffset"] = -120.154724121094,
			["animation"] = {
				["start"] = {
					["preset"] = "slidetop",
					["duration_type"] = "seconds",
					["type"] = "preset",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["preset"] = "spiral",
					["duration_type"] = "seconds",
					["type"] = "preset",
				},
			},
			["text1Enabled"] = true,
			["text2Containment"] = "INSIDE",
			["rotation"] = 0,
			["text1Color"] = {
				0.988235294117647, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["icon"] = true,
			["mirror"] = false,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["regionType"] = "icon",
			["width"] = 59,
			["blendMode"] = "BLEND",
			["text2FontSize"] = 24,
			["frameStrata"] = 4,
			["text1"] = "%p",
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Smooth_Border2",
			["text1FontFlags"] = "THICKOUTLINE",
			["text2"] = "%p",
			["auto"] = true,
			["zoom"] = 0,
			["id"] = "铁骨酒",
			["cooldownTextEnabled"] = true,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Font"] = "Friz Quadrata TT",
			["desaturate"] = false,
			["inverse"] = false,
			["text1Containment"] = "OUTSIDE",
			["conditions"] = {
			},
			["cooldown"] = false,
			["internalVersion"] = 9,
		},
		["雕像 cd"] = {
			["sparkWidth"] = 10,
			["stacksSize"] = 12,
			["xOffset"] = -477.500244140625,
			["stacksFlags"] = "None",
			["yOffset"] = 141.249938964844,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["rotateText"] = "NONE",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.890196078431373, -- [1]
				0.709803921568628, -- [2]
				0.125490196078431, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["sparkOffsetY"] = 0,
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
						true, -- [1]
					},
				},
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["stacks"] = true,
			["texture"] = "TukTex",
			["textFont"] = "Friz Quadrata TT",
			["zoom"] = 0,
			["spark"] = false,
			["timerFont"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["borderInset"] = 11,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["parent"] = "玄牛雕像",
			["customTextUpdate"] = "update",
			["displayTextLeft"] = "%n",
			["triggers"] = {
				{
					["trigger"] = {
						["spellId"] = "115308",
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showOnCooldown",
						["use_unit"] = true,
						["spellName"] = 115315,
						["custom_hide"] = "timed",
						["type"] = "status",
						["debuffType"] = "HELPFUL",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["use_spellName"] = true,
						["event"] = "Cooldown Progress (Spell)",
						["spellIds"] = {
						},
						["realSpellName"] = "玄牛雕像",
						["use_spellId"] = true,
						["custom"] = "\n-- 不要移除这条信息，这是该触发器的一部分。雕像 cd",
						["name"] = "铁骨酒",
						["subeventSuffix"] = "_CAST_START",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
					},
					["untrigger"] = {
						["spellName"] = 115315,
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 9,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["backdropInFront"] = false,
			["text"] = false,
			["stickyDuration"] = false,
			["timer"] = true,
			["timerFlags"] = "None",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["auto"] = true,
			["borderOffset"] = 5,
			["height"] = 35,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["useAdjustededMax"] = false,
			["border"] = false,
			["borderEdge"] = "None",
			["sparkOffsetX"] = 0,
			["borderSize"] = 16,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["icon_side"] = "RIGHT",
			["sparkRotationMode"] = "AUTO",
			["anchorFrameType"] = "SCREEN",
			["sparkHeight"] = 30,
			["borderInFront"] = true,
			["textSize"] = 12,
			["stacksColor"] = {
				0.984313725490196, -- [1]
				1, -- [2]
				0.984313725490196, -- [3]
				1, -- [4]
			},
			["timerSize"] = 12,
			["id"] = "雕像 cd",
			["sparkHidden"] = "NEVER",
			["displayTextRight"] = "%p",
			["frameStrata"] = 1,
			["width"] = 35,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["textFlags"] = "None",
			["inverse"] = true,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["orientation"] = "VERTICAL_INVERSE",
			["conditions"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksFont"] = "Friz Quadrata TT",
		},
		["health"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["user_x"] = 0,
			["xOffset"] = -51.8648681640625,
			["stacksFlags"] = "None",
			["yOffset"] = -18.4118347167969,
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkRotation"] = 0,
			["sameTexture"] = true,
			["rotateText"] = "NONE",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "TOP",
			["barColor"] = {
				0.949019607843137, -- [1]
				0.976470588235294, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["sparkOffsetY"] = 0,
			["crop_y"] = 0.41,
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["regionType"] = "text",
			["stacks"] = false,
			["blendMode"] = "BLEND",
			["texture"] = "Wglass",
			["textFont"] = "Standard",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["auto"] = true,
			["compress"] = false,
			["timerFont"] = "Standard",
			["alpha"] = 1,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["fixedWidth"] = 200,
			["backgroundOffset"] = 2,
			["outline"] = "OUTLINE",
			["actions"] = {
				["start"] = {
				},
				["init"] = {
				},
				["finish"] = {
				},
			},
			["borderBackdrop"] = "Solid",
			["wordWrap"] = "WordWrap",
			["color"] = {
				0.988235294117647, -- [1]
				1, -- [2]
				0.988235294117647, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["customText"] = "function()    \n    local stagger = UnitHealth(\"player\")\n    \n    local percentOfHealth=format(\"%i\",(100*stagger/UnitHealthMax(\"player\")))\n    \n    return percentOfHealth;\nend",
			["barInFront"] = true,
			["spark"] = false,
			["desaturateBackground"] = false,
			["anchorPoint"] = "CENTER",
			["borderOffset"] = 1,
			["sparkRotationMode"] = "AUTO",
			["automaticWidth"] = "Auto",
			["textSize"] = 10,
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["genericShowOn"] = "showOnActive",
						["names"] = {
							"Staggered Daze", -- [1]
						},
						["powertype"] = 3,
						["subeventPrefix"] = "SPELL",
						["unit"] = "player",
						["custom_hide"] = "custom",
						["use_powertype"] = true,
						["debuffType"] = "HARMFUL",
						["custom_type"] = "event",
						["type"] = "custom",
						["subeventSuffix"] = "_CAST_START",
						["unevent"] = "auto",
						["power_operator"] = ">=",
						["spellIds"] = {
						},
						["event"] = "Chat Message",
						["use_percentpower"] = false,
						["customDuration"] = "function()\n    \n    WA_STAGGER = WA_STAGGER or {}\n    WA_STAGGER.maxValue = UnitHealthMax(\"player\")\n    return WA_STAGGER.value, WA_STAGGER.maxValue, UnitStagger(\"player\")\nend\n\n\n\n\n\n\n\n\n\n\n\n\n",
						["power"] = "60",
						["events"] = "UNIT_AURA",
						["custom"] = "function(self,unitID)\n    if not (unitID == 'player') then return false end\n    WA_STAGGER = WA_STAGGER or {}\n    WA_STAGGER.value = UnitStagger(\"player\")\n    if (WA_STAGGER.value > 0) then\n        return true\n    end\nend",
						["check"] = "event",
						["use_unit"] = true,
						["percentpower"] = "35",
						["percentpower_operator"] = ">=",
					},
					["untrigger"] = {
						["custom"] = "function(self,unitID)\n    if not (unitID == 'player') then return false end    \n    WA_STAGGER = WA_STAGGER or {}\n    WA_STAGGER.value = UnitStagger(\"player\")\n    if (WA_STAGGER.value == 0) then\n        return true\n    end\nend",
						["use_unit"] = true,
						["percentpower_operator"] = "<",
						["use_percentpower"] = true,
						["percentpower"] = "35",
						["unit"] = "player",
					},
				}, -- [1]
				["disjunctive"] = "any",
				["activeTriggerMode"] = -10,
			},
			["progressPrecision"] = 0,
			["internalVersion"] = 9,
			["displayTextLeft"] = "%p",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["colorR"] = 0.137254901960784,
					["type"] = "custom",
					["duration_type"] = "seconds",
					["use_color"] = false,
					["colorB"] = 1,
					["duration"] = "0.1",
					["alpha"] = 0,
					["x"] = 0,
					["y"] = 0,
					["colorType"] = "custom",
					["colorG"] = 0.16078431372549,
					["colorA"] = 1,
					["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n    --print(\"Percent\", WA_STAGGER.percent)\n    local color = { \n        {r = 0.0, g = 1.0, b = 0.2}, --Light\n        {r = 1.0, g = 0.7, b = 0.0}, --Moderate\n        {r = 1.0, g = 0.0, b = 0.0} --Heavy\n    }\n    \n    if WA_STAGGER == nil then\n        return color[1].r, color[1].g, color[1].b\n    end\n    \n    WA_STAGGER.percent = WA_HEALTH.value / WA_HEALTH.maxValue\n    \n    --STAGGER_YELLOW_TRANSITION = 0.3\n    if (WA_STAGGER.percent > 0.3 and WA_STAGGER.percent < STAGGER_RED_TRANSITION) then\n        color = color[2]; --Moderate\n    elseif (WA_STAGGER.percent > STAGGER_RED_TRANSITION) then\n        color =color[3]; --Heavy\n    else\n        color = color[1]; --Light\n    end\n    \n    --print(\"Color\", color.r, color.g, color.b)\n    return color.r, color.g, color.b\nend",
					["rotate"] = 0,
					["scaley"] = 1,
					["scalex"] = 1,
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["width"] = 25.4461307525635,
			["text"] = false,
			["customTextUpdate"] = "event",
			["stickyDuration"] = false,
			["discrete_rotation"] = 0,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
						["DRUID"] = true,
						["MONK"] = true,
						["ROGUE"] = true,
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["level"] = "75",
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_level"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["level_operator"] = ">=",
			},
			["sparkHidden"] = "NEVER",
			["user_y"] = 0,
			["height"] = 24.0261154174805,
			["rotate"] = true,
			["justify"] = "LEFT",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["timerFlags"] = "None",
			["sparkWidth"] = 10,
			["stacksFont"] = "Standard",
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["border"] = true,
			["borderEdge"] = "Seerah Solid",
			["mirror"] = false,
			["borderSize"] = 1,
			["zoom"] = 0,
			["icon_side"] = "LEFT",
			["sparkOffsetX"] = 0,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkHeight"] = 30,
			["fontSize"] = 24,
			["timer"] = true,
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["timerSize"] = 25,
			["displayTextRight"] = "%c",
			["id"] = "health",
			["displayText"] = "%c",
			["frameStrata"] = 2,
			["anchorFrameType"] = "SCREEN",
			["desaturateForeground"] = false,
			["icon"] = false,
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["crop_x"] = 0.41,
			["borderInset"] = 1,
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
		},
		["受伤警报"] = {
			["xOffset"] = -478.249450683594,
			["conditions"] = {
			},
			["mirror"] = false,
			["yOffset"] = 141.000793457031,
			["regionType"] = "texture",
			["blendMode"] = "BLEND",
			["parent"] = "玄牛雕像",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_type"] = "status",
						["custom_hide"] = "timed",
						["genericShowOn"] = "showOnActive",
						["unit"] = "player",
						["event"] = "Health",
						["custom"] = "function()\n    if not WA_BlackOx then return false end\n    local lastHit = WA_BlackOx.lastHit or 0\n    if GetTime() - lastHit <= 3 then\n        return true\n    end\n    return false\n    \nend",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["check"] = "update",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function()\n    if not WA_BlackOx then return false end\n    local lastHit = WA_BlackOx.lastHit or 0    \n    if GetTime() - lastHit > 3 then\n        return true\n    end\n    return false\n    \nend\n\n\n",
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["texture"] = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White",
			["anchorPoint"] = "CENTER",
			["internalVersion"] = 9,
			["desaturate"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["colorR"] = 1,
					["duration"] = "2",
					["alphaType"] = "alphaPulse",
					["colorA"] = 1,
					["colorG"] = 1,
					["alphaFunc"] = "    function(progress, start, delta)\n      local angle = (progress * 2 * math.pi) - (math.pi / 2)\n      return start + (((math.sin(angle) + 1)/2) * delta)\n    end\n  ",
					["use_alpha"] = true,
					["type"] = "custom",
					["scaley"] = 1,
					["use_color"] = false,
					["alpha"] = 0,
					["x"] = 0,
					["y"] = 0,
					["colorType"] = "pulseColor",
					["scalex"] = 1,
					["preset"] = "alphaPulse",
					["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n  local angle = (progress * 2 * math.pi) - (math.pi / 2)\n  local newProgress = ((math.sin(angle) + 1)/2);\n  return r1 + (newProgress * (r2 - r1)),\n       g1 + (newProgress * (g2 - g1)),\n       b1 + (newProgress * (b2 - b1)),\n       a1 + (newProgress * (a2 - a1))\nend\n",
					["rotate"] = 0,
					["colorB"] = 1,
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["id"] = "受伤警报",
			["width"] = 55,
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["discrete_rotation"] = 0,
			["rotation"] = 0,
			["alpha"] = 1,
			["selfPoint"] = "CENTER",
			["height"] = 55,
			["rotate"] = true,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
			},
			["color"] = {
				1, -- [1]
				0, -- [2]
				0.0745098039215686, -- [3]
				0.75, -- [4]
			},
		},
		["Stagger"] = {
			["textFlags"] = "None",
			["stacksSize"] = 12,
			["user_x"] = 0,
			["xOffset"] = -64.4138793945313,
			["displayText"] = "%c",
			["yOffset"] = 81.1435546875,
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sameTexture"] = true,
			["rotateText"] = "NONE",
			["icon"] = false,
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "TOP",
			["barColor"] = {
				0.949019607843137, -- [1]
				0.976470588235294, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["font"] = "Friz Quadrata TT",
			["sparkOffsetY"] = 0,
			["crop_y"] = 0.41,
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["regionType"] = "text",
			["stacks"] = false,
			["blendMode"] = "BLEND",
			["texture"] = "Wglass",
			["textFont"] = "Standard",
			["borderOffset"] = 1,
			["spark"] = false,
			["compress"] = false,
			["timerFont"] = "Standard",
			["alpha"] = 1,
			["borderInset"] = 1,
			["fixedWidth"] = 200,
			["backgroundOffset"] = 2,
			["outline"] = "OUTLINE",
			["rotation"] = 0,
			["borderBackdrop"] = "Solid",
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0, -- [4]
			},
			["color"] = {
				1, -- [1]
				0.854901960784314, -- [2]
				0.231372549019608, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["customText"] = "function()    \n    local stagger = UnitStagger(\"player\")\n    \n    \n    local percentOfHealth=format(\"%i\",(100/UnitHealthMax(\"player\")*stagger))\n    \n    \n    \n    --[[\n    for current tick\n    return ticksTotal;\n    \n    for total damage\n    return staggerTotal;\n    \n    for stagger as a percentage of max health\n    return percentOfHealth;\n\n    --]]\n    \n    return percentOfHealth;\nend",
			["barInFront"] = true,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["desaturateBackground"] = false,
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["textSize"] = 10,
			["customTextUpdate"] = "event",
			["automaticWidth"] = "Auto",
			["desaturateForeground"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["use_power"] = false,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["powertype"] = 3,
						["subeventPrefix"] = "SPELL",
						["names"] = {
							"Staggered Daze", -- [1]
						},
						["debuffType"] = "HARMFUL",
						["use_powertype"] = true,
						["custom_hide"] = "custom",
						["custom_type"] = "event",
						["type"] = "custom",
						["events"] = "UNIT_AURA",
						["unevent"] = "auto",
						["power_operator"] = ">=",
						["custom"] = "function(self,unitID)\n    if not (unitID == 'player') then return false end\n    WA_STAGGER = WA_STAGGER or {}\n    WA_STAGGER.value = UnitStagger(\"player\")\n    if (WA_STAGGER.value > 0) then\n        return true\n    end\nend",
						["event"] = "Health",
						["use_percentpower"] = false,
						["customDuration"] = "function()\n    \n    WA_STAGGER = WA_STAGGER or {}\n    WA_STAGGER.maxValue = UnitHealthMax(\"player\")\n    return WA_STAGGER.value, WA_STAGGER.maxValue, UnitStagger(\"player\")\nend\n\n\n\n\n\n\n\n\n\n\n\n\n",
						["power"] = "60",
						["spellIds"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["check"] = "event",
						["unit"] = "player",
						["percentpower"] = "35",
						["percentpower_operator"] = ">=",
					},
					["untrigger"] = {
						["custom"] = "function(self,unitID)\n    if not (unitID == 'player') then return false end    \n    WA_STAGGER = WA_STAGGER or {}\n    WA_STAGGER.value = UnitStagger(\"player\")\n    if (WA_STAGGER.value == 0) then\n        return true\n    end\nend",
						["unit"] = "player",
						["percentpower_operator"] = "<",
						["use_percentpower"] = true,
						["percentpower"] = "35",
						["use_unit"] = true,
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["auto"] = true,
			["internalVersion"] = 9,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["level_operator"] = ">=",
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["level"] = "75",
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_level"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
						["DRUID"] = true,
						["MONK"] = true,
						["ROGUE"] = true,
					},
				},
			},
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["colorR"] = 0.137254901960784,
					["type"] = "custom",
					["scalex"] = 1,
					["scaley"] = 1,
					["colorA"] = 1,
					["duration"] = "0.5",
					["alpha"] = 0,
					["x"] = 0,
					["y"] = 0,
					["colorType"] = "custom",
					["colorG"] = 0.16078431372549,
					["colorB"] = 1,
					["colorFunc"] = "function(progress, r1, g1, b1, a1, r2, g2, b2, a2)\n    --print(\"Percent\", WA_STAGGER.percent)\n    local color = { \n        {r = 0.0, g = 1.0, b = 0.2}, --Light\n        {r = 1.0, g = 0.7, b = 0.0}, --Moderate\n        {r = 1.0, g = 0.0, b = 0.0} --Heavy\n    }\n    \n    if WA_STAGGER == nil then\n        return color[1].r, color[1].g, color[1].b\n    end\n    \n    WA_STAGGER.percent = WA_STAGGER.value / WA_STAGGER.maxValue\n    \n    --STAGGER_YELLOW_TRANSITION = 0.3\n    if (WA_STAGGER.percent > 0.3 and WA_STAGGER.percent < STAGGER_RED_TRANSITION) then\n        color = color[2]; --Moderate\n    elseif (WA_STAGGER.percent > STAGGER_RED_TRANSITION) then\n        color =color[3]; --Heavy\n    else\n        color = color[1]; --Light\n    end\n    \n    --print(\"Color\", color.r, color.g, color.b)\n    return color.r, color.g, color.b\nend",
					["rotate"] = 0,
					["use_color"] = true,
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["width"] = 25.4461307525635,
			["text"] = false,
			["stacksFlags"] = "None",
			["stickyDuration"] = false,
			["discrete_rotation"] = 0,
			["wordWrap"] = "WordWrap",
			["sparkHidden"] = "NEVER",
			["sparkRotation"] = 0,
			["height"] = 24.0261764526367,
			["rotate"] = true,
			["timerSize"] = 25,
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["fontSize"] = 24,
			["stacksFont"] = "Standard",
			["timer"] = true,
			["timerFlags"] = "None",
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["border"] = true,
			["borderEdge"] = "Seerah Solid",
			["sparkWidth"] = 10,
			["borderSize"] = 1,
			["zoom"] = 0,
			["icon_side"] = "LEFT",
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["mirror"] = false,
			["sparkHeight"] = 30,
			["sparkOffsetX"] = 0,
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["displayTextRight"] = "%c",
			["justify"] = "LEFT",
			["id"] = "Stagger",
			["user_y"] = 0,
			["frameStrata"] = 2,
			["anchorFrameType"] = "SCREEN",
			["displayTextLeft"] = "%p",
			["sparkRotationMode"] = "AUTO",
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["crop_x"] = 0.41,
			["anchorPoint"] = "CENTER",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
		},
		["DK-Blood Death Strike"] = {
			["user_y"] = 0,
			["text2Point"] = "CENTER",
			["text1FontSize"] = 18,
			["cooldownTextEnabled"] = true,
			["displayText"] = "%c",
			["yOffset"] = 62.9206237792969,
			["anchorPoint"] = "CENTER",
			["sameTexture"] = true,
			["url"] = "https://wago.io/NkaTBpcPW/21",
			["actions"] = {
				["start"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
				["finish"] = {
					["custom"] = "\n\n",
					["do_custom"] = false,
				},
				["init"] = {
					["custom"] = "--settings start\naura_env.showAbsolute = false --set to true to show absolute heal value instead of percentage\naura_env.numDecimals = 1 --number of decimals to show for percentage based display (can also be 0)\n\n--if you want the text to be colored should certain percentages be reached, then you can insert or remove the entries in this table.\n--the entries have to be sorted by increasing percentages for this to work correctly.\n--this is independent of using aura_env.showAbsolute, meaning you can show the absolute value being healed, but the coloring is always based on percentages.\naura_env.colors = {\n    {0.0, \"ffffffff\"},\n    {0.3, \"ffe85537\"},\n    {0.5, \"ffff0000\"},\n}\n--settings end\n\n--DON'T TOUCH THIS!\naura_env.dmgTaken = {} --table to store damage taken\naura_env.lastSec = 5 --how long damage events are taken into account\naura_env.percDmg = 0.25 --percentage of the damage that is being healed\naura_env.minHealthPerc = 0.07 --minimum percentage that is being\n\naura_env.healing = nil --holds the value currently being predicted (always absolute)\naura_env.display = nil --holds the value currently being displayed (either absolute or percentage)\n\n--table to exclude certain abilities that deal damage but do not increase the healing done by DS\naura_env.exclude = {\n    [223414] = true, --Parasitic Fetter\n    [204611] = true, --Crushing Grip\n    [204658] = true, --Crushing Grip\n    [240448] = true, --Quaking\n    [243237] = true, --Bursting\n    [258837] = true, --Rent Soul\n}\n\n--number shortening function\naura_env.shortenNumber = function(number)\n    if type(number) ~= \"number\" then\n        number = tonumber(number)\n    end\n    if not number then\n        return\n    end\n    \n    local affixes = {\n        \"\",\n        \"k\",\n        \"m\",\n        \"b\",\n    }\n    \n    local affix = 1\n    local dec = 0\n    local num1 = math.abs(number)\n    while num1 >= 1000 and affix < #affixes do\n        num1 = num1 / 1000\n        affix = affix + 1\n    end\n    if affix > 1 then\n        dec = 2\n        local num2 = num1\n        while num2 >= 10 do\n            num2 = num2 / 10\n            dec = dec - 1\n        end\n    end\n    if number < 0 then\n        num1 = -num1\n    end\n    \n    return string.format(\"%.\"..dec..\"f\"..affixes[affix], num1)\nend",
					["do_custom"] = true,
				},
			},
			["text2Font"] = "Friz Quadrata TT",
			["keepAspectRatio"] = false,
			["selfPoint"] = "LEFT",
			["desaturate"] = false,
			["rotation"] = 0,
			["font"] = "Friz Quadrata TT",
			["text2FontFlags"] = "OUTLINE",
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "DEATHKNIGHT",
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["use_combat"] = true,
				["difficulty"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["textureWrapMode"] = "CLAMP",
			["foregroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "text",
			["blendMode"] = "BLEND",
			["text2FontSize"] = 24,
			["slantMode"] = "INSIDE",
			["zoom"] = 0.1,
			["auto"] = true,
			["compress"] = false,
			["alpha"] = 1,
			["uid"] = "GcsXuzOfvD1",
			["displayIcon"] = 237517,
			["backgroundOffset"] = 2,
			["outline"] = "OUTLINE",
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["customText"] = "function()\n    \n    --get total damage taken\n    --variables to loop\n    local i = 1\n    local cur = GetTime()\n    local total = 0\n    while aura_env.dmgTaken[i] do\n        --grab table entries with time and damage\n        local time = aura_env.dmgTaken[i][1]\n        local dmg = aura_env.dmgTaken[i][2]\n        \n        --if the damage happened outside of the timewindow\n        if cur > time + aura_env.lastSec then\n            --remove the entry\n            table.remove(aura_env.dmgTaken, i)\n        else --otherwise\n            --add up the damage and go to next entry\n            total = total + dmg\n            i = i + 1\n        end\n    end\n    \n    \n    --[[\n    --Versatility\n    local vers = 1 + ((GetCombatRatingBonus(29) + GetVersatilityBonus(30)) / 100)\n    \n    --Vampiric Blood\n    local vamp = WA_GetUnitBuff(\"player\", 55233) and 1.3 or 1\n    \n    --Guardian Spirit\n    local gs = 1 + (select(16, WA_GetUnitBuff(\"player\", 47788)) or 0) / 100\n    \n    --Divine Hymn\n    local dh = WA_GetUnitBuff(\"player\", 64844) and 1.1 or 1\n    \n    --Hemostasis\n    local haemo = 1 + 0.08 * (select(3, WA_GetUnitBuff(\"player\", 273947)) or 0)\n    --Skullflower's Haemostasis legendary\n    local haemoleg = 1 + 0.2 * (select(3, WA_GetUnitBuff(\"player\", 235559)) or 0)\n    \n    --Lana'thel's Lament legendary\n    local lana = WA_GetUnitBuff(\"player\", 188290) and IsEquippedItem(133974) and 1.05 or 1\n    ]]\n    \n    local heal = total * aura_env.percDmg --damage taken * DS percentage\n    local perc = heal / UnitHealthMax(\"player\") --relative to maxHP\n    perc = math.max(aura_env.minHealthPerc, perc) --minimum DS percentage\n    --perc = perc * vamp * vers * gs * dh * lana * haemo * haemoleg --apply all multipliers\n    heal = perc * UnitHealthMax(\"player\") --get the actual heal value\n    \n    --store the values in aura_env variables to access them from other locations\n    aura_env.healing = heal\n    if aura_env.showAbsolute then\n        aura_env.display = aura_env.shortenNumber(heal)\n    else\n        aura_env.display = string.format(\"%.\"..aura_env.numDecimals..\"f\", perc*100)\n    end\n    \n    --coloring based on predicted percentage\n    local color = nil\n    for _, v in ipairs(aura_env.colors) do\n        if perc < v[1] then\n            break\n        else\n            color = v[2]\n        end\n    end\n    --should there be no entries, fall back to white\n    if not color then\n        color = \"ffffffff\"\n    end\n    \n    --the display variable will only contain one % so it can be printed correctly, replace that with %% so one % gets output into WA\n    return string.format(\"|c%s%s|r\", color, aura_env.display)\nend",
			["desaturateBackground"] = false,
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
			["desaturateForeground"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["custom_hide"] = "custom",
						["type"] = "custom",
						["custom_type"] = "event",
						["subeventSuffix"] = "_DAMAGE",
						["names"] = {
						},
						["subeventPrefix"] = "SPELL",
						["genericShowOn"] = "showOnActive",
						["unit"] = "player",
						["destUnit"] = "player",
						["unevent"] = "timed",
						["spellIds"] = {
						},
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["custom"] = "function(event, ...)\n    \n    local timestamp, subevent = select(1, ...)\n    \n    --target = player\n    if select(8, ...) == UnitGUID(\"player\") then\n        \n        --set selection offset to amount for baseline SWING_DAMAGE\n        local offset = 12\n        \n        --handle SPELL_ABSORBED events\n        if subevent == \"SPELL_ABSORBED\" then\n            \n            --if a spell gets absorbed instead of a melee hit, there are 3 additional parameters regarding which spell got absorbed, so move the offset 3 more places\n            local spellid, spellname = select(offset, ...)\n            if GetSpellInfo(spellid) == spellname then\n                --check for excluded spellids before moving the offset\n                if aura_env.exclude[spellid] then\n                    return\n                end\n                offset = offset + 3\n            end\n            \n            --absorb value is 7 places further\n            offset = offset + 7\n            table.insert(aura_env.dmgTaken, {GetTime(), (select(offset, ...)), timestamp})\n            \n            --handle regular XYZ_DAMAGE events\n        elseif subevent:find(\"_DAMAGE\") then\n            \n            --don't include environmental damage (like falling etc)\n            if not subevent:find(\"ENVIRONMENTAL\") then\n                \n                --move offset by 3 places for spell info for RANGE_ and SPELL_ prefixes\n                if subevent:find(\"SPELL\") then\n                    --check for excluded spellids before moving the offset\n                    local spellid = select(offset, ...)\n                    if aura_env.exclude[spellid] then\n                        return\n                    end\n                    offset = offset + 3\n                elseif subevent:find(\"RANGE\") then\n                    offset = offset + 3\n                end\n                \n                --damage event\n                table.insert(aura_env.dmgTaken, {GetTime(), (select(offset, ...)), timestamp})\n                \n            end\n            \n        end\n        \n    end\n    \nend",
						["use_destUnit"] = false,
						["event"] = "Combat Log",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
						["custom"] = "function()\n    return false\nend\n\n\n\n\n\n",
					},
				}, -- [1]
				{
					["trigger"] = {
						["use_genericShowOn"] = true,
						["genericShowOn"] = "showAlways",
						["use_unit"] = true,
						["buffShowOn"] = "showOnActive",
						["type"] = "aura",
						["unevent"] = "auto",
						["use_showOn"] = true,
						["spellName"] = 49998,
						["event"] = "Cooldown Progress (Spell)",
						["ownOnly"] = true,
						["realSpellName"] = "灵界打击",
						["use_spellName"] = true,
						["spellIds"] = {
						},
						["debuffType"] = "HELPFUL",
						["subeventSuffix"] = "_CAST_START",
						["subeventPrefix"] = "SPELL",
						["names"] = {
							"白骨之盾", -- [1]
						},
						["unit"] = "player",
					},
					["untrigger"] = {
						["showOn"] = "showAlways",
						["spellName"] = 49998,
					},
				}, -- [2]
				["disjunctive"] = "any",
				["activeTriggerMode"] = 1,
			},
			["endAngle"] = 360,
			["internalVersion"] = 9,
			["animation"] = {
				["start"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["stickyDuration"] = false,
			["startAngle"] = 0,
			["useAdjustededMin"] = false,
			["height"] = 34.8963394165039,
			["crop_x"] = 0.41,
			["text2"] = "%p",
			["crop"] = 0.41,
			["useAdjustededMax"] = false,
			["backgroundTexture"] = "Textures\\SpellActivationOverlays\\Eclipse_Sun",
			["text2Containment"] = "INSIDE",
			["glow"] = false,
			["text1Font"] = "Friz Quadrata TT",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["mirror"] = false,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["user_x"] = 0,
			["anchorFrameType"] = "SCREEN",
			["icon"] = true,
			["fontSize"] = 24,
			["text1Enabled"] = true,
			["fixedWidth"] = 200,
			["text1"] = "%c",
			["wordWrap"] = "WordWrap",
			["desc"] = "by Hamsda and Macrologia",
			["text1Point"] = "RIGHT",
			["justify"] = "LEFT",
			["xOffset"] = -60.84521484375,
			["id"] = "DK-Blood Death Strike",
			["text1Containment"] = "OUTSIDE",
			["frameStrata"] = 2,
			["width"] = 34.8968276977539,
			["crop_y"] = 0.41,
			["foregroundColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["inverse"] = true,
			["text2Enabled"] = false,
			["orientation"] = "VERTICAL",
			["conditions"] = {
			},
			["cooldown"] = false,
			["backgroundColor"] = {
				0.5, -- [1]
				0.5, -- [2]
				0.5, -- [3]
				0.5, -- [4]
			},
		},
		["雕像受伤光环"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 12,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 163.000244140625,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "custom",
						["custom_hide"] = "timed",
						["unevent"] = "timed",
						["custom_type"] = "event",
						["unit"] = "player",
						["genericShowOn"] = "showOnActive",
						["names"] = {
						},
						["subeventSuffix"] = "_CAST_START",
						["spellIds"] = {
						},
						["custom"] = "-----------------------------------------------------------------------\n-- Hidden aura that tracks damage taken by the Statue\n-- Author: Shandaren @  Zul'jin(US) \n-----------------------------------------------------------------------\n\nfunction(event, ...)\n    \n    local playerID = UnitGUID(\"player\")\n    local evnt,_,source,_,_,_,target,tname,_,_,spellId,spellName,_,damage = select(2,...)\n    \n    if not WA_BlackOx  then \n        WA_BlackOx  = { \n            GUID = 0,\n            hp = 0,  \n            maxHP = 1,\n            hpPercent = 0,\n            lastHit = 0,\n        }  \n    end\n    \n    -- If summoning a statue...\n    if evnt == \"SPELL_SUMMON\" and  source==playerID and spellId==115315 then\n        WA_BlackOx.GUID = target\n        WA_BlackOx.maxHP = UnitHealthMax(\"player\")  * 0.5\n        WA_BlackOx.hp = WA_BlackOx.maxHP\n        WA_BlackOx.hpPercent = 100\n    end    \n    \n    -- If the statue just took damage...\n    if string.find(evnt,\"_DAMAGE\") and target==WA_BlackOx.GUID then\n        if evnt == \"SWING_DAMAGE\" then \n            damage = spellId \n        end \n        WA_BlackOx.hp = WA_BlackOx.hp -  damage\n        WA_BlackOx.lastHit = GetTime()\n        WA_BlackOx.hpPercent = tonumber((\"%.0f\"):format(100*(WA_BlackOx.hp / WA_BlackOx.maxHP))) \n    end \n    \n    -- but u can heal ur statue   ---add by pantseblue\n    if evnt == \"SPELL_HEAL\" and target==WA_BlackOx.GUID then\n        WA_BlackOx.hp = WA_BlackOx.hp + damage\n        if WA_BlackOx.hp > WA_BlackOx.maxHP then\n            WA_BlackOx.hp = WA_BlackOx.maxHP\n        end\n        WA_BlackOx.hpPercent = tonumber((\"%.0f\"):format(100*(WA_BlackOx.hp / WA_BlackOx.maxHP)))   \n    end\n    if WA_BlackOx.hpPercent < 0 then\n        WA_BlackOx.hpPercent = 0    \n    end\n    \n    \n    return false\n    \nend",
						["events"] = "COMBAT_LOG_EVENT_UNFILTERED",
						["check"] = "event",
						["subeventPrefix"] = "SPELL",
						["event"] = "Combat Log",
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = false,
			["text1Point"] = "BOTTOMRIGHT",
			["text2FontFlags"] = "OUTLINE",
			["height"] = 4.99990606307983,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 5.00003719329834,
			["internalVersion"] = 9,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["text2Containment"] = "INSIDE",
			["selfPoint"] = "CENTER",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["text2Font"] = "Friz Quadrata TT",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text1Containment"] = "INSIDE",
			["stickyDuration"] = false,
			["text2FontSize"] = 24,
			["glow"] = false,
			["text1"] = "%s",
			["frameStrata"] = 1,
			["zoom"] = 0,
			["text2"] = "%p",
			["auto"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "雕像受伤光环",
			["alpha"] = 1,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Font"] = "Friz Quadrata TT",
			["cooldownTextEnabled"] = true,
			["inverse"] = false,
			["parent"] = "玄牛雕像",
			["displayIcon"] = "Interface\\Icons\\achievement_shadowpan_hideout_1",
			["stacksPoint"] = "TOPRIGHT",
			["xOffset"] = -520,
		},
		["壮胆酒"] = {
			["textFlags"] = "OUTLINE",
			["stacksSize"] = 30,
			["text1FontSize"] = 32,
			["xOffset"] = -143.405151367188,
			["stacksFlags"] = "None",
			["yOffset"] = 14.1500854492188,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["rotateText"] = "NONE",
			["actions"] = {
				["start"] = {
					["do_glow"] = true,
					["glow_frame"] = "WeakAuras:壮胆酒",
					["glow_action"] = "show",
				},
				["finish"] = {
					["do_glow"] = false,
					["glow_frame"] = "WeakAuras:壮胆酒",
					["glow_action"] = "show",
				},
				["init"] = {
				},
			},
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = false,
			["selfPoint"] = "CENTER",
			["barColor"] = {
				1, -- [1]
				0.0156862745098039, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["text1Point"] = "CENTER",
			["sparkOffsetY"] = 0,
			["text2FontFlags"] = "OUTLINE",
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["single"] = "TANK",
					["multi"] = {
						["TANK"] = true,
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				0.890196078431373, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["text1FontFlags"] = "THICKOUTLINE",
			["regionType"] = "icon",
			["stacks"] = true,
			["text2FontSize"] = 24,
			["texture"] = "Blizzard Raid Bar",
			["textFont"] = "Friz Quadrata TT",
			["stacksFont"] = "Friz Quadrata TT",
			["spark"] = true,
			["timerFont"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["borderInset"] = 11,
			["displayIcon"] = "Interface\\Icons\\ability_monk_fortifyingale_new",
			["sparkOffsetX"] = 0,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["barInFront"] = true,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["sparkRotationMode"] = "AUTO",
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["displayTextLeft"] = "%n",
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["custom_hide"] = "timed",
						["ownOnly"] = true,
						["event"] = "Health",
						["names"] = {
							"壮胆酒", -- [1]
						},
						["use_name"] = true,
						["name_operator"] = "==",
						["name"] = "壮胆酒",
						["unit"] = "player",
						["spellIds"] = {
						},
						["subeventPrefix"] = "SPELL",
						["debuffType"] = "HELPFUL",
						["buffShowOn"] = "showOnActive",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["glow"] = false,
			["internalVersion"] = 9,
			["text2Font"] = "Friz Quadrata TT",
			["animation"] = {
				["start"] = {
					["preset"] = "slideright",
					["duration_type"] = "seconds",
					["type"] = "preset",
				},
				["main"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
				["finish"] = {
					["type"] = "none",
					["duration_type"] = "seconds",
				},
			},
			["text2Enabled"] = false,
			["text"] = true,
			["textSize"] = 16,
			["stickyDuration"] = false,
			["icon"] = true,
			["width"] = 70.3250579833985,
			["borderOffset"] = 5,
			["text1Containment"] = "OUTSIDE",
			["height"] = 34.9115562438965,
			["timerFlags"] = "None",
			["sparkHidden"] = "NEVER",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["timer"] = true,
			["text2Containment"] = "INSIDE",
			["timerSize"] = 32,
			["text1Color"] = {
				0.988235294117647, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["borderEdge"] = "None",
			["border"] = false,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["text1Font"] = "Friz Quadrata TT",
			["borderSize"] = 16,
			["borderBackdrop"] = "Blizzard Tooltip",
			["icon_side"] = "LEFT",
			["sparkHeight"] = 69,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["text1"] = "%p",
			["zoom"] = 0,
			["sparkWidth"] = 20,
			["stacksColor"] = {
				1, -- [1]
				0.36078431372549, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["displayTextRight"] = "%p",
			["auto"] = true,
			["id"] = "壮胆酒",
			["customTextUpdate"] = "update",
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["cooldownTextEnabled"] = true,
			["text2Point"] = "CENTER",
			["inverse"] = false,
			["sparkDesature"] = false,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["cooldown"] = false,
			["text2"] = "%p",
		},
		["能量"] = {
			["outline"] = "OUTLINE",
			["fontSize"] = 12,
			["xOffset"] = -90.3529663085938,
			["displayText"] = "%p",
			["yOffset"] = 92.8627319335938,
			["regionType"] = "text",
			["customTextUpdate"] = "update",
			["automaticWidth"] = "Auto",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "status",
						["unevent"] = "auto",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Power",
						["use_power"] = false,
						["genericShowOn"] = "showOnActive",
						["subeventPrefix"] = "SPELL",
						["use_unit"] = true,
						["powertype"] = 99,
						["spellIds"] = {
						},
						["use_percentpower"] = false,
						["unit"] = "player",
						["names"] = {
						},
						["use_powertype"] = true,
						["debuffType"] = "HELPFUL",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["anchorPoint"] = "CENTER",
			["internalVersion"] = 9,
			["justify"] = "LEFT",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["id"] = "能量",
			["anchorFrameType"] = "SCREEN",
			["frameStrata"] = 1,
			["width"] = 22.3122825622559,
			["fixedWidth"] = 200,
			["font"] = "Friz Quadrata TT",
			["wordWrap"] = "WordWrap",
			["selfPoint"] = "BOTTOM",
			["height"] = 11.490668296814,
			["conditions"] = {
			},
			["load"] = {
				["talent2"] = {
					["multi"] = {
					},
				},
				["use_never"] = true,
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["ingroup"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["use_class"] = true,
				["race"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["faction"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
		},
		["雕像血量"] = {
			["sparkWidth"] = 10,
			["stacksSize"] = 12,
			["xOffset"] = -476.999877929688,
			["stacksFlags"] = "None",
			["yOffset"] = 115,
			["anchorPoint"] = "CENTER",
			["sparkRotation"] = 0,
			["rotateText"] = "NONE",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["fontFlags"] = "OUTLINE",
			["icon_color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["selfPoint"] = "CENTER",
			["barColor"] = {
				0.00784313725490196, -- [1]
				1, -- [2]
				0, -- [3]
				1, -- [4]
			},
			["desaturate"] = false,
			["progressPrecision"] = 0,
			["sparkOffsetY"] = 0,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
			},
			["timerColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["useAdjustededMin"] = false,
			["regionType"] = "aurabar",
			["stacks"] = false,
			["texture"] = "Blizzard Raid Bar",
			["textFont"] = "Friz Quadrata TT",
			["zoom"] = 0,
			["spark"] = false,
			["timerFont"] = "Friz Quadrata TT",
			["alpha"] = 1,
			["borderInset"] = 11,
			["textColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["borderBackdrop"] = "Blizzard Dialog Background",
			["parent"] = "玄牛雕像",
			["customTextUpdate"] = "update",
			["textSize"] = 8,
			["triggers"] = {
				{
					["trigger"] = {
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["use_totemType"] = true,
						["custom_hide"] = "timed",
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["custom_type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["custom"] = "function()\n    if (GetTotemInfo(1)) then\n        return true\n    end\n    return false\nend",
						["event"] = "Combat Log",
						["totemType"] = 1,
						["customDuration"] = "function()\n    if (not WA_BlackOx) then return 0,0,false  end\n    local h = WA_BlackOx.hpPercent or 0    \n    return h, 100, true    \nend\n\n\n\n\n\n\n\n\n",
						["spellIds"] = {
						},
						["events"] = "PLAYER_TOTEM_UPDATE",
						["unevent"] = "timed",
						["check"] = "update",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
					},
					["untrigger"] = {
						["custom"] = "function()\n    if (not GetTotemInfo(1)) then\n        return true\n    end\n    return false\n    \nend",
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["internalVersion"] = 9,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["backdropInFront"] = false,
			["text"] = false,
			["stickyDuration"] = false,
			["timer"] = true,
			["timerFlags"] = "None",
			["sparkBlendMode"] = "ADD",
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["displayTextLeft"] = "%p%",
			["borderOffset"] = 5,
			["height"] = 15,
			["backgroundColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["useAdjustededMax"] = false,
			["border"] = false,
			["borderEdge"] = "None",
			["icon"] = false,
			["borderInFront"] = true,
			["textFlags"] = "OUTLINE",
			["icon_side"] = "RIGHT",
			["borderColor"] = {
				0, -- [1]
				0, -- [2]
				0, -- [3]
				0.5, -- [4]
			},
			["anchorFrameType"] = "SCREEN",
			["sparkHeight"] = 30,
			["sparkTexture"] = "Interface\\CastingBar\\UI-CastingBar-Spark",
			["displayTextRight"] = "%p%",
			["stacksColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["timerSize"] = 14,
			["id"] = "雕像血量",
			["sparkHidden"] = "NEVER",
			["sparkRotationMode"] = "AUTO",
			["frameStrata"] = 1,
			["width"] = 36,
			["sparkOffsetX"] = 0,
			["borderSize"] = 2,
			["inverse"] = false,
			["auto"] = true,
			["orientation"] = "HORIZONTAL",
			["conditions"] = {
			},
			["sparkColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["stacksFont"] = "Friz Quadrata TT",
		},
		["有雕像"] = {
			["text2Point"] = "CENTER",
			["text1FontSize"] = 12,
			["color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["yOffset"] = 141.000305175781,
			["anchorPoint"] = "CENTER",
			["customTextUpdate"] = "update",
			["icon"] = true,
			["triggers"] = {
				{
					["trigger"] = {
						["use_totemName"] = false,
						["genericShowOn"] = "showOnActive",
						["use_unit"] = true,
						["use_totemType"] = true,
						["custom_hide"] = "timed",
						["type"] = "custom",
						["debuffType"] = "HELPFUL",
						["custom_type"] = "status",
						["subeventSuffix"] = "_CAST_START",
						["totemType"] = 1,
						["event"] = "Totem",
						["totemName"] = "Black Ox Statue",
						["unevent"] = "auto",
						["custom"] = "function()\n    if (GetTotemInfo(1)) then\n        return true\n    end\n    return false\nend",
						["events"] = "PLAYER_TOTEM_UPDATE",
						["spellIds"] = {
						},
						["check"] = "event",
						["unit"] = "player",
						["subeventPrefix"] = "SPELL",
						["names"] = {
						},
					},
					["untrigger"] = {
						["custom"] = "function()\n    if (not GetTotemInfo(1)) then\n        return true\n    end\n    return false\n    \nend\n\n\n",
						["totemType"] = 1,
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["text1Enabled"] = true,
			["keepAspectRatio"] = false,
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["desaturate"] = false,
			["text1Point"] = "BOTTOMRIGHT",
			["text2FontFlags"] = "OUTLINE",
			["height"] = 35,
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["use_never"] = false,
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["use_talent"] = true,
				["use_class"] = true,
				["role"] = {
					["multi"] = {
					},
				},
				["use_spec"] = true,
				["size"] = {
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["single"] = 11,
					["multi"] = {
					},
				},
				["spec"] = {
					["single"] = 1,
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["race"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
			},
			["width"] = 35,
			["internalVersion"] = 9,
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["text2Containment"] = "INSIDE",
			["selfPoint"] = "CENTER",
			["text1Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["conditions"] = {
			},
			["text2Font"] = "Friz Quadrata TT",
			["text1FontFlags"] = "OUTLINE",
			["regionType"] = "icon",
			["text1Containment"] = "INSIDE",
			["glow"] = false,
			["text2FontSize"] = 24,
			["stickyDuration"] = false,
			["text1"] = "%s",
			["frameStrata"] = 1,
			["zoom"] = 0,
			["text2"] = "%p",
			["auto"] = true,
			["text2Color"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				1, -- [4]
			},
			["id"] = "有雕像",
			["alpha"] = 1,
			["text2Enabled"] = false,
			["anchorFrameType"] = "SCREEN",
			["text1Font"] = "Friz Quadrata TT",
			["cooldownTextEnabled"] = true,
			["inverse"] = false,
			["parent"] = "玄牛雕像",
			["displayIcon"] = "Interface\\Icons\\monk_ability_summonoxstatue",
			["stacksPoint"] = "CENTER",
			["xOffset"] = -477.000061035156,
		},
		["玄牛雕像"] = {
			["backdropColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["controlledChildren"] = {
				"雕像受伤光环", -- [1]
				"有雕像", -- [2]
				"无雕像", -- [3]
				"受伤警报", -- [4]
				"雕像血量", -- [5]
				"雕像 cd", -- [6]
			},
			["borderBackdrop"] = "Blizzard Tooltip",
			["xOffset"] = 334.107238769531,
			["border"] = false,
			["yOffset"] = -321.380950927734,
			["regionType"] = "group",
			["borderSize"] = 16,
			["borderColor"] = {
				1, -- [1]
				1, -- [2]
				1, -- [3]
				0.5, -- [4]
			},
			["expanded"] = false,
			["triggers"] = {
				{
					["trigger"] = {
						["type"] = "aura",
						["subeventSuffix"] = "_CAST_START",
						["event"] = "Health",
						["subeventPrefix"] = "SPELL",
						["spellIds"] = {
						},
						["debuffType"] = "HELPFUL",
						["unit"] = "player",
						["names"] = {
						},
						["buffShowOn"] = "showOnActive",
					},
					["untrigger"] = {
					},
				}, -- [1]
				["activeTriggerMode"] = 1,
			},
			["borderOffset"] = 5,
			["anchorPoint"] = "CENTER",
			["selfPoint"] = "BOTTOMLEFT",
			["id"] = "玄牛雕像",
			["actions"] = {
				["start"] = {
				},
				["finish"] = {
				},
				["init"] = {
				},
			},
			["frameStrata"] = 1,
			["anchorFrameType"] = "SCREEN",
			["animation"] = {
				["start"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["main"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
				["finish"] = {
					["duration_type"] = "seconds",
					["type"] = "none",
				},
			},
			["borderInset"] = 11,
			["internalVersion"] = 9,
			["scale"] = 1,
			["conditions"] = {
			},
			["load"] = {
				["ingroup"] = {
					["multi"] = {
					},
				},
				["affixes"] = {
					["multi"] = {
					},
				},
				["talent"] = {
					["multi"] = {
					},
				},
				["class"] = {
					["single"] = "MONK",
					["multi"] = {
					},
				},
				["talent2"] = {
					["multi"] = {
					},
				},
				["role"] = {
					["multi"] = {
					},
				},
				["use_class"] = "true",
				["race"] = {
					["multi"] = {
					},
				},
				["talent3"] = {
					["multi"] = {
					},
				},
				["pvptalent"] = {
					["multi"] = {
					},
				},
				["difficulty"] = {
					["multi"] = {
					},
				},
				["spec"] = {
					["multi"] = {
					},
				},
				["faction"] = {
					["multi"] = {
					},
				},
				["size"] = {
					["multi"] = {
					},
				},
			},
			["borderEdge"] = "None",
		},
	},
	["registered"] = {
	},
	["frame"] = {
		["xOffset"] = -1120.55316162109,
		["width"] = 802.743286132813,
		["height"] = 718.548461914063,
		["yOffset"] = -229.757690429688,
	},
	["login_squelch_time"] = 10,
	["editor_theme"] = "Monokai",
}
