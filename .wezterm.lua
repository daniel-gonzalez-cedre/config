-- pull in the wezterm api
local wezterm = require 'wezterm'

-- this will hold the configuration.
local config = wezterm.config_builder()

-- this is where you actually apply your config choices

config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
-- config.font = wezterm.font 'Berkeley Mono'
config.font = wezterm.font_with_fallback {
  'Berkeley Mono',
  'Fira Code Retina'
}
config.color_scheme = 'Gruvbox dark, hard (base16)'

-- config.colors = {
  -- foreground = '#ebdbb2',
  -- background = '#1d2021'
-- }

-- return the configuration to wezterm
return config
