vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.laststatus = 3 -- global statusline
opt.fillchars = { eob = " " } -- hide end-of-buffer ~ characters

-- tabbing and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = true -- word wrapping

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

-- autoread - automatically update when file changes
opt.autoread = true

-- persistent undo history
opt.undofile = true

-- treesitter folding, all folds open by default
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99

-- reopen files at the last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    if vim.bo[args.buf].filetype ~= "gitcommit" and mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- trigger autoread when changing buffers or after `focusgained` 
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "checktime",
  pattern = "*",
})

-- brace-based indent inside fenced code blocks in markdown
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.smartindent = true
  end,
})

-- spellcheck in prose filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "tex", "typst" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})
