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

    -- 内建颜色方案（可选：用于 terminal 颜色）
    color_scheme = (current_theme_name == 'solarized_light' and 'Solarized Light (Gogh)') or
                   (current_theme_name == 'dracula' and 'Dracula') or '',

    -- background - 从主题读取或使用默认值
    window_background_opacity = app_config.window_background_opacity or 1.0,
    macos_window_background_blur = app_config.macos_window_background_blur or 0,
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
        -- 应用主题中的核心颜色
        foreground = theme.colors.foreground,
        background = theme.colors.background,
        cursor_bg = theme.colors.cursor_bg,
        cursor_border = theme.colors.cursor_border,
        cursor_fg = theme.colors.cursor_fg,
        selection_bg = theme.colors.selection_bg,
        selection_fg = theme.colors.selection_fg,
        scrollbar_thumb = theme.colors.scrollbar_thumb,
        split = theme.colors.split,
        ansi = theme.colors.ansi,
        brights = theme.colors.brights,
    },

    -- window
    window_decorations = "RESIZE",
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
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
