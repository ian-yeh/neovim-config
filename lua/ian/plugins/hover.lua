-- K shows LSP docs, diagnostics, man pages (C), GitHub issues/PRs (#123); <C-n>/<C-p> switch source
return {
  "lewis6991/hover.nvim",
  keys = {
    { "K", function() require("hover").open() end, desc = "Hover (LSP/diagnostic/man/gh)" },
    { "gK", function() require("hover").enter() end, desc = "Enter hover window" },
    { "<C-n>", function() require("hover").switch("next") end, desc = "Hover: next source" },
    { "<C-p>", function() require("hover").switch("previous") end, desc = "Hover: previous source" },
  },
  config = function()
    require("hover").config({
      providers = {
        "hover.providers.diagnostic",
        "hover.providers.lsp",
        "hover.providers.man",
        "hover.providers.gh",
        "hover.providers.gh_user",
        "hover.providers.fold_preview",
      },
      preview_opts = { border = "rounded" },
    })
  end,
}
