#!/bin/bash

if [ "$(uname -s)" = 'Linux' ]; then
	SCRIPT=$(readlink -f $0)
elif [ "$(uname -s)" = 'Darwin' ]; then
	SCRIPT=`perl -e 'use Cwd "abs_path";print abs_path(shift)' $0`
else
	echo "Kernel not recognized, exiting."
	exit 1
fi

DIR=`dirname $SCRIPT`

if [ -e ~/.vim ]; then
	while true; do
		read -e -p "WARNING .vim file found, this setup script will erase it. Would you like make a backup as .vim.bkp [YnC] ? " backup
		case $backup in
			[Cc]* ) echo "Setup cancelled."; exit;;
			[Nn]* ) rm -rf ~/.vim; break;;
			[Yy]* ) 
				if [ -e ~/.vimrc.bkp ]; then
					while true; do
						read -p "Replace already existing backup [YnC] ? " replace;
						case $replace in
							[Cc]* ) echo "Setup cancelled."; exit;;
							[Nn]* ) rm -rf ~/.vim; break;;
							[Yy]* ) mv ~/.vim ~/.vim.bkp; echo '.vim saved as .vim.bkp'; break;;
							* ) echo "Please type Y (yes), N (no) or C (cancel)";;
						esac;
					done
				else
					mv ~/.vim ~/.vim.bkp
					echo '.vim saved as .vim.bkp'
				fi; break;;
			* ) echo "Please type Y (yes), N (no) or C (cancel)";;
		esac
	done
fi

ln -s $DIR/rmvim ~/.vim

if [ -e ~/.vimrc ]; then
	while true; do
		read -p "WARNING .vimrc file found, this setup script will erase it.Would you like to make a backup as .vimrc.bkp [YnC] ? " backuprc
		case $backuprc in
			[Cc]* ) exit; echo "Setup cancelled.";;
			[Nn]* ) rm ~/.vimrc; break;;
			[Yy]* ) 
				if [ -e ~/.vimrc.bkp ]; then
					while true; do
						read -p "Replace already existing backup [YnC] ? " replacerc;
						case $replacerc in
							[Cc]* ) exit; echo "Setup cancelled.";;
							[Nn]* ) rm ~/.vimrc; break;;
							[Yy]* ) mv ~/.vimrc ~/.vimrc.bkp; echo '.vimrc saved as .vimrc.bkp'; break;;
							* ) echo "Please type Y (yes), N (no) or C (cancel)";;
						esac;
					done
				else
					mv ~/.vimrc ~/.vimrc.bkp
					echo '.vimrc saved as .vimrc.bkp'
				fi; break;;
			* ) echo "Please type Y (yes), N (no) or C (cancel)";;
		esac
	done
fi

ln -s $DIR/rmvimrc ~/.vimrc
