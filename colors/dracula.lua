-- Dracula color scheme for WezTerm
-- Source: https://github.com/dracula/wezterm
-- Author: timescam

return {
    name = 'Dracula (Official)',

    -- 颜色配置
    colors = {
        foreground = '#f8f8f2',
        background = '#282a36',
        cursor_bg = '#f8f8f2',
        cursor_border = '#f8f8f2',
        cursor_fg = '#282a36',
        selection_bg = 'rgba(98, 114, 164, 0.5)',
        selection_fg = '#f8f8f2',

        ansi = {
            '#21222c', -- black
            '#ff5555', -- red
            '#50fa7b', -- green
            '#f1fa8c', -- yellow
            '#bd93f9', -- blue
            '#ff79c6', -- magenta
            '#8be9fd', -- cyan
            '#f8f8f2', -- white
        },

        brights = {
            '#6272a4', -- bright black
            '#ff6e6e', -- bright red
            '#69ff94', -- bright green
            '#ffffa5', -- bright yellow
            '#d6acff', -- bright blue
            '#ff92df', -- bright magenta
            '#a4ffff', -- bright cyan
            '#ffffff', -- bright white
        },

        tab_bar = {
            background = '#282a36',
            active_tab = {
                bg_color = '#bd93f9',
                fg_color = '#282a36',
                intensity = 'Normal',
                italic = false,
                strikethrough = false,
                underline = 'None',
            },
            inactive_tab = {
                bg_color = '#282a36',
                fg_color = '#f8f8f2',
                intensity = 'Normal',
                italic = false,
                strikethrough = false,
                underline = 'None',
            },
            inactive_tab_hover = {
                bg_color = '#6272a4',
                fg_color = '#f8f8f2',
                intensity = 'Normal',
                italic = true,
                strikethrough = false,
                underline = 'None',
            },
            new_tab = {
                bg_color = '#282a36',
                fg_color = '#f8f8f2',
                intensity = 'Normal',
                italic = false,
                strikethrough = false,
                underline = 'None',
            },
            new_tab_hover = {
                bg_color = '#ff79c6',
                fg_color = '#f8f8f2',
                intensity = 'Normal',
                italic = true,
                strikethrough = false,
                underline = 'None',
            },
        },

        compose_cursor = '#ffb86c',
        scrollbar_thumb = '#44475a',
        split = '#6272a4',
    },

    -- 配套外观配置
    appearance = {
        window_background_opacity = 0.82,
        macos_window_background_blur = 23,
        active_titlebar_bg = '#090909',
    },

    tab_title = {
        default = { bg = '#45475a', fg = '#1c1b19' },
        is_active = { bg = '#bd93f9', fg = '#282a36' },
        hover = { bg = '#6272a4', fg = '#f8f8f2' },
        unseen_output = '#ff79c6',
    },
}