#!/bin/bash

unamestr=`uname`
pm='unknown'

if [[ "$unamestr" == 'Darwin' ]]; then

	# Great! It's Mac OS

	# Installing brew
	command -v brew || {
		echo " -> Installing brew"
		ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"
	}

	pm='brew'

elif [[ "$unamestr" == 'Linux' ]]; then
	# Detect package manager
	if [ -f /etc/redhat-release ] ; then
		pm='yum'
	elif [ -f /etc/debian_version ] ; then
		pm='apt-get'
	fi
fi

echo "Your package manager: $pm"

if [[ "$pm" != 'unknown' ]]; then

	# Installing git 
	command -v ack || {
		echo " -> Installing ack"
		$pm install ack
	}

else
	echo "Package manager not detected. Sad :-("
fi