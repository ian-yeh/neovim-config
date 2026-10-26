return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets", "fang2hou/blink-copilot" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = "none",
      ["<C-k>"] = { "select_prev", "fallback" }, -- previous suggestion
      ["<C-j>"] = { "select_next", "fallback" }, -- next suggestion
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "fallback" }, -- show completion suggestions
      ["<C-e>"] = { "cancel", "fallback" }, -- close completion window
      ["<CR>"] = { "accept", "fallback" },
    },
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      documentation = { auto_show = true },
      menu = {
        draw = {
          components = {
            label = { width = { fill = true, max = 50 } },
          },
        },
      },
    },
    -- vs-code like pictograms
    appearance = {
      nerd_font_variant = "mono",
    },
    -- sources for autocompletion
    sources = {
      default = { "lsp", "snippets", "buffer", "path", "copilot" },
      providers = {
        copilot = { name = "copilot", module = "blink-copilot", score_offset = 100, async = true },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
