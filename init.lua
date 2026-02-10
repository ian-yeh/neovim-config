require("ian.core")
require("ian.lazy")

-- applying background transparency
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      highlight Normal guibg=NONE ctermbg=NONE
      highlight NonText guibg=NONE ctermbg=NONE
      highlight LineNr guibg=NONE ctermbg=NONE
      highlight SignColumn guibg=NONE ctermbg=NONE
      highlight StatusLine guibg=NONE ctermbg=NONE
      highlight StatusLineNC guibg=NONE ctermbg=NONE
      highlight NormalFloat guibg=NONE ctermbg=NONE

      highlight NvimTreeNormal guibg=NONE ctermbg=NONE
      highlight NvimTreeEndOfBuffer guibg=NONE ctermbg=NONE
      highlight NvimTreeVertSplit guibg=NONE ctermbg=NONE
      highlight NvimTreeNormalNC guibg=NONE ctermbg=NONE
      highlight NvimTreeWinSeparator guibg=NONE ctermbg=NONE
      highlight NvimTreeCursorLine guibg=NONE ctermbg=NONE
    ]])
  end,
})

vim.cmd([[colorscheme tokyonight-night]])
