#!/usr/bin/env sh

set -u

if command -v shellspec >/dev/null 2>&1; then
	printf '\n%s\n' "> Inspecting release with 'shellspec' | https://shellspec.info/"

	shellspec ./test/spec/release_spec.sh
	shellspec_exit_code="${?}"
else
	printf '%s\n' "> 'shellspec' not found - https://shellspec.info/"
	printf '%s\n' "> 'shellspec' is required for release inspection"
fi

if [ "${shellspec_exit_code}" -lt 1 ]; then
	printf '%s\n' "> This branch is ready for release."
else
	printf '%s\n' "> This branch isn't ready for release."
	exit "${shellspec_exit_code}"
fi
