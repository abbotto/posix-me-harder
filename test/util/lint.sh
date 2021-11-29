#!/usr/bin/env sh

set -u

if command -v shellcheck >/dev/null 2>&1; then
	printf '\n%s\n' "> Inspecting 'sh' files with ShellCheck | https://www.shellcheck.net/"

	SHELLCHECK_OPTS="-s sh -e SC1090 -e SC1091 -e SC2148"
	export SHELLCHECK_OPTS

	scripts='./dev/util/*sh ./src/*sh ./test/spec/*sh ./test/util/*sh'
	eval "find ${scripts} -type f -exec shellcheck ${SHELLCHECK_OPTS} {} +"
	exit_status="${?}"

	if [ "${exit_status}" = 0 ]; then
		printf '%s\n' "✔ PASS"
	fi

	exit "${exit_status}"

else
	printf '%s\n' "> 'shellcheck' not found - https://www.shellcheck.net/"
	printf '%s\n' "> Skipping script lint inspection"
fi
