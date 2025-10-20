return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")
    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" })
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
    
    local function open_tab_silent(node)
      local api = require("nvim-tree.api")
      local view = require("nvim-tree.view")
      
      -- Open the file in a new tab
      vim.cmd("tabnew " .. node.absolute_path)
      
      -- Keep nvim-tree open in the new tab if desired
      if not view.is_visible() then
        api.tree.open()
      end
    end

    local function my_on_attach(bufnr)
      local api = require('nvim-tree.api')
      local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end
      -- Default mappings
      api.config.mappings.default_on_attach(bufnr)
      -- Custom function to open file in new tab and keep tree open
      local function open_file_in_new_tab()
        local node = api.tree.get_node_under_cursor()
        if node.type == "file" then
          -- Open file in new tab
          vim.cmd("tabnew " .. node.absolute_path)
          -- Switch back to the previous tab temporarily to keep tree context
          vim.cmd("tabprevious")
          -- Open nvim-tree in the new tab
          vim.cmd("tabnext")
          api.tree.open()
          -- Focus on the file buffer instead of nvim-tree
          vim.cmd("wincmd l") -- move cursor to the right window (the file)
        end
      end
      -- Custom mappings for tabs
      vim.keymap.set('n', 't', open_file_in_new_tab, opts('Open in New Tab'))
      vim.keymap.set('n', '<C-t>', open_file_in_new_tab, opts('Open in New Tab (Ctrl+t)'))
    end
    -- Apply the custom keymap
    nvimtree.setup({
      -- ... your existing config ...
      on_attach = my_on_attach,
      -- ... rest of config
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          quit_on_open = false, -- don't close tree when opening file
          resize_window = false, -- don't resize when opening file
        },
      },
      filters = {
        custom = { ".DS_Store" },
        dotfiles = false,
      },
      git = {
        ignore = false,
      },
      -- Configure tab behavior
      tab = {
        sync = {
          open = true,   -- opens the tree when a new tab is created
          close = true,  -- closes the tree when a tab is closed
        },
      },
    })
  end
}
