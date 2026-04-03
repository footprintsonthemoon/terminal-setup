# Terminal Setup

A modular macOS terminal workflow built around **iTerm2**, **tmux**, **Starship**, **Neovim**, and **Stream Deck**.

This repository documents both the configuration and the workflow philosophy behind the setup. The goal is a fast, keyboard-first environment with reliable pane and window management, a clean prompt, a focused editor, and optional hardware shortcuts through Stream Deck.

## Overview

The setup is built around five layers:

- **iTerm2** as the terminal UI
- **tmux** as the session and workspace backbone
- **Starship** as the shell prompt
- **Neovim** as the editor and navigator
- **Stream Deck** as an optional control surface for tmux actions

The result is a workflow where tmux manages long-lived sessions, Neovim handles editing and navigation, Starship provides compact context, and Stream Deck exposes frequent tmux operations as dedicated buttons.

## Repository Structure

```text
terminal-setup/
├── README.md
├── .gitignore
├── bootstrap.sh
├── docs/
│   └── images/
├── iterm2/
│   └── README.md
├── nvim/
│   └── config/
├── starship/
│   └── starship.toml
├── streamdeck/
│   ├── README.md
│   └── scripts/
└── tmux/
    └── .tmux.conf
```

## Core Components

### tmux

The tmux configuration uses `Ctrl-a` as prefix, keeps pane and window indexing 1-based, enables mouse support, uses vi-style copy mode, and preserves the current path when splitting panes.

Highlights:

- `Ctrl-a` prefix instead of the default `Ctrl-b`
- pane navigation on `Ctrl-h/j/k/l`
- window navigation on `Alt-h` and `Alt-l`
- pane resizing on prefix + `H/J/K/L`
- top pane borders with pane titles
- clipboard integration on macOS through `pbcopy`
- TPM plugins for sensible defaults and session restore

The tmux config is stored in `tmux/.tmux.conf`.

### Starship

The prompt uses a Catppuccin Mocha-inspired palette and stays intentionally compact. It shows:

- operating system icon
- current directory
- git branch and status
- language/runtime information when relevant
- command duration
- prompt mode indicators
- an optional `PANE_ROLE` environment variable for pane-specific context

This is especially useful in combination with tmux panes that represent different roles such as local shell, Claude, or SSH.

The Starship config is stored in `starship/starship.toml`. fileciteturn1file0L1-L26

### Neovim

Neovim is configured in a modular structure under `nvim/config` and currently includes:

- `lazy.nvim` for plugin management
- `catppuccin` for colors
- `telescope.nvim` for navigation and search
- `nvim-treesitter` for syntax awareness
- `neo-tree` for a file explorer
- `lualine.nvim` for a minimal statusline
- `which-key.nvim` for discoverable keybindings
- `render-markdown.nvim` for Markdown rendering

Useful conventions in the current setup:

- `Space` is the leader key
- `Ctrl-p` opens Telescope file search
- `Space fg` starts project grep
- `Space fc` searches the Neovim config
- `Space e` toggles Neo-tree
- `Space o` focuses Neo-tree
- `Space w` switches between Neo-tree and the editor

### Stream Deck

The Stream Deck integration is based on shell scripts instead of raw keypress emulation.

That has two main advantages:

- actions are explicit and reproducible
- tmux can be controlled directly without depending on the active application state

The included scripts cover actions such as:

- pane navigation
- pane splitting
- pane zoom
- new windows
- next and previous window
- detach session
- choose session
- reload tmux config
- toggle mouse mode
- enter copy mode

There are also higher-level launcher scripts for prebuilt pane layouts:

- `tmux-shell-ssh.sh` creates a local shell + remote SSH layout
- `tmux-claude-ssh.sh` creates a Claude + remote SSH layout
- `launch-shell.sh` launches iTerm2 and attaches to the `main` tmux session
- `launch-claude.sh` does the same for the Claude-oriented layout

The scripts live in `streamdeck/scripts/`.

## Installation

### Prerequisites

This setup assumes:

- macOS
- Homebrew
- iTerm2
- a Nerd Font for icons
- a shell that loads Starship, such as zsh or bash

### Install core tools

```bash
brew install neovim tmux starship git ripgrep fd tree-sitter-cli
```

### Clone the repository

```bash
git clone <your-repo-url>
cd terminal-setup
```

### Run the bootstrap script

```bash
./bootstrap.sh
```

This script:

- installs core packages with Homebrew
- creates required config directories
- links Neovim, tmux, and Starship configs into the expected locations

### Enable Starship in your shell

For zsh:

```bash
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

For bash:

```bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc
```

Then reload your shell.

### Install tmux plugins

Start tmux, then press:

```text
Prefix + I
```

In this setup, the prefix is:

```text
Ctrl-a
```

This installs the TPM-managed plugins declared in `.tmux.conf`.

### Finalize Neovim

Open Neovim and run:

```vim
:Lazy sync
:TSUpdate
```

## Configuration Locations

This repository keeps the source files in the project itself and links them into the usual runtime locations.

Resulting locations:

- Neovim: `~/.config/nvim`
- tmux: `~/.config/tmux/tmux.conf`
- Starship: `~/.config/starship.toml`

The repository itself can live anywhere on disk. No absolute path is required.


### Stream Deck configuration file

The public version of this repository does not hardcode any personal hostnames or absolute paths in the Stream Deck scripts.

Instead, copy the example file and adapt it locally:

```bash
cp streamdeck/config.example.sh streamdeck/config.sh
```

Then edit:

- `STREAMDECK_REMOTE_HOST`
- `STREAMDECK_REMOTE_DIR`
- `STREAMDECK_CLAUDE_CMD`
- `STREAMDECK_TMUX_SESSION`
- `STREAMDECK_ITERM_PROFILE`

`streamdeck/config.sh` should stay untracked if you want to keep machine-specific values private.

## Updating

### Homebrew packages

```bash
brew update
brew upgrade
```

### tmux plugins

Inside tmux:

```text
Prefix + U
```

### Neovim plugins

Inside Neovim:

```vim
:Lazy sync
```

### Treesitter parsers

Inside Neovim:

```vim
:TSUpdate
```

## Daily Workflow

A typical work session looks like this:

1. Open iTerm2
2. Attach or create the `main` tmux session
3. Use tmux windows for different tasks or projects
4. Use Neovim for editing and project navigation
5. Use Telescope for file search and grep
6. Use Neo-tree when a project structure view is helpful
7. Optionally use Stream Deck buttons for pane, window, or session actions

The setup is intentionally split between:

- **tmux** for session and layout persistence
- **Neovim** for editing and in-project navigation
- **Stream Deck** for fast access to repeated tmux actions

## Stream Deck Notes

The included shell scripts are intended as examples and working utilities, but some values are machine-specific and should be reviewed before publishing or reusing them broadly.

In particular, check:

- remote host names
- remote directories
- tmux session names if you do not use `main`
- optional iTerm2 profile names
- any environment-specific commands such as `claude`

The launcher scripts in this repository resolve their own directory dynamically and can optionally read machine-specific values from `streamdeck/config.sh`.

## iTerm2 Notes

The repository does not yet include an exported iTerm2 profile. The `iterm2/` directory is reserved for future additions such as:

- profile exports
- screenshots
- notes on triggers or profile switching
- color settings

## Keybindings Cheat Sheet

### tmux

- prefix: `Ctrl-a`
- send prefix: `Ctrl-a Ctrl-a`
- pane move: `Ctrl-h/j/k/l`
- previous and next window: `Alt-h`, `Alt-l`
- resize pane: `Prefix + H/J/K/L`
- copy mode: `Prefix + [`
- reload config: `Prefix + r`

### Neovim

- file search: `Ctrl-p`
- grep: `Space fg`
- search Neovim config: `Space fc`
- search home directory: `Space fh`
- toggle Neo-tree: `Space e`
- focus Neo-tree: `Space o`
- switch between Neo-tree and editor: `Space w`
- toggle Markdown rendering: `Space mr`

## Design Principles

This setup follows a few consistent rules:

- **Modular:** each tool has its own directory and config
- **Portable:** no repository path is assumed in the documentation
- **Fast:** quick navigation through Telescope and tmux keybindings
- **Readable:** clean prompt, restrained statuslines, and a simple color story
- **Practical:** Stream Deck scripts call tmux directly instead of emulating keystrokes

## Future Improvements

Possible next steps for this repository:

- add exported iTerm2 profiles
- add screenshots under `docs/images`
- add LSP and formatter configuration for Neovim
- add a `Makefile` for install and update tasks
- document Stream Deck button layouts visually

## License

Use, adapt, and extend this setup as needed.
