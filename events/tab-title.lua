local wezterm = require("wezterm")
local acrylic = require("utils.acrylic")
local constants = require("utils.constants")

local M = {}

-- Store tab icons
local tab_icons = {}

M.setup = function()
	wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
		local edge_background = acrylic.title_color_bg
		local background = acrylic.title_color_bg:lighten(0.05)
		local foreground = acrylic.title_color_fg

		if tab.is_active then
			background = background:lighten(0.1)
			foreground = foreground:lighten(0.1)
		elseif hover then
			background = background:lighten(0.2)
			foreground = foreground:lighten(0.2)
		end

		local edge_foreground = background

		-- Get or create icon for this tab
		if not tab_icons[tab.tab_id] then
			tab_icons[tab.tab_id] = constants.icons[math.random(#constants.icons)]
		end
		local icon = tab_icons[tab.tab_id]

		-- ensure that the titles fit in the available space,
		-- and that we have room for the edges.
		local title = "  " .. icon .. "  "
		title = wezterm.truncate_right(title, max_width - 2)

		return {
			{ Background = { Color = edge_background } },
			{ Foreground = { Color = edge_foreground } },
			{ Text = acrylic.TAB_EDGE_LEFT },
			{ Background = { Color = background } },
			{ Foreground = { Color = foreground } },
			{ Text = title },
			{ Background = { Color = edge_background } },
			{ Foreground = { Color = edge_foreground } },
			{ Text = acrylic.TAB_EDGE_RIGHT },
		}
	end)

	-- Clean up closed tabs
	wezterm.on("window-config-reloaded", function()
		local mux = wezterm.mux
		if not mux then return end
		
		local window = mux.get_active_window()
		if not window then return end
		
		-- Get all active tab IDs
		local active_tabs = {}
		for _, tab in ipairs(window:tabs()) do
			active_tabs[tab.tab_id] = true
		end
		
		-- Remove icons for closed tabs
		for tab_id, _ in pairs(tab_icons) do
			if not active_tabs[tab_id] then
				tab_icons[tab_id] = nil
			end
		end
	end)
end

return M
