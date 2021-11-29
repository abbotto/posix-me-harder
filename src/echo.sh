#!/usr/bin/env sh

# ECHO
# https://pubs.opengroup.org/onlinepubs/009604599/utilities/echo.html
# https://pubs.opengroup.org/onlinepubs/009604599/utilities/echo.html#tag_04_41_16
# https://www.gnu.org/software/bash/manual/bash.html
# https://yash.osdn.jp/doc/_echo.html
# https://zsh.sourceforge.io/Doc/Release/Options-Index.html

# Ensure that 'echo' expands '\' escape sequences and does not parse options.
# BEFORE: > echo "Hello\nworld" -> Hello\nworld
# AFTER: > echo "Hello\nworld" ->
# Hello
# world

# An 'echo' polyfill with POSIX-compliant behaviour
pmh_echo_polyfill=$(
	cat <<EOF
echo() {
	IFS_CACHE="\${IFS:-}"
	unset IFS
	printf "%b\n" "\${*}"
	IFS="\${IFS_CACHE}"
	export IFS
	unset IFS_CACHE
}
EOF
)

# The 'bsdecho' option should be disabled in POSIX mode
if set -o | grep 'bsdecho' >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3040
	set +o bsdecho # zsh
fi

# Ensure that 'echo' is POSIX-compliant
if command -v shopt >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3044
	shopt -s xpg_echo # bash
elif [ -n "${YASH_VERSION:-}" ]; then
	ECHO_STYLE='SYSV' # yash
	export ECHO_STYLE
elif [ -z "${KSH_VERSION}" ] || case "${KSH_VERSION}" in *MIRBSD*) true ;; esac then
	pmh_requires_echo_polyfill=1 # dash,mksh,zsh
fi

if [ -n "${pmh_requires_echo_polyfill}" ]; then
	eval "${pmh_echo_polyfill}"
fi

unset pmh_echo_polyfill
unset pmh_requires_echo_polyfill
