# Dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Set up a new machine

1.  Install **chezmoi**.
2.  Create `~/.config/chezmoi/chezmoi.toml` file with the following content:

        [data]
            name = "Name me"
            email = "email@address.org"

    This data will be used to configure `.gitconfig`.
3.  Run `chezmoi init --apply SnichOne`.

## Basic usage

1. Run `chezmoi add $FILE` to add a new file to the dotfiles,
2. Run `chezmoi edit $FILE` to edit a file in the dotfiles,
3. Run `chezmoi apply -v` to apply changes from *working copy*,
4. Run `chezmoi diff` to check what changes chezmoi will make to your home directory.
5. Run `chezmoi merge $FILE` if you are unsatisfied with changes from `chezmoi diff`.
6. Run `chezmoi update -v` to pull and apply the latest changes from your git
   repo (by default, chezmoi will run `git pull --autostash --rebase
   [--recurse-submodules]`).

**Note** `$FILE` is a file in your home directory (e.g. `~/.zshrc`).

For more, see [chezmoi User Guide](https://www.chezmoi.io/user-guide/command-overview/).


## Prerequisites

### Optional dependencies

These are automatically installed on Arch Linux using the
`run_once-after_install-packages.sh` script.

1. zsh
2. direnv
3. kitty
4. mpv
5. parallel
6. bat
7. tmux
8. Neovim and coc.nvim dependencies: python and nodejs.
9. Emacs
10. pandoc

## Scripts

1. `run_once_after_install-packages.sh` automatically installs [optional
   dependencies](#optional-dependencies) if the operating system is Arch Linux.
2. `run_once_after_install-nvim-plugins.sh` automatically installs Neovim
   plugins through [vim-plug](https://github.com/junegunn/vim-plug).

Excerpt from chezmoi's documentation:

- Scripts with the `run_once_` prefix are run only if they have not been run
  before.
- Scripts with `before_`/`after_` in prefix are run before/after the dotfiles
  are updated
