#!/usr/bin/env sh

# HISTORY
# https://pubs.opengroup.org/onlinepubs/009604599/utilities/ed.html
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/fc.html
# https://pubs.opengroup.org/onlinepubs/9699919799/utilities/sh.html

# Ensure that $HISTSIZE has a consistent default value.
# An implementation may choose to access this variable only when initializing the history file.
HISTSIZE=2048
export HISTSIZE

# Ensure that $HISTFILE has the correct default value.
if [ ! -f "${HOME}/.sh_history" ]; then
	touch "${HOME}/.sh_history"
fi

HISTFILE="${HOME}/.sh_history"
export HISTFILE

# Ensure that 'ed' is the default editor for the 'fc' builtin.
# In bash, 'fc' will fallback to $EDITOR if $FCEDIT is null or unset.
FCEDIT=$(command -v ed)
export FCEDIT
