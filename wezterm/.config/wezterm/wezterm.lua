local wezterm = require('wezterm')
local config = wezterm.config_builder()
wezterm.log_info("reloading")

require("tabs").setup(config)
require("keys").setup(config)
require("links").setup(config)
require("mouse").setup(config)

config.enable_wayland = true
config.webgpu_power_preference = "HighPerformance"
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- Colorscheme
local theme = require('rose-pine').main
config.colors = theme.colors()

-- Fonts
config.font = wezterm.font({ family = "BerkeleyMono Nerd Font"})
config.font_size = 14
config.bold_brightens_ansi_colors = true

config.underline_thickness = 3
config.cursor_thickness = 4
config.underline_position = -6

config.term = "wezterm"
config.window_decorations = "NONE"


-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.scrollback_lines = 10000



return config
