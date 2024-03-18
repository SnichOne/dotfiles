# Dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Set up a new machine

1.  Install **chezmoi**.
2.  Create `~/.config/chezmoi/chezmoi.toml` file with the following content:

        [data]
            name = "Name me"
            email = "email@address.org"
            github_user = "GitHub username"  # Optional (used for Magit Forge)

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

1. `run_once_before_install-packages.sh` automatically installs [optional
   dependencies](#optional-dependencies) if the operating system is Arch Linux.
2. `run_once_after_install-nvim-plugins.sh` automatically installs Neovim
   plugins through [vim-plug](https://github.com/junegunn/vim-plug).

Excerpt from chezmoi's documentation:

- Scripts with the `run_once_` prefix are run only if they have not been run
  before.
- Scripts with `before_`/`after_` in prefix are run before/after the dotfiles
  are updated

## Use cases

### Python virtual environments

In general, there are many tools to manage virtual environments for Python
runtime, e.g., built-in [venv](https://docs.python.org/3/library/venv.html) (in Python 3.3+),
[poetry](https://python-poetry.org/),
[pipenv](https://pipenv.pypa.io/en/latest/), [conda](https://conda.io/).

So I wanted to have a convenient uniform interface to all of them. And it seems
that [direnv](https://direnv.net/) covers that and works on a per-project basis.

To manage virtual environment for a project with direnv, you need to create an
`.envrc` file in the project root directory. E.g., if the project is managed by
`venv` then the `.envrc` should contain:

    layout python

The first time the .envrc is loaded it will automatically create the virtualenv
under .direnv/python-$python_version. The sandbox is also automatically
activated whenever direnv loads the .envrc file (although the prompt won't
change by default, however see [here](https://github.com/direnv/direnv/wiki/PS1)
or [here](https://github.com/direnv/direnv/wiki/Python#restoring-the-ps1)).

It is also possible to integrate direnv with Emacs or Vim.

For more, see [direnv wiki](https://github.com/direnv/direnv/wiki/Python#restoring-the-ps1).


## Ideas for possible improvements

- The [asdf](https://asdf-vm.com/) tool seems to be interesting, it supports
  multiple runtime environments on a per-project basis. It is like gvm, nvm,
  rbenv & pyenv (and more) but all in one tool.
