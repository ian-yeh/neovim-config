return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && npm install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
    vim.g.mkdp_theme = "light"
    -- default closes the preview when the md buffer is hidden (e.g. switching to edit markdown.css)
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_markdown_css = vim.fn.stdpath("config") .. "/mkdp/markdown.css"
    -- plugin closes every preview tab on quit; drop that so tabs stay open
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        for _, au in ipairs(vim.api.nvim_get_autocmds({ event = "VimLeave" })) do
          if au.group_name and au.group_name:match("^MKDP_REFRESH_INIT") then
            vim.api.nvim_clear_autocmds({ event = "VimLeave", group = au.group })
          end
        end
      end,
    })
  end,
  ft = { "markdown" },
  keys = {
    {
      "<leader>md",
      -- built-in toggle stops the whole server (closing every buffer's tab); close only this buffer's
      function()
        if vim.b.MarkdownPreviewToggleBool == 1 then
          vim.fn["mkdp#rpc#preview_close"]()
        else
          vim.cmd("MarkdownPreview")
          vim.b.MarkdownPreviewToggleBool = 1
        end
      end,
      ft = "markdown",
      desc = "Toggle Markdown Preview",
    },
  },
}
