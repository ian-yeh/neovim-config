# Ian's Neovim Config

## Colorschemes

- [tokyonight](https://github.com/folke/tokyonight.nvim)
- [catppuccin](https://github.com/catppuccin/nvim)

Set via `NVIM_COLORSCHEME` in `.env`.

## Plugins

### UI
- **bufferline** — tab/buffer bar
- **lualine** — statusline
- **alpha** — start screen
- **indent-blankline** — indentation guides
- **dressing** — improved UI inputs/selects
- **nvim-web-devicons** — file icons
- **which-key** — keybind hints
- **todo-comments** — highlighted TODO/FIX/NOTE comments
- **snacks.nvim** — misc QOL utilities

### Navigation
- **telescope** + fzf-native — fuzzy finder
- **nvim-tree** — file explorer
- **vim-tmux-navigator** — seamless tmux/nvim pane navigation
- **auto-session** — session save/restore
- **vim-maximizer** — maximize/restore splits

### Editing
- **nvim-treesitter** — syntax parsing
- **nvim-ts-autotag** — auto-close/rename HTML tags
- **nvim-autopairs** — auto-close brackets/quotes
- **nvim-surround** — surround motions
- **substitute** — exchange/substitute motions
- **Comment.nvim** + ts-context-commentstring — smart commenting

### LSP & Completion
- **nvim-lspconfig** — LSP client config
- **mason** + mason-lspconfig + mason-tool-installer — LSP/linter installer
- **nvim-cmp** + cmp-nvim-lsp + cmp-buffer + cmp-path — completion engine
- **LuaSnip** + friendly-snippets + cmp_luasnip — snippets
- **lspkind** — LSP completion icons
- **neodev** — Lua/Neovim API completion
- **nvim-lsp-file-operations** — LSP-aware file operations

### Language-specific
- **vimtex** — LaTeX editing
- **markdown-preview** — live Markdown preview in browser
- **pdfreader.nvim** — PDF reading
- **image.nvim** — inline image rendering

### Terminal
- **toggleterm** — floating/split terminal
