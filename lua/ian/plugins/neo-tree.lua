return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false, -- needed to hijack netrw and for nvim-lsp-file-operations hooks
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  init = function()
    -- global explorer visibility: shown in every tab while on, hidden everywhere while off
    vim.g.neotree_visible = true

    local function tree_win()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "neo-tree" and vim.api.nvim_win_get_config(win).relative == "" then
          return win
        end
      end
    end

    local function sync()
      local open = tree_win() ~= nil
      if vim.g.neotree_visible and not open then
        vim.cmd("Neotree show")
      elseif not vim.g.neotree_visible and open then
        vim.cmd("Neotree close")
      end
    end

    vim.keymap.set("n", "<leader>ee", function()
      vim.g.neotree_visible = not vim.g.neotree_visible
      sync()
    end, { desc = "Toggle file explorer (all tabs)" })

    vim.api.nvim_create_autocmd("TabEnter", { callback = function() vim.schedule(sync) end })
    vim.api.nvim_create_autocmd("BufWinEnter", {
      callback = function(args)
        local ft = vim.bo[args.buf].filetype
        if vim.g.neotree_visible and vim.bo[args.buf].buftype == "" and ft ~= "gitcommit" and ft ~= "gitrebase" then
          vim.schedule(sync)
        end
      end,
    })
  end,
  keys = {
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
