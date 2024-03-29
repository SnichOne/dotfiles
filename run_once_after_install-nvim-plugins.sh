#!/usr/bin/env sh

# Proceed only if nvim is installed
if command -v nvim &> /dev/null
then
    # Create Neovim 'backupdir'.
    mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}"/nvim/backup/
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    nvim +PlugInstall +qall
    nvim +CocInstall +qall
fi
