return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>mp",
      function() require("conform").format({ lsp_format = "fallback" }) end,
      mode = { "n", "v" },
      desc = "Format file or range",
    },
  },
  opts = {
    -- filetypes not listed (C/C++ via clangd, Go via gopls, ...) fall back to LSP formatting
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat then
        return
      end
      return { lsp_format = "fallback", timeout_ms = 1000 }
    end,
  },
  init = function()
    vim.keymap.set("n", "<leader>mt", function()
      vim.g.disable_autoformat = not vim.g.disable_autoformat
      vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
    end, { desc = "Toggle format on save" })
  end,
}
