return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false, -- needed to hijack netrw and for nvim-lsp-file-operations hooks
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>ee", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    { "<leader>ef", "<cmd>Neotree reveal<CR>", desc = "Reveal current file in explorer" },
    { "<leader>eg", "<cmd>Neotree float git_status<CR>", desc = "Git status (float)" },
    { "<leader>eb", "<cmd>Neotree float buffers<CR>", desc = "Open buffers (float)" },
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    window = {
      width = math.floor(vim.o.columns * 0.25),
      mappings = {
        ["<space>"] = "none", -- keep <leader> usable inside the tree
        ["l"] = "open",
        ["h"] = "close_node",
        ["v"] = "open_vsplit",
        ["s"] = "open_split",
        ["n"] = "add",
        ["P"] = { "toggle_preview", config = { use_float = true } },
      },
    },
    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { ".git", "node_modules", "__pycache__", ".cache" },
        never_show = { ".DS_Store" },
      },
    },
  },
}
