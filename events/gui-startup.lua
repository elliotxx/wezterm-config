local wezterm = require("wezterm")

local M = {}

M.setup = function()
	wezterm.on("gui-startup", function(cmd)
		local mux = wezterm.mux

		local padSize = 80
		local screenWidth = 2560
		local screenHeight = 1600

		local tab, _, window = mux.spawn_window(cmd or {
			workspace = "main",
		})

		if window ~= nil then
			window:gui_window():set_position(padSize, padSize)
			window:gui_window():set_inner_size(screenWidth - (padSize * 2), screenHeight - (padSize * 2) - 48)
		end
	end)
end

return M
