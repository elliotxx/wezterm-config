-- Solarized Light color scheme for WezTerm
-- Based on Ethan Schoonover's Solarized color palette

return {
    name = 'Solarized Light',

    colors = {
        foreground = '#657b83',
        background = '#fdf6e3',

        cursor_bg = '#657b83',
        cursor_border = '#657b83',
        cursor_fg = '#fdf6e3',

        selection_bg = '#eee8d5',
        selection_fg = '#657b83',

        ansi = {
            '#073642', -- black (base02)
            '#dc322f', -- red
            '#859900', -- green
            '#b58900', -- yellow
            '#268bd2', -- blue
            '#d33682', -- magenta
            '#2aa198', -- cyan
            '#eee8d5', -- white (base2)
        },

        brights = {
            '#002b36', -- bright black (base03)
            '#cb4b16', -- bright red (orange)
            '#586e75', -- bright green (base01)
            '#839496', -- bright yellow (base0)
            '#6c71c4', -- bright blue (violet)
            '#b58900', -- bright magenta (yellow)
            '#93a1a1', -- bright cyan (base1)
            '#fdf6e3', -- bright white (base3)
        },

        tab_bar = {
            background = '#eee8d5',
            active_tab = {
                bg_color = '#268bd2',
                fg_color = '#fdf6e3',
            },
            inactive_tab = {
                bg_color = '#93a1a1',
                fg_color = '#073642',
            },
            inactive_tab_hover = {
                bg_color = '#839496',
                fg_color = '#073642',
            },
            new_tab = {
                bg_color = '#93a1a1',
                fg_color = '#073642',
            },
            new_tab_hover = {
                bg_color = '#839496',
                fg_color = '#073642',
            },
        },

        split = '#93a1a1',
        scrollbar_thumb = '#93a1a1',
    },

    appearance = {
        window_background_opacity = 0.96,
        macos_window_background_blur = 10,
        active_titlebar_bg = '#fdf6e3',
    },
}