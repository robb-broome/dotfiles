# this bashrc should have only stuff that applies to this workstation.
# MacPorts Installer addition on 2009-09-02_at_22:11:08: adding an appropriate PATH variable for use with MacPorts.
PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=~/bin:$PATH
PATH=/usr/local/git/bin:$PATH
PATH=/usr/local/mysql/bin:$PATH
PATH=/opt/local/bin:$PATH
PATH=$PATH:/usr/local/pgsql/bin
PATH=$PATH:/Users/robb/.rvm/gems/ruby-1.8.7-p302@scroogeit/gems/
export PATH

export CLASSPATH=$HOME
export EVENT_NOKQUEUE=1
export DYLD_LIBRARY_PATH=Users/Robb/bin/instantclient_10_2
export DOTFILES=$HOME/dotfiles

#source $DOTFILES/eccrc
#source $DOTFILES/mmhrc
#source $DOTFILES/affinityrc
#source $DOTFILES/macpythonrc
source $DOTFILES/bashrc
#source $DOTFILES/lonrc
source $DOTFILES/promptrc

 if [[ -s /Users/robb/.rvm/scripts/rvm ]] ; then source /Users/robb/.rvm/scripts/rvm ; fi

 dubig() {  
   [ -z "$1" ] && echo "usage: dubig sizethreshKB [duargs]" && return  
   du $2 | awk '{ if ($1 > '$1') { print $0} }'  
 }
