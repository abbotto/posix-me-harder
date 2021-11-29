#!/usr/bin/env sh

set -eu

if command -v cz >/dev/null 2>&1; then
	printf '%s\n' "> Bumping version with 'commitizen' | https://commitizen-tools.github.io/commitizen/"
	eval "cz bump --changelog ${*:-}"
else
	printf '%s\n' "> 'commitizen' not found - https://commitizen-tools.github.io/commitizen/"
	printf '%s\n' "> Run 'pipx install commitizen' to install it"
fi
