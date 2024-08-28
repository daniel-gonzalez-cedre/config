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
config.show_new_tab_button_in_tab_bar = false

-- function tab_title(tab_info)
  -- local title = tab_info.tab_title
  -- -- if the tab title is explicitly set, take that
  -- if title and #title > 0 then
    -- return title
  -- end
  -- -- Otherwise, use the title from the active pane
  -- -- in that tab
  -- return tab_info.active_pane.title
-- end

-- wezterm.on(
  -- 'format-tab-title',
  -- function(tab, tabs, panes, config, hover, max_width)
    -- local title = tab_title(tab)
    -- if tab.is_active then
      -- return {
        -- { Background = { Color = '#282828' } },
        -- { Text = ' ' .. tab_title(tab) .. ' ' },
      -- }
    -- else
      -- return {
        -- { Background = { Color = '#1d2021' } },
        -- { Text = ' ' .. tab_title(tab) .. ' ' },
      -- }
    -- end
    -- return
  -- end
-- )

-- set cursor
config.default_cursor_style = "SteadyBlock"

-- set font
-- config.font_size = 11
config.font_size = 18
-- config.font = wezterm.font 'Berkeley Mono'
config.font = wezterm.font_with_fallback {
  'Berkeley Mono',
  'CommitMono-400-01111-00000011000',
  'Fira Code Retina'
}
-- config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}

-- set color scheme
-- config.color_scheme = 'GruvboxDark'
-- config.color_scheme = 'GruvboxDarkHard'
config.color_scheme = 'Gruvbox dark, pale (base16)'
-- config.color_scheme = 'Gruvbox dark, medium (base16)'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
-- config.color_scheme = 'Gruvbox Dark (Gogh)'

-- local scheme = wezterm.color.get_builtin_schemes()['Gruvbox dark, pale (base16)']
-- scheme.black = '#282828'
-- wezterm.on('window-config-reloaded', function(window, pane)
  -- window:set_config_overrides {
    -- color_scheme = scheme,
  -- }
-- end)

config.bold_brightens_ansi_colors = 'BrightAndBold'

config.colors = {
  tab_bar = {
    background = '#1c1c1c',
    -- background = '#1d2021',
    active_tab = {
      bg_color = '#282828',
      fg_color = '#d4be98',

      italic = false,
      strikethrough = false,
      intensity = 'Normal',
      underline = 'None',
    },
    inactive_tab = {
      bg_color = '#1d2021',
      -- fg_color = '#7c6f64',
      fg_color = '#928374',
    },
    inactive_tab_hover = {
      bg_color = '#1d2021',
      fg_color = '#7c6f64',
    },
  },
  -- foreground = '#ebdbb2',
  -- -- background = '#1d2021'
  background = '#262626',
  -- ansi = {
    -- '#262626',  -- black
    -- '#ff8700',  -- orange
    -- '#afaf00',  -- green
    -- '#ffaf00',  -- yellow
    -- '#83adad',  -- blue
    -- '#d485ad',  -- purple
    -- '#85ad85',  -- aqua
    -- '#ebdbb2',  -- ++++
  -- },
  -- brights = {
    -- '#282828',  -- ----
    -- '#d75f5f',  -- red
    -- '#afaf00',  -- green
    -- '#ffaf00',  -- yellow
    -- '#83adad',  -- blue
    -- '#d485ad',  -- purple
    -- '#85ad85',  -- aqua
    -- '#ebdbb2',  -- ++++
  -- }
  -- ansi = {
    -- '#282828',  -- ----
    -- '#3a3a3a',  -- ---
    -- '#4e4e4e',  -- --
    -- '#8a8a8a',  -- -
    -- '#949494',  -- +
    -- '#dab997',  -- ++
    -- '#d5c4a1',  -- +++
    -- '#ebdbb2',  -- ++++
  -- },
  -- brights = {
    -- '#ff8700',  -- orange
    -- '#d75f5f',  -- red
    -- '#afaf00',  -- green
    -- '#ffaf00',  -- yellow
    -- '#83adad',  -- blue
    -- '#d485ad',  -- purple
    -- '#85ad85',  -- aqua
    -- '#d65d0e',  -- brown
  -- }
}

config.keys = {
  { key = 'r',  -- command for setting custom tab titles
    mods = 'CMD|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = 'p',  -- command for moving tab left
    mods = 'CMD|SHIFT',
    action = wezterm.action.MoveTabRelative(-1),
  },
  { key = 'n',  -- command for moving tab right
    mods = 'CMD|SHIFT',
    action = wezterm.action.MoveTabRelative(1),
  },
  { key = '-',  -- disable font decrease mapping
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  { key = '=',  -- disable font increase mapping
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
}

return config
