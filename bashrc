# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# let's work in vi mode (http://www.catonmat.net/download/bash-vi-editing-mode-cheat-sheet.txt)
set -o vi
# set some bindings
[ -f ~/.bash_bindings ] && . ~/.bash_bindings

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

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

# git aliasses
alias gc='/usr/bin/git commit'
alias gs='/usr/bin/git status'
alias gpush='/usr/bin/git push'
alias gpp='/usr/bin/git pull && /usr/bin/git push'
alias gdep='/usr/bin/git pull && /usr/bin/git push && cap deploy'
alias gstash='/usr/bin/git stash'
alias gpop='/usr/bin/git stash pop'
alias gstashdep='gstash && gpp && gpop && cap deploy'
alias gpull='/usr/bin/git pull'
alias gl="/usr/bin/git lg"
alias gla="/usr/bin/git lg --all"
alias gm="/usr/bin/git mv"
alias gr="/usr/bin/git rm"
alias ga="/usr/bin/git add"
alias gaf="/usr/bin/git add --force"
alias gb="/usr/bin/git branch"
alias gd="/usr/bin/git diff"
alias gdc="/usr/bin/git diff --cached"
alias gdw="/usr/bin/git diff --color-words"
alias gdt="/usr/bin/git difftool"
alias go="/usr/bin/git checkout"
alias gob="/usr/bin/git checkout -b"
alias gitx="gitg --all"
alias capdep='cap deploy'

alias chrome='/opt/google/chrome/chrome'

# TMUX aliasses
alias tn='tmux new -s '
alias ta='tmux attach -t '
alias tl='tmux ls'

# Backup
rsyncopts='-avz --exclude=lost+found --no-perms --no-owner --no-group --append-verify'
alias bck_foto='rsync ${rsyncopts} --exclude-from=/data/foto/.excludefile  /data/foto/ /netwerk/foto/'
alias bck_home='rsync ${rsyncopts} --exclude-from=/home/alex/.excludelist --delete /home/alex/ /netwerk/home-alex/'
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
alias sad='ssh-add ~/.ssh/id_rsa_nedap.local;ssh-add ~/.ssh/id_rsa_nedap_moves;ssh-add ~/.ssh/id_rsa_swen.nu'

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

# FUNCTIONS
die () {
  # if you use die, then use return after die to make sure the rest of a function is not executed
  rc=$1
  shift
  echo "==========================">&2
  echo "====    FATAL  ERROR  ====" >&2
  echo "==========================">&2
  echo "" >&2
  echo $@ >&2
}

duration () {
  before=$1
  after="$(date +%s)"
  elapsed="$(expr $after - $before)"
  hours=$(($elapsed / 3600))
  elapsed=$(($elapsed - $hours * 3600))
  minutes=$(($elapsed / 60))
  seconds=$(($elapsed - $minutes * 60))
  time_running="${hours}:${minutes}:${seconds}"
}

log_msg () {
  duration ${before_total}
  message="$1"
  echo "${time_running} $1"|tee -a ${short_log}
}

# This lists all available luks encrypted partitions
listluks () {
sudo fdisk -l 2>&1|awk '/^\/dev\/sd[a-z][0-9]/ {print $1}'|while read part;do
  sudo cryptsetup isLuks ${part} && echo -n "$part "
done
}

mnt_cryptdisk () {
  # this function needs a file that holds a table of uuid => name matches
  listfile=~/.cryptvolumes
  # without that file this excercise doesn't make sense
  if [ ! -s "${listfile}" ];then
    die 1 "Listfile ${listfile} not found"
    return
  fi

  # I need to know what to do
  if [ -z "$1" ];then
    die 1 "you have to tell which volume"
    return
  fi

  # $1 has to be declared in $listfile
  uuid=$(awk -v vol="$1" '$0 ~ " "vol {print $1}' ${listfile})
  # if uuid is empty exit
  if [ -z "${uuid}" ];then
    die 1 "no uuid found in ${listfile} for $1"
    return
  fi

  # check if there is a volume available with this uuid
  part=$(sudo blkid|awk -v uuid="${uuid}" '$2 ~ uuid {sub (/:/, ""); print $1}')
  # if the partition is not found stop
  if [ -z "${part}" ];then
    die 1 "no partition found for ${uuid}. Is the device plugged?"
    return
  fi

  # let's try to open the vault
  sudo cryptsetup luksOpen ${part} $1
  # this should result is a special device /dev/mapper/$1
  if [ ! -L /dev/mapper/$1 ];then
    die 1 "cryptsetup failed"
    return
  fi

  # now let's mount
  [ -d /mnt/$1 ]|| sudo mkdir -p /mnt/$1
  sudo mount /dev/mapper/$1 /mnt/$1

  echo "I mounted a cryptdisk with the name $1 and uuid ${uuid} on partition ${part} to /mnt/$1"
  df -TH /mnt/$1
  l /mnt/$1
}

# remove a mounted disk properly
umnt_cryptdisk () {

  # I need to know what to do
  if [ -z "$1" ];then
    die 1 "you have to tell which volume"
    return
  fi

  # if mounted umount
  [ "$(grep /mnt/$1 /proc/mounts)" ] && sudo umount /mnt/$1

  # if luksopened close
  [ -b /dev/mapper/$1 ] && sudo cryptsetup luksClose $1
}

# this might install or update java...
fix_java () {
  # I need to know where to download from
  if [ $# -lt 2 ];then
    echo "usage: fix_java <url> <version>"
    echo "example: fix_java http://javadl.sun.com/webapps/download/AutoDL?BundleId=78697 jre1.7.0_25"
    return
  fi

  # check dir
  [ -d /usr/$2 ] || curl $1 | sudo tar zxvf - -C /usr
  ln -sf /usr/$2 /usr/java

  # fix google chrome plugin
  gcpplugins=/opt/google/chrome/plugins
  [ -d ${gcplugins} ]|| sudo install -dm 755 ${gcplugins}
  [ -L ${gcplugins}/libnpjp2.so ]|| sudo ln -s /usr/java/lib/amd64/libnpjp2.so ${gcplugins}/libnpjp2.so

  # fix ff plugin
  ffplugins=$(awk -v homedir=~ '/Path/ {sub (/Path=/, ""); print homedir"/.mozilla/firefox/"$1"/plugins" }' ~/.mozilla/firefox/profiles.ini)
  [ -L ${ffplugins}/libnpjp2.so ]|| sudo ln -s /usr/java/lib/amd64/libnpjp2.so ${ffplugins}/libnpjp2.so
}


# This function should make extracting archives easy. I copied it from Hunner but it doesn't work for me and i never tried to find out why...
ex () {
  if whence gtar > /dev/null ; then
    TAR=gtar
  else
    TAR=tar
  fi
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2) $TAR xvjf $1  ;;
      *.tar.gz)  $TAR xvzf $1  ;;
      *.tar.xz)  $TAR xvJf $1  ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.xz)      unxz $1       ;;
      *.tar)     $TAR xvf $1   ;;
      *.tbz2)    $TAR xvjf $1  ;;
      *.tbz)     $TAR xvjf $1  ;;
      *.tgz)     $TAR xvzf $1  ;;
      *.txz)     $TAR xvJf $1  ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# This is to have a branch indication in PS1 when in a git repo
parse_git_branch () {
ref=$(git symbolic-ref HEAD 2> /dev/null) && echo "$(date +%H:%M:%S) $(pwd) ("${ref#refs/heads/}")" || echo "$(date +%H:%M:%S) ${USERNAME}@${HOSTNAME} $(pwd)"
}
PS1="\$(parse_git_branch)\$ "

# this is here for the sake of ruby puppet
# export RUBYLIB=/data/git/nedap/puppet/modules/hiera/lib:/data/git/nedap/puppet/modules/hiera-puppet/lib
export PATH=/data/git/nedap/puppet/modules/hiera/bin:$PATH

# have some colour support in tmux
[ -z "$TMUX" ] && export TERM=xterm-256color

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

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
