# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git extract)

source $ZSH/oh-my-zsh.sh

# User configuration

# n (Node version manager) install path
export N_PREFIX=$HOME/.local
# export XDG_CONFIG_HOME=$HOME/.config
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# alias vi='nvim'
# alias pbcopy='xsel --clipboard --input'
# alias pbpaste='xsel --clipboard --output'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias open='xdg-open'


if type workon >/dev/null 2>&1; then
  VENV_WRAPPER=true
else
  VENV_WRAPPER=false
fi

function _virtualenv_auto_activate() {
    if [ -e "env" ]; then
        # Check for symlink pointing to virtualenv
        if [ -L "env" ]; then
            _VENV_PATH=$(readlink env)
            _VENV_WRAPPER_ACTIVATE=false
            # Check for directory containing virtualenv
        elif [ -d "env" ]; then
            _VENV_PATH=$(pwd -P)/env
            _VENV_WRAPPER_ACTIVATE=false
            # Check for file containing name of virtualenv
        elif [ -f "env" -a $VENV_WRAPPER = "true" ]; then
            _VENV_PATH=$WORKON_HOME/$(cat env)
            _VENV_WRAPPER_ACTIVATE=true
        else
            return
        fi

        # Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != $_VENV_PATH ]; then
            if $_VENV_WRAPPER_ACTIVATE; then
                _VENV_NAME=$(basename $_VENV_PATH)
                workon $_VENV_NAME
            else
                _VENV_NAME=$(basename `pwd`)
                VIRTUAL_ENV_DISABLE_PROMPT=1
                source env/bin/activate
                _OLD_VIRTUAL_PS1="$PS1"
                PS1="($_VENV_NAME)$PS1"
                export PS1
            fi
            echo Activated virtualenv \"$_VENV_NAME\".
        fi
    fi
}

# function chpwd() {
    # _virtualenv_auto_activate
# }
# _virtualenv_auto_activate
precmd() { _virtualenv_auto_activate }

mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# make ctrl+p, ctrl+n behave exactly like up, down arrows correspondingly
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search
bindkey "^[u" kill-line
bindkey "^[k" kill-line


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
