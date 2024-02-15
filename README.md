# To clone this

```sh
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:otavioschwanck/lunardotfiles.git tmpdotfiles
rsync --recursive --verbose --exclude '.git' tmpdotfiles/ $HOME/
rm -r tmpdotfiles
cd ~/.dotfiles/
dotfiles config --local status.showUntrackedFiles no

or

# More risky:
git clone --separate-git-dir=$HOME/.dotfiles git@github.com:otavioschwanck/lunardotfiles.git ~
```

# Dependencies:

Mac Packages:
install git-delta readline openssl zlib postgresql sqlite libffi ripgrep tmux tmuxinator alacritty bash fd

Ubuntu Packages:
sqlite3 libsqlite3-dev xclip python3-pip tmux build-essentials

(try to install delta too)

NPM:
neovim diagnostic-languageserver

Gems:
solargraph neovim bundler

Pip:
pip install neovim-remote pynvim --quiet

# SKHD
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
