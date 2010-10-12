# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias r='rails'

# rails shortcuts from http://blog.envylabs.com/2010/07/common-rails-command-shortcuts/
function be {
  bundle exec $@
                }

function ber {
  bundle exec rails $@
                }

function berg {
  bundle exec rails generate $@
                }

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
fi
# stop screen from complaining with wuff-wuff!
alias screen='TERM=screen screen'

# use vim style editing on the command line
#set -o vi

#function parse_git_dirty {
#  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
#}

#function parse_git_branch {
#      git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
#}

#export PS1='\h:\W$(parse_git_branch "[\[\e[0;32m\]%s\[\e[0m\]\[\e[0;33m\]$(parse_git_dirty)\[\e[0m\]]")$ '
# see: http://stufftohelpyouout.blogspot.com/2010/01/show-name-of-git-branch-in-prompt.html
# see also: http://superuser.com/questions/31744/how-to-get-git-completion-bash-to-work-on-mac-os-x
# see also: http://stackoverflow.com/questions/347901/what-are-your-favorite-git-features-or-tricks
# install http://macports.org/
# sudo port selfupdate
# sudo port install git-core +bash_completion
#if [ -f /opt/local/etc/bash_completion ]; then
#    . /opt/local/etc/bash_completion
#    PS1='[\h \W$(__git_ps1 " (%s)")]\$ '
#fi
