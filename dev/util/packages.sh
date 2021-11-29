#!/usr/bin/env sh

set -eu

platform=$(uname -s | tr '[:upper:]' '[:lower:]')

if [ "${platform}" = 'linux' ]; then
	ksh=ksh

	if lsb_release -d | grep '20.04' >/dev/null 2>&1; then
		ksh=ksh93
	fi

	sudo apt-add-repository \
		"deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse"
	sudo apt-get -qq update
	sudo apt-get install shellcheck xz-utils bash $ksh mksh yash zsh

	if ! command -v shellspec >/dev/null 2>&1; then
		if [ -n "${CI}" ]; then
			wget -c "https://github.com/shellspec/shellspec/releases/download/0.28.1/shellspec-dist.tar.gz" -O - | tar -zx
			ln -s "$PWD"/shellspec/shellspec /usr/local/bin/shellspec
		else
			wget -O- https://git.io/shellspec | sh
		fi

		shellspec --init
	fi
elif [ "${platform}" = 'darwin' ]; then
	if command -v brew >/dev/null 2>&1; then
		brew tap shellspec/shellspec
		brew install shellcheck shellspec bash ksh mksh yash zsh
		shellspec --init
	else
		printf '%s\n' "> 'homebrew' not found - https://brew.sh/"
		exit 127
	fi
fi
