#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
SHELL_RC=""

log() { printf "\n==> %s\n" "$1"; }
success() { printf "   ✓ %s\n" "$1"; }
warn() { printf "   ! %s\n" "$1"; }

ask_yes_no() {
  local prompt="$1"
  local reply
  read -r -p "$prompt [y/N]: " reply
  [[ "$reply" =~ ^[Yy]$ ]]
}

detect_shell_rc() {
  local shell_name
  shell_name="$(basename "${SHELL:-}")"

  case "$shell_name" in
    zsh) SHELL_RC="$HOME/.zshrc" ;;
    bash) SHELL_RC="$HOME/.bashrc" ;;
    *)
      if [ -f "$HOME/.zshrc" ]; then
        SHELL_RC="$HOME/.zshrc"
      else
        SHELL_RC="$HOME/.bashrc"
      fi
      ;;
  esac
}

ensure_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    success "Homebrew found"
    return
  fi

  warn "Homebrew is not installed."
  if ask_yes_no "Install Homebrew now?"; then
    /bin/bash -c "$(curl -fsSL https://brew.sh)"
    success "Homebrew installed"
  else
    warn "Homebrew is required for this bootstrap script."
    exit 1
  fi
}

install_package() {
  local package="$1"
  if brew list "$package" >/dev/null 2>&1; then
    success "$package already installed"
  else
    log "Installing $package"
    brew install "$package"
  fi
}

install_cask() {
  local cask="$1"
  if brew list --cask "$cask" >/dev/null 2>&1; then
    success "$cask already installed"
  else
    log "Installing $cask"
    brew install --cask "$cask"
  fi
}

ensure_dir() {
  local dir="$1"
  mkdir -p "$dir"
  success "Ensured directory $dir"
}

link_path() {
  local source_path="$1"
  local target_path="$2"

  if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
    warn "$target_path exists and is not a symlink"
    warn "Creating backup at ${target_path}.bak"
    mv "$target_path" "${target_path}.bak"
  fi

  ln -sfn "$source_path" "$target_path"
  success "Linked $target_path -> $source_path"
}

append_block_once() {
  local file="$1"
  local start_marker="$2"
  local end_marker="$3"
  local content="$4"

  touch "$file"

  if grep -qF "$start_marker" "$file"; then
    success "Shell block already present in $file"
    return
  fi

  {
    printf "\n%s\n" "$start_marker"
    printf "%s\n" "$content"
    printf "%s\n" "$end_marker"
  } >> "$file"

  success "Added shell block to $file"
}

main() {
  log "Checking prerequisites"
  ensure_homebrew

  log "Installing required packages"
  install_package git
  install_package neovim
  install_package tmux
  install_package starship
  install_package ripgrep
  install_package fd
  install_package tree-sitter-cli
  install_package eza
  install_package make

  log "Installing recommended apps and fonts"
  brew tap homebrew/cask-fonts >/dev/null 2>&1 || true
  install_cask iterm2
  install_cask font-jetbrains-mono-nerd-font

  log "Preparing directories"
  ensure_dir "$HOME/.config"

  log "Creating symlinks"
  link_path "$DOTFILES_DIR/nvim/config" "$HOME/.config/nvim"
  link_path "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  link_path "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

  detect_shell_rc
  log "Updating shell config in $SHELL_RC"

  append_block_once \
    "$SHELL_RC" \
    "# >>> terminal-setup starship >>>" \
    "# <<< terminal-setup starship <<<" \
'if command -v starship >/dev/null 2>&1; then
  eval "$(starship init ${SHELL##*/})"
fi'

  append_block_once \
    "$SHELL_RC" \
    "# >>> terminal-setup eza >>>" \
    "# <<< terminal-setup eza <<<" \
'export EZA_COLORS="di=38;5;111:ln=38;5;117:ex=38;5;150:fi=38;5;252:so=38;5;176:pi=38;5;222:bd=38;5;222;1:cd=38;5;222;1"

alias ls="eza -a --icons=auto --group-directories-first"
alias ll="eza -alh --icons=auto --group-directories-first --git"
alias la="eza -alh --icons=auto --group-directories-first --git"
alias lt="eza --tree -a --level=2 --icons=auto"'

  log "Bootstrap complete"
  printf "\nNext steps:\n"
  printf "  1. Restart your shell or run: source %s\n" "$SHELL_RC"
  printf "  2. Open iTerm2 and set the font to JetBrainsMono Nerd Font\n"
  printf "  3. Start Neovim and run: :Lazy sync\n"
  printf "  4. Then run: :TSUpdate\n"
}

main "$@"
