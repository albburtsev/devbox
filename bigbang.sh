#!/bin/bash

unamestr=`uname`
pm='unknown'

if [[ "$unamestr" == 'Darwin' ]]; then

	# Great! It's Mac OS
	command -v brew >/dev/null || {
		echo " > Install brew"
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
	command -v git >/dev/null || {
		echo " > Install git"
		$pm install git
	}

	command -v node >/dev/null || {
		echo " > Install node and npm"
		$pm install node
	}

    command -v jq >/dev/null || {
        echo " > Install jq: http://stedolan.github.io/jq/"
        if [[ "$pm" == 'brew' ]]; then
            brew install jq
        else
            git clone https://github.com/stedolan/jq.git
            cd jq
            autoreconf -i
            ./configure
            make
            make install
            cd ..
            rm -rf jq/
        fi
    }

	command -v grunt >/dev/null || {
		echo " > Install grunt"
		npm install -g grunt-cli
	}

    command -v yo >/dev/null || {
        echo " > Install yeoman"
        npm install -g yo
    }

    command -v replace >/dev/null || {
    	echo " > Install replace"
    	npm install replace -g
    }

    echo "All required packages installed!"
else
	echo "Package manager not detected. Sad :-("
fi