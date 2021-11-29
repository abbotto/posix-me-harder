#!/usr/bin/env sh

# ARGUMENTS

# Determine if this module was sourced
pmh_source=0
case "${0##*/}" in bash | dash | ksh | mksh | yash | zsh) pmh_source=1 ;; esac

# Evaluate arguments that are passed into the module.
# This is useful for running code in an isolated PMH process.
# This will only work if the module isn't being sourced.
if [ "${pmh_source}" -eq 0 ] && [ "${#}" -gt 0 ]; then
	eval "${*}"
fi

unset pmh_source
