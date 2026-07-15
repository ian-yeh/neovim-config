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
      -- Keymap <leader>tw to toggle the Typst preview (watch)
      { "<leader>tw", ":TypstPreview<CR>", mode = "n", desc = "Toggle Typst Preview" },
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

      -- LSP keymaps are defined globally in lua/ian/plugins/lsp/lspconfig.lua
    end,
  },
}
