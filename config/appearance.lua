local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')

-- 动态加载主题
local current_theme_name = require('config.theme')
local theme = require('colors.' .. current_theme_name)
local app_config = theme.appearance or {}

-- 从主题文件读取 tab bar 配色
local theme_tab_bar = theme.colors.tab_bar or {}

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

    -- 当前使用内置配色方案 (推荐用于 git diff 等场景)
    color_scheme = 'Solarized Light (Gogh)',

    -- background
    window_background_opacity = 1.0,
    macos_window_background_blur = 0,
    adjust_window_size_when_changing_font_size = false,

    -- scrollbar
    enable_scroll_bar = false,

    -- tab bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    tab_max_width = 30,
    show_tab_index_in_tab_bar = false,
    switch_to_last_active_tab_when_closing_tab = true,

    -- tab bar 配色，从主题文件读取
    colors = {
        tab_bar = theme_tab_bar,
    },

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
        active_titlebar_bg = app_config.active_titlebar_bg or '#000000',
    },
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.65,
    },
}
