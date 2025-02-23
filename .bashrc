# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
    * ) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Color Variables For debian_chroot(T:Thin, B:Blod)
T_BL='\[\033[00;30m\]' B_BL='\[\033[01;30m\]'
T_RE='\[\033[00;31m\]' B_RE='\[\033[01;31m\]'
T_GR='\[\033[00;32m\]' B_GR='\[\033[01;32m\]'
T_YL='\[\033[00;33m\]' B_YL='\[\033[01;33m\]'
T_BU='\[\033[00;34m\]' B_BU='\[\033[01;34m\]'
T_PR='\[\033[00;35m\]' B_PR='\[\033[01;35m\]'
T_DG='\[\033[00;36m\]' B_DG='\[\033[01;36m\]'
T_WT='\[\033[00;37m\]' B_WT='\[\033[01;37m\]'
C_ED='\[\033[00m\]'

function git_branch
{
    branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
    if [ "${branch}" != "" ];then
        if [ "${branch}" = "(no branch)" ];then
            branch="(`git rev-parse --short HEAD`...)"
        fi
        echo "($branch)"
    fi
}

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}'$B_DG'[\u'$B_YL'♔'$B_BU'\h'$T_BU':'$T_DG'\w'$T_PR'$(git_branch)'$B_DG']'$C_ED'\$ '
    PS1='${debian_chroot:+($debian_chroot)}'$B_DG'[\u'$B_YL'♔'$B_BU'ubuntu18'$T_BU':'$T_DG'\w'$T_PR'$(git_branch)'$B_DG']'$C_ED'\$ '
else
    PS1='[${debian_chroot:+($debian_chroot)}\u@\h:\w]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \W\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -hl'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# svn alias
alias sdf='svn diff'
alias sdi='svn diff -r'    #+logid 查看当前版本与logid版本的区别, 若加"logid_old:logid_new"则比较此两个版本的区别(注意顺序)
alias sup='sudo svn update'
alias sst='svn status | grep ^M'
alias slo='svn log -v | less'

# my cmd alias
alias py='python3'
alias nx='netwox'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash
fi

# Make manpage have color
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# 指定less为默认阅读器
export PAGER=less
export EDITOR=vim
export SVN_USER=git
export SVN_PWD=git
export KCONFIG_NOTIMESTAMP=1
export SSH_TTY=`tty`

# Add some basic tools for the xDSL Router Project
export OLDPATH=$PATH

if [ -f ~/bin/release_me.sh ]; then
    . ~/bin/release_me.sh; set_root_path --init
fi

if [ -f ~/bin/rbpost.sh ]; then
    . ~/bin/rbpost.sh;
fi

#if [ -f ~/workspace/test/shell/myrelease.sh ]; then
    #. ~/workspace/test/shell/myrelease.sh;
#fi

#load rfc.sh
if [ -f ~/bin/rfc.sh ]; then
    . ~/bin/rfc.sh;
fi

if [ -f ~/bin/functions ]; then
	. ~/bin/functions
	dir 1       # choose which enviroment: 1:~/workspace/; 2:~/workroom/; 3:~/

	dir P53_NX_MK
	#dir workroom
	#dir learnspace
fi

#发送当前路径到Terminal
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'

#配置X11远程显示, (改用secureCRT的X11转发实现，这里就不用再指定了, 但是延迟大)
export DISPLAY=$(ip route list default | awk '{print $3}'):0
#export DISPLAY=`who | grep pts | awk -F '[()]' 'NR==1 {print $2}'`":0.0"
export LIBGL_ALWAYS_INDIRECT=1 #解决libGL报错

#export TERM=linux

#可执行程序路径 PATH
export PATH=$PATH:/usr/local/bin:./:/usr/lib:~/win_cmd
#export PATH=$PATH:/opt/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin #树莓派

#依赖库路径 LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/usr/lib:/usr/local/lib
export GST_PLUGIN_PATH=/usr/local/lib:/usr/lib/x86_64-linux-gnu/gstreamer-1.0

