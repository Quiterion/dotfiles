#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Load bash aliases
if [ -f ~/.aliases ]; then
. ~/.aliases
fi

# Export custom scripts to path
export PATH="$HOME/.local/bin:$PATH"

# Use custom rc for ranger
export RANGER_LOAD_DEFAULT_RC='FALSE'

# Use dope ass colourscheme
(cat ~/.cache/wal/sequences &)
