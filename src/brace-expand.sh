#!/usr/bin/env sh

# BRACE EXPAND
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06

# Ensure that brace expansion is disabled.
# Brace expansion is not defined by POSIX.
# BEFORE: > printf '%s\n' {a,b,c} -> abc
# AFTER: > printf '%s\n' {a,b,c} -> {a,b,c}
if set -o | grep 'braceexpand' >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3040
	set +o braceexpand # ash,bash,ksh,mksh,yash
elif set -o | grep 'braceccl' >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3040
	set -o braceccl # zsh
fi
