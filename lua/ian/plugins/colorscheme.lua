return {
  -- tokyo colorscheme
  {
    "folke/tokyonight.nvim",
    priority = 200,
    config = function()
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"
      
      require("tokyonight").setup({
        style = "night",
        transparent = true,  -- Enable transparency
        styles = {
          sidebars = "dark",  -- Keep sidebars with color (not transparent)
          floats = "dark",    -- Keep floats with color
        },
        on_colors = function(colors)
          -- Remove bg and bg_dark to keep transparency
          -- colors.bg = bg  -- REMOVE THIS
          -- colors.bg_dark = bg_dark  -- REMOVE THIS
          -- colors.bg_float = bg_dark  -- REMOVE THIS
          -- colors.bg_popup = bg_dark  -- REMOVE THIS
          -- colors.bg_sidebar = bg_dark  -- REMOVE THIS
          -- colors.bg_statusline = bg_dark  -- REMOVE THIS
          
          -- Keep these custom colors
          colors.bg_highlight = bg_highlight
          colors.bg_search = bg_search
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  -- catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 200,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
      })
      --vim.cmd([[colorscheme catppuccin]])
    end,
  },
}
