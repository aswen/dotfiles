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
  for function in ~/.bash_functions.d/*;do
    source ${function}
  done
fi

# get colours
[ -f ~/.bash_colours ] && . ~/.bash_colours

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# have some colour support in tmux
[ -n "$TMUX" ] && export TERM=xterm-256color

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -lah'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# requires package libnotify-bin
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
alias fetch='curl -O'

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

# Backup
rsyncopts='-avz --exclude=lost+found --no-perms --no-owner --no-group --append-verify'
alias bck_foto='rsync ${rsyncopts} --exclude-from=/data/foto/.excludefile  /data/foto/ /netwerk/foto/'
alias bck_foto_usb='rsync ${rsyncopts} --exclude-from=/data/foto/.excludefile  /data/foto/ /mnt/1500g_2/foto/'
alias bck_foto_cider='rsync ${rsyncopts} --exclude-from=/data/foto/.excludefile  /data/foto/ /netwerk/fileserver-foto/'
alias bck_home='rsync ${rsyncopts} --exclude-from=/home/alex/.excludelist --delete /home/alex/ alex@cider.lochem.swen.nu:/home/alex/'
alias bck_home_remote='rsync ${rsyncopts} --exclude-from=/home/alex/.excludelist --delete /home/alex/ alex@lochem.swen.nu:/home/alex/'
alias bck_home_usb='rsync ${rsyncopts} --exclude-from=/home/alex/.excludelist --delete /home/alex/ /mnt/1500g_1/home/alex/'
alias bck_vis='cd /data/vmware;tar cvf - vis|pigz -c >vis.tar.gz'
alias restore_vis='cd /data/vmware;pigz -cd vis.tar.gz|tar xvf -'
alias bck_nico='rsync ${rsyncopts} Documenten/Nicoline/ nico@cider:~/Documenten/'

# admin aliasses
alias pagrep='ps auxf|grep'
alias hgrep='history|grep'
alias sudi='sudo -i'
alias meminfo='ps -eo pid,user,pmem,rss,vsz,cmd --sort rss'
alias top='top -cHd1'
alias tailf='tail -f'
alias dusort='du -h --time --max-depth=1|sort -hr'

# ssh add
alias sad='for key in ~/.ssh/*.priv;do ssh-add -t 28800 ${key};done'

# just for fun
alias say='echo "$1" | espeak -s 120 2>/dev/null'

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
export EDITOR=`which vim`

# source specific stuff for my work
[ -x ~/.nedaprc ] && . ~/.nedaprc

# source specific stuff for my other work
[ -x ~/.melkwegrc ] && . ~/.melkwegrc

# source specific stuff for my network
[ -x ~/.swenrc ] && . ~/.swenrc

# mtp shit (http://www.omgubuntu.co.uk/2011/12/how-to-connect-your-android-ice-cream-sandwich-phone-to-ubuntu-for-file-access)
alias note_connect='mtpfs -o allow_other /mnt/note'
alias note_disconnect='fusermount -u /mnt/note'

alias ':qa'='exit'

if [ -d "$HOME/bin" ];then
  PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.rvm/bin" ];then
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

# this is here for the sake of ruby puppet
# export RUBYLIB=/data/git/nedap/puppet/modules/hiera/lib:/data/git/nedap/puppet/modules/hiera-puppet/lib
if [ -d /data/git/nedap/puppet/modules/hiera/bin ];then
  export PATH=$PATH:/data/git/nedap/puppet/modules/hiera/bin
fi

