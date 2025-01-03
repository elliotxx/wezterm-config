local Config = require("config")

require("utils.backdrops"):set_files():random()

require("events.gui-startup").setup()
require("events.tab-title").setup()
require("events.update-right-status").setup()
require("events.new-tab-button").setup()

return Config:init()
	:append(require("config.appearance"))
	:append(require("config.bindings"))
	:append(require("config.domains"))
	:append(require("config.fonts"))
	:append(require("config.general"))
	:append(require("config.launch")).options
