# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# 查看wsl启动时的路由表：ip route 或 route -n  可得知如何配置使得wsl能联通外网
# save WSL up ip
export WSL_UP_IP=`ifconfig eth0 | grep "inet " | awk '{print $2}'`
export WSL_UP_MASK=`ifconfig eth0 | grep "inet " | awk '{print $4}'`
export WSL_UP_GW=`ip route | grep default`
export WSL_UP_ROUTE=`ip route | grep / | awk '{print $1,$2,$3}'`
