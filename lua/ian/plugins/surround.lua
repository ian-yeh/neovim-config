return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  config = true,
}
-- COMMANDS
-- ysiw( (add parentheses around the text)
-- ys0 or ys$, add to cursor to start or end
-- cs[first][after] replace nearest [first] with [after]

