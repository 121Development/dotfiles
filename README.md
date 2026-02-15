# Dotfiles

Personal dotfiles for macOS, managed with GNU Stow.

## What's included

### Shell
- **Zsh** (`.zshrc`, `.zshenv`, `.zprofile`) — Powerlevel10k prompt, custom aliases and PATH setup
- **Bash** (`.bashrc`, `.bash_profile`) — fallback shell config

### Terminal
- **Ghostty** (`.config/ghostty/`) — font, opacity, padding, and a collection of custom GLSL shaders (CRT, bloom, matrix, etc.)

### Editor
- **Neovim** (`.config/nvim/`) — Lazy.nvim plugin manager with:
  - LSP via nvim-lspconfig + Mason (TypeScript, Deno, Python, Lua, Svelte, HTML)
  - Completions via blink.cmp
  - Telescope, Treesitter, Harpoon, Oil, Undotree
  - Formatting with conform.nvim
  - Gruvbox Material / Nord colorschemes

### Multiplexer
- **tmux** (`.tmux.conf`) — 256-color support, custom keybindings

### File Manager
- **Yazi** (`.config/yazi/`) — keymaps, theme, plugins

### Git
- **Global gitignore** (`.config/git/ignore`)

## Setup

```sh
git clone <repo-url> ~/dotfiles
cd ~/dotfiles
stow .
```
