SHELL := /bin/bash

.PHONY: help bootstrap sync relink nvim tmux reload-tmux

help:
	@echo "make bootstrap  -> full setup"
	@echo "make sync       -> git pull"
	@echo "make relink     -> recreate symlinks"

bootstrap:
	./bootstrap.sh

sync:
	git pull

relink:
	ln -sfn "$(PWD)/nvim/config" "$(HOME)/.config/nvim"
	ln -sfn "$(PWD)/tmux/.tmux.conf" "$(HOME)/.tmux.conf"
	ln -sfn "$(PWD)/starship/starship.toml" "$(HOME)/.config/starship.toml"

nvim:
	nvim

tmux:
	tmux attach -t main || tmux new -s main

reload-tmux:
	tmux source-file ~/.tmux.conf
