# Based on https://github.com/sapegin/dotfiles/blob/master/includes/bash_functions.bash

# Ban npm if project uses Yarn
npm() {
    if [ -f "yarn.lock" ]; then
        echo "$(tput sgr 0 1)$(tput setaf 1)You should use Yarn for this project.$(tput sgr0)"
        return
    fi
    command npm $@
}

# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# Show weather forecast (by default for Moscow)
# Usage:
# 	weather
# 	weather Berlin
#
function weather() {
	if [ -z "$1" ]
	then city="Moscow"
	else city=$1
	fi

	curl -4 "wttr.in/$city"
}

# Find shorthand
#function f() {
#    find . -name "$1"
#}

# Get gzipped file size
function gz() {
	echo "Original size (bytes): "
	cat "$1" | wc -c
	echo "Gzipped size (bytes): "
	gzip -c "$1" | wc -c
}

# Extract archives of various types
function extract() {
	if [ -f $1 ] ; then
		local dir_name=${1%.*}  # Filename without extension
		case $1 in
			*.tar.bz2)  tar xjf           $1 ;;
			*.tar.gz)   tar xzf           $1 ;;
			*.tar.xz)   tar Jxvf          $1 ;;
			*.tar)      tar xf            $1 ;;
			*.tbz2)     tar xjf           $1 ;;
			*.tgz)      tar xzf           $1 ;;
			*.bz2)      bunzip2           $1 ;;
			*.rar)      unrar x           $1 $2 ;;
			*.gz)       gunzip            $1 ;;
			*.zip)      unzip -d$dir_name $1 ;;
			*.Z)        uncompress        $1 ;;
			*)          echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Print nyan cat
# https://github.com/steckel/Git-Nyan-Graph/blob/master/nyan.sh
# If you want big animated version: `telnet miku.acm.uiuc.edu`
function nyan() {
	echo
	echo -en $RED'-_-_-_-_-_-_-_'
	echo -e $NOCOLOR$BOLD',------,'$NOCOLOR
	echo -en $YELLOW'_-_-_-_-_-_-_-'
	echo -e $NOCOLOR$BOLD'|   /\_/\\'$NOCOLOR
	echo -en $GREEN'-_-_-_-_-_-_-'
	echo -e $NOCOLOR$BOLD'~|__( ^ .^)'$NOCOLOR
	echo -en $CYAN'-_-_-_-_-_-_-'
	echo -e $NOCOLOR$BOLD'""  ""'$NOCOLOR
	echo
}

# Creates an SSH key and uploads it to the given host
# Based on https://gist.github.com/1761938
add-ssh-host() {
	username=$1
	hostname=$2
	identifier=$3

	if [[ "$identifier" == "" ]] || [[ "$username" == "" ]] || [[ "$hostname" == "" ]]
	then
		echo "Usage: configure_ssh_host <username> <hostname> <identifier>"
	else
		if [ ! -f "$HOME/.ssh/$identifier.id_rsa" ]; then
			ssh-keygen -f ~/.ssh/$identifier.id_rsa -C "$USER $(date +'%Y/%m%/%d %H:%M:%S')"
		fi

		if ! grep -Fxiq "host $identifier" "$HOME/.ssh/config"; then
			echo -e "Host $identifier\n\tHostName $hostname\n\tUser $username\n\tIdentityFile ~/.ssh/$identifier.id_rsa" >> ~/.ssh/config
		fi

		ssh $identifier 'mkdir -p .ssh && cat >> ~/.ssh/authorized_keys' < ~/.ssh/$identifier.id_rsa.pub

		tput bold; ssh -o PasswordAuthentication=no $identifier true && { tput setaf 2; echo "SSH key added."; } || { tput setaf 1; echo "Failure"; }; tput sgr0

		_ssh_load_autocomplete
	fi
}

# Adds ~/.ssh/config to the ssh autocomplete
_ssh_load_autocomplete() {
    if [ -f ~/.ssh/config ]; then
	   complete -W "$(awk '/^\s*Host\s*/ { sub(/^\s*Host /, ""); print; }' ~/.ssh/config)" ssh
    fi
}
_ssh_load_autocomplete

# Find files with Windows line endings (and convert then to Unix in force mode)
# USAGE: crlf [file] [--force]
function crlf() {
	local force=

	# Single file
	if [ "$1" != "" ] && [ "$1" != "--force" ]; then
		[ "$2" == "--force" ] && force=1 || force=0
		_crlf_file $1 $force
		return
	fi

	# All files
	[ "$1" == "--force" ] && force=1 || force=0
	for file in $(find . -type f -not -path "*/.git/*" -not -path "*/node_modules/*" | xargs file | grep ASCII | cut -d: -f1); do
		_crlf_file $file $force
	done
}
function _crlf_file() {
	grep -q $'\x0D' "$1" && echo "$1" && [ $2 ] && dos2unix "$1"
}