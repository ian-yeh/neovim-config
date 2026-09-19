return {
  "echasnovski/mini.icons",
  lazy = false,
  priority = 100,
  config = function()
    require("mini.icons").setup()
    require("mini.icons").mock_nvim_web_devicons()
  end,
}
