#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
SHELL_RC=""

log() {
  printf "\n==> %s\n" "$1"
}

success() {
  printf "   ✓ %s\n" "$1"
}

warn() {
  printf "   ! %s\n" "$1"
}

detect_shell_rc() {
  local shell_name
  shell_name="$(basename "${SHELL:-}")"

  case "$shell_name" in
    zsh)
      SHELL_RC="$HOME/.zshrc"
      ;;
    bash)
      SHELL_RC="$HOME/.bashrc"
      ;;
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
  if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew is not installed."
    warn "Please install Homebrew first: https://brew.sh"
    exit 1
  fi
  success "Homebrew found"
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

ensure_dir() {
  local dir="$1"
  mkdir -p "$dir"
  success "Ensured directory $dir"
}

link_file() {
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
  log "Checking Homebrew"
  ensure_homebrew

  log "Installing core tools"
  install_package git
  install_package neovim
  install_package tmux
  install_package starship
  install_package ripgrep
  install_package fd
  install_package tree-sitter-cli
  install_package eza

  log "Creating config directories"
  ensure_dir "$HOME/.config"
  ensure_dir "$HOME/.config/tmux"

  log "Creating symlinks"
  link_file "$DOTFILES_DIR/nvim/config" "$HOME/.config/nvim"
  link_file "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  link_file "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

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
  printf "  2. Start Neovim and run: :Lazy sync\n"
  printf "  3. Then run: :TSUpdate\n"
}

main "$@"
