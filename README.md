# My Neovim Configuration

## Overview

A personal Neovim configuration built with lazy.nvim package manager, featuring:

* Modular plugin structure
* Catppuccin colorscheme
* Telescope fuzzy finder
* Clean, organized codebase

## Structure

```
~/.config/nvim/
├── init.lua              # Main configuration entry point
├── lua/
│   ├── core/
│   │   ├── keymaps.lua   # Key mappings
│   │   └── lazy.lua      # lazy.nvim setup
│   └── plugins/          # Plugin configurations
│       ├── catppuccin.lua
│       └── telescope.lua
└── lazy-lock.json        # Plugin version lockfile
```

## Installation

### Prerequisites

- Neovim 0.9+ (stable or nightly)
- Git
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for Telescope live grep)
- [fd](https://github.com/sharkdp/fd) (for Telescope file search)
- A [Nerd Font](https://www.nerdfonts.com/) (optional, for icons)

### Setup

1. Backup your existing Neovim configuration
2. Clone this repository:
   ```sh
   git clone <your-repo-url> ~/.config/nvim
   ```
3. Start Neovim - lazy.nvim will automatically install plugins
4. Run `:checkhealth` to verify everything is working

## Plugins

- **lazy.nvim** - Plugin manager
- **Catppuccin** - Colorscheme (Macchiato variant)
- **Telescope** - Fuzzy finder with live grep support

## Key Bindings

### Telescope
- `<leader>ff` - Find files
- `<leader>fg` - Live grep (search in files)  
- `<leader>fb` - List buffers
- `<leader>fh` - Help tags

## Customization

Add new plugins by creating files in `lua/plugins/`. Each file should return a plugin specification table that lazy.nvim will automatically load.

## Features

- **Clipboard integration** - Copy/paste with system clipboard
- **Highlight on yank** - Visual feedback when copying text
- **Modular architecture** - Easy to extend and maintain
- **Version locking** - Reproducible plugin installations via lazy-lock.json