local gpu_adapters = require("utils.gpu_adapter")
local acrylic = require("utils.acrylic")

return {
	animation_fps = 120,
	max_fps = 120,
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",
	webgpu_preferred_adapter = gpu_adapters:pick_best(),
	initial_rows = 40,
	initial_cols = 140,

	-- -- cursor style
	default_cursor_style = "BlinkingBlock",
	cursor_blink_rate = 500,

	colors = {
		-- Basic colors
		ansi = {
			"#21222c",
			"#ff5555",
			"#50fa7b",
			"#f1fa8c",
			"#bd93f9",
			"#ff79c6",
			"#8be9fd",
			"#f8f8f2",
		},
		brights = {
			"#6272a4",
			"#ff6e6e",
			"#69ff94",
			"#ffffa5",
			"#d6acff",
			"#ff92df",
			"#a4ffff",
			"#ffffff",
		},
		background = "#282a36",
		foreground = "#f8f8f2",
		cursor_bg = "#f8f8f2",
		cursor_fg = "#282a36",
		cursor_border = "#f8f8f2",
		compose_cursor = "#ffb86c",
		selection_bg = "rgba(26.666668% 27.843138% 35.294117% 50%)",
		selection_fg = "rgba(0% 0% 0% 0%)",
		scrollbar_thumb = "#44475a",
		-- split = "#6272a4",

		-- Tab bar colors
		-- tab_bar = {
		-- 	background = "#282a36",
		-- 	active_tab = {
		-- 		bg_color = "#bd93f9",
		-- 		fg_color = "#282a36",
		-- 	},
		-- 	inactive_tab = {
		-- 		bg_color = "#282a36",
		-- 		fg_color = "#f8f8f2",
		-- 	},
		-- }
		tab_bar = {
			active_tab = {
				bg_color = acrylic.title_color_bg:lighten(0.03),
				fg_color = acrylic.title_color_fg:lighten(0.8),
				intensity = "Bold",
			},
			inactive_tab = {
				bg_color = acrylic.title_color_bg:lighten(0.01),
				fg_color = acrylic.title_color_fg,
				intensity = "Half",
			},
			inactive_tab_edge = acrylic.title_color_bg,
		},
		split = acrylic.title_color_bg:lighten(0.3):desaturate(0.5),
	},
	-- window_background_opacity = 0.6,
	window_background_opacity = 0.7,
	window_frame = {
		active_titlebar_bg = acrylic.title_color_bg,
		inactive_titlebar_bg = acrylic.title_color_bg,
		font_size = 10.0,
	},

	window_decorations = "RESIZE",
	win32_system_backdrop = "Acrylic",
	show_tab_index_in_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	-- window_background_opacity = 0.6,
	-- window_frame = {
	-- 	active_titlebar_bg = title_color_bg,
	-- 	inactive_titlebar_bg = title_color_bg,
	-- 	font_size = 10.0,
	-- },

	-- win32_system_backdrop = "Acrylic",
	-- show_new_tab_button_in_tab_bar = false,

	-- -- color scheme
	-- -- style 1:
	-- -- colors = colors,
	-- -- style 2:
	-- color_scheme = "Dracula (Official)",

	-- -- background
	-- -- style 1:
	-- -- window_background_opacity = 0.95,
	macos_window_background_blur = 30,
	-- adjust_window_size_when_changing_font_size = false,
	-- -- style 2:
	-- -- background = {
	-- --     {
	-- --         source = { File = wezterm.GLOBAL.background },
	-- --     },
	-- --     {
	-- --         source = { Color = colors.background },
	-- --         height = '100%',
	-- --         width = '100%',
	-- --         opacity = 0.96,
	-- --     },
	-- -- },

	-- -- scrollbar
	-- -- enable_scroll_bar = false,

	-- -- tab bar
	-- -- enable_tab_bar = true,
	-- -- hide_tab_bar_if_only_one_tab = true,
	-- -- use_fancy_tab_bar = false,
	-- -- tab_max_width = 30,
	-- -- show_tab_index_in_tab_bar = false,
	-- -- switch_to_last_active_tab_when_closing_tab = true,

	-- -- window
	-- window_decorations = "RESIZE",
	-- -- window_padding = {
	-- -- 	left = 5,
	-- -- 	right = 10,
	-- -- 	top = 10,
	-- -- 	bottom = 7,
	-- -- },
	window_close_confirmation = "NeverPrompt",
	-- -- window_frame = {
	-- -- 	active_titlebar_bg = "#090909",
	-- -- 	-- font = fonts.font,
	-- -- 	-- font_size = fonts.font_size,
	-- -- },
	-- -- inactive_pane_hsb = {
	-- -- 	saturation = 0.9,
	-- -- 	brightness = 0.65,
	-- -- },
}
