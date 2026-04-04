# ⚡ Terminal Setup

![macOS](https://img.shields.io/badge/macOS-compatible-blue?logo=apple)
![Neovim](https://img.shields.io/badge/Neovim-0.12%2B-green?logo=neovim)
![tmux](https://img.shields.io/badge/tmux-workflow-informational?logo=tmux)
![Starship](https://img.shields.io/badge/Starship-prompt-yellow?logo=starship)
![Theme](https://img.shields.io/badge/theme-catppuccin-mocha?color=1e1e2e)
![Workflow](https://img.shields.io/badge/workflow-keyboard--first-orange)

> Keyboard-first development environment with tmux, Neovim, Starship and hardware integration

---

![Terminal Setup Banner](docs/images/hero-banner.svg)

---

## 🚀 Why this setup?

Most setups optimize tools — this one optimizes **flow**.

- minimal context switching  
- instant visual feedback  
- hardware + software as one system  
- reproducible on any machine  

---

## ⚡ Quickstart

```bash
git clone https://github.com/footprintsonthemoon/terminal-setup.git
cd terminal-setup
make bootstrap
```

---

## 🧭 Architecture

![architecture diagram](docs/images/architecture-diagram.svg)

Layered system:

- Hardware → Stream Deck / Dygma / Monogram  
- tmux → orchestration  
- Neovim → editing  
- Starship → context  
- eza → file visibility  

---

## 🎨 Visual System

| Element | Meaning |
|--------|--------|
| Peach prompt | Local |
| Mauve prompt | Server |
| Blue | Directories |
| Cyan | Symlinks |
| Green | Executables |
| Grey | Files |

---

## ⌨️ Hardware

![hardware](docs/images/hardware-setup.png)

![streamdeck](docs/images/streamdeck-close.png)

---

## 🖥️ Interface

![terminal](docs/images/terminal.png)

![tmux](docs/images/tmux.png)

![nvim](docs/images/nvim.png)

![telescope](docs/images/telescope.png)

---

## 📁 File UX (eza)

```bash
alias ls="eza -a --icons"
alias ll="eza -alh --icons"
alias la="eza -alh --icons"
alias lt="eza --tree --level=2"
```

---

## ⚙️ Prerequisites

- macOS  
- iTerm2 recommended  

Installed automatically:

- Homebrew  
- git  
- neovim  
- tmux  
- starship  
- eza  
- Nerd Font  

---

## 🚀 Installation

```bash
make bootstrap
```

---

## 🔤 Font Setup

Set in iTerm2:

JetBrainsMono Nerd Font

---

## 🛠️ Makefile

```bash
make bootstrap
make sync
make relink
make tmux
make nvim
```

---

## 🔗 Symlinks

~/.config/nvim → nvim/config  
~/.tmux.conf → tmux/.tmux.conf  
~/.config/starship.toml → starship/starship.toml  

---

## ⚠️ Troubleshooting

### SSH error

```bash
git clone https://github.com/footprintsonthemoon/terminal-setup.git
```

---

## 🔁 Updates

```bash
brew upgrade
make sync
```

---

## 🧠 Philosophy

Reduce friction. Increase flow.
