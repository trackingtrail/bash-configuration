case $- in
    *i*) ;;
      *) return;;
esac

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:~/.local/bin:/snap/bin:$PATH

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 1 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]☺\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]☺\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\34	2\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\033[1;32m\]\342\224\200\$([[ \$ == *\"10.\"* ]] && echo \"[\[\033[1;34m\]\$(/opt/vpnserver.sh)\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\$()\[\033[1;32m\]]\342\224\200\")[\[\033[1;37m\]\u\[\033[01;32m\]@\[\033[01;34m\]\h\[\033[1;32m\]]\342\224\200[\[\033[1;37m\]\w\[\033[1;32m\]]\n\[\033[1;32m\]\342\224\224\342\224\200\342\224\200\342\225\274 [\[\e[01;33m\]★\[\e[01;32m\]]\\$ \[\e[0m\]"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ymp3='youtube-dl -x --audio-format mp3 --prefer-ffmpeg ' #downloads youtube-mp3
    alias "c=xclip"
    alias lastten='history | tail'
    alias rot13="tr 'A-Za-z' 'N-ZA-Mn-za-m'"
    alias cls='clear'
    alias v='vim'
    alias rmd='sudo rmdir'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias l='ls -CF'
alias dd='dd status=progress'
alias _='sudo'
alias _i='sudo -i'
alias lsd='ls -d */'
alias htb='sudo openvpn /home/johndoe/desktop/main/pentesting/pentesting/HTB/BatterySoup.ovpn' #this is my HackTheBox openvpn alias.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# user-defined functions (credits: https://github.com/jaivardhankapoor/bestbash/blob/master/functions)

mkcd() {
  if [ $# != 1 ]; then
    echo "Usage: mkcd <dir>"
  else
    mkdir -p $1 && cd $1
  fi
}

if which systemctl &>/dev/null; then
  start() {
    sudo systemctl start $1.service
  }
  restart() {
    sudo systemctl restart $1.service
  }
  stop() {
    sudo systemctl stop $1.service
  }
  enable() {
    sudo systemctl enable $1.service
  }
  status() {
    sudo systemctl status $1.service
  }
  disable() {
    sudo systemctl disable $1.service
  }
fi

force_color_prompt=yes
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''
