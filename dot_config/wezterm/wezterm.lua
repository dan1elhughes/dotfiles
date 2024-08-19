local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local appearance = require 'appearance'

if appearance.is_dark() then
  config.color_scheme = 'Ayu Mirage'
else
  config.color_scheme = 'Ayu Light (Gogh)'
end

config.font_size = 18
config.font = wezterm.font({ family = 'Twilio Sans Mono' })
config.line_height = 1.2

config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font({ family = 'Twilio Sans Mono', weight = 'Bold' }),
}

config.keys = {
  {
    key = 'd',
    mods = 'SUPER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'd',
    mods = 'SUPER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
}

return config
