return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    local function fg(group)
      return function() return { fg = require("lualine.utils.utils").extract_highlight_colors(group, "fg") } end
    end

    -- theme follows whatever colorscheme is active (see colorscheme.lua)
    lualine.setup({
      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } } },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = fg("DiagnosticWarn"),
          },
          {
            function()
              return vim.g.mkdp_clients_active == 1 and "MD preview" or "MD preview (no tab)"
            end,
            cond = function()
              return vim.fn.exists("*mkdp#rpc#get_server_status") == 1 and vim.fn["mkdp#rpc#get_server_status"]() == 1
            end,
            color = fg("DiagnosticOk"),
          },
          { "filetype" },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
