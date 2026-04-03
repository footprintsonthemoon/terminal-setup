# ⚡ Terminal Setup

![macOS](https://img.shields.io/badge/macOS-compatible-blue?logo=apple)
![Neovim](https://img.shields.io/badge/Neovim-0.12%2B-green?logo=neovim)
![tmux](https://img.shields.io/badge/tmux-workflow-informational?logo=tmux)
![Starship](https://img.shields.io/badge/Starship-prompt-yellow?logo=starship)
![Theme](https://img.shields.io/badge/theme-catppuccin-mocha?color=1e1e2e)
![Workflow](https://img.shields.io/badge/workflow-keyboard--first-orange)

**Repository description:** Keyboard-first terminal setup with tmux, Neovim, Starship and hardware integration (Stream Deck, Dygma and Monogram).

---

![Terminal Setup Banner](docs/images/hero-banner.svg)

---

## 🚀 A Keyboard-First Development Environment

A modular, hardware-accelerated development environment built around:

- **tmux** for session and workflow management
- **Neovim** for editing and navigation
- **Starship** for contextual feedback
- **Stream Deck, Dygma and Monogram** for physical interaction

This repository is not just configuration — it is a **complete workflow system**.

---

## 🧭 Architecture

![architecture diagram](docs/images/architecture-diagram.svg)

The architecture is intentionally layered:

- **Hardware layer** for fast, repeatable control
- **tmux layer** for orchestration, layouts and local/remote context
- **Neovim layer** for navigation, editing and review
- **Prompt / file visibility layer** for context and quick recognition

---

## 🎨 Visual System

This setup follows a **semantic color model**:

| Element | Meaning |
|--------|--------|
| Peach prompt | Local machine |
| Mauve prompt | Remote server |
| Blue (eza) | Directories |
| Cyan (eza) | Symlinks |
| Green (eza) | Executables |
| Grey (eza) | Files |

**Principle:**

- Prompt color → *Where you are*
- File colors → *What you are looking at*

---

## ⌨️ Hardware Integration

### Full Setup
![hardware setup](docs/images/hardware-setup.png)

### Stream Deck Detail
![stream deck](docs/images/streamdeck-close.png)

This setup combines multiple input layers:

- **Stream Deck** → triggers workflows such as tmux layouts, SSH splits and launcher actions
- **Dygma Keyboard** → layer-based input system
- **Monogram Console** → additional physical controls

### Companion Project

👉 https://github.com/footprintsonthemoon/dygma_profile_switcher

---

## 🖥️ Interface

### Terminal (Starship + eza)
![terminal](docs/images/terminal.png)

### tmux (local + remote)
![tmux](docs/images/tmux.png)

### Neovim (Neo-tree + editing)
![nvim](docs/images/nvim.png)

### Telescope (navigation)
![telescope](docs/images/telescope.png)

---

## 📁 File Visualization

The default macOS `ls` is replaced by **eza**.

### Included shell setup

The bootstrap script adds the following to your shell config automatically:

```bash
export EZA_COLORS="di=38;5;111:ln=38;5;117:ex=38;5;150:fi=38;5;252:so=38;5;176:pi=38;5;222:bd=38;5;222;1:cd=38;5;222;1"

alias ls="eza -a --icons=auto --group-directories-first"
alias ll="eza -alh --icons=auto --group-directories-first --git"
alias la="eza -alh --icons=auto --group-directories-first --git"
alias lt="eza --tree -a --level=2 --icons=auto"
```

This keeps file type recognition separate from machine context:

- **Starship prompt colors** tell you where you are
- **eza colors** tell you what kind of file you are looking at

---

## 🧱 System Layers

| Layer | Tool | Role |
|------|------|------|
| UI | iTerm2 | terminal environment |
| Session | tmux | layout & orchestration |
| Editor | Neovim | editing & navigation |
| Prompt | Starship | context awareness |
| File view | eza | file type visibility |
| Control | Stream Deck | execution layer |
| Input | Dygma | abstraction layer |

---

## 🧭 Core Workflows

### Navigation
- `<C-p>` → find files
- `<leader>fg` → search content
- `<leader>e` → file explorer

### Window Management
- `Ctrl + h/j/k/l` → move between panes
- `Alt + h/l` → switch windows

### Hardware
- Stream Deck → start workflows
- Dygma → switch input layers

---

## 🚀 Installation

```bash
git clone git@github.com:footprintsonthemoon/terminal-setup.git
cd terminal-setup
./bootstrap.sh
```

---

## ⚙️ What `bootstrap.sh` does

The bootstrap script is intended to make the setup reproducible on a fresh machine.

It will:

- install required Homebrew packages:
  - `git`
  - `neovim`
  - `tmux`
  - `starship`
  - `ripgrep`
  - `fd`
  - `tree-sitter-cli`
  - `eza`
- create required config directories
- create symlinks for:
  - `~/.config/nvim`
  - `~/.tmux.conf`
  - `~/.config/starship.toml`
- append a Starship init block to your shell config
- append the `eza` aliases and colors to your shell config

The script detects your shell and updates either:

- `~/.zshrc`
- or `~/.bashrc`

---

## 🔗 Symlink Strategy

```text
~/.config/nvim          → nvim/config
~/.tmux.conf            → tmux/.tmux.conf
~/.config/starship.toml → starship/starship.toml
```

This repository stays the **single source of truth**. System paths point to the repo instead of containing copied files.

---

## 🔁 Updates

```bash
brew upgrade
```

Inside Neovim:

```vim
:Lazy sync
:TSUpdate
```

tmux:

```text
Prefix + r
```

---

## 🧠 Philosophy

> Reduce friction. Increase flow.

This setup aligns tools, visuals and hardware into a single coherent system.

---

## 📄 License

MIT
