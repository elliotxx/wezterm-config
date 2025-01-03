local wezterm = require("wezterm")
local acrylic = require("utils.acrylic")

local M = {}

M.setup = function()
	local color_off = acrylic.title_color_bg:lighten(0.4)
	local color_on = color_off:lighten(0.4)
	wezterm.on("update-right-status", function(window)
		local bat = ""
		local b = wezterm.battery_info()[1]
		bat = wezterm.format({
			{ Foreground = {
				Color = b.state_of_charge > 0.2 and color_on or color_off,
			} },
			{ Text = "▉" },
			{ Foreground = {
				Color = b.state_of_charge > 0.4 and color_on or color_off,
			} },
			{ Text = "▉" },
			{ Foreground = {
				Color = b.state_of_charge > 0.6 and color_on or color_off,
			} },
			{ Text = "▉" },
			{ Foreground = {
				Color = b.state_of_charge > 0.8 and color_on or color_off,
			} },
			{ Text = "▉" },
			{ Background = {
				Color = b.state_of_charge > 0.98 and color_on or color_off,
			} },
			{
				Foreground = {
					Color = b.state == "Charging" and color_on:lighten(0.3):complement()
						or (b.state_of_charge < 0.2 and wezterm.GLOBAL.count % 2 == 0) and color_on
							:lighten(0.1)
							:complement()
						or color_off:darken(0.1),
				},
			},
			{ Text = " ⚡ " },
		})

		local time = wezterm.strftime("%-l:%M %P")

		local bg1 = acrylic.title_color_bg:lighten(0.1)
		local bg2 = acrylic.title_color_bg:lighten(0.2)

		window:set_right_status(wezterm.format({
			{ Background = { Color = acrylic.title_color_bg } },
			{ Foreground = { Color = bg1 } },
			{ Text = "" },
			{ Background = { Color = acrylic.title_color_bg:lighten(0.1) } },
			{ Foreground = { Color = acrylic.title_color_fg } },
			{ Text = " " .. window:active_workspace() .. " " },
			{ Foreground = { Color = bg1 } },
			{ Background = { Color = bg2 } },
			{ Text = "" },
			{ Foreground = { Color = acrylic.title_color_bg:lighten(0.4) } },
			{ Foreground = { Color = acrylic.title_color_fg } },
			{ Text = " " .. time .. " " .. bat },
		}))
	end)
end

return M
