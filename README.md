# Dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Set up a new machine
1. Install **chezmoi**.
2. Edit `~/.config/chezmoi/chezmoi.toml`, `.gitconfig` will be configured from
   this file:

        [data]
            name = "Name me"
            email = "email@address.org"

3. Run `chezmoi init --apply $GITHUB_USERNAME`.


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
