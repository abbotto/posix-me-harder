#!/usr/bin/env sh

set -eu

if command -v shfmt >/dev/null 2>&1; then
	printf '\n%s\n' "> Formatting scripts files with 'shfmt' | https://github.com/mvdan/sh"
	find ./dev/util/*sh ./src/*sh ./test/util/*sh -type f -exec shfmt -w -p -l -s -i 0 {} +
else
	printf '%s\n' "> 'shfmt' not found - https://github.com/mvdan/sh"
	printf '%s\n' "> Skipping shell script formatting"
fi
