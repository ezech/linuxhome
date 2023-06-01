# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
#export TERM=xterm-256color
#export TERM=rxvt-256color
#export TERM=rxvt
export EDITOR=vim

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk

export HISTTIMEFORMAT="%d.%m.%Y %T "
export HISTSIZE=2000
export HISTFILESIZE=999999

export XKB_DEFAULT_LAYOUT=pl
export XKB_DEFAULT_MODEL=pc105
export XKB_OPTIONS="lv3:ralt_switch,compose:rctrl,terminate:ctrl_alt_bksp"
#export XKB_DEFAULT_VARIANT=

#source ~/.openstack_passwords

# User specific aliases and functions
alias mobile="kdeconnect-cli -d bd7a67ecdfbac0c"
alias gitgud="git add . & git commit & git push"
alias sshfix="ssh-add && ssh-add ~/.ssh/ansible_rsa"
alias sqlplus="rlwrap sqlplus"
alias calm="gcalcli calm"
alias calw="gcalcli calw"
alias agenda="gcalcli agenda"
alias addmeeting="gcalcli import"
alias encrypt="gpg2 -qer 'Arkadiusz Dzik'"
alias ll="exa -l"

eval $(thefuck --alias)
#. /usr/share/powerline/bash/powerline.sh

SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initialising new SSH agent..."
    (umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  eval $(dbus-launch --sh-syntax)
fi

