#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Set a decent console font (if in a tty)
if [ $TERM = 'linux' ] 
then
  setfont latarcyrheb-sun32
fi

# Load bash aliases
if [ -f ~/.aliases ]; then
. ~/.aliases
fi

# Use custom rc for ranger
export RANGER_LOAD_DEFAULT_RC='FALSE'
