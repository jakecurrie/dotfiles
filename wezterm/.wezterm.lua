local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("MesloLGS NF")
config.font_size = 13
config.color_scheme = "Kanagawa (Gogh)"
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

return config
