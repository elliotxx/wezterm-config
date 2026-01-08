# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 架构概览

这是一个模块化的 WezTerm 配置，使用 Lua 编写。核心设计采用了链式配置模式，将不同关注点的配置分离到独立的模块中。

### 主入口 (`wezterm.lua`)

配置通过 `Config:init():append()` 链式模式构建：

```lua
return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options
```

**重要**: `backdrops:set_files():random()` 必须在主入口调用，因为 `wezterm.read_dir()` 在初始加载时只能在 `wezterm.lua` 中执行（其运行在子进程中，其他地方调用会抛出协程错误）。

### Config 类 (`config/init.lua`)

`Config` 类使用元表模式提供 `:append()` 方法，会将新配置合并到 `options` 表中。如果遇到重复的配置键，会发出警告并跳过。

### 模块结构

- **`config/`** - 配置模块，每个文件返回一个 WezTerm 配置表
- **`events/`** - 事件处理器，通过 `wezterm.on()` 注册钩子
- **`utils/`** - 工具模块，提供通用功能
- **`colors/`** - 颜色方案模块
- **`backdrops/`** - 背景图片目录

## 平台检测

使用 `utils.platform()` 检测当前平台：

```lua
local platform = require('utils.platform')()

if platform.is_mac then
    -- macOS 特定配置
elseif platform.is_win then
    -- Windows 特定配置
elseif platform.is_linux then
    -- Linux 特定配置
end
```

返回的表包含 `os`, `is_win`, `is_linux`, `is_mac` 字段。

## 修饰键约定

配置使用平台感知的修饰键：

- **macOS**: `SUPER` = `SUPER`, `SUPER_REV` = `SUPER|SHIFT`
- **Windows/Linux**: `SUPER` = `ALT`, `SUPER_REV` = `ALT|CTRL`

统一的 `LEADER` 键定义为 `SUPER_REV` + `Space`。

## 关键表格 (Key Tables)

配置定义了两个 key tables，通过 leader 键进入：

- `resize_font` (LEADER+f): 使用 j/k 调整字体大小
- `resize_pane` (LEADER+p): 使用 h/j/k/l 调整面板大小

退出 key table 使用 `q` 或 `Escape`。

## BackDrops 模块使用

`utils/backdrops.lua` 提供背景图片管理：

```lua
local backdrops = require('utils.backdrops')

-- 必须在 wezterm.lua 初始化时调用
require('utils.backdrops'):set_files():random()

-- 在 key bindings 中通过回调使用
action = wezterm.action_callback(function(window, _pane)
    backdrops:random(window)
end)
```

可用的方法：`:random()`, `:cycle_forward()`, `:cycle_back()`, `:set_img(window, idx)`, `:choices()`。

## 事件处理器

事件模块在 `events/` 目录下，每个模块通过 `setup()` 函数注册事件：

```lua
require('events.right-status').setup()
require('events.tab-title').setup()
require('events.new-tab-button').setup()
```

事件处理器内部使用 `wezterm.on()` 注册具体的钩子。

## 主题系统

### 主题切换

主题通过 `config/theme.lua` 指定当前使用的主题名称：

```lua
return 'solarized_light'  -- 可选: 'solarized_light', 'dracula', 'custom'
```

修改这个文件即可切换主题，配套的外观配置（透明度、模糊、标题栏颜色）会自动应用。

### 主题文件结构

主题文件位于 `colors/` 目录，使用 Lua 格式：

```lua
return {
    name = 'Solarized Light',

    colors = {
        foreground = '#657b83',
        background = '#fdf6e3',
        ansi = { ... },
        brights = { ... },
        tab_bar = { ... },
        -- ... 其他颜色配置
    },

    appearance = {
        window_background_opacity = 0.96,
        macos_window_background_blur = 10,
        active_titlebar_bg = '#fdf6e3',
    },
}
```

`appearance.lua` 会动态读取指定主题的 `colors` 表和 `appearance` 配置，并合并到 WezTerm 配置中。

### 创建新主题

要添加新主题，在 `colors/` 创建新的 Lua 文件，包含 `colors` 和可选的 `appearance` 部分，然后更新 `config/theme.lua` 引用。

## 全局状态

使用 `wezterm.GLOBAL.background` 存储当前背景图片路径，确保在配置重载和 window 之间共享状态。