local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')
local colors = require('colors.custom')

return {
    animation_fps = 120,
    max_fps = 120,
    front_end = 'WebGpu',
    webgpu_power_preference = 'HighPerformance',
    webgpu_preferred_adapter = gpu_adapters:pick_best(),
    initial_rows = 40,
    initial_cols = 140,

    -- cursor style
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 500,

    -- color scheme
    -- style 1:
    -- colors = colors,
    -- style 2:
    color_scheme = "Dracula (Official)",

    -- background
    -- style 1:
    window_background_opacity = 0.95,
    macos_window_background_blur = 30,
    adjust_window_size_when_changing_font_size = false,
    -- style 2:
    -- background = {
    --     {
    --         source = { File = wezterm.GLOBAL.background },
    --     },
    --     {
    --         source = { Color = colors.background },
    --         height = '100%',
    --         width = '100%',
    --         opacity = 0.96,
    --     },
    -- },

    -- scrollbar
    enable_scroll_bar = false,

    -- tab bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_max_width = 30,
    show_tab_index_in_tab_bar = false,
    switch_to_last_active_tab_when_closing_tab = true,

    -- window
    window_decorations = "RESIZE",
    window_padding = {
        left = 5,
        right = 10,
        top = 10,
        bottom = 7,
    },
    window_close_confirmation = 'NeverPrompt',
    window_frame = {
        active_titlebar_bg = '#090909',
        -- font = fonts.font,
        -- font_size = fonts.font_size,
    },
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.65,
    },
}
