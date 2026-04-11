-- ~/.config/nvim/lua/plugins/typst.lua

return {
  -- 1. Typst Preview Plugin: chomosuke/typst-preview.nvim
  {
    "chomosuke/typst-preview.nvim",
    ft = { "typst" }, -- Only load this plugin for .typst files
    build = "npm install", -- Required for the web viewer components
    dependencies = {
      -- Ensure nvim-lspconfig is available for LSP setup
      "neovim/nvim-lspconfig",
      -- Optional: For easier LSP server management (like auto-installing tinymist)
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    keys = {
      -- Keymap <leader>tp to toggle the Typst preview
      { "<leader>tp", ":TypstPreview<CR>", mode = "n", desc = "Toggle Typst Preview" },
    },
    config = function()
      require("typst-preview").setup({
        executable = "tinymist", -- Configure to use 'tinymist' for rendering
        scroll_sync = true,      -- Enable scroll synchronization (cursor follow)
        -- You can add other options here if needed, e.g.:
        -- default_browser = "chromium", -- Specify your preferred browser
      })
    end,
  },

  -- 2. LSP Configuration for Tinymist via nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- Setup tinymist as the LSP server for Typst files
      lspconfig.tinymist.setup({
        filetypes = { "typst" },
        root_dir = function(fname)
          -- Defines how the LSP server finds the project root
          -- It looks for 'typst.toml', 'main.typ', or a '.git' directory
          return require("lspconfig.util").root_pattern("typst.toml", "main.typ", ".git")(fname)
            or require("lspconfig.util").find_git_ancestor(fname)
        end,
        settings = {
          -- Optional: Tinymist specific settings
          tinymist = {
            exportPdf = "onSave", -- Export PDF automatically on save
            -- For example, to pass custom font paths to the Typst compiler:
            -- compile = {
            --   args = { "--font-path", "/usr/share/fonts/typst" }
            -- }
          },
        },
      })

      -- Ensure tinymist is installed if you use Mason
      mason_lspconfig.setup({
        ensure_installed = { "tinymist" },
      })

      -- Optional: Basic LSP keymaps (add these if you don't have them configured elsewhere)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP Go to Definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP Go to Declaration" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "LSP Go to References" })
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "LSP Go to Implementation" })
      vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "LSP Hover Documentation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    end,
  },
}
