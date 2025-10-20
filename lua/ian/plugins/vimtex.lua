return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    -- VimTeX configuration
    vim.g.vimtex_view_method = "skim"
    vim.g.vimtex_compiler_method = "latexmk"
  end,
  config = function()
    -- Set up keymaps for LaTeX files
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "tex",
      callback = function()
        local opts = { buffer = true, silent = true }
        vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", opts)
        vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", opts)
        vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<CR>", opts)
        vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", opts)
        vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", opts)
        vim.keymap.set("n", "<leader>lg", "<cmd>VimtexStatus<CR>", opts)
      end,
    })
  end,
}
