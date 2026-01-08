local wezterm = require('wezterm')
local platform = require('utils.platform')()
local umath = require('utils.math')

-- 动态加载当前主题
local current_theme_name = require('config.theme')
local theme = require('colors.' .. current_theme_name)
local colors = theme.colors

local PATH_SEP = platform.is_win and '\\' or '/'

---@class BackDrops
---@field current_idx number index of current image
---@field files string[] background images
local BackDrops = {}
BackDrops.__index = BackDrops

--- Initialise backdrop controller
---@private
function BackDrops:init()
   local inital = {
      current_idx = 1,
      files = {},
   }
   local backdrops = setmetatable(inital, self)
   wezterm.GLOBAL.background = nil
   return backdrops
end

---MUST BE RUN BEFORE ALL OTHER `BackDrops` functions
---Sets the `files` after instantiating `BackDrops`.
---
--- INFO:
---   During the initial load of the config, this function can only invoked in `wezterm.lua`.
---   WezTerm's fs utility `read_dir` (used in this function) works by running on a spawned child process.
---   This throws a coroutine error if the function is invoked in outside of `wezterm.lua` in the -
---   initial load of the Terminal config.
function BackDrops:set_files()
   self.files = wezterm.read_dir(wezterm.config_dir .. PATH_SEP .. 'backdrops')
   wezterm.GLOBAL.background = self.files[1]
   return self
end

---Override the current window options for background
---@private
---@param window any WezTerm Window see: https://wezterm.org/config/lua/window/index.html
function BackDrops:_set_opt(window)
   local opacity = theme.appearance and theme.appearance.window_background_opacity or 0.96

   local opts = {
      background = {
         {
            source = { File = wezterm.GLOBAL.background },
         },
         {
            source = { Color = colors.background },
            height = '100%',
            width = '100%',
            opacity = opacity,
         },
      },
   }
   window:set_config_overrides(opts)
end

---Convert the `files` array to a table of `InputSelector` choices
---see: https://wezterm.org/config/lua/keyassignment/InputSelector.html
function BackDrops:choices()
   local choices = {}
   for idx, file in ipairs(self.files) do
      local name = file:match('([^' .. PATH_SEP .. ']+)$')
      table.insert(choices, {
         id = tostring(idx),
         label = name,
      })
   end
   return choices
end

---Select a random file and redefine the global `wezterm.GLOBAL.background` variable
---Pass in `Window` object to override the current window options
---@param window any? WezTerm `Window` see: https://wezterm.org/wezterm/config/lua/window/index.html
function BackDrops:random(window)
   self.current_idx = math.random(#self.files)
   wezterm.GLOBAL.background = self.files[self.current_idx]

   if window ~= nil then
      self:_set_opt(window)
   end
end

---Cycle the loaded `files` and select the next background
---@param window any WezTerm `Window` see: https://wezterm.org/config/lua/window/index.html
function BackDrops:cycle_forward(window)
   if self.current_idx == #self.files then
      self.current_idx = 1
   else
      self.current_idx = self.current_idx + 1
   end
   wezterm.GLOBAL.background = self.files[self.current_idx]
   self:_set_opt(window)
end

---Cycle the loaded `files` and select the previous background
---@param window any WezTerm `Window` see: https://wezterm.org/config/lua/window/index.html
function BackDrops:cycle_back(window)
   if self.current_idx == 1 then
      self.current_idx = #self.files
   else
      self.current_idx = self.current_idx - 1
   end
   wezterm.GLOBAL.background = self.files[self.current_idx]
   self:_set_opt(window)
end

---Set a specific background from the `files` array
---@param window any WezTerm `Window` see: https://wezterm.org/config/lua/window/index.html
---@param idx number index of the `files` array
function BackDrops:set_img(window, idx)
   if idx > #self.files or idx < 0 then
      wezterm.log_error('Index out of range')
      return
   end

   self.current_idx = idx
   wezterm.GLOBAL.background = self.files[self.current_idx]
   self:_set_opt(window)
end

return BackDrops:init()
