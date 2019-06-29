# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# TODO: (some advices from emg in #bash)
#2) all capital variable names
#3) echo's -e and -n (not as big of a deal, still recommend against it)
#4) unquoted expansions (you should always quote expansions, I can count the number of exceptinos on one hand)
#5) echo expansions
#6) use of [ instead of [[ (can be done safely, but when in bash just use [[)
#7) you should pm greybot the following to read more: varcap, echo, quotewhen, test, which

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set some bindings
[ -f ~/.bash_bindings ] && . ~/.bash_bindings

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=200000
HISTTIMEFORMAT="|%F %T| "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# cd into a dir if it was typed without cd
shopt -s autocd

# allow for small typo's
shopt -s cdspell
shopt -s dirspell

# check for background jobs
shopt -s checkjobs

# ** and **/
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# FUNCTIONS
if [ -d ~/.bash_functions.d ];then
  for FUNCTION in ~/.bash_functions.d/*;do
    source ${FUNCTION}
  done
fi

# get colours
[ -f ~/.bash_colours ] && . ~/.bash_colours

PROMPT_COMMAND=prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -lah'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# requires package libnotify-bin
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && printf '%s' "terminal" || printf '%s' "error")" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -p'
alias fetch='curl -LO'

# git aliasses
alias ga='/usr/bin/git add'
alias gaf='/usr/bin/git add --force'
alias gb='/usr/bin/git branch -vvv'
alias gc='/usr/bin/git commit'
alias gd='/usr/bin/git diff'
alias gdc='/usr/bin/git diff --cached'
alias gdep='/usr/bin/git pull && /usr/bin/git push && cap deploy'
alias gdt='/usr/bin/git difftool'
alias gdw='/usr/bin/git diff --color-words'
alias gitx='gitg --all'
alias gl='/usr/bin/git lg'
alias gla='/usr/bin/git lg --all'
alias gm='/usr/bin/git mv'
alias go='/usr/bin/git checkout'
alias gob='/usr/bin/git checkout -b'
alias gpop='/usr/bin/git stash pop'
alias gpp='/usr/bin/git pull && /usr/bin/git push'
alias gpull='/usr/bin/git pull'
alias gpush='/usr/bin/git push'
alias gr='/usr/bin/git rm'
alias gs='/usr/bin/git status'
alias gstash='/usr/bin/git stash'
alias gstashdep='gstash && gpp && gpop && cap deploy'
alias gitcleanbranches="go master;git branch --merged|grep -v '^*'|xargs -n 1 git branch -d"

alias capdep='cap deploy'
alias chrome='/opt/google/chrome/chrome'

# TMUX aliasses
alias tn='tmux new -s '
alias ta='tmux attach -t '
alias tl='tmux ls'
alias ltmux="if tmux has-session -t $USER; then tmux attach -t $USER; else tmux new -s $USER; fi"

rsyncopts='-av --exclude=lost+found --no-perms --no-owner --no-group'

# admin aliasses
alias hgrep='history|grep -i'
alias sudi='sudo -i'
alias meminfo='ps -eo pid,user,pmem,rss,vsz,cmd --sort rss'
alias top='top -cHd1'
alias df='df -TH'
alias tailf='tail -f'
alias dusort='du -h --time --max-depth=1|sort -hr'
alias upgrade='sudo apt update;sudo apt -V dist-upgrade;sudo apt-get autoremove'

# XrandR
alias xra_home='xrandr --output LVDS --off --output DisplayPort-2 --auto --output VGA-0 --auto --left-of DisplayPort-2 --verbose'
alias xra_laptop='xrandr -s 1600x900 --output LVDS --auto --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output VGA-0 --off'
alias xra_tweedescherm='xrandr --output LVDS --auto --output DisplayPort-1 --off --output DisplayPort-2 --auto --right-of LVDS  --output VGA-0 --off'
alias xra_dp_laptop='xrandr --output LVDS --auto --output DisplayPort-0 --auto --right-of LVDS'
alias xra_beamer_1024='xrandr --output LVDS --auto --output VGA-0 --auto --right-of LVDS'

# some standard settings and functions
alias date_ymd='date +%Y%m%d'
alias date_time='date +%Y-%m-%d\ %T'
alias date_time_short='date +%Y%m%d%H%M%S'

# setup my favorite editor
export EDITOR=/usr/bin/vim

# source specific stuff for my work
[ -x ~/.nedaprc ] && . ~/.nedaprc

# source specific stuff for my other work
[ -x ~/.melkwegrc ] && . ~/.melkwegrc

# source specific stuff for my network
[ -x ~/.swenrc ] && . ~/.swenrc

alias vagrant='/usr/bin/vagrant'

alias ':qa'='exit'

[ -d "$HOME/bin" ] && PATH="$HOME/bin:$PATH"

# Add stpst package to path
if [ -d /opt/stpst/embedded/bin ];then
  export PATH="/opt/stpst/embedded/bin:$PATH"
fi

complete -C /data/software/vault/vault vault
