-- Solarized Light color scheme for WezTerm
-- Based on Ethan Schoonover's Solarized color palette
-- Enhanced contrast for better git diff visibility

return {
    name = 'Solarized Light',

    colors = {
        foreground = '#4a5568',
        background = '#fdf6e3',

        cursor_bg = '#4a5568',
        cursor_border = '#4a5568',
        cursor_fg = '#fdf6e3',

        selection_bg = '#e0d9c5',
        selection_fg = '#2d3748',

        ansi = {
            '#1a202c', -- black
            '#ea580c', -- orange → 用于删除行
            '#0066cc', -- blue → 用于新增行
            '#92400e', -- yellow (元信息)
            '#1e3a8a', -- deep blue (其他用途)
            '#86198f', -- magenta (diff 片段标记 @@)
            '#155e75', -- cyan
            '#e2e8f0', -- white
        },

        brights = {
            '#171923', -- bright black
            '#f97316', -- bright orange (鲜艳的橙色用于删除行)
            '#0088ff', -- bright blue (高亮蓝色用于新增行)
            '#ca8a04', -- bright yellow
            '#3b82f6', -- bright blue
            '#c026d3', -- bright magenta
            '#0891b2', -- bright cyan
            '#f7fafc', -- bright white
        },

        tab_bar = {
            background = '#e2e8f0',
            active_tab = {
                bg_color = '#2b6cb0',
                fg_color = '#fdf6e3',
            },
            inactive_tab = {
                bg_color = '#cbd5e0',
                fg_color = '#2d3748',
            },
            inactive_tab_hover = {
                bg_color = '#a0aec0',
                fg_color = '#1a202c',
            },
            new_tab = {
                bg_color = '#cbd5e0',
                fg_color = '#2d3748',
            },
            new_tab_hover = {
                bg_color = '#a0aec0',
                fg_color = '#1a202c',
            },
        },

        split = '#cbd5e0',
        scrollbar_thumb = '#a0aec0',
    },

    appearance = {
        window_background_opacity = 0.96,
        macos_window_background_blur = 10,
        active_titlebar_bg = '#fdf6e3',
    },

    tab_title = {
        default = { bg = '#cbd5e0', fg = '#2d3748' },
        is_active = { bg = '#2b6cb0', fg = '#fdf6e3' },
        hover = { bg = '#a0aec0', fg = '#1a202c' },
        unseen_output = '#c53030',
    },

    right_status = {
        date_fg = '#657b83',
        date_bg = 'rgba(238, 232, 213, 0.5)',
        battery_fg = '#859900',
        battery_bg = 'rgba(238, 232, 213, 0.5)',
        separator_fg = '#93a1a1',
        separator_bg = 'rgba(238, 232, 213, 0.5)',
    },
}