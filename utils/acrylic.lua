local wezterm = require("wezterm")
local constants = require("utils.constants")

local M = {}

local color = (function()
	local COLOR = require("colors.acrylic")

	local coolors = {
		COLOR.VERIDIAN,
		COLOR.PAYNE,
		COLOR.INDIGO,
		COLOR.CAROLINA,
		COLOR.FLAME,
		COLOR.JET,
		COLOR.TAUPE,
		COLOR.ECRU,
		COLOR.VIOLET,
		COLOR.VERDIGRIS,
	}

	return coolors[math.random(#coolors)]
end)()

local color_primary = color

M.title_color_bg = color_primary.bg
M.title_color_fg = color_primary.fg

M.TAB_EDGE_LEFT = wezterm.nerdfonts.ple_left_half_circle_thick
M.TAB_EDGE_RIGHT = wezterm.nerdfonts.ple_right_half_circle_thick

M.tab_title = function(tab_info)
	-- Use random icon for tab title
	return "  " .. constants.icons[math.random(#constants.icons)] .. "  "
end

return M
