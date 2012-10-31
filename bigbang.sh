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
	command -v git || {
		echo " -> Installing git"
		$pm install git
	}

	# Installing node.js
	command -v node || {
		echo " -> Installing node.js"
		$pm install node
	}

	# Installing npm
	command -v npm || {
		echo " -> Installing npm"
		curl https://npmjs.org/install.sh | sh
	}

	# Installing npm grunt
	command -v grunt || {
		echo " -> Installing grunt"
		npm install -g grunt
	}

else
	echo "Package manager not detected. Sad :-("
fi