# Neovim Cheatsheet

`<leader>` = **Space**. Insert-mode escape shortcut: `jk`.

Modes: **n** normal, **i** insert, **v/x** visual, **t** terminal.

---

## Plugin Inventory

| Plugin | Purpose | Lazy trigger |
|---|---|---|
| alpha-nvim | Start dashboard/greeter | `VimEnter` |
| auto-session | Save/restore sessions per cwd | on load |
| nvim-autopairs | Auto-close brackets/quotes | `InsertEnter` |
| nvim-ts-autotag | Auto-close/rename HTML/JSX tags | `InsertEnter` |
| bufferline.nvim | Tab/buffer bar (tabs mode) | on load |
| tokyonight / catppuccin | Colorschemes (via `.env` `NVIM_COLORSCHEME`) | on load |
| Comment.nvim | Commenting (ts-context aware) | `BufReadPre` |
| doorbell.nvim | Local personal plugin | always |
| dressing.nvim | Better UI selects/inputs | `VeryLazy` |
| image.nvim | Inline image rendering (kitty) | `VeryLazy` |
| indent-blankline (ibl) | Indent guides (`┊`) | `BufReadPre` |
| plenary.nvim | Lua lib (dependency) | on demand |
| lualine.nvim | Statusline (custom theme) | on load |
| markdown-preview.nvim | Browser markdown preview | `ft=markdown` |
| nvim-cmp | Completion engine | `InsertEnter` |
| nvim-tree | File explorer | on load |
| pdfreader.nvim + snacks.nvim | PDF viewing | `ft=pdf` |
| substitute.nvim | Substitute-with-motion | `BufReadPre` |
| nvim-surround | Add/change/delete surroundings | `BufReadPre` |
| telescope.nvim (+fzf) | Fuzzy finder | on load |
| vim-tmux-navigator | Seamless tmux/nvim pane nav | always |
| todo-comments.nvim | Highlight/jump TODO/FIXME | `BufReadPre` |
| toggleterm.nvim | Terminal management | keys/cmd |
| nvim-treesitter | Syntax/indent/parsers | `BufReadPre` |
| vim-maximizer | Maximize a split | key |
| vimtex | LaTeX toolchain (Skim + latexmk) | always |
| which-key.nvim | Popup keybind hints | `VeryLazy` |
| nvim-lspconfig | LSP client config | `BufReadPre` |
| mason.nvim | LSP/tool installer | on load |
| typst-preview + tinymist | Typst preview & LSP | `ft=typst` |

---

## Core / General (keymaps.lua)

| Key | Mode | Action |
|---|---|---|
| `jk` | i | Exit insert mode |
| `<leader>nh` | n | Clear search highlights |
| `<leader>+` | n | Increment number |
| `<leader>-` | n | Decrement number |

### Windows / Splits

| Key | Action |
|---|---|
| `<leader>sv` | Split vertically |
| `<leader>sh` | Split horizontally |
| `<leader>se` | Make splits equal size |
| `<leader>sx` | Close current split |
| `<leader>sm` | Maximize/restore split (vim-maximizer) |
| `<C-Up>` / `<C-Down>` | Increase / decrease height |
| `<C-Left>` / `<C-Right>` | Decrease / increase width |
| `<C-h/j/k/l>` | Navigate splits/tmux panes (tmux-navigator) |

### Tabs

| Key | Action |
|---|---|
| `<leader>to` | New tab |
| `<leader>tx` | Close tab |
| `<leader>tn` | Next tab |
| `<leader>tp` | Previous tab |
| `<leader>tf` | Open current buffer in new tab |

---

## File Explorer (nvim-tree)

Toggle/open:

| Key | Action |
|---|---|
| `<leader>ee` | Toggle explorer |
| `<leader>ef` | Toggle explorer on current file |
| `<leader>ec` | Collapse |
| `<leader>er` | Refresh |

Inside the tree:

| Key | Action |
|---|---|
| `l` | Open file/folder |
| `h` | Close directory |
| `t` / `<C-t>` | Open in new tab (keeps tree open) |
| `v` | Open in vertical split |
| `s` | Open in horizontal split |
| `n` | Create file/folder |
| `d` | Delete |
| `r` | Rename |
| `y` | Copy |
| `x` | Cut |
| `p` | Paste |

*(plus all nvim-tree default mappings; press `g?` in tree for full list)*

---

## Telescope (fuzzy finder)

| Key | Action |
|---|---|
| `<leader>ff` | Find files in cwd |
| `<leader>fr` | Recent files |
| `<leader>fs` | Live grep (find string in cwd) |
| `<leader>fc` | Grep string under cursor |
| `<leader>ft` | Find TODOs |
| `<leader>fp` | Find PDF files |

Inside a picker: `<C-k>` prev result, `<C-j>` next result, `<C-q>` send selection to quickfix.

---

## LSP (lspconfig)

Active on `LspAttach`. Servers: ts_ls, html, cssls, tailwindcss, svelte, graphql, emmet_ls, pyright, lua_ls, gopls, clangd (typst via tinymist).

| Key | Action |
|---|---|
| `gd` | Go to definition (Telescope) |
| `gD` | Go to declaration |
| `gR` | Show references (Telescope) |
| `gi` | Go to implementation |
| `gt` | Go to type definition |
| `K` | Hover docs |
| `<leader>ca` | Code actions (n/v) |
| `<leader>rn` | Smart rename |
| `<leader>D` | Buffer diagnostics (Telescope) |
| `<leader>d` | Line diagnostics (float) |
| `[d` / `]d` | Prev / next diagnostic |
| `<leader>rs` | Restart LSP |

Jump back/forward after a `gd`: `<C-o>` / `<C-i>`.

---

## Completion (nvim-cmp) - insert mode

| Key | Action |
|---|---|
| `<C-k>` | Previous suggestion |
| `<C-j>` | Next suggestion |
| `<C-b>` | Scroll docs up |
| `<C-f>` | Scroll docs down |
| `<C-Space>` | Trigger completion |
| `<C-e>` | Abort/close menu |
| `<CR>` | Confirm (no auto-select) |

Sources: LSP, LuaSnip snippets, buffer, path.

---

## Terminal (toggleterm)

| Key | Action |
|---|---|
| `<C-\>` | Toggle terminal (open_mapping) |
| `<leader>tt` | Floating terminal |
| `<leader>th` | Horizontal terminal |
| `<leader>tv` | Vertical terminal |
| `<leader>tg` | Lazygit (float) |
| `<leader>1..4` | Numbered terminals 1-4 |

Inside terminal: `<esc>` or `jk` to normal mode; `<C-h/j/k/l>` move between windows; `<C-w>` window prefix.

---

## Sessions (auto-session)

| Key | Action |
|---|---|
| `<leader>ws` | Save session for cwd |
| `<leader>wr` | Restore session for cwd |

*(auto-restore is off; suppressed in `~/`, `~/Dev/`, Downloads, Documents, Desktop)*

---

## Editing plugins

### substitute.nvim

| Key | Mode | Action |
|---|---|---|
| `s` + motion | n | Substitute with motion |
| `ss` | n | Substitute line |
| `S` | n | Substitute to end of line |
| `s` | x | Substitute selection |

### nvim-surround

| Command | Action |
|---|---|
| `ysiw(` | Surround word with `()` |
| `ys$` / `ys0` | Surround to end / start of line |
| `cs"'` | Change surrounding `"` to `'` |
| `ds(` | Delete surrounding `()` |

### Comment.nvim

Defaults: `gcc` toggle line, `gc` + motion / visual block, `gbc` block comment. Treesitter-context aware (JSX/TSX/Svelte/HTML).

### todo-comments

| Key | Action |
|---|---|
| `]t` | Next todo comment |
| `[t` | Previous todo comment |
| `<leader>ft` | List todos (Telescope) |

### Treesitter incremental selection

| Key | Action |
|---|---|
| `<C-space>` | Start / expand node selection |
| `<bs>` | Shrink node selection |

---

## Images (image.nvim)

| Key | Action |
|---|---|
| `<leader>ic` | Clear images |
| `<leader>ir` | Refresh images |

Opens `.png/.jpg/.jpeg/.gif/.webp/.avif` directly as images; inline markdown images enabled.

---

## PDF (pdfreader.nvim)

Buffer keys in a PDF: `n` next page, `p` prev page, `z` zoom in, `q` zoom out, `e` reset zoom.

| Key | Action |
|---|---|
| `<leader>fp` | Find PDF files |
| `<leader>vs` | Standard view (images) |
| `<leader>vd` | Dark view |
| `<leader>vt` | Text-only view (fast) |

---

## LaTeX (vimtex) - in `.tex` files

Viewer: Skim. Compiler: latexmk.

| Key | Action |
|---|---|
| `<leader>ll` | Compile |
| `<leader>lv` | View PDF |
| `<leader>lc` | Clean aux files |
| `<leader>le` | Show errors |
| `<leader>lk` | Stop compile |
| `<leader>lg` | Status |

---

## Typst (`.typ` files)

| Key | Action |
|---|---|
| `<leader>tw` | Toggle Typst preview |

Auto-exports PDF on save (tinymist).

---

## Markdown

`:MarkdownPreview` / `:MarkdownPreviewToggle` / `:MarkdownPreviewStop` - browser preview.

---

## Useful commands

| Command | Purpose |
|---|---|
| `:Lazy` | Plugin manager UI |
| `:Mason` | LSP/tool installer UI |
| `:LspRestart` | Restart language servers |
| `:TSUpdate` | Update treesitter parsers |
| `:checkhealth` | Diagnose config issues |
| `:SessionSave` / `:SessionRestore` | Sessions |
