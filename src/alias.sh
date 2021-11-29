#!/usr/bin/env sh

# ALIAS
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/alias.html

# Ensure that aliases are expanded.
# BEFORE: > alias echo='echo hello-world'; echo hello-world -> hello-world
# AFTER: > alias echo='echo hello-world'; echo hello-world -> hello-world hello-world
if command -v shopt >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3044
	shopt -s expand_aliases # bash
elif command -v setopt >/dev/null 2>&1; then
	# shellcheck disable=SC2039,SC3044
	setopt aliases # zsh
fi
