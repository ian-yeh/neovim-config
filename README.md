# Ian's Neovim Config

Keymaps and per-plugin usage: see [CHEATSHEET.md](CHEATSHEET.md).

## Colorschemes

- [tokyonight](https://github.com/folke/tokyonight.nvim) (default)
- [catppuccin](https://github.com/catppuccin/nvim)
- [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)

Set via `NVIM_COLORSCHEME` in `.env`: `tokyonight`, `catppuccin`, or `github_dark_high_contrast`.

## Plugins

### UI
- **bufferline** - buffer bar with LSP diagnostics
- **hover.nvim** - multi-source `K` hover (LSP, diagnostics, man, GitHub)
- **lualine** - statusline
- **dropbar** - winbar breadcrumbs
- **alpha** - start screen
- **indent-blankline** - indentation guides
- **dressing** - improved UI inputs/selects
- **mini.icons** - file icons (mocks nvim-web-devicons)
- **which-key** - keybind hints
- **todo-comments** - highlighted TODO/FIX/NOTE comments

### Navigation
- **telescope** + fzf-native - fuzzy finder
- **neo-tree** - file explorer (float preview, git status, buffers)
- **vim-tmux-navigator** - seamless tmux/nvim pane navigation
- **auto-session** - session save/restore
- **vim-maximizer** - maximize/restore splits

### Editing
- **nvim-treesitter** - syntax parsing
- **nvim-ts-autotag** - auto-close/rename HTML tags
- **nvim-autopairs** - auto-close brackets/quotes
- **nvim-surround** - surround motions
- **substitute** - exchange/substitute motions
- **Comment.nvim** + ts-context-commentstring - smart commenting
- **mini.move** - move lines/selections with Alt+hjkl

### Git
- **gitsigns** - hunk signs, inline blame, stage/reset

### LSP & Completion
- **nvim-lspconfig** - LSP server configs
- **mason** + mason-lspconfig + mason-tool-installer - LSP/linter installer
- **blink.cmp** + friendly-snippets - completion engine and snippets
- **blink-copilot** - Copilot completions (copilot LSP, off until toggled)
- **conform.nvim** - formatting (format on save, LSP fallback)
- **nvim-lint** - linting (eslint_d, pylint)
- **lazydev** - Lua/Neovim API completion
- **nvim-lsp-file-operations** - LSP-aware file operations

### Language-specific
- **vimtex** - LaTeX editing
- **typst-preview** - live Typst preview (tinymist LSP)
- **markdown-preview** - live Markdown preview in browser
- **pdfreader.nvim** + snacks.nvim (image module, also used for bufdelete and neo-tree previews) - PDF reading

### Terminal
- **toggleterm** - floating/split terminal, lazygit

### Personal
- **doorbell.nvim** - [ian-yeh/doorbell.nvim](https://github.com/ian-yeh/doorbell.nvim)
