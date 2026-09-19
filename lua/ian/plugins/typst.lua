return {
  "chomosuke/typst-preview.nvim",
  ft = "typst",
  build = "npm install", -- required for the web viewer components
  keys = {
    { "<leader>tw", "<cmd>TypstPreview<CR>", desc = "Toggle Typst Preview" },
  },
  opts = {
    executable = "tinymist",
    scroll_sync = true,
  },
}
