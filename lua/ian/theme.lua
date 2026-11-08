-- Color profiles, keyed by profile name.
-- Default comes from "colorscheme" in config.json; switch live with :Theme <name>.
--   plugin       lazy.nvim spec for the theme
--   colorscheme  :colorscheme name, if different from the profile name
--   background   "dark" | "light"
--   transparent  false keeps the theme's own background (default: cleared)
--   opts         passed to the theme's setup()
--   hl           highlight overrides applied after the theme (neo-tree, markdown, ...)
--   tabs         bufferline colors: fill, bg/fg (inactive), sel_bg/sel_fg (active), border
local M = {}

M.profiles = {
  tokyonight = {
    plugin = { "folke/tokyonight.nvim" },
    background = "dark",
    opts = {
      style = "night",
      transparent = true,
      styles = { sidebars = "dark", floats = "dark" },
      on_colors = function(c)
        c.bg_highlight = "#143652"
        c.bg_search = "#0A64AC"
        c.bg_visual = "#275378"
        c.border = "#547998"
        c.fg, c.fg_float = "#CBE0F0", "#CBE0F0"
        c.fg_dark, c.fg_sidebar = "#B4D0E9", "#B4D0E9"
        c.fg_gutter = "#627E97"
      end,
    },
  },

  catppuccin = {
    plugin = { "catppuccin/nvim", name = "catppuccin" },
    background = "dark",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        neotree = true,
        gitsigns = true,
        lualine = {},
        indent_blankline = { enabled = true },
        native_lsp = { enabled = true },
      },
    },
  },

  -- matches Ghostty "GitHub Dark High Contrast"
  github_dark_high_contrast = {
    plugin = { "projekt0n/github-nvim-theme", name = "github-theme", main = "github-theme" },
    background = "dark",
    opts = { options = { transparent = true } },
    hl = {
      -- theme colours every markdown heading the same
      ["@markup.heading.1.markdown"] = { fg = "#ff9492", bold = true },
      ["@markup.heading.2.markdown"] = { fg = "#ffb757", bold = true },
      ["@markup.heading.3.markdown"] = { fg = "#71b7ff", bold = true },
      ["@markup.heading.4.markdown"] = { fg = "#cb9eff", bold = true },
      ["@markup.heading.5.markdown"] = { fg = "#72f088", bold = true },
      ["@markup.heading.6.markdown"] = { fg = "#f0b72f", bold = true },
      -- theme paints all of neo-tree white
      NeoTreeDirectoryIcon = { fg = "#cb9eff" },
      NeoTreeDirectoryName = { fg = "#dbb7ff" },
      NeoTreeFileNameOpened = { fg = "#72f088" },
      NeoTreeIndentMarker = { fg = "#525964" },
      NeoTreeExpander = { fg = "#525964" },
    },
  },

  -- matches VSCodium light
  ["vscode-light"] = {
    plugin = { "Mofiqul/vscode.nvim" },
    colorscheme = "vscode",
    background = "light",
    opts = { style = "light" },
    -- VSCodium "Light Modern" tabs
    tabs = { fill = "#F8F8F8", bg = "#F8F8F8", fg = "#868686", sel_bg = "#FFFFFF", sel_fg = "#3B3B3B", border = "#E5E5E5" },
    hl = {
      -- theme gives neo-tree's indent column a grey background
      NeoTreeIndentMarker = { fg = "#D2D2D2", bg = "NONE" },
      NeoTreeExpander = { fg = "#616161", bg = "NONE" },
      NeoTreeDimText = { fg = "#A0A0A0", bg = "NONE" },
    },
  },
}

M.specs = {}
for _, p in pairs(M.profiles) do
  table.insert(M.specs, vim.tbl_extend("force", p.plugin, { lazy = true, opts = p.opts }))
end

local function config()
  local f = io.open(vim.fn.stdpath("config") .. "/config.json")
  if not f then return {} end
  local ok, cfg = pcall(vim.json.decode, f:read("*a"))
  f:close()
  return ok and cfg or {}
end

local transparent_groups = { "Normal", "NonText", "LineNr", "SignColumn", "StatusLine", "StatusLineNC", "NormalFloat" }

local function profile_for(scheme)
  for name, p in pairs(M.profiles) do
    if (p.colorscheme or name) == scheme then return p end
  end
  return {}
end

local function clear_bufferline()
  for g in pairs(vim.api.nvim_get_hl(0, {})) do
    if g:find("^BufferLine") then vim.api.nvim_set_hl(0, g, {}) end
  end
end

-- bufferline only fills empty groups, so drop the previous theme's
vim.api.nvim_create_autocmd("ColorSchemePre", { callback = clear_bufferline })

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(args)
    local p = profile_for(args.match)
    if p.transparent ~= false then
      for _, g in ipairs(transparent_groups) do
        vim.cmd("highlight " .. g .. " guibg=NONE ctermbg=NONE")
      end
    end
    for g, v in pairs(p.hl or {}) do
      vim.api.nvim_set_hl(0, g, v)
    end
    -- drop the theme's own bufferline groups so `tabs` wins
    if p.tabs then clear_bufferline() end
  end,
})

-- bufferline calls this on every colorscheme change (see plugins/bufferline.lua)
function M.bufferline(defaults)
  local t = profile_for(vim.g.colors_name).tabs
  if not t then return {} end
  local hl = {}
  for k in pairs(defaults.highlights) do
    hl[k] = { bg = k:match("_selected$") and t.sel_bg or t.bg }
  end
  hl.fill.bg = t.fill
  for _, k in ipairs({ "separator", "separator_visible", "separator_selected", "offset_separator", "tab_separator", "tab_separator_selected" }) do
    hl[k].fg = t.border
  end
  for _, k in ipairs({ "background", "buffer_visible", "tab", "tab_close", "close_button", "close_button_visible" }) do
    hl[k].fg = t.fg
  end
  hl.buffer_selected.fg, hl.tab_selected.fg, hl.close_button_selected.fg = t.sel_fg, t.sel_fg, t.sel_fg
  return hl
end

function M.apply(name)
  name = name or config().colorscheme or "tokyonight"
  local p = M.profiles[name]
  if not p then
    return vim.notify("Unknown theme: " .. name, vim.log.levels.ERROR)
  end
  vim.o.background = p.background
  vim.cmd.colorscheme(p.colorscheme or name)
end

vim.api.nvim_create_user_command("Theme", function(a) M.apply(a.args) end, {
  nargs = 1,
  complete = function() return vim.tbl_keys(M.profiles) end,
})

return M
