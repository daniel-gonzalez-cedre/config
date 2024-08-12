-- pull in the wezterm api
local wezterm = require 'wezterm'

-- this will hold the configuration.
local config = wezterm.config_builder()

-- set window size
config.initial_rows = 48
config.initial_cols = 160

-- set tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = '#282828' } },
        { Text = ' ' .. title .. ' ' },
      }
    else
      return {
        { Background = { Color = '#1d2021' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
    return title
  end
)

-- set font
config.font_size = 11
config.font = wezterm.font_with_fallback {
  'Berkeley Mono',
  'Fira Code Retina'
}
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
-- config.font = wezterm.font 'Berkeley Mono'

config.default_cursor_style = "SteadyBlock"

-- set color scheme
config.color_scheme = 'GruvboxDark'
-- config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'Gruvbox dark, pale (base16)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'
config.bold_brightens_ansi_colors = 'BrightAndBold'

-- config.colors = {
  -- foreground = '#ebdbb2',
  -- background = '#1d2021'
-- }

return config
