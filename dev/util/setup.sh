#!/usr/bin/env sh

set -eu

os=$(uname -s | tr '[:upper:]' '[:lower:]')

base_system_requirements=''
old_stty_cfg=$(stty -g)

if [ "${os}" = 'darwin' ] || [ "${os}" = 'linux' ]; then
	base_system_requirements=true
fi

if [ -z "${base_system_requirements}" ]; then
	printf '%s\n' "> Unsupported system [${os}]. Exiting..."
	exit 127
fi

printf '%s\n' "> Install dev tools and system packages? (y/n)"
printf '%s' '[commitizen gh pipx pre-commit shellcheck shfmt] '
stty raw -echo
answer=$(head -c 1)
stty "${old_stty_cfg}"

if echo "${answer}" | grep -iq "^y"; then
	printf '%s\n' ''

	if '/usr/bin/bash' -c 'echo 0' >/dev/null 2>&1; then
		printf '\n%s\n' "> Installing 'shellcheck' linter | https://shellcheck.com/"
		curl -sS https://webinstall.dev/shellcheck | bash

		printf '\n%s\n' "> Installing 'shfmt' formatter | https://github.com/mvdan/sh/"
		curl -sS https://webinstall.dev/shfmt | bash
	else
		printf '%s\n' "> 'bash' not found - https://www.gnu.org/software/bash/"
		exit 127
	fi

	if ! command -v pipx >/dev/null 2>&1; then
		pip install pipx
	fi

	if command -v pipx >/dev/null 2>&1; then
		printf '\n%s\n' "> Installing apps with 'pipx' | https://github.com/pipxproject/pipx"

		if ! command -v gh >/dev/null 2>&1; then
			pipx install gh
		fi

		if ! command -v cz >/dev/null 2>&1; then
			pipx install commitizen
		fi

		if ! command -v pre-commit >/dev/null 2>&1; then
			pipx install pre-commit
		fi

		pre-commit autoupdate
	else
		printf '%s\n' "> 'pipx' not found - https://github.com/pipxproject/pipx"
		printf '%s\n' "> Run 'pip install pipx' to install it"
		exit 127
	fi

	if command -v pre-commit >/dev/null 2>&1; then
		printf '\n%s\n' "> Installing 'pre-commit' Git hooks | https://pre-commit.com/"

		pre-commit install --hook-type commit-msg
		pre-commit install
	else
		printf '%s\n' "> 'pre-commit' not found - https://pre-commit.com/"
		printf '%s\n' "> Run 'pipx install pre-commit' to install it"
		exit 127
	fi

	. ./dev/util/packages.sh
fi
