local wezterm = require('wezterm')
local gpu_adapters = require('utils.gpu_adapter')

-- 动态加载主题
local current_theme_name = require('config.theme')
local theme = require('colors.' .. current_theme_name)
local colors = theme.colors
local app_config = theme.appearance or {}

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

    -- 使用动态加载的主题配色
    colors = colors,

    -- background
    -- 使用主题提供的 appearance 配置，并设置默认值
    window_background_opacity = app_config.window_background_opacity or 0.9,
    macos_window_background_blur = app_config.macos_window_background_blur or 15,
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
