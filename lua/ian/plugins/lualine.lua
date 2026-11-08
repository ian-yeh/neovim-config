return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- monochrome: no background, mode in the text colour, everything else a grey between line-number and text.
    -- re-evaluated on every colorscheme change
    local function theme()
      local fg = function(g) return require("lualine.utils.utils").extract_highlight_colors(g, "fg") end
      local text, dim = fg("Normal"), fg("LineNr")
      -- nudge the grey 35% toward the text colour for a bit more contrast
      local function mix(a, b, t)
        local x, y = tonumber(a:sub(2), 16), tonumber(b:sub(2), 16)
        local out = 0
        for shift = 16, 0, -8 do
          local ca, cb = bit.band(bit.rshift(x, shift), 255), bit.band(bit.rshift(y, shift), 255)
          out = out + bit.lshift(math.floor(ca + (cb - ca) * t + 0.5), shift)
        end
        return string.format("#%06x", out)
      end
      dim = mix(dim, text, 0.35)
      local s = {
        a = { fg = text, bg = "NONE", gui = "bold" },
        b = { fg = dim, bg = "NONE" },
        c = { fg = dim, bg = "NONE" },
      }
      return { normal = s, insert = s, visual = s, replace = s, command = s, inactive = s }
    end

    lualine.setup({
      options = {
        theme = theme,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { { "diagnostics", colored = false, symbols = { error = " ", warn = " ", info = " ", hint = " " } } },
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
          },
          {
            function()
              return vim.g.mkdp_clients_active == 1 and "MD preview" or "MD preview (no tab)"
            end,
            cond = function()
              return vim.fn.exists("*mkdp#rpc#get_server_status") == 1 and vim.fn["mkdp#rpc#get_server_status"]() == 1
            end,
          },
          { "filetype", colored = false },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
