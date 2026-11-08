return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  keys = {
    -- [b / ]b (built in) cycle buffers
    { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Close buffer (keep window layout)" },
  },
  opts = {
    -- per-theme tab colors come from lua/ian/theme.lua
    highlights = function(defaults)
      return vim.tbl_deep_extend("force", require("ian.theme").bufferline(defaults), {
        buffer_selected = { bold = false, italic = false },
      })
    end,
    options = {
      separator_style = "thin",
      indicator = { style = "none" },
      color_icons = false,
      tab_size = 20,
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "neo-tree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        }
      },
    },
  },
}
