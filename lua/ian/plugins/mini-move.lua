-- <M-h/j/k/l> moves the current line or visual selection
return {
  "echasnovski/mini.move",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
}
