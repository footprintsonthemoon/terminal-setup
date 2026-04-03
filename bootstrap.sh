#!/usr/bin/env bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"

echo "Installing core tools with Homebrew..."
brew install neovim tmux starship git ripgrep fd tree-sitter-cli

echo "Creating configuration directories..."
mkdir -p ~/.config
mkdir -p ~/.config/tmux

echo "Linking configuration files..."
ln -sfn "$REPO_ROOT/nvim/config" ~/.config/nvim
ln -sfn "$REPO_ROOT/tmux/.tmux.conf" ~/.config/tmux/tmux.conf
ln -sfn "$REPO_ROOT/starship/starship.toml" ~/.config/starship.toml

echo "Setup complete."
echo "Next steps:"
echo "  1) Open tmux and install TPM plugins with prefix + I"
echo "  2) Start Neovim and run :Lazy sync and :TSUpdate"
echo "  3) Ensure your shell loads Starship"
