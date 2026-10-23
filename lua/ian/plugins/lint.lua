return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
    }

    local eslint_configs = {
      "eslint.config.js", "eslint.config.mjs", "eslint.config.cjs", "eslint.config.ts",
      ".eslintrc", ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.json", ".eslintrc.yml", ".eslintrc.yaml",
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        -- eslint_d errors out in projects without an eslint config
        local linters = lint.linters_by_ft[vim.bo.filetype] or {}
        if linters[1] == "eslint_d" and not vim.fs.root(0, eslint_configs) then
          return
        end
        lint.try_lint()
      end,
    })
  end,
}
