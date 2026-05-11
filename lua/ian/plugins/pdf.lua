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
      -- Plugin sets up keymaps on BufEnter automatically:
      -- n = next page, p = prev page
      -- z = zoom in, q = zoom out, e = reset zoom
      require("pdfreader").setup()

      -- Just set text mode for faster loading
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.pdf",
        callback = function()
          vim.defer_fn(function()
            vim.cmd("PDFReader setViewMode text")
          end, 300)
        end,
      })

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
