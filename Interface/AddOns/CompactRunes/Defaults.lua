local _G = getfenv(0)
local ADDON_NAME, addon = ...

addon.defaults = {
	profile = {
		minimap = {
			hide = true,
		},
		debug = false,
		debugBP = false,
		locked = false,
		hideBlizzardFrames = false,
		ooc_alpha = 0.4,
		combatAlpha = 1.0,
		vehicleAlpha = 0.0,
		alphas = {
			petBattle = 0.0,
		},
		auxBarOOCAlpha = 0.0,
		oocRechargeAlphaEnabled = false,
		oocRechargeAlpha = 0.4,
		rechargeAlpha = 0.3,
		showCDText = true,
		rechargeTimers = "None",
		runeOrientation = "HORIZONTAL",
		almostReadyTime = 0,
		almostReadyAlpha = 0.6,
		sortRunes = true,
		runeSortOrder = "Down",
		runeBackground = 1,
		runeBackgroundAlpha = 0.1,
		runeBackgrounds = {
			transparent = { r = 0.0, g = 0.0, b = 0.0, a = 0.0 },
			black = { r = 0.0, g = 0.0, b = 0.0, a = 1.0 },
		},
		RuneColors = {
			["DEFAULT"] = { r = 0.7, g = 0.7, b = 1.0, a = 1.0 },
		},
		RuneCooldownColors = {
			["DEFAULT"] = { r = 0.6, g = 0.6, b = 0.7, a = 0.1 },
			["NONE"] = { r = 0.0, g = 0.0, b = 0.0, a = 0.0 },
		},
		rangeInd = true,
		rangeColor = { r = 1.0, g = 0.0, b = 0.0, a = 0.6 },
		rcProcInd = true,
		rcProcColor = { r = 1.0, g = 1.0, b = 1.0, a = 0.6 },
		kmStats = false,
		font_face = "Friz Quadrata TT",
		font_size = 12,
		fontFlags = {
			OUTLINE = true,
			THICKOUTLINE = false,
			MONOCHROME = false
		},
		texture = "Compact Runes",
		border = "Compact Runes",
		borderInd = "Compact Runes Bright",
		dimensions = {
			["HORIZONTAL"] = {
				width = 30,
				height = 10,
				spacing = 4,
				inset = 6,
				swap = false,
				barSpacing = 6,
			},
			["VERTICAL"] = {
				width = 12,
				height = 25,
				spacing = 4,
				inset = 6,
				swap = true,
				barSpacing = 6,
			},
		},
		["frame"] = {
			x = 0,
			y = 0,
			color = { r = 0.1, g = 0.1, b = 0.1, a = 1.0 },
			bdcolor = { r = 0.5, g = 0.5, b = 0.5, a = 1.0 },
			rccolor = { r = 1.0, g = 1.0, b = 1.0, a = 0.7 },
		},
		rpTicks = {
			enabled = false,
			color = { r = 0.0, g = 0.0, b = 0.0, a = 1.0 },
			width = 2,
			specs = {
				["Blood"] = {
					cost = 45,
				},
				["Frost"] = {
					cost = 25,
				},
				["Unholy"] = {
					cost = 45,
				},
			},
		},
		["procIcon"] = {
			scale = 1.0,
			userPlaced = false,
			x = 0,
			y = 0,
			alphas = {
				combat = 1.0,
				ooc = 0.6,
			},
		},
		procs = true,
		ignoreRuneCDs = {
			["Procs"] = true,
			["CooldownBar"] = true,
		},
		enabled = {
			["Blood"] = {
				["Blood Boil"] = true,
				["Rune Strike"] = false,
				["Crimson Scourge"] = true,
				["Death and Decay"] = false,
				["Bone Shield <= 6"] = true,
				["Consumption"] = true,
				["Blooddrinker"] = true,
			},
			["Frost"] = {
				["Breath of Sindragosa"] = true,
				["Dark Succor"] = true,
				["Empower Rune Weapon"] = true,
				["Freezing Fog"] = true,
				["Glacial Advance"] = true,
				["Killing Machine"] = true,
				["Horn of Winter"] = true,
				["Obliteration"] = true,
				["Pillar of Frost"] = true
			},
			["Unholy"] = {
				["Apocalypse"] = true,
				["Dark Succor"] = true,
				["Dark Transformation"] = true,
				["Death and Decay"] = false,
				["Festering Wound < 5"] = true,
				["Necrosis Buff"] = true,
				["Raise Dead"] = true,
				["Sudden Doom"] = true,
				["Summon Gargoyle"] = true,
			},
		},
		priorityList = {
			["Blood"] = {},
			["Frost"] = {},
			["Unholy"] = {},
		},
		cdbars = {
			['**'] = {
				enabled = false,
				x = nil,
				y = nil,
				spacing = 5,
				maxItemsPerRow = 10,
				maxRows = 2,
				oocAlpha = 0.6,
				combatAlpha = 1.0,
				inactiveAlpha = 0.4,
				activeAlpha = 1.0,
				vehicleAlpha = 0.0,
				textcolor = { r = 0.85, g = 0.85, b = 0.0, a = 1.0 },
				textFontSize = 14,
				fontFace = "Friz Quadrata TT",
				height = 32,
				width = 32,
			},
			["Unholy"] = {
				cds = {
					["Anti-Magic Shell"] = {
						enabled = true,
						type = "spell",
					},
					["Apocalypse"] = {
						enabled = true,
						type = "spell",
					},
					["Army of the Dead"] = {
						enabled = true,
						type = "spell",
					},
					["Asphyxiate"] = {
						enabled = true,
						type = "spell",
					},
					["Blighted Rune Weapon"] = {
						enabled = true,
						type = "spell",
					},
					["Corpse Shield"] = {
						enabled = true,
						type = "spell",
					},
					["Dark Arbiter"] = {
						enabled = true,
						type = "spell",
					},
					["Dark Transformation"] = {
						enabled = true,
						type = "spell",
					},
					["Death and Decay"] = {
						enabled = true,
						type = "spell",
					},
					["Defile"] = {
						enabled = true,
						type = "spell",
					},
					["Icebound Fortitude"] = {
						enabled = true,
						type = "spell",
					},
					["Mind Freeze"] = {
						enabled = true,
						type = "spell",
					},
					["Outbreak"] = {
						enabled = true,
						type = "spell",
					},
					["Soul Reaper"] = {
						enabled = true,
						type = "spell",
					},
					["Summon Gargoyle"] = {
						enabled = true,
						type = "spell",
					},
					["Wraith Walk"] = {
						enabled = true,
						type = "spell",
					},
					-- Items
					["Jes' Howler"] = {
						enabled = true,
						type = "item",
					},
					["Kil'jaeden's Burning Wish"] = {
						enabled = true,
						type = "item",
					},
				},
				ordering = {},
			},
			["Frost"] = {
				cds = {
					["Anti-Magic Shell"] = {
						enabled = true,
						type = "spell",
					},
					["Blinding Sleet"] = {
						enabled = true,
						type = "spell",
					},
					["Breath of Sindragosa"] = {
						enabled = true,
						type = "spell",
					},
					["Empower Rune Weapon"] = {
						enabled = true,
						type = "spell",
					},
					["Glacial Advance"] = {
						enabled = true,
						type = "spell",
					},
					["Horn of Winter"] = {
						enabled = true,
						type = "spell",
					},
					["Hungering Rune Weapon"] = {
						enabled = true,
						type = "spell",
					},
					["Icebound Fortitude"] = {
						enabled = true,
						type = "spell",
					},
					["Mind Freeze"] = {
						enabled = true,
						type = "spell",
					},
					["Obliteration"] = {
						enabled = true,
						type = "spell",
					},
					["Pillar of Frost"] = {
						enabled = true,
						type = "spell",
					},
					["Remorseless Winter"] = {
						enabled = true,
						type = "spell",
					},
					["Sindragosa's Fury"] = {
						enabled = true,
						type = "spell",
					},
					["Wraith Walk"] = {
						enabled = true,
						type = "spell",
					},
					-- Items
					["Jes' Howler"] = {
						enabled = true,
						type = "item",
					},
					["Kil'jaeden's Burning Wish"] = {
						enabled = true,
						type = "item",
					},
				},
				ordering = {},
			},
			["Blood"] = {
				cds = {
					["Anti-Magic Shell"] = {
						enabled = true,
						type = "spell",
					},
					["Asphyxiate (Blood)"] = {
						enabled = true,
						type = "spell",
					},
					["Rune Strike"] = {
						enabled = true,
						type = "spellcharges",
					},
					["Blood Mirror"] = {
						enabled = true,
						type = "spell",
					},
					["Blooddrinker"] = {
						enabled = true,
						type = "spell",
					},
					["Bonestorm"] = {
						enabled = true,
						type = "spell",
					},
					["Consumption"] = {
						enabled = true,
						type = "spell",
					},
					["Dancing Rune Weapon"] = {
						enabled = true,
						type = "spell",
					},
					["Death and Decay"] = {
						enabled = true,
						type = "spell",
					},
					["Death's Caress"] = {
						enabled = true,
						type = "spell",
					},
					["Gorefiend's Grasp"] = {
						enabled = true,
						type = "spell",
					},
					["Icebound Fortitude"] = {
						enabled = true,
						type = "spell",
					},
					["Mark of Blood"] = {
						enabled = true,
						type = "spell",
					},
					["Mind Freeze"] = {
						enabled = true,
						type = "spell",
					},
					["Strangulate"] = {
						enabled = true,
						type = "spell",
					},
					["Rune Tap"] = {
						enabled = true,
						type = "spellcharges",
					},
					["Tombstone"] = {
						enabled = true,
						type = "spell",
					},
					["Vampiric Blood"] = {
						enabled = true,
						type = "spell",
					},
					["Wraith Walk"] = {
						enabled = true,
						type = "spell",
					},
					-- Items
					["Jes' Howler"] = {
						enabled = true,
						type = "item",
					},
				},
				ordering = {},
			},
		},
		blocks = {
			['**'] = {
				width = 30,
				height = 10,
				textcolor = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
				userPlaced = false,
				x = nil,
				y = nil,
			},
			["T18Frost2POblit"] = {
				enabled = false,
				width = 30,
				height = 30,
				userPlaced = true,
				x = -80,
				y = -30,
				fontSize = 16,
				combatAlpha = 0.0,
				oocAlpha = 0.0,
				activeAlpha = 1.0,
				textcolor = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
			},
			["T18Frost2PFW"] = {
				enabled = false,
				width = 30,
				height = 30,
				userPlaced = true,
				x = -50,
				y = -30,
				fontSize = 16,
				combatAlpha = 0.0,
				oocAlpha = 0.0,
				activeAlpha = 1.0,
				textcolor = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
			},
		},
		-- Bars
		bars = {
			-- Provide defaults for all bars.
			-- These are inherited if no bar or no value is set.
			['**'] = {
				textcolor = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
				userPlaced = false,
				x = nil,
				y = nil,
				overrideHeight = false,
				overrideWidth = false,
				height = nil,
				width = nil,
				alpha = 1.0,
			},
			["RunicPowerBar"] = {
				enabled = true,
				color = { r = 0.0, g = 0.82, b = 1.0, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.205, b = 0.25, a = 1.0 },
				textcolor = { r = 0.66, g = 0.82, b = 1.0, a = 1.0 },
				showNumericValue = true,
			},
			["BloodShieldBar"] = {
				enabled = false,
				color = { r = 1.0, g = 0.1, b = 0.1, a = 1.0 },
				bgcolor = { r = 0.5, g = 0.05, b = 0.05, a = 1.0 },
				textcolor = { r = 1.0, g = 0.85, b = 0.85, a = 1.0 },
			},
			["FrostFeverBar"] = {
				enabled = true,
				color = { r = 0.0, g = 0.45, b = 0.6, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.1125, b = 0.15, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["BloodPlagueBar"] = {
				enabled = true,
				color = { r = 0.5, g = 0.0, b = 0.6, a = 1.0 },
				bgcolor = { r = 0.125, g = 0.0, b = 0.15, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["VirulentPlagueBar"] = {
				enabled = true,
				color = { r = 0.7, g = 0.7, b = 0.0, a = 1.0 },
				bgcolor = { r = 0.15, g = 0.15, b = 0.0, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["BoneShieldBar"] = {
				enabled = true,
				progress = "Time",
				color = { r = 0.1, g = 0.45, b = 0.1, a = 1.0 },
				bgcolor = { r = 0.05, g = 0.15, b = 0.05, a = 0.9 },
				textcolor = { r = 0.9, g = 1.0, b = 0.9, a = 1.0 },
			},
			["SwingTimerBar"] = {
				enabled = false,
				color = { r = 0.7, g = 0.7, b = 0.7, a = 1.0 },
				bgcolor = { r = 0.2, g = 0.2, b = 0.2, a = 1.0 },
				userPlaced = true,
				x = 0,
				y = -30,
				numericTimer = true,
				specs = {
					["Blood"] = false,
					["Frost"] = true,
					["Unholy"] = false,
				},
			},
			["FesteringWoundBar"] = {
				enabled = true,
				color = { r = 0.5, g = 0.0, b = 0.6, a = 1.0 },
				bgcolor = { r = 0.125, g = 0.0, b = 0.15, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
				progress = "Time",
			},
			["BloodTapBar"] = {
				enabled = true,
				color = { r = 0.7, g = 0.2, b = 0.2, a = 1 },
				bgcolor = { r = 0.55, g = 0.1, b = 0.1, a = 0.8 },
				textcolor = { r = 1.0, g = 0.9, b = 0.9, a = 1.0 },
			},
			["BloodBoilBar"] = {
				enabled = true,
				color = { r = 1.0, g = 0.0, b = 0.0, a = 1 },
				bgcolor = { r = 0.65, g = 0.0, b = 0.0, a = 0.8 },
				textcolor = { r = 1.0, g = 0.9, b = 0.9, a = 1.0 },
			},
			["DarkTransformationBar"] = {
				enabled = true,
				showCooldown = "ShadowInfusion",
				color = { r = 0.0, g = 0.5, b = 0.0, a = 1.0 },
				bgcolor = { r = 0.125, g = 0.0, b = 0.15, a = 0.9 },
				textcolor = { r = 0.83, g = 0.66, b = 0.86, a = 1.0 },
				alt_color = { r = 0.5, g = 0.25, b = 0.0, a = 1.0 },
				alt_textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["SoulReaperBar"] = {
				enabled = true,
				showCooldown = true,
				primaryValue = "Stacks",
				secondaryValue = "None",
				color = { r = 0.0, g = 0.7, b = 1.0, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.1, b = 0.15, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.9, a = 1.0 },
				alt_color = { r = 0.0, g = 0.3, b = 0.7, a = 0.8 },
				alt_textcolor = { r = 0.8, g = 0.8, b = 0.9, a = 0.9 },
			},
			["EpidemicBar"] = {
				enabled = true,
				color = { r = 0.0, g = 1.0, b = 0.0, a = 1 },
				bgcolor = { r = 0.0, g = 0.65, b = 0.0, a = 0.8 },
				textcolor = { r = 0.9, g = 1.0, b = 0.9, a = 1.0 },
			},
			["PestilentPustulesBar"] = {
				enabled = true,
				color = { r = 0.7, g = 0.0, b = 0.7, a = 1.0 },
				bgcolor = { r = 0.125, g = 0.0, b = 0.15, a = 0.9 },
				textcolor = { r = 0.9, g = 1.0, b = 0.9, a = 1.0 },
			},
			["IcyTalonsBar"] = {
				enabled = true,
				color = { r = 0.0, g = 0.25, b = 0.5, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.1, b = 0.15, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["RazoriceBar"] = {
				enabled = true,
				color = { r = 0.0, g = 0.25, b = 0.5, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.1, b = 0.15, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["RemorselessWinterBar"] = {
				enabled = true,
				color = { r = 0.0, g = 0.4, b = 0.9, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.25, b = 0.4, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
			["DeathAndDecayBar"] = {
				enabled = false,
				showCooldown = true,
				color = { r = 0.4, g = 0.4, b = 0.48, a = 1 },
				bgcolor = { r = 0.1, g = 0.1, b = 0.1, a = 0.8 },
				textcolor = { r = 0.9, g = 0.9, b = 0.9, a = 1.0 },
				alt_color = { r = 0.3, g = 0.3, b = 0.38, a = 0.3 },
				alt_textcolor = { r = 0.9, g = 0.9, b = 0.9, a = 0.7 },
				specs = {
					["Blood"] = true,
					["Unholy"] = true,
				},
			},
			["VampiricBloodBar"] = {
				enabled = false,
				showCooldown = true,
				color = { r = 1.0, g = 0.0, b = 0.0, a = 1 },
				bgcolor = { r = 0.65, g = 0.0, b = 0.0, a = 0.8 },
				textcolor = { r = 1.0, g = 0.9, b = 0.9, a = 1.0 },
				alt_color = { r = 0.6, g = 0.0, b = 0.0, a = 0.5 },
				alt_textcolor = { r = 0.9, g = 0.9, b = 0.9, a = 0.7 },
			},
			["SoWBar"] = {
				enabled = true,
				color = { r = 0.784, g = 0.627, b = 0.47, a = 1 },
				bgcolor = { r = 0.549, g = 0.439, b = 0.329, a = 0.8 },
				textcolor = { r = 1.0, g = 0.9, b = 0.9, a = 1.0 },
			},
			["RuneStrikeBar"] = {
				enabled = true,
				color = { r = 0.0, g = 0.4, b = 0.9, a = 1.0 },
				bgcolor = { r = 0.0, g = 0.25, b = 0.4, a = 0.9 },
				textcolor = { r = 0.8, g = 0.8, b = 0.8, a = 1.0 },
			},
		},
		events = {
			["**"] = {
				sound = "None",
				soundChannel = "Master",
			},
		},
	},
}
