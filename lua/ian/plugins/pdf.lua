return {
  -- snacks.nvim is required for pdfreader.nvim image rendering
  {
    "folke/snacks.nvim",
    lazy = true,
    opts = {
      -- Enable only image module (disable unused modules for faster startup)
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      terminal = { enabled = false },
      toggle = { enabled = false },
      which = { enabled = false },
      words = { enabled = false },
      -- Only enable what we need for PDFs
      image = {
        enabled = true,
        -- no inline images inside documents (html, markdown, ...)
        doc = { enabled = false },
        -- default formats minus pdf, so pdfreader.nvim owns *.pdf
        formats = {
          "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff",
          "heic", "avif", "mp4", "mov", "avi", "mkv", "webm", "icns",
        },
      },
    },
  },
  {
    "r-pletnev/pdfreader.nvim",
    ft = "pdf",
    keys = { { "<leader>fp", desc = "Find PDF files" } },
    dependencies = {
      "folke/snacks.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- pdfreader only checks $TERM (validation.lua:6), and ghostty reports
      -- xterm-256color here. tmux is already handled by its own $TMUX check.
      if vim.env.TERM_PROGRAM == "ghostty" and not vim.env.TMUX then
        vim.env.TERM = "xterm-ghostty"
      end

      -- Plugin sets up keymaps on BufEnter automatically:
      -- n = next page, p = prev page
      -- z = zoom in, q = zoom out, e = reset zoom
      require("pdfreader").setup()

      -- Telescope integration for finding PDFs
      vim.keymap.set("n", "<leader>fp", function()
        require("telescope.builtin").find_files({
          prompt_title = "Find PDFs",
          find_command = { "fd", "--type", "f", "--extension", "pdf" },
        })
      end, { desc = "Find PDF files" })

      -- Quick switch commands
      vim.keymap.set("n", "<leader>vs", ":PDFReader setViewMode standard<CR>",
        { desc = "PDF: Standard view (images)" })
      vim.keymap.set("n", "<leader>vd", ":PDFReader setViewMode dark<CR>",
        { desc = "PDF: Dark view" })
      vim.keymap.set("n", "<leader>vt", ":PDFReader setViewMode text<CR>",
        { desc = "PDF: Text only (fast)" })
    end,
  },
}
