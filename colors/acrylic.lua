-- Reference: 
--  - https://gist.github.com/gsuuon/5511f0aa10c10c6cbd762e0b3e596b71
--  - https://github.com/wez/wezterm/discussions/628#discussioncomment-5735102
local wezterm = require("wezterm")

local color_default_fg_light = wezterm.color.parse("#cacaca") -- 💩
local color_default_fg_dark = wezterm.color.parse("#303030")

return {
	DRACULA = {
		bg = wezterm.color.parse("#282a36"),
		fg = color_default_fg_light,
	},
	VERIDIAN = {
		bg = wezterm.color.parse("#4D8060"),
		fg = color_default_fg_light,
	},
	PAYNE = {
		bg = wezterm.color.parse("#385F71"),
		fg = color_default_fg_light,
	},
	INDIGO = {
		bg = wezterm.color.parse("#7C77B9"),
		fg = color_default_fg_light,
	},
	CAROLINA = {
		bg = wezterm.color.parse("#8FBFE0"),
		fg = color_default_fg_dark,
	},
	FLAME = {
		bg = wezterm.color.parse("#D36135"),
		fg = color_default_fg_dark,
	},
	JET = {
		bg = wezterm.color.parse("#282B28"),
		fg = color_default_fg_light,
	},
	TAUPE = {
		bg = wezterm.color.parse("#785964"),
		fg = color_default_fg_light,
	},
	ECRU = {
		bg = wezterm.color.parse("#C6AE82"),
		fg = color_default_fg_dark,
	},
	VIOLET = {
		bg = wezterm.color.parse("#685F74"),
		fg = color_default_fg_light,
	},
	VERDIGRIS = {
		bg = wezterm.color.parse("#28AFB0"),
		fg = color_default_fg_light,
	},
}
