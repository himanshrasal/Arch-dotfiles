# ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"
export TERMINAL=foot
export EDITOR=nvim

export QT_QPA_PLATFORMTHEME=qt6ct      # ← Use this only
export QT_STYLE_OVERRIDE=kvantum       # ← Enables Kvantum

# aliases
alias ll='ls -lh --color=auto'
alias ls='ls --color=auto'
alias shutdown='shutdown 0'
alias hibernate="sudo systemctl hibernate"
alias flatseal='flatpak run com.github.tchx84.Flatseal'
alias bottles='flatpak run com.usebottles.bottles'

# Pywal
(cat ~/.cache/wal/sequences &)
source ~/.cache/wal/colors-tty.sh

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

