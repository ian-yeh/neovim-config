return {
  "3rd/image.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    kitty_method = "normal",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
        filetypes = { "markdown", "vimwiki" },
      },
      neorg = {
        enabled = true,
        filetypes = { "norg" },
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    scale_factor = 1.0,
    window_overlap_clear_enabled = true,
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,
    tmux_show_only_in_active_window = false,
    -- This enables opening image files (png, jpg, etc) directly as images
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
  },
  config = function(_, opts)
    require("image").setup(opts)
    
    -- Set conceallevel for markdown (required for images to embed inline)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "vimwiki" },
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
    
    -- Keymaps for managing images
    vim.keymap.set("n", "<leader>ic", function()
      require("image").clear()
    end, { desc = "Clear images" })
    
    vim.keymap.set("n", "<leader>ir", function()
      require("image").clear()
      vim.cmd("edit!")
    end, { desc = "Refresh images" })
  end,
}
