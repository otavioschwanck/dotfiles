#!/bin/bash

# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.config/nvim
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.config/alacritty
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.zshrc
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.tmux.conf
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/README.md
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.zshrc
# git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/Library/Application\ Support/lazygit/config.yml

git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/.config/nvim
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add -u
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit -m "Sync"
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push
