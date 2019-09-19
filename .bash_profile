#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

wal -R

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
