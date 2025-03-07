# +---+ Default +---+
case $- in
    *i*) ;;
      *) return;;
esac

export LC_ALL=en_US.UTF-8


# +---+ History +---+

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize

# +---+ Appearance +---+
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi


# +---+ Bash Completion +---+
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# +---+ Aliases and Functions +---+
[[ -f $HOME/.bash_aliases ]]   && . $HOME/.bash_aliases
[[ -f $HOME/.bash_functions ]]   && . $HOME/.bash_functions
[[ -f $HOME/.bash_motv ]] && . $HOME/.bash_motv
[[ -f $HOME/.bash_switches ]] && . $HOME/.bash_switches


# +---+ BASH PS1 Customized +---+
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

PS1="\[$(tput setaf 168)  \[$(tput setaf 6)\w\[$(tput setaf 214)\$(parse_git_branch)\[$(tput sgr0)\]\n"

# Site for cheat: https://www.nerdfonts.com/cheat-sheet
# Site for colours: https://robotmoon.com/bash-prompt-generator/


# +---+ ASDF environment +---+
export PATH=$PATH:$HOME/.bin
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

#. "$HOME/.asdf/asdf.sh"
#. "$HOME/.asdf/completions/asdf.bash"

# +---+ For Vim in root +---+
SUDO_EDITOR=/usr/bin/vim
export SUDO_EDITOR
