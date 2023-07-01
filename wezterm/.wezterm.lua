-- Pull in the wezterm API
local wezterm = require 'wezterm'

local schemes = wezterm.color.get_builtin_schemes()

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Dracula'
-- config.color_scheme = 'cyberpunk'
-- config.color_scheme = 'Duotone Dark'
-- config.color_scheme = 'Calamity'
-- config.color_scheme = 'ChallengerDeep'
-- config.color_scheme = 'jubi'
-- config.color_scheme = 'lovelace'
-- config.color_scheme = 'purplepeter'
-- config.color_scheme = 'Sakura'
-- config.color_scheme = 'tokyonight_moon'
-- config.color_scheme = 'Urple'
-- config.color_scheme = 'Whimsy'
config.color_scheme = 'duskfox'

config.show_tab_index_in_tab_bar = false

config.default_cursor_style = 'BlinkingBar'
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'
config.cursor_thickness = '1.5pt'
config.cursor_blink_rate = 500

config.font_size = 16.0

config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.

  font = wezterm.font { family = 'Roboto', weight = 'Regular' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 18.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = schemes[config.color_scheme].selection_bg,

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = schemes[config.color_scheme].selection_bg,
}

config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = schemes[config.color_scheme].selection_bg,

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = schemes[config.color_scheme].background,
      -- The color of the text for the tab
      fg_color = schemes[config.color_scheme].foreground,

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = schemes[config.color_scheme].selection_bg,
      fg_color =  schemes[config.color_scheme].selection_fg,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = schemes[config.color_scheme].brights[1],
      fg_color =  schemes[config.color_scheme].brights[8],
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = schemes[config.color_scheme].selection_bg,
      fg_color =  schemes[config.color_scheme].selection_fg,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = schemes[config.color_scheme].brights[1],
      fg_color =  schemes[config.color_scheme].brights[8],

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

-- and finally, return the configuration to wezterm
return config
