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
          vim.cmd("tabnew " .. node.absolute_path)
          vim.cmd("tabprevious")
          vim.cmd("tabnext")
          vim.cmd("wincmd l")
        end
      end
      -- Custom mappings for tabs
      vim.keymap.set('n', 't', open_file_in_new_tab, opts('Open in New Tab'))
      vim.keymap.set('n', '<C-t>', open_file_in_new_tab, opts('Open in New Tab (Ctrl+t)'))
      
      -- ADD THESE: Useful additional keymaps
      vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))  -- 'l' to open file/folder
      vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))  -- 'h' to close folder
      vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))  -- 'v' for vertical split
      vim.keymap.set('n', 's', api.node.open.horizontal, opts('Open: Horizontal Split'))  -- 's' for horizontal split
      vim.keymap.set('n', 'n', api.fs.create, opts('Create Node')) -- 'n' to create file/folder
      vim.keymap.set('n', 'd', api.fs.remove, opts('Delete Node')) -- 'd' to delete file/folder
      vim.keymap.set('n', 'r', api.fs.rename, opts('Rename Node')) -- 'r' to rename file/folder
      vim.keymap.set('n', 'y', api.fs.copy.node, opts('Copy Node')) -- 'y' to copy file/folder
      vim.keymap.set('n', 'x', api.fs.cut, opts('Cut Node')) -- 'x' to cut file/folder
      vim.keymap.set('n', 'p', api.fs.paste, opts('Paste Node')) -- 'p' to paste file/folder    
    end
    
    nvimtree.setup({
      on_attach = my_on_attach,
      
      -- ADD: Sort folders before files
      sort_by = "case_sensitive",
      
      view = {
        width = function()
          return math.floor(vim.opt.columns:get() * 0.2) -- 20% of screen width
        end,
        relativenumber = true,
        -- ADD: Show file size
        side = "left",
      },
      
      renderer = {
        -- ADD: Show git status and file icons
        add_trailing = false,
        group_empty = true,  -- Collapse empty folders
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "icon",  -- Highlight open files
        root_folder_label = false,
        
        indent_markers = {
          enable = true,
          inline_arrows = true,  -- Better looking arrows
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            none = " ",
          },
        },
        
        icons = {
          webdev_colors = true,  -- Colorful file icons
          git_placement = "before",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "",
            folder = {
              arrow_closed = "▶",
              arrow_open = "▼",
              default = "", -- Folder icon
              open = "", -- Open folder icon
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "🗑",
              ignored = "◌",
            },
          },
        },
      },
      
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
          quit_on_open = false,
          resize_window = true,  -- CHANGED: Auto-resize when opening files
        },
      },
      
      filters = {
        custom = { ".DS_Store", "^.git$", "node_modules", ".cache", "fuse", "gvfs", "__pycache__" },  -- ADD: More ignores
        dotfiles = false,
      },
      
      git = {
        enable = true,  -- ADDED: Explicitly enable git
        ignore = false,
        show_on_dirs = true,  -- Show git status on folders
        timeout = 400,
      },
      
      -- ADD: Show file diagnostics (errors/warnings)
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      
      -- ADD: Better update behavior
      update_focused_file = {
        enable = true,  -- Automatically find current file in tree
        update_root = false,
      },
      
      tab = {
        sync = {
          open = false,
          close = false,
        },
      },
    })
    
    -- Transparency
    vim.cmd([[
      highlight NvimTreeNormal guibg=NONE ctermbg=NONE
      highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
      highlight NvimTreeVertSplit guibg=NONE ctermbg=NONE
      highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
    ]])
  end
}
