if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

case "$TERM" in
    xterm-256color) color_prompt=yes;;
    xterm-color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function parse_git_branch {
	sed -e 's/ref: refs\/heads\/\(.*\)/ (\1)/' .git/HEAD 2> /dev/null
}

if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
	PS1='\[\033[00;36m\][\t] \[\033[01;31m\]\h\[\033[01;34m\] \W \[\033[00;34m\]\$\[\033[00m\] '
    else
	PS1='\[\033[00;32m\]\u@\h\[\033[01;34m\] \W\[\033[00;33m\]$(parse_git_branch) \[\033[00;34m\]\$\[\033[00m\] '
    fi
else
    PS1='[\t] \u@\h \W$(parse_git_branch) \$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	eval "`dircolors -b 2> /dev/null`"
fi
if [ -x /usr/bin/dircolors ] || [[ -f ~/.dir_colors ]]; then
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls -G'

alias yui='java -jar ~/bin/yuicompressor-2.4.2.jar'

# Other configuration
export EDITOR="vim"
export PATH="$HOME/bin:$PATH"

# Git bash completion
if [ -f ~/bin/git-completion.sh ]; then
	. ~/bin/git-completion.sh
fi
