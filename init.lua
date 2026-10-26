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

      highlight NeoTreeNormal guibg=NONE ctermbg=NONE
      highlight NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE
      highlight NeoTreeNormalNC guibg=NONE ctermbg=NONE
      highlight NeoTreeWinSeparator guibg=NONE ctermbg=NONE
      highlight NeoTreeCursorLine guibg=NONE ctermbg=NONE
    ]])
  end,
})
