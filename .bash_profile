# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export JAVA_HOME=$HOME/java/latest

PATH=$JAVA_HOME/bin:$PATH:$HOME/.local/bin:$HOME/bin

export PATH

ll="ls -lh"

