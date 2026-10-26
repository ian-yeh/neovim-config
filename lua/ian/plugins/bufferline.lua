return {
  "akinsho/bufferline.nvim",
  version = "*",
  lazy = false,
  keys = {
    -- [b / ]b (built in) cycle buffers
    { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Close buffer (keep window layout)" },
  },
  opts = {
    options = {
      separator_style = "slant",
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
