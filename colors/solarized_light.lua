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
            '#1a202c', -- black (darker base02 for better contrast)
            '#9b2c2c', -- red (very dark for deletions)
            '#22543d', -- green (very dark for additions)
            '#b7791f', -- yellow (slightly darker)
            '#2b6cb0', -- blue (slightly darker for better readability)
            '#97266d', -- magenta (deeper)
            '#2c7a7b', -- cyan (deeper)
            '#e2e8f0', -- white (lighter)
        },

        brights = {
            '#171923', -- bright black (darker)
            '#c53030', -- bright red (deep for deletions)
            '#276749', -- bright green (deep for additions)
            '#ecc94b', -- bright yellow (brighter)
            '#4299e1', -- bright blue (brighter)
            '#ed64a6', -- bright magenta (vibrant)
            '#38b2ac', -- bright cyan (vibrant)
            '#f7fafc', -- bright white (almost white)
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
}