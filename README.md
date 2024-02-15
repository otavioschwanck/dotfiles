# Disclaimer
This is my personal config, but you can clone and use it as example.

It uses GNU Stow to manage dotfiles (see: https://www.youtube.com/watch?v=y6XCebnB9gs)

You need to have `stow` installed to install those configs.

`brew install stow`
# To clone this

```sh
cd ~/
git clone git@github.com:otavioschwanck/dotfiles.git
cd dotfiles
stow .

# if you already has some of the dotfiles, you can use instead of stow . :
stow --adopt . # This will generate conflicts to be solved on the dotfiles repository, make sure to fix them.
```
# Dependencies:

Mac Packages:
git-delta readline openssl zlib postgresql sqlite libffi ripgrep tmux tmuxinator alacritty bash fd

Ubuntu Packages:
sqlite3 libsqlite3-dev xclip python3-pip tmux build-essentials

(try to install delta too)

NPM:
neovim diagnostic-languageserver

Gems:
solargraph neovim bundler

Pip:
pip install neovim-remote pynvim --quiet

# SKHD and Yabai <3
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
