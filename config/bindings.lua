local wezterm = require('wezterm')
local platform = require('utils.platform')()
local act = wezterm.action

local mod = {}

if platform.is_mac then
    mod.SUPER = 'SUPER'
    mod.SUPER_REV = 'SUPER|SHIFT'
elseif platform.is_win or platform.is_linux then
    mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
    mod.SUPER_REV = 'ALT|CTRL'
end

-- stylua: ignore
local keys = {
    -- misc/useful --
    { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
    { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
    { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
    { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
    {
        key = 'F5',
        mods = 'NONE',
        action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
    },
    -- toggle fullscreen
    { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
    { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },
    { key = 'f',   mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = '' }) },
    {
        key = 'u',
        mods = mod.SUPER,
        action = wezterm.action.QuickSelectArgs({
            label = 'open url',
            patterns = {
                'https?://\\S+',
            },
            action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.open_with(url)
            end),
        }),
    },
    { key = 'q',          mods = mod.SUPER,     action = wezterm.action.QuitApplication },
    -- Make Super-Left equivalent to Alt-b which many line editors interpret as backward-word
    { key = 'LeftArrow',  mods = 'OPT',         action = act.SendString '\x1bb' },
    -- Make Super-Right equivalent to Alt-f; forward-word
    { key = 'RightArrow', mods = 'OPT',         action = act.SendString '\x1bf' },


    -- copy/paste --
    -- { key = 'c', mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
    -- { key = 'v', mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },
    { key = 'c',          mods = mod.SUPER,     action = act.CopyTo('Clipboard') },
    { key = 'v',          mods = mod.SUPER,     action = act.PasteFrom('Clipboard') },

    -- tabs --
    -- tabs: spawn+close
    { key = 't',          mods = mod.SUPER,     action = act.SpawnCommandInNewTab { cwd = wezterm.home_dir, domain = 'DefaultDomain' } },
    { key = 't',          mods = mod.SUPER_REV, action = act.SpawnTab({ DomainName = 'WSL:Ubuntu' }) },
    { key = 'w',          mods = mod.SUPER_REV, action = act.CloseCurrentTab({ confirm = false }) },

    -- tabs: navigation
    { key = '[',          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
    { key = ']',          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
    { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
    { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

    -- SUPER + number to activate that tab
    { key = '1',          mods = mod.SUPER,     action = act.ActivateTab(0) },
    { key = '2',          mods = mod.SUPER,     action = act.ActivateTab(1) },
    { key = '3',          mods = mod.SUPER,     action = act.ActivateTab(2) },
    { key = '4',          mods = mod.SUPER,     action = act.ActivateTab(3) },
    { key = '5',          mods = mod.SUPER,     action = act.ActivateTab(4) },
    { key = '6',          mods = mod.SUPER,     action = act.ActivateTab(5) },
    { key = '7',          mods = mod.SUPER,     action = act.ActivateTab(6) },
    { key = '8',          mods = mod.SUPER,     action = act.ActivateTab(7) },
    { key = '9',          mods = mod.SUPER,     action = act.ActivateTab(8) },

    -- window --
    -- spawn windows
    { key = 'n',          mods = mod.SUPER,     action = act.SpawnCommandInNewWindow { cwd = wezterm.home_dir, domain = 'DefaultDomain' } },

    -- panes --
    -- panes: split panes
    {
        key = [[\]],
        mods = mod.SUPER_REV,
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = [[\]],
        mods = mod.SUPER,
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    -- panes: zoom+close pane
    { key = 'Enter', mods = mod.SUPER,     action = act.TogglePaneZoomState },
    { key = 'w',     mods = mod.SUPER,     action = act.CloseCurrentPane({ confirm = false }) },

    -- panes: navigation
    { key = 'k',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
    { key = 'j',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
    { key = 'h',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
    { key = 'l',     mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },
    {
        key = 'p',
        mods = mod.SUPER_REV,
        action = act.PaneSelect({ alphabet = '1234567890', mode = 'SwapWithActiveKeepFocus' }),
    },

    -- font_size
    -- Increases the font size of the current window by 10%
    { key = '=', mods = mod.SUPER, action = act.IncreaseFontSize },
    -- Decreases the font size of the current window by 10%
    { key = '-', mods = mod.SUPER, action = act.DecreaseFontSize },

    -- key-tables --
    -- resizes fonts
    {
        key = 'f',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_font',
            one_shot = false,
            timeout_milliseconds = 1000,
        }),
    },
    -- resize panes
    {
        key = 'p',
        mods = 'LEADER',
        action = act.ActivateKeyTable({
            name = 'resize_pane',
            one_shot = false,
            timeout_milliseconds = 1000,
        }),
    },
}

-- stylua: ignore
local key_tables = {
    resize_font = {
        { key = 'k',      action = act.IncreaseFontSize },
        { key = 'j',      action = act.DecreaseFontSize },
        { key = 'r',      action = act.ResetFontSize },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
    resize_pane = {
        { key = 'k',      action = act.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'j',      action = act.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'h',      action = act.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'l',      action = act.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'Escape', action = 'PopKeyTable' },
        { key = 'q',      action = 'PopKeyTable' },
    },
}

local mouse_bindings = {
    -- Ctrl-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = 'Left' } },
        mods = mod.SUPER,
        action = act.OpenLinkAtMouseCursor,
    },
}

return {
    disable_default_key_bindings = true,
    leader = { key = 'Space', mods = mod.SUPER_REV },
    keys = keys,
    key_tables = key_tables,
    mouse_bindings = mouse_bindings,
}
