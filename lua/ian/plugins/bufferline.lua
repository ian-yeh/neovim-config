return {
  "akinsho/bufferline.nvim",
  version = "*",
  opts = {
    options = {
      mode = "tabs",
      separator_style = "slant",
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        }
      },
      custom_filter = function(buf_number)
        if vim.bo[buf_number].filetype == "NvimTree" then
          return false
        end
        return true
      end,
    },
  },
}
