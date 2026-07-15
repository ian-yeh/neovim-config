return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    [[<c-\>]],
    { "<leader>tt", desc = "Toggle floating terminal" },
    { "<leader>th", desc = "Toggle horizontal terminal" },
    { "<leader>tv", desc = "Toggle vertical terminal" },
    { "<leader>tg", desc = "Toggle lazygit" },
    { "<leader>1", desc = "Toggle terminal 1" },
    { "<leader>2", desc = "Toggle terminal 2" },
    { "<leader>3", desc = "Toggle terminal 3" },
    { "<leader>4", desc = "Toggle terminal 4" },
  },
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<c-\>]], -- Toggle with Ctrl+\
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- degree to dim terminal (1-3)
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- options: "vertical" | "horizontal" | "tab" | "float"
      close_on_exit = true,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Set terminal keymaps in the current terminal buffer
    local function set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- Exit terminal mode
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- Auto-set keymaps only for toggleterm buffers
    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*toggleterm#*",
      callback = set_terminal_keymaps,
    })

    -- Toggleterm user commands for different layouts
    local Terminal = require("toggleterm.terminal").Terminal

    local function start_insert()
      vim.cmd("startinsert!")
    end

    -- Floating terminal
    local float_term = Terminal:new({
      direction = "float",
      on_open = start_insert,
    })

    -- Horizontal bottom terminal
    local horizontal_term = Terminal:new({
      direction = "horizontal",
      on_open = start_insert,
    })

    -- Vertical side terminal
    local vertical_term = Terminal:new({
      direction = "vertical",
      on_open = start_insert,
    })

    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = start_insert,
      on_close = function(term)
        vim.cmd("checktime")
      end,
    })

    -- Keymaps for different terminal modes
    vim.keymap.set("n", "<leader>tt", function() float_term:toggle() end, { desc = "Toggle floating terminal" })
    vim.keymap.set("n", "<leader>th", function() horizontal_term:toggle() end, { desc = "Toggle horizontal terminal" })
    vim.keymap.set("n", "<leader>tv", function() vertical_term:toggle() end, { desc = "Toggle vertical terminal" })
    vim.keymap.set("n", "<leader>tg", function() lazygit:toggle() end, { desc = "Toggle lazygit" })

    -- Multiple terminals (numbered)
    vim.keymap.set("n", "<leader>1", "<Cmd>1ToggleTerm<CR>", { desc = "Toggle terminal 1" })
    vim.keymap.set("n", "<leader>2", "<Cmd>2ToggleTerm<CR>", { desc = "Toggle terminal 2" })
    vim.keymap.set("n", "<leader>3", "<Cmd>3ToggleTerm<CR>", { desc = "Toggle terminal 3" })
    vim.keymap.set("n", "<leader>4", "<Cmd>4ToggleTerm<CR>", { desc = "Toggle terminal 4" })
  end,
}
