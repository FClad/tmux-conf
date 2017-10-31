#!/bin/bash

# Retrieve path to the current directory
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ] ; do SOURCE="$(readlink "$SOURCE")"; done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Create a symbolic link to this folder from $HOME/.tmux
if [ "${DIR}" != "${HOME}/.tmux" ]; then
	if [ -e "${HOME}/.tmux" ]; then
		echo "Warning: a .tmux folder already exists. Old folder moved to tmux_bak."
		mv ${HOME}/.tmux ${HOME}/tmux_bak
	fi
	echo "Creating symbolic link for .tmux folder."
	ln -s ${DIR} ${HOME}/.tmux
fi

# Create a symbolic link to tmux.conf file from $HOME/.tmux.conf
if [ ! -L "${HOME}/.tmux.conf" ]; then
	if [ -e "${HOME}/.tmux.conf" ] ; then
		echo "Warning: a .tmux.conf file already exists. Old file moved to tmux.conf_bak."
		mv ${HOME}/.tmux.conf ${HOME}/tmux.conf_bak 
	fi
	echo "Creating symbolic link for .tmux.conf file."
	ln -s ${DIR}/tmux.conf ${HOME}/.tmux.conf
fi

echo "If not already installed, please run 'brew install reattach-to-user-namespace' before attempting to start tmux"

