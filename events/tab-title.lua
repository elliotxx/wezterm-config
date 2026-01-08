local wezterm = require('wezterm')

-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614

local GLYPH_SEPARATOR = '│' -- box drawing light vertical
local GLYPH_CIRCLE = '' -- nf.fa_circle
local GLYPH_ADMIN = '󰞀' -- nf.md_shield_half_full

local M = {}

local __cells__ = {}

-- 从主题文件读取 tab_title 颜色
local current_theme_name = require('config.theme')
local theme = require('colors.' .. current_theme_name)
local tab_bar = theme.colors.tab_bar

-- 根据 theme 名称适配配色
local is_solarized_light = current_theme_name == 'solarized_light'

local bg_color
local colors

if is_solarized_light then
   -- Solarized Light 适配配色
   bg_color = '#eee8d5'  -- 浅米色背景
   colors = {
      default = { bg = bg_color, fg = '#657b83' },
      is_active = { bg = '#839496', fg = '#fdf6e3' },
      hover = { bg = '#dcd3ba', fg = '#586e75' },
   }
else
   -- 默认/其他配色
   bg_color = tab_bar and tab_bar.background or '#45475a'
   colors = theme.tab_title or {
      default = { bg = bg_color, fg = '#1c1b19' },
      is_active = { bg = bg_color, fg = '#11111b' },
      hover = { bg = bg_color, fg = '#1c1b19' },
   }
end
local unseen_output_color = theme.tab_title and theme.tab_title.unseen_output or '#FFA066'
local separator_color = is_solarized_light and '#839496' or (tab_bar and tab_bar.active_tab and tab_bar.active_tab.bg_color or '#7fb4ca')

local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

local _set_title = function(process_name, base_title, max_width, inset)
   local title
   inset = inset or 6

   if process_name:len() > 0 then
      title = process_name .. ' ~ ' .. base_title
   else
      title = base_title
   end

   if title:len() > max_width - inset then
      local diff = title:len() - max_width + inset
      title = wezterm.truncate_right(title, title:len() - diff)
   end

   return title
end

local _check_if_admin = function(p)
   if p:match('^Administrator: ') then
      return true
   end
   return false
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

M.setup = function()
   wezterm.on('format-tab-title', function(tab, tabs, _panes, _config, hover, max_width)
      __cells__ = {}

      local bg
      local fg
      local process_name = _set_process_name(tab.active_pane.foreground_process_name)
      local is_admin = _check_if_admin(tab.active_pane.title)
      local title = _set_title(process_name, tab.active_pane.title, max_width, (is_admin and 8))

      if tab.is_active then
         bg = colors.is_active.bg
         fg = colors.is_active.fg
      elseif hover then
         bg = colors.hover.bg
         fg = colors.hover.fg
      else
         bg = colors.default.bg
         fg = colors.default.fg
      end

      local has_unseen_output = false
      for _, pane in ipairs(tab.panes) do
         if pane.has_unseen_output then
            has_unseen_output = true
            break
         end
      end

      -- Title
      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- Admin Icon
      if is_admin then
         _push(bg, fg, { Intensity = 'Bold' }, GLYPH_ADMIN .. ' ')
      end

      _push(bg, fg, { Intensity = 'Bold' }, title)

      -- Unseen output alert
      if has_unseen_output then
         _push(bg, unseen_output_color, { Intensity = 'Bold' }, ' ' .. GLYPH_CIRCLE)
      end

      -- Right padding
      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- Right separator (only if not the last tab)
      if tab.tab_index ~= #tabs then
         _push(bg, tab_bar.inactive_tab.fg_color, { Intensity = 'Normal' }, ' ')
         _push(bg, separator_color, { Intensity = 'Normal' }, GLYPH_SEPARATOR)
      end

      return __cells__
   end)
end

return M
