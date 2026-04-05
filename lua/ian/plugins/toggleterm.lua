return {
  "akinsho/toggleterm.nvim",
  version = "*",
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
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })

    -- Function to set terminal keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- Exit terminal mode
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- Auto-set keymaps when terminal opens
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    -- Toggleterm user commands for different layouts
    local Terminal = require("toggleterm.terminal").Terminal

    -- Floating terminal
    local float_term = Terminal:new({
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- Horizontal bottom terminal
    local horizontal_term = Terminal:new({
      direction = "horizontal",
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- Vertical side terminal
    local vertical_term = Terminal:new({
      direction = "vertical",
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
      on_close = function(term)
        vim.cmd("checktime")
      end,
    })

    -- Global functions to toggle terminals
    function _G.toggle_float_term()
      float_term:toggle()
    end

    function _G.toggle_horizontal_term()
      horizontal_term:toggle()
    end

    function _G.toggle_vertical_term()
      vertical_term:toggle()
    end

    function _G.toggle_lazygit()
      lazygit:toggle()
    end

    -- Keymaps for different terminal modes
    vim.keymap.set("n", "<leader>tt", ":lua toggle_float_term()<CR>", { desc = "Toggle floating terminal" })
    vim.keymap.set("n", "<leader>th", ":lua toggle_horizontal_term()<CR>", { desc = "Toggle horizontal terminal" })
    vim.keymap.set("n", "<leader>tv", ":lua toggle_vertical_term()<CR>", { desc = "Toggle vertical terminal" })
    vim.keymap.set("n", "<leader>tg", ":lua toggle_lazygit()<CR>", { desc = "Toggle lazygit" })

    -- Multiple terminals (numbered)
    vim.keymap.set("n", "<leader>1", "<Cmd>1ToggleTerm<CR>", { desc = "Toggle terminal 1" })
    vim.keymap.set("n", "<leader>2", "<Cmd>2ToggleTerm<CR>", { desc = "Toggle terminal 2" })
    vim.keymap.set("n", "<leader>3", "<Cmd>3ToggleTerm<CR>", { desc = "Toggle terminal 3" })
    vim.keymap.set("n", "<leader>4", "<Cmd>4ToggleTerm<CR>", { desc = "Toggle terminal 4" })
  end,
}
