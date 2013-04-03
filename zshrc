# Path to your oh-my-zsh configuration.
ZSH=$DOTFILES/.oh-my-zsh
#ZSH_CUSTOM=$ZSH/custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robb-broome"


# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git heroku osx rails ruby vim pow rvm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=/usr/local/share/npm/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/usr/X11/bin:/usr/local/pgsql/bin:/Users/robb/.rvm/bin
# this bashrc should have only stuff that applies to this workstation.
PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=~/bin:$PATH
PATH=/usr/local/git/bin:$PATH
PATH=/usr/local/mysql/bin:$PATH
PATH=/opt/local/bin:$PATH
PATH=$PATH:/usr/local/pgsql/bin
export PATH

export CLASSPATH=$HOME
export EVENT_NOKQUEUE=1
#export DYLD_LIBRARY_PATH="/usr/local/mysql/bin"
export DOTFILES=$HOME/dotfiles
export LOCAL_RAILS_DEV_ENV=1

#source $DOTFILES/eccrc
#source $DOTFILES/mmhrc
# source $DOTFILES/affinityrc
#source $DOTFILES/sears-stylerc
#source $DOTFILES/macpythonrc
source $DOTFILES/bashrc
#source $DOTFILES/lonrc
#source $DOTFILES/promptrc
source $DOTFILES/mongotestrc
source $DOTFILES/railsrc
source $DOTFILES/environmentrc
source $DOTFILES/qfrc
source $DOTFILES/teamvoicerc
# source $DOTFILES/oscrc
source $DOTFILES/jinglepierc
source $DOTFILES/disneyrc

alias be="bundle exec"
alias ber="bundle exec rails"
alias bek="bundle exec rake"
alias rake='noglob rake'
alias reset_net='sudo ifconfig en3 down; sudo ifconfig en3 up'
alias side='cd /Volumes/Macintosh\ HD\ 2/Robb\ Home\ Folder/work/rails/side_projects/'
alias lighted='cd ~/work/rails/side_projects/lighted'
alias timeline='cd ~/work/rails/side_projects/timeline'

# provided by Jonathan Meeks, updated by me
on_vpn() { export http_proxy=http://uskihsvpcflow.kih.kmart.com:8080 }
off_vpn() { export http_proxy=; reset_net }
###
alias git lg='nocorrect git lg'
function cdf() {
  cd *$1*/
}

dubig() {
   [ -z "$1" ] && echo "usage: dubig sizethreshKB [duargs]" && return
   du $2 | awk '{ if ($1 > '$1') { print $0} }'
 }

